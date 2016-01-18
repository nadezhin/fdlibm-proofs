package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import jdkproofs.llvm2acl2.Value.Argument;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Arrays;
import org.bridj.Pointer;

/**
 *
 */
public class DumpACL2 implements Instruction.Visitor<Void, Void> {

    private final PrintStream out;
    private int indent;
    private Function curFun;

    DumpACL2(PrintStream out) {
        this.out = out;
    }

    private void nl(String s) {
        out.println();
        for (int i = 0; i < indent; i++) {
            out.print(' ');
        }
        out.print(s);
    }

    private void dumpModule(Module module, String[] deps) {
        out.print("(in-package \"ACL2\")");
        nl("(include-book \"../llvm\")");
        for (String dep : deps) {
            nl("(include-book \"" + dep + "\")");
        }
        for (Function fun : module.funs) {
            if (fun.blocks.isEmpty()) {
                continue;
            }
            curFun = fun;
            String args = "";
            for (int i = 0; i < fun.args.size(); i++) {
                Argument arg = fun.args.get(i);
                if (i > 0) {
                    args += ' ';
                }
                args += '%' + arg.name;
            }
            for (int i = fun.blocks.size() - 1; i >= 0; i--) {
                BasicBlock bb = fun.blocks.get(i);
                nl("");
                nl("(defund @" + fun.name + "-%" + bb.label + " (mem " + bb.getUseArgs() + ")");
                nl("  (b* (");
                indent += 4;
                for (int j = 0; j < bb.insts.size() - 1; j++) {
                    Instruction inst = bb.insts.get(j);
                    nl("(");
                    inst.accept(this, null);
                    out.print(')');
                }
                out.print(")");
                indent -= 2;
                nl("");
                bb.terminator.accept(this, null);
                out.print("))");
                indent -= 2;
            }
            nl("");
            nl("(defund @" + fun.name + " (" + args + ")");
            nl("  (@" + fun.name + "-%0 () " + fun.blocks.get(0).getUseArgs() + "))");
        }
        nl("");
    }

    private static void dumpFile(String dir, String file, String[] deps, String outDir) throws IOException {
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
                try (PrintStream out = new PrintStream(outDir + file.replace(".bc", ".lisp"))) {
                    DumpACL2 dump = new DumpACL2(out);
                    dump.dumpModule(module, deps);
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
            String s = operand.representation.substring(7).trim();
            if (s.startsWith("0x")) {
                return "#x" + s.substring(2);
            } else {
                s = Long.toHexString(Double.doubleToRawLongBits(Double.valueOf(s)));
                while (s.length() < 16) {
                    s = '0' + s;
                }
                return "#x" + s;
            }
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

    @Override
    public Void visitBinaryOperator(Instruction.BinaryOperator inst, Void p) {
        String opname = inst.opcode.name().substring(4).toLowerCase();
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        if (inst.typesMatch("double", "double", "double")) {
            out.print(inst.refName + " (" + opname + "-double " + op0 + " " + op1 + ")");
        } else if (inst.typesMatch("i32", "i32", "i32")) {
            out.print(inst.refName + " (" + opname + "-i32 " + op0 + " " + op1 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitCallInst(Instruction.CallInst inst, Void p) {
        Function fn = (Function) inst.operands[inst.operands.length - 1];
        assert fn.args.size() == inst.operands.length - 1;
        if (inst.type.typeStr.equals("double")) {
            out.print(inst.refName + " (@" + fn.name);
            for (int i = 0; i < fn.args.size(); i++) {
                out.print(" " + operandStr(inst.operands[i]));
            }
            out.print(")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitFCmpInst(Instruction.CmpInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitICmpInst(Instruction.ICmpInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        String cmp = Utils.intPredicateOf(LLVMGetICmpPredicate(inst.getPeer())).name();
        cmp = cmp.substring("LLVMInt".length()).toLowerCase();
        if (inst.typesMatch("i1", "i32", "i32")) {
            out.print(inst.refName + " (icmp-" + cmp + "-i32 " + op0 + " " + op1 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitGetElementPtrInst(Instruction.GetElementPtrInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        if (inst.typesMatch("i32*", "i32*", "i64")) {
            out.print(inst.refName + " (getelementptr-i32 " + op0 + " " + op1 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitPHINode(Instruction.PHINode inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitSelectInst(Instruction.SelectInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitStoreInst(Instruction.StoreInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        if (inst.typesMatch("void", "double", "double*")) {
            out.print("mem (store-double " + op0 + " " + op1 + " mem)");
        } else if (inst.typesMatch("void", "i32", "i32*")) {
            out.print("mem (store-i32 " + op0 + " " + op1 + " mem)");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitAllocaInst(Instruction.AllocaInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String nm = inst.refName;
        assert nm.charAt(0) == '%';
        nm = nm.substring(1);

        try {
            int ind = Integer.valueOf(nm);
            nm = ind == 1 ? "ret" : curFun.args.get(ind - 2).name;
        } catch (NumberFormatException e) {
        }
        if (inst.typesMatch("double*", "i32")) {
            if (op0.equals("1")) {
                out.print("(mv " + inst.refName + " mem) (alloca-double-1 '" + nm + " mem)");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("i32*", "i32")) {
            if (op0.equals("1")) {
                out.print("(mv " + inst.refName + " mem) (alloca-i32-1 '" + nm + " mem)");
            } else {
                throw new UnsupportedOperationException();
            }
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitBitCastInst(Instruction.BitCastInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("i32*", "double*")) {
            out.print(inst.refName + " (bitcast-double*-to-i32* " + op0 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitFPExtInst(Instruction.FPExtInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitFPToSIInst(Instruction.FPToSIInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitSExtInst(Instruction.SExtInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitSIToFPInst(Instruction.SIToFPInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitUIToFPInst(Instruction.UIToFPInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitZExtInst(Instruction.ZExtInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitLoadInst(Instruction.LoadInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("double", "double*")) {
            out.print(inst.refName + " (load-double " + op0 + " mem)");
        } else if (inst.typesMatch("i32", "i32*")) {
            out.print(inst.refName + " (load-i32 " + op0 + " mem)");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitBranchInst(TerminatorInst.BranchInst inst, Void p) {
        if (inst.typesMatch("void", "label")) {
            BasicBlock bb0 = (BasicBlock) inst.operands[0];
            out.print("(@" + curFun.name + "-%" + bb0.label + " mem " + bb0.getUseArgs() + ")");
        } else if (inst.typesMatch("void", "i1", "label", "label")) {
            String op0 = operandStr(inst.operands[0]);
            BasicBlock bb1 = (BasicBlock) inst.operands[1];
            BasicBlock bb2 = (BasicBlock) inst.operands[2];
            out.print("(case " + op0);
            nl("  (-1  (@" + curFun.name + "-%" + bb2.label + " mem " + bb2.getUseArgs() + "))");
            nl("  (0 (@" + curFun.name + "-%" + bb1.label + " mem " + bb1.getUseArgs() + ")))");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitReturnInst(TerminatorInst.ReturnInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("void", "double")) {
            out.print(op0);
        } else if (inst.typesMatch("void", "i32")) {
            out.print(op0);
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitSwitchInst(TerminatorInst.SwitchInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private static final String[][] sortedFiles = {
        {"w_acos.bc", "e_acos"},
        //        "e_acos.bc",
        {"w_asin.bc", "e_asin"},
        //        "e_asin.bc",
        //        "s_atan.bc",
        {"w_atan2.bc", "e_atan2"},
        //        "e_atan2.bc",
        {"s_cbrt.bc"},
        {"s_copysign.bc"},
        //        "s_cos.bc",
        //        "k_cos.bc",
        {"w_cosh.bc", "e_cosh"},
        //        "e_cosh.bc",
        {"w_exp.bc", "e_exp"},
        //        "e_exp.bc",
        //        "s_expm1.bc", 
        {"s_fabs.bc"},
        //        "s_floor.bc",
        {"w_hypot.bc", "e_hypot"},
        //        "e_hypot.bc", 
        {"w_log.bc", "e_log"},
        //        "e_log.bc", 
        {"w_log10.bc", "e_log10"},
        //        "e_log10.bc",
        //        "s_log1p.bc",
        {"w_pow.bc", "e_pow"},
        //        "e_pow.bc",
        //        "e_rem_pio2.bc",
        //        "k_rem_pio2.bc",
        //        "s_scalbn.bc",
        //        "s_sin.bc",
        //        "k_sin.bc",
        {"w_sinh.bc", "e_sinh"},
        //        "e_sinh.bc",
        {"w_sqrt.bc", "e_sqrt"}, //        "e_sqrt.bc", 
    //        "s_tan.bc",
    //        "k_tan.bc",
    //        "s_tanh.bc"
    };

    public static void main(String[] args) throws IOException {
        for (String[] filenames : sortedFiles) {
            String filename = filenames[0];
            String[] deps = Arrays.copyOfRange(filenames, 1, filenames.length);
            System.out.println(filename);
            dumpFile("netlib.llvm/", filename, deps, "acl2/llvm/");
        }
    }
}
