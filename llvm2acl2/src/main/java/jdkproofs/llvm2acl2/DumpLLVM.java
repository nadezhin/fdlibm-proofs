package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import org.bridj.Pointer;

/**
 *
 */
public class DumpLLVM {

    private static void dumpModule(PrintStream out, Module module, String moduleId) {
        out.println("; ModuleID = '" + moduleId + "'");
//        out.println("; ModuleID = '../jdk8/src/" + filename.replace(".bc", ".c") + "'");
        out.println("target datalayout = \"" + module.dataLayout + "\"");
        out.println("target triple = \"" + module.target + "\"");
        if (!module.globals.isEmpty()) {
            out.println();
            for (Value global : module.globals) {
                out.println(doubleSugar(global.representation));
//                out.println("@" + global.name + " = internal constant " + global.type.typeString + );
            }
        }
        for (int k = 0; k < module.funs.size(); k++) {
            Function fun = module.funs.get(k);
            out.println();
            if (fun.attribute != 0) {
                out.print("; Function Attrs:");
                for (LLVMAttribute attr : LLVMAttribute.values()) {
                    if ((fun.attribute & attr.value()) != 0) {
                        String name = attr.name();
                        name = name.substring("LLVM".length());
                        if (name.endsWith("Attribute")) {
                            name = name.substring(0, name.length() - "Attribute".length());
                        }
                        out.print(" " + name.toLowerCase());
                    }
                }
                out.println();
            }
            if (fun.blocks.isEmpty()) {
                System.out.println("  " + fun.name);
                out.print("declare " + fun.returnType.typeStr + " @" + fun.name + "(");
                for (int i = 0; i < fun.args.size(); i++) {
                    if (i > 0) {
                        out.print(", ");
                    }
                    Value.Argument arg = fun.args.get(i);
                    out.print(arg.type.typeStr);
                }
                out.println(") " + fun.attributesGroup);
            } else {
                System.out.println("  *" + fun.name);
                out.print("define " + fun.returnType.typeStr + " @" + fun.name + "(");
                for (int i = 0; i < fun.args.size(); i++) {
                    if (i > 0) {
                        out.print(", ");
                    }
                    Value.Argument arg = fun.args.get(i);
                    out.print(arg.type.typeStr + " %" + arg.name);
                }
                out.println(") " + fun.attributesGroup + " {");
                for (BasicBlock bb : fun.blocks) {
                    if (bb.label != 0) {
                        out.println();
                        String s = "; <label>:" + bb.label;
                        while (s.length() < 50) {
                            s += ' ';
                        }
                        out.println(s + "; preds =" + bb.preds);
                    }
                    for (Instruction inst : bb.insts) {
                        out.print("  ");
                        if (inst.refName != null) {
                            out.print(inst.refName + " = ");
                        }
                        out.print(inst.opcode.name().substring(4).toLowerCase());
                        inst.accept(instrVisitor, out);
                        out.println();
                    }
                }
                out.println("}");
            }
        }
        out.println();
        out.print(module.tail);
    }

    private static void dumpFile(String dir, String idPrefix, String file) throws IOException {
        int ok;

        Pointer<Byte> path = Pointer.pointerToCString(dir + file);
        Pointer<LLVMMemoryBufferRef> outMemBuf = Pointer.allocate(LLVMMemoryBufferRef.class);
        Pointer<Pointer<Byte>> outMessage = Pointer.allocatePointer(Byte.class);
        ok = LLVMCreateMemoryBufferWithContentsOfFile(path, outMemBuf, outMessage);
        LLVMMemoryBufferRef memBuf = outMemBuf.get();
        Pointer<Byte> message = outMessage.get();
        Pointer.release(path, outMemBuf, outMessage);

        if (ok == 0) {
            assert message == null;
            Pointer<LLVMModuleRef> outModule = Pointer.allocate(LLVMModuleRef.class);
            outMessage = Pointer.allocatePointer(Byte.class);
            ok = LLVMParseBitcode(memBuf, outModule, outMessage);
            LLVMModuleRef moduleRef = outModule.get();
            message = outMessage.get();
            LLVMDisposeMemoryBuffer(memBuf);
            Pointer.release(outModule, outMessage);

            if (ok == 0) {
                assert message == null;
                Module module = new Module(Pointer.getPeer(moduleRef));
                try (PrintStream out = new PrintStream(dir + "t/" + file.replace(".bc", ".llvm"))) {
                    String moduleId = idPrefix + file.replace(".bc", ".c");
                    dumpModule(out, module, moduleId);
                }
                LLVMDisposeModule(moduleRef);
            } else {
                System.out.println(message.getCString());
                LLVMDisposeMessage(message);
                assert moduleRef == null;
            }
        } else {
            System.out.println(message.getCString());
            LLVMDisposeMessage(message);
            assert memBuf == null;
        }
    }

    private static String[] sugars = {
        "-1.000000e+00",
        "1.000000e-300",
        "2.500000e-01",
        "5.000000e-01",
        "1.000000e+00",
        "1.500000e+00",
        "2.000000e+00",
        "3.000000e+00",
        "1.000000e+300"
    };

    private static String doubleSugar(String s) {
        for (String sug : sugars) {
            String pat = Long.toHexString(Double.doubleToLongBits(Double.valueOf(sug))).toUpperCase();
            pat = "0x" + pat;
            s = s.replace(pat, sug);
        }
        return s;
    }

    private static String operandStr(Value operand) {
        if (operand instanceof Instruction) {
            return ((Instruction) operand).refName;
        } else if (operand instanceof Constant.ConstantInt) {
            if (operand.representation.startsWith("i32 ")
                    || operand.representation.startsWith("i64 ")) {
                return operand.representation.substring(4);
            } else {
                assert operand.representation.startsWith("i1");
                return operand.representation.substring(3);
            }
        } else if (operand instanceof Constant.ConstantFP) {
            assert operand.representation.startsWith("double ");
            return doubleSugar(operand.representation.substring(7));
        } else if (operand instanceof Constant.ConstantExpr) {
            if (operand.representation.startsWith("double* ")) {
                return operand.representation.substring("double* ".length());
            } else if (operand.representation.startsWith("i32* ")) {
                return operand.representation.substring("i32* ".length());
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (operand instanceof Constant.GlobalVariable) {
            int indAt = operand.representation.indexOf('@');
            int indSp = operand.representation.indexOf(' ', indAt);
            return operand.representation.substring(indAt, indSp);
        } else if (operand instanceof BasicBlock) {
            return "label %" + ((BasicBlock) operand).label;
        } else if (operand instanceof Value.Argument) {
            return "%" + operand.name;
        } else {
            throw new UnsupportedOperationException();
        }
    }

    private static final Instruction.Visitor<Void, PrintStream> instrVisitor = new Instruction.Visitor<Void, PrintStream>() {

        @Override
        public Void visitBinaryOperator(Instruction.BinaryOperator inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            if (inst.typesMatch("double", "double", "double")) {
                out.print(" double " + op0 + ", " + op1);
            } else if (inst.typesMatch("i32", "i32", "i32")) {
                String nsw = "";
                if (inst.representation.contains(" nsw ")) {
                    nsw += " nsw";
                }
                out.print(nsw + " i32 " + op0 + ", " + op1);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitCallInst(Instruction.CallInst inst, PrintStream out) {
            Function fn = (Function) inst.operands[inst.operands.length - 1];
            assert fn.args.size() == inst.operands.length - 1;
            if (inst.type.typeStr.equals("double")) {
                out.print(" double @" + fn.name + "(");
                for (int i = 0; i < fn.args.size(); i++) {
                    if (i > 0) {
                        out.print(", ");
                    }
                    out.print(fn.args.get(i).type.typeStr + " " + operandStr(inst.operands[i]));
                }
                out.print(")");
                if (inst.attributeGroup != null) {
                    out.print(" " + inst.attributeGroup);
                }
            } else if (inst.type.typeStr.equals("i32")) {
                out.print(" i32 @" + fn.name + "(");
                for (int i = 0; i < fn.args.size(); i++) {
                    if (i > 0) {
                        out.print(", ");
                    }
                    out.print(fn.args.get(i).type.typeStr + " " + operandStr(inst.operands[i]));
                }
                out.print(")");
                if (inst.attributeGroup != null) {
                    out.print(" " + inst.attributeGroup);
                }
            } else if (inst.type.typeStr.equals("i32*")) {
                out.print(" i32* @" + fn.name + "(");
                for (int i = 0; i < fn.args.size(); i++) {
                    if (i > 0) {
                        out.print(", ");
                    }
                    out.print(fn.args.get(i).type.typeStr + " " + operandStr(inst.operands[i]));
                }
                out.print(")");
                if (inst.attributeGroup != null) {
                    out.print(" " + inst.attributeGroup);
                }
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitFCmpInst(Instruction.CmpInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            String cmp = Utils.realPredicateOf(LLVMGetFCmpPredicate(inst.getPeer())).name();
            cmp = cmp.substring("LLVMReal".length()).toLowerCase();
            if (inst.typesMatch("i1", "double", "double")) {
                out.print(" " + cmp + " double " + op0 + ", " + op1);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitICmpInst(Instruction.ICmpInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            String cmp = Utils.intPredicateOf(LLVMGetICmpPredicate(inst.getPeer())).name();
            cmp = cmp.substring("LLVMInt".length()).toLowerCase();
            if (inst.typesMatch("i1", "i32", "i32")) {
                out.print(" " + cmp + " i32 " + op0 + ", " + op1);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitGetElementPtrInst(Instruction.GetElementPtrInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            if (inst.typesMatch("i32*", "i32*", "i64")) {
                out.print(" inbounds i32, i32* " + op0 + ", i64 " + op1);
            } else if (inst.typesMatch("double*", "double*", "i64")) {
                out.print(" inbounds double, double* " + op0 + ", i64 " + op1);
            } else if (inst.typesMatch("double*", "[2 x double]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [2 x double], [2 x double]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("double*", "[2 x double]*", "i32", "i32")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [2 x double], [2 x double]* " + op0 + ", i32 " + op1 + ", i32 " + op2);
            } else if (inst.typesMatch("double*", "[3 x double]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [3 x double], [3 x double]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("double*", "[3 x double]*", "i32", "i32")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [3 x double], [3 x double]* " + op0 + ", i32 " + op1 + ", i32 " + op2);
            } else if (inst.typesMatch("double*", "[4 x double]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [4 x double], [4 x double]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("double*", "[8 x double]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [8 x double], [8 x double]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("double*", "[20 x double]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [20 x double], [20 x double]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("i32*", "[4 x i32]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [4 x i32], [4 x i32]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("i32*", "[20 x i32]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [20 x i32], [20 x i32]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else if (inst.typesMatch("i32*", "[32 x i32]*", "i32", "i64")) {
                String op2 = operandStr(inst.operands[2]);
                out.print(" inbounds [32 x i32], [32 x i32]* " + op0 + ", i32 " + op1 + ", i64 " + op2);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitPHINode(Instruction.PHINode inst, PrintStream out) {
            if (inst.type.typeStr.equals("double")) {
                out.print(" double ");
                for (int i = 0; i < inst.incomingBlocks.length; i++) {
                    int label = inst.incomingBlocks[i].label;
                    String value = operandStr(inst.incomingValues[i]);
                    if (i > 0) {
                        out.print(", ");
                    }
                    out.print("[ " + value + ", %" + label + " ]");
                }
            } else if (inst.type.typeStr.equals("i1")) {
                out.print(" i1 ");
                for (int i = 0; i < inst.incomingBlocks.length; i++) {
                    int label = inst.incomingBlocks[i].label;
                    String value = operandStr(inst.incomingValues[i]);
                    if (i > 0) {
                        out.print(", ");
                    }
                    out.print("[ " + value + ", %" + label + " ]");
                }
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitSelectInst(Instruction.SelectInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            String op2 = operandStr(inst.operands[2]);
            if (inst.typesMatch("double", "i1", "double", "double")) {
                out.print(" i1 " + op0 + ", double " + op1 + ", double " + op2);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitStoreInst(Instruction.StoreInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            if (inst.typesMatch("void", "double", "double*")) {
                out.print(" double " + op0 + ", double* " + op1);
            } else if (inst.typesMatch("void", "double*", "double**")) {
                out.print(" double* " + op0 + ", double** " + op1);
            } else if (inst.typesMatch("void", "i32", "i32*")) {
                out.print(" i32 " + op0 + ", i32* " + op1);
            } else if (inst.typesMatch("void", "i32*", "i32**")) {
                out.print(" i32* " + op0 + ", i32** " + op1);
            } else {
                throw new UnsupportedOperationException();
            }
            if (inst.alignment != 0) {
                out.print(", align " + inst.alignment);
            }
            return null;
        }

        @Override
        public Void visitAllocaInst(Instruction.AllocaInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("double*", "i32")) {
                if (op0.equals("1")) {
                    out.print(" double");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("double**", "i32")) {
                if (op0.equals("1")) {
                    out.print(" double*");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("i32*", "i32")) {
                if (op0.equals("1")) {
                    out.print(" i32");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("i32**", "i32")) {
                if (op0.equals("1")) {
                    out.print(" i32*");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("[2 x double]*", "i32")) {
                if (op0.equals("1")) {
                    out.print(" [2 x double]");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("[3 x double]*", "i32")) {
                if (op0.equals("1")) {
                    out.print(" [3 x double]");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("[20 x double]*", "i32")) {
                if (op0.equals("1")) {
                    out.print(" [20 x double]");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else if (inst.typesMatch("[20 x i32]*", "i32")) {
                if (op0.equals("1")) {
                    out.print(" [20 x i32]");
                } else {
                    throw new UnsupportedOperationException();
                }
            } else {
                throw new UnsupportedOperationException();
            }
            if (inst.alignment != 0) {
                out.print(", align " + inst.alignment);
            }
            return null;
        }

        @Override
        public Void visitBitCastInst(Instruction.BitCastInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("i32*", "double*")) {
                out.print(" double* " + op0 + " to i32*");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitFPExtInst(Instruction.FPExtInst inst, PrintStream out) {
            throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        }

        @Override
        public Void visitFPToSIInst(Instruction.FPToSIInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("i32", "double")) {
                out.print(" double " + op0 + " to i32");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitSExtInst(Instruction.SExtInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("i64", "i32")) {
                out.print(" i32 " + op0 + " to i64");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitSIToFPInst(Instruction.SIToFPInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("double", "i32")) {
                out.print(" i32 " + op0 + " to double");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitUIToFPInst(Instruction.UIToFPInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("double", "i32")) {
                out.print(" i32 " + op0 + " to double");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitZExtInst(Instruction.ZExtInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("i64", "i32")) {
                out.print(" i32 " + op0 + " to i64");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitLoadInst(Instruction.LoadInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("double", "double*")) {
                out.print(" double, double* " + op0);
            } else if (inst.typesMatch("double*", "double**")) {
                out.print(" double*, double** " + op0);
            } else if (inst.typesMatch("i32", "i32*")) {
                out.print(" i32, i32* " + op0);
            } else if (inst.typesMatch("i32*", "i32**")) {
                out.print(" i32*, i32** " + op0);
            } else {
                throw new UnsupportedOperationException();
            }
            if (inst.alignment != 0) {
                out.print(", align " + inst.alignment);
            }
            return null;
        }

        @Override
        public Void visitBranchInst(TerminatorInst.BranchInst inst, PrintStream out) {
            if (inst.typesMatch("void", "label")) {
                String op0 = operandStr(inst.operands[0]);
                out.print(" " + op0);
            } else if (inst.typesMatch("void", "i1", "label", "label")) {
                String op0 = operandStr(inst.operands[0]);
                String op1 = operandStr(inst.operands[1]);
                String op2 = operandStr(inst.operands[2]);
                out.print(" i1 " + op0 + ", " + op2 + ", " + op1);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitReturnInst(TerminatorInst.ReturnInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            if (inst.typesMatch("void", "double")) {
                out.print(" double " + op0);
            } else if (inst.typesMatch("void", "i32")) {
                out.print(" i32 " + op0);
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

        @Override
        public Void visitSwitchInst(TerminatorInst.SwitchInst inst, PrintStream out) {
            String op0 = operandStr(inst.operands[0]);
            String op1 = operandStr(inst.operands[1]);
            if (inst.operands[0].type.typeStr.equals("i32")) {
                int numCases = inst.operands.length / 2 - 1;
                out.println(" i32 " + op0 + ", " + op1 + " [");
                for (int i = 0; i < numCases; i++) {
                    String tag = operandStr(inst.operands[i * 2 + 2]);
                    String label = operandStr(inst.operands[i * 2 + 3]);
                    out.println("    i32 " + tag + ", " + label);
                }
                out.print("  ]");
            } else {
                throw new UnsupportedOperationException();
            }
            return null;
        }

    };

    private static void dumpFiles(String dir, String idPrefix, String[] files) throws IOException {
        for (String file : files) {
            System.out.println(file);
            dumpFile(dir, idPrefix, file);
        }

    }

    private static void dumpDir(String dir, String idPrefix) throws IOException {
        File dirFile = new File(dir);
        List<String> files = new ArrayList<>();
        for (String file : dirFile.list()) {
            if (file.endsWith(".bc")) {
                if (file.equals("k_standard.bc") || file.equals("s_matherr.bc")) {
                    continue;
                }
                files.add(file);
            }
        }
        dumpFiles(dir, idPrefix, files.toArray(new String[files.size()]));
    }

    private static final String[] sortedFiles = {
        "w_acos.bc",
        "e_acos.bc",
        "w_asin.bc",
        "e_asin.bc",
        "s_atan.bc",
        "w_atan2.bc",
        "e_atan2.bc",
        "s_cbrt.bc",
        "s_copysign.bc",
        "s_cos.bc",
        "k_cos.bc",
        "w_cosh.bc",
        "e_cosh.bc",
        "w_exp.bc",
        "e_exp.bc",
        "s_expm1.bc", 
        "s_fabs.bc",
        "s_floor.bc",
        "w_hypot.bc",
        "e_hypot.bc", 
        "w_log.bc",
        "e_log.bc", 
        "w_log10.bc",
        "e_log10.bc",
        "s_log1p.bc",
        "w_pow.bc",
        "e_pow.bc",
        "e_rem_pio2.bc",
        "k_rem_pio2.bc",
        "s_scalbn.bc",
        "s_sin.bc",
        "k_sin.bc",
        "w_sinh.bc",
        "e_sinh.bc",
        "w_sqrt.bc",
        "e_sqrt.bc", 
        "s_tan.bc",
        "k_tan.bc",
        "s_tanh.bc"
    };
    
    private static final String[] interestingFiles = {
        "s_sin.bc", "s_cos.bc", "s_tan.bc",
        "e_asin.bc", "e_acos.bc", "s_atan.bc",
        "e_exp.bc", "e_log.bc", "e_log10.bc",
        "s_cbrt.bc", "e_atan2.bc", "e_pow.bc",
        "e_sinh.bc", "e_cosh.bc", "s_tanh.bc",
        "e_hypot.bc", "s_expm1.bc", "s_log1p.bc",
        
        "e_sqrt.bc", "s_fabs.bc", "e_rem_pio2.bc", "s_scalbn.bc", "s_copysign.bc", "s_floor.bc",
        
        "k_sin.bc", "k_cos.bc", "k_tan.bc", "k_rem_pio2.bc"
    };
    
    private static final String[] w_files = {
        "w_asin.bc", "w_acos.bc",
        "w_exp.bc", "w_log.bc", "w_log10.bc",
        "w_atan2.bc", "w_pow.bc",
        "w_sinh.bc", "w_cosh.bc",
        "w_hypot.bc", "w_sqrt.bc"
    };
    
    public static void main(String[] args) throws IOException {
//        dumpDir("netlib.llvm/", "../netlib/");
        dumpDir("jdk8.llvm/", "../jdk8/src/");
        
//        dumpFiles("netlib.llvm/", "../netlib/", interestingFiles);
//        dumpFiles("jdk8.llvm/", "../jdk8/src/", w_files);
//        dumpFiles("jdk8.llvm/", "../jdk8/src/", interestingFiles);
    }
}
