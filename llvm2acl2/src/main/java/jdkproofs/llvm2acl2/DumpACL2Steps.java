package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.Set;
import jdkproofs.llvm2acl2.llvm.BasicBlock;
import jdkproofs.llvm2acl2.llvm.Constant;
import jdkproofs.llvm2acl2.llvm.Function;
import jdkproofs.llvm2acl2.llvm.Instruction;
import jdkproofs.llvm2acl2.llvm.Module;
import jdkproofs.llvm2acl2.llvm.TerminatorInst;
import jdkproofs.llvm2acl2.llvm.TerminatorInst.ReturnInst;
import jdkproofs.llvm2acl2.llvm.Utils;
import jdkproofs.llvm2acl2.llvm.Value;
import jdkproofs.llvm2acl2.llvm.Value.Argument;
import org.bridj.Pointer;

/**
 *
 */
public class DumpACL2Steps implements Instruction.Visitor<Void, Void> {

    private final PrintStream out;
    private int indent;
    private Function curFun;
    private BasicBlock curBb;
    private boolean smallFuns;
    private boolean revFuns;
    private String lastMem;
    private String lastLoc;
    private String lastPred;
    private String nextRev;

    DumpACL2Steps(PrintStream out) {
        this.out = out;
    }

    private void nl(String s) {
        out.println();
        for (int i = 0; i < indent; i++) {
            out.print(' ');
        }
        out.print(s);
    }

    private String st() {
        return "s" + curBb.label;
    }

    private void genFwd() {
        nl("");
        nl("(defund @" + curFun.name + "-%" + curBb.label + "-mem (" + st() + ")");
        nl("  (car " + st() + "))");
        nl("(defund @" + curFun.name + "-%" + curBb.label + "-loc (" + st() + ")");
        nl("  (cadr " + st() + "))");
        nl("(defund @" + curFun.name + "-%" + curBb.label + "-pred (" + st() + ")");
        nl("  (caddr " + st() + "))");
        lastMem = "(@" + curFun.name + "-%" + curBb.label + "-mem " + st() + ")";
        lastLoc = "(@" + curFun.name + "-%" + curBb.label + "-loc " + st() + ")";
        lastPred = "(@" + curFun.name + "-%" + curBb.label + "-pred " + st() + ")";
        smallFuns = true;
        for (int j = 0; j < curBb.insts.size(); j++) {
            Instruction inst = curBb.insts.get(j);
            inst.accept(this, null);
        }
        smallFuns = false;
        nl("");
        nl("(defund @" + curFun.name + "-%" + curBb.label + "-fwd (mem loc pred)");
        nl("  (let ((" + st() + " (list mem loc pred)))");
        nl("    (mv (" + curBb.terminator.fn("lab") + " " + st() + ") "
                + lastMem + " " + lastLoc + ")))");
    }

    private void genRev() {
        nl("");
        revFuns = true;
        nextRev = null;
        for (int j = curBb.insts.size() - 1; j >= 0; j--) {
            Instruction inst = curBb.insts.get(j);
            nl("(defund " + inst.fn("rev") + " (mem loc pred)");
            indent += 2;
            inst.accept(this, null);
            out.print(")");
            indent -= 2;
            nextRev = inst.fn("rev");
        }
        nl("");
        nl("(defund @" + curFun.name + "-%" + curBb.label + "-rev (mem loc pred)");
        nl("  (" + nextRev + " mem loc pred))");
        revFuns = false;
    }

    private void genExpandRevRules() {
        nl("");
        lastMem = "(@" + curFun.name + "-%" + curBb.label + "-mem " + st() + ")";
        lastLoc = "(@" + curFun.name + "-%" + curBb.label + "-loc " + st() + ")";
        lastPred = "(@" + curFun.name + "-%" + curBb.label + "-pred " + st() + ")";
        String lastEnable = "@" + curFun.name + "-%" + curBb.label + "-rev"
                + " @" + curFun.name + "-%" + curBb.label + "-mem"
                + " @" + curFun.name + "-%" + curBb.label + "-loc"
                + " @" + curFun.name + "-%" + curBb.label + "-pred";
        for (int i = 0; i < curBb.insts.size(); i++) {
            Instruction inst = curBb.insts.get(i);
            nl("(defruled @" + curFun.name + "-%" + curBb.label + "-expand-rev-as-" + inst.fn("rev"));
            nl("  (equal (@" + curFun.name + "-%" + curBb.label + "-rev mem loc pred)");
            nl("         (let ((" + st() + " (list mem loc pred)))");
            nl("           (" + curBb.insts.get(i).fn("rev"));
            nl("            " + lastMem);
            nl("            " + lastLoc);
            nl("            " + lastPred + ")))");
            nl("  :enable (" + lastEnable + "))");
            lastEnable = "@" + curFun.name + "-%" + curBb.label + "-expand-rev-as-" + inst.fn("rev")
                    + " " + inst.fn("rev");
            if (inst instanceof Instruction.AllocaInst) {
                lastMem = "(" + inst.fn("mem") + " " + st() + ")";
                lastLoc = "(" + inst.fn("loc") + " " + st() + ")";
                lastEnable += " " + inst.fn("mem") + " " + inst.fn("loc");
            } else if (inst instanceof Instruction.StoreInst) {
                lastMem = "(" + inst.fn("mem") + " " + st() + ")";
                lastEnable += " " + inst.fn("mem");
            } else if (inst instanceof TerminatorInst) {
                lastEnable += " " + inst.fn("lab")
                        + " @" + curFun.name + "-%" + curBb.label + "-fwd";
            } else {
                lastLoc = "(" + inst.fn("loc") + " " + st() + ")";
                lastEnable += " " + inst.fn("loc") + " " + inst.fn("val");
            }
        }
        nl("(defruled @" + curFun.name + "-%" + curBb.label + "-expand-rev-as-fwd");
        nl("  (equal (@" + curFun.name + "-%" + curBb.label + "-rev mem loc pred)");
        nl("         (@" + curFun.name + "-%" + curBb.label + "-fwd mem loc pred))");
        nl("  :enable (" + lastEnable + "))");
    }

    private void genBb() {
        nl("");
        nl("(defund @" + curFun.name + "-%" + curBb.label + "-bb (mem loc pred)");
        if (curBb.numPhi == 0) {
            nl("  (declare (ignore pred))");
        }
        indent += 2;
        nl("(b* (");
        indent += 2;
        for (int j = 0; j < curBb.insts.size(); j++) {
            Instruction inst = curBb.insts.get(j);
            inst.accept(this, null);
        }
        out.print(")");
        indent -= 2;
        nl("(mv succ mem loc)");
        indent -= 2;
        out.print("))");
    }

    private void genExpandBb() {
        nl("");
        nl("(defruled @" + curFun.name + "-%" + curBb.label + "-expand-bb");
        nl("  (equal (@" + curFun.name + "-%" + curBb.label + "-bb mem loc pred)");
        nl("         (@" + curFun.name + "-%" + curBb.label + "-rev mem loc pred))");
        nl("  :enable (@" + curFun.name + "-%" + curBb.label + "-bb"
                + " @" + curFun.name + "-%" + curBb.label + "-rev");
        indent += 4;
        for (Instruction inst : curBb.insts) {
            nl(inst.fn("rev"));
        }
        out.print(")");
        indent -= 4;
        nl("  :disable s-diff-s)");
    }

    private void genBasicBlock(BasicBlock bb) {
        curBb = bb;
        genFwd();
        genRev();
        genExpandRevRules();
        genBb();
//        genExpandBb();
    }

    private void genFunction(Function fun) {
        curFun = fun;
        String args = "";
        for (int i = 0; i < fun.args.size(); i++) {
            Argument arg = fun.args.get(i);
            if (i > 0) {
                args += ' ';
            }
            args += '%' + arg.name;
        }
        for (int i = 0; i < fun.blocks.size(); i++) {
            genBasicBlock(fun.blocks.get(i));
        }
        nl("");
        nl("(defund @" + fun.name + "-step (label mem loc pred)");
        nl("  (case label");
        indent += 4;
        for (int i = 0; i < fun.blocks.size(); i++) {
            curBb = fun.blocks.get(i);
            nl("(%" + curBb.label + " (@" + fun.name + "-%" + curBb.label + "-bb mem loc pred))");
        }
        nl("(otherwise (mv nil mem loc))))");
        indent -= 4;
        nl("");
        nl("(defund @" + fun.name + "-steps (label mem loc pred n)");
        nl("  (declare (xargs :measure (nfix n)))");
        nl("  (if (equal label 'ret)");
        ReturnInst retInst = (ReturnInst) fun.blocks.get(fun.blocks.size() - 1).terminator;
        nl("      " + operandStr(retInst.operands[0]));
        nl("    (if (zp n) nil");
        nl("      (mv-let");
        nl("        (new-label new-mem new-loc)");
        nl("        (@" + fun.name + "-step label mem loc pred)");
        nl("        (@" + fun.name + "-steps new-label new-mem new-loc label (1- n))))))");
        nl("");
        nl("(defund @" + fun.name + " (" + args + ")");
        nl("  (declare (ignore " + args + "))");
        nl("   nil)");
    }

    private void genModule(Module module, String[] deps) {
        out.print("(in-package \"ACL2\")");
        nl("(include-book \"std/util/defrule\" :dir :system)");
        nl("(include-book \"../llvm\")");
        for (String dep : deps) {
            nl("(include-book \"" + dep + "\")");
        }
        String moduleName = module.funs.get(0).name;
        nl("");
        nl("(defconst *" + moduleName + "-globals* '(");
        indent += 2;
        for (Value global : module.globals) {
            nl("(" + global.name + globalStr(global) + ")");
        }
        out.print("))");
        indent -= 2;
        nl("");
        nl("(defconst *" + moduleName + "-labels* '(");
        for (Function fun : module.funs) {
            if (fun.blocks.isEmpty()) {
                continue;
            }
            for (int i = 0; i < fun.blocks.size(); i++) {
                if (i > 0) {
                    out.print(" ");
                }
                out.print("%" + fun.blocks.get(i).label);
            }
        }
        out.print("))");
        for (Function fun : module.funs) {
            if (fun.blocks.isEmpty()) {
                continue;
            }
            genFunction(fun);
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
                    DumpACL2Steps dump = new DumpACL2Steps(out);
                    dump.genModule(module, deps);
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

    private static void appendDoublePiece(StringBuilder sb, String piece) {
        assert piece.startsWith("double ");
        piece = piece.substring("double ".length());
        long bits;
        if (piece.startsWith("0x")) {
            bits = Long.parseUnsignedLong(piece.substring(2), 16);
        } else {
            bits = Double.doubleToLongBits(Double.parseDouble(piece));
        }
        sb.append(String.format(" #x%08x #x%08x", bits & 0xFFFFFFFFL, bits >>> 32));
    }

    private static void appendI32Piece(StringBuilder sb, String piece) {
        assert piece.startsWith("i32 ");
        piece = piece.substring("i32 ".length());
        int bits = Integer.parseInt(piece);
        sb.append(String.format(" #x%08x", bits & 0xFFFFFFFFL));
    }

    private static String globalStr(Value global) {
        StringBuilder sb = new StringBuilder();
        String rep = global.representation;
        int indexEq = rep.indexOf('=');
        rep = rep.substring(indexEq + 1);
        int indexOfAlign = rep.indexOf(", align");
        if (indexOfAlign >= 0) {
            rep = rep.substring(0, indexOfAlign);
        }
        rep = rep.trim();
        if (rep.startsWith("internal global double ")) {
            rep = rep.substring("internal global ".length());
            appendDoublePiece(sb, rep);
        } else if (rep.startsWith("internal constant double ")) {
            rep = rep.substring("internal constant ".length());
            appendDoublePiece(sb, rep);
        } else if (rep.startsWith("internal constant [2 x double] [")) {
            rep = rep.substring("internal constant [2 x double] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendDoublePiece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [4 x double] [")) {
            rep = rep.substring("internal constant [4 x double] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendDoublePiece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [8 x double] [")) {
            rep = rep.substring("internal constant [8 x double] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendDoublePiece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [11 x double] [")) {
            rep = rep.substring("internal constant [11 x double] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendDoublePiece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [16 x double] [")) {
            rep = rep.substring("internal constant [16 x double] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendDoublePiece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [4 x i32] [")) {
            rep = rep.substring("internal constant [4 x i32] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendI32Piece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [32 x i32] [")) {
            rep = rep.substring("internal constant [32 x i32] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendI32Piece(sb, piece);
            }
        } else if (rep.startsWith("internal constant [66 x i32] [")) {
            rep = rep.substring("internal constant [66 x i32] [".length());
            int indexOfRBracket = rep.indexOf(']');
            rep = rep.substring(0, indexOfRBracket);
            String[] pieces = rep.split(", ");
            for (String piece : pieces) {
                appendI32Piece(sb, piece);
            }
        } else {
            throw new UnsupportedOperationException();
        }
        return sb.toString();
    }

    private String operandStr(Value operand) {
        if (operand instanceof Instruction) {
            return "(g '" + ((Instruction) operand).refName + " loc)";
        } else if (operand instanceof Constant.ConstantInt) {
            if (operand.representation.startsWith("i32 ")
                    || operand.representation.startsWith("i64 ")) {
                return operand.representation.substring(4);
            } else {
                assert operand.representation.startsWith("i1");
                return operand.representation.substring(3).replace("false", "0").replace("true", "-1");
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
                String[] ss1 = {
                    "double* getelementptr inbounds ([2 x double], [2 x double]* @",
                    "double* getelementptr inbounds ([4 x double], [4 x double]* @",
                    "double* getelementptr inbounds ([11 x double], [11 x double]* @",
                    "double* getelementptr inbounds ([16 x double], [16 x double]* @",};
                String s2 = ", i32 0, i64 ";
                String s3 = ")";
                int indexOfS2 = operand.representation.indexOf(s2);
                if (indexOfS2 >= 0 && operand.representation.endsWith(s3)) {
                    String offsetStr = operand.representation.substring(
                            indexOfS2 + s2.length(),
                            operand.representation.length() - s3.length());
                    int offset = Integer.valueOf(offsetStr);
                    for (String s1 : ss1) {
                        if (operand.representation.startsWith(s1)) {
                            String nameStr = operand.representation.substring(s1.length(), indexOfS2);
                            return "(getelementptr-double '(" + nameStr + " . 0) " + offset + ")";
                        }
                    }
                }
                throw new UnsupportedOperationException();
            } else if (operand.representation.startsWith("i32* ")) {
                String s1a = "i32* bitcast (double* @";
                String s2a = " to i32*)";
                String s1b = "i32* getelementptr inbounds ([66 x i32], [66 x i32]* @";
                String s2b = ", i32 0, i32 0)";
                if (operand.representation.startsWith(s1a)
                        && operand.representation.endsWith(s2a)) {
                    String s = operand.representation.substring(s1a.length(), operand.representation.length() - s2a.length());
                    return "'(" + s + " . 0)";
                } else if (operand.representation.startsWith(s1b)
                        && operand.representation.endsWith(s2b)) {
                    String s = operand.representation.substring(s1b.length(), operand.representation.length() - s2b.length());
                    return "'(" + s + " . 0)";
                } else {
                    throw new UnsupportedOperationException();
                }
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (operand instanceof Constant.GlobalVariable) {
            int indAt = operand.representation.indexOf('@');
            int indSp = operand.representation.indexOf(' ', indAt);
            return "'(" + operand.representation.substring(indAt + 1, indSp) + " . 0)";
        } else if (operand instanceof BasicBlock) {
            return "label %" + ((BasicBlock) operand).label;
        } else if (operand instanceof Value.Argument) {
            return "(g '%" + operand.name + " loc)";
        } else {
            throw new UnsupportedOperationException();
        }
    }

    private void setAlloca(Instruction inst, String type, String nm, String size) {
        size = size != null ? " " + size : "";
        if (smallFuns) {
            nl("(defund " + inst.fn("mem") + " (" + st() + ")");
            nl("  (alloca-" + type + " '" + nm + size + " " + lastMem + "))");
            lastMem = "(" + inst.fn("mem") + " " + st() + ")";
            nl("(defund " + inst.fn("loc") + " (" + st() + ")");
            nl("  (s '" + inst.refName + " '(" + nm + " . 0) " + lastLoc + "))");
            lastLoc = "(" + inst.fn("loc") + " " + st() + ")";
        } else if (revFuns) {
            nl("(" + nextRev + " (alloca-" + type + " '" + nm + size + " mem)"
                    + " (s '" + inst.refName + " '(" + nm + " . 0) loc) pred)");
        } else {
            nl("(mem (alloca-" + type + " '" + nm + size + " mem))");
            nl("(loc (s '" + inst.refName + " '(" + nm + " . 0) loc))");
        }
    }

    private void setLoc(Instruction inst, String expr) {
        if (smallFuns) {
            nl("(defund " + inst.fn("val") + " (" + st() + ")");
            nl("  " + expr
                    .replace("mem", lastMem)
                    .replace("loc", lastLoc)
                    .replace("pred", lastPred)
                    + ")");
            nl("(defund " + inst.fn("loc") + " (" + st() + ")");
            nl("  (s '" + inst.refName + " (" + inst.fn("val") + " " + st() + ") " + lastLoc + "))");
            lastLoc = "(" + inst.fn("loc") + " " + st() + ")";
        } else if (revFuns) {
            nl("(" + nextRev + " mem (s '" + inst.refName + " " + expr + " loc) pred)");
        } else {
            nl("(loc (s '" + inst.refName + " " + expr + " loc))");
        }
    }

    private void setMem(Instruction inst, String newMem) {
        if (smallFuns) {
            nl("(defund " + inst.fn("mem") + " (" + st() + ")");
            nl("  " + newMem.replace("mem", lastMem).replace("loc", lastLoc) + ")");
            lastMem = "(" + inst.fn("mem") + " " + st() + ")";
        } else if (revFuns) {
            nl("(" + nextRev + " " + newMem + " loc pred)");
        } else {
            nl("(mem " + newMem + ")");
        }
    }

    private void setSucc(TerminatorInst inst, String label) {
        if (smallFuns) {
            nl("(defund " + inst.fn("lab") + " (" + st() + ")");
            if (label.indexOf("loc") < 0) {
                nl("  (declare (ignore s" + curBb.label + "))");
            }
            nl("  " + label.replace("loc", lastLoc) + ")");
        } else if (revFuns) {
            nl("(declare (ignore pred))");
            nl("(mv " + label + " mem loc)");
        } else {
            nl("(succ " + label + ")");
        }
    }

    @Override
    public Void visitBinaryOperator(Instruction.BinaryOperator inst, Void p) {
        String opname = inst.opcode.name().substring(4).toLowerCase();
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        if (inst.typesMatch("double", "double", "double")) {
            setLoc(inst, "(" + opname + "-double " + op0 + " " + op1 + ")");
        } else if (inst.typesMatch("i32", "i32", "i32")) {
            setLoc(inst, "(" + opname + "-i32 " + op0 + " " + op1 + ")");
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
            String expr = "(@" + fn.name;
            for (int i = 0; i < fn.args.size(); i++) {
                expr += " " + operandStr(inst.operands[i]);
            }
            expr += ")";
            setLoc(inst, expr);
        } else if (inst.type.typeStr.equals("i32")) {
            String expr = "(@" + fn.name;
            for (int i = 0; i < fn.args.size(); i++) {
                expr += " " + operandStr(inst.operands[i]);
            }
            expr += ")";
            setLoc(inst, expr);
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitFCmpInst(Instruction.CmpInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        String cmp = Utils.realPredicateOf(LLVMGetFCmpPredicate(inst.getPeer())).name();
        cmp = cmp.substring("LLVMReal".length()).toLowerCase();
        if (inst.typesMatch("i1", "double", "double")) {
            setLoc(inst, "(fcmp-" + cmp + "-double " + op0 + " " + op1 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitICmpInst(Instruction.ICmpInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        String cmp = Utils.intPredicateOf(LLVMGetICmpPredicate(inst.getPeer())).name();
        cmp = cmp.substring("LLVMInt".length()).toLowerCase();
        if (inst.typesMatch("i1", "i32", "i32")) {
            setLoc(inst, "(icmp-" + cmp + "-i32 " + op0 + " " + op1 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitGetElementPtrInst(Instruction.GetElementPtrInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        if (inst.typesMatch("double*", "double*", "i64")) {
            setLoc(inst, "(getelementptr-double " + op0 + " " + op1 + ")");
        } else if (inst.typesMatch("i32*", "i32*", "i64")) {
            setLoc(inst, "(getelementptr-i32 " + op0 + " " + op1 + ")");
        } else if (inst.typesMatch("double*", "[2 x double]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double*", "[2 x double]*", "i32", "i32")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double*", "[3 x double]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double*", "[3 x double]*", "i32", "i32")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double*", "[4 x double]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double*", "[8 x double]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double*", "[20 x double]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-double " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("i32*", "[4 x i32]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-i32 " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("i32*", "[20 x i32]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-i32 " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("i32*", "[32 x i32]*", "i32", "i64")) {
            String op2 = operandStr(inst.operands[2]);
            if (op1.equals("0")) {
                setLoc(inst, "(getelementptr-i32 " + op0 + " " + op2 + ")");
            } else {
                throw new UnsupportedOperationException();
            }
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitPHINode(Instruction.PHINode inst, Void p) {
        if (inst.type.typeStr.equals("double")) {
            String s = "(case pred";
            for (int i = 0; i < inst.incomingBlocks.length; i++) {
                int label = inst.incomingBlocks[i].label;
                String value = operandStr(inst.incomingValues[i]);
                s += " (%" + label + " " + value + ")";
            }
            s += ")";
            setLoc(inst, s);
        } else if (inst.type.typeStr.equals("i1")) {
            String s = "(case pred";
            for (int i = 0; i < inst.incomingBlocks.length; i++) {
                int label = inst.incomingBlocks[i].label;
                String value = operandStr(inst.incomingValues[i]);
                s += " (%" + label + " " + value + ")";
            }
            s += ")";
            setLoc(inst, s);
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitSelectInst(Instruction.SelectInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        String op2 = operandStr(inst.operands[2]);
        if (inst.typesMatch("double", "i1", "double", "double")) {
            setLoc(inst, "(select-double " + op0 + " " + op1 + " " + op2 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitStoreInst(Instruction.StoreInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        String op1 = operandStr(inst.operands[1]);
        if (inst.typesMatch("void", "double", "double*")) {
            setMem(inst, "(store-double " + op0 + " " + op1 + " mem)");
        } else if (inst.typesMatch("void", "i32", "i32*")) {
            setMem(inst, "(store-i32 " + op0 + " " + op1 + " mem)");
        } else if (inst.typesMatch("void", "double*", "double**")) {
            setMem(inst, "(store-pointer " + op0 + " " + op1 + " mem)");
        } else if (inst.typesMatch("void", "i32*", "i32**")) {
            setMem(inst, "(store-pointer " + op0 + " " + op1 + " mem)");
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
                setAlloca(inst, "double", nm, "1");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("i32*", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "i32", nm, "1");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("[2 x double]*", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "double", nm, "2");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("[3 x double]*", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "i32", nm, "3");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("[20 x double]*", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "double", nm, "20");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("[20 x i32]*", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "i32", nm, "20");
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("double**", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "pointer", nm, null);
            } else {
                throw new UnsupportedOperationException();
            }
        } else if (inst.typesMatch("i32**", "i32")) {
            if (op0.equals("1")) {
                setAlloca(inst, "pointer", nm, null);
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
            setLoc(inst, "(bitcast-double*-to-i32* " + op0 + ")");
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
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("i32", "double")) {
            setLoc(inst, "(fptosi-double-to-i32 " + op0 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitSExtInst(Instruction.SExtInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("i64", "i32")) {
            setLoc(inst, "(sext-i32-to-i64 " + op0 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitSIToFPInst(Instruction.SIToFPInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("double", "i32")) {
            setLoc(inst, "(sitofp-i32-to-double " + op0 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitUIToFPInst(Instruction.UIToFPInst inst, Void p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Void visitZExtInst(Instruction.ZExtInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("i64", "i32")) {
            setLoc(inst, "(zext-i32-to-i64 " + op0 + ")");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitLoadInst(Instruction.LoadInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        if (inst.typesMatch("double", "double*")) {
            setLoc(inst, "(load-double " + op0 + " mem)");
        } else if (inst.typesMatch("i32", "i32*")) {
            setLoc(inst, "(load-i32 " + op0 + " mem)");
        } else if (inst.typesMatch("double*", "double**")) {
            setLoc(inst, "(load-pointer " + op0 + " mem)");
        } else if (inst.typesMatch("i32*", "i32**")) {
            setLoc(inst, "(load-pointer " + op0 + " mem)");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitBranchInst(TerminatorInst.BranchInst inst, Void p) {
        if (inst.typesMatch("void", "label")) {
            BasicBlock bb0 = (BasicBlock) inst.operands[0];
            setSucc(inst, "'%" + bb0.label);
        } else if (inst.typesMatch("void", "i1", "label", "label")) {
            String op0 = operandStr(inst.operands[0]);
            BasicBlock bb1 = (BasicBlock) inst.operands[1];
            BasicBlock bb2 = (BasicBlock) inst.operands[2];
            setSucc(inst, "(case " + op0 + " (-1 '%" + bb2.label + ") (0 '%" + bb1.label + "))");
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    @Override
    public Void visitReturnInst(TerminatorInst.ReturnInst inst, Void p) {
        setSucc(inst, "'ret");
        return null;
    }

    @Override
    public Void visitSwitchInst(TerminatorInst.SwitchInst inst, Void p) {
        String op0 = operandStr(inst.operands[0]);
        BasicBlock defaultLabel = (BasicBlock) inst.operands[1];
        if (inst.operands[0].type.typeStr.equals("i32")) {
            int numCases = inst.operands.length / 2 - 1;
            String s = "(case " + op0;
            for (int i = 0; i < numCases; i++) {
                String tag = operandStr(inst.operands[i * 2 + 2]);
                BasicBlock label = (BasicBlock) inst.operands[i * 2 + 3];
                s += "(" + tag + " '%" + label.label + ")";
            }
            s += " (otherwise '%" + defaultLabel.label + "))";
            setSucc(inst, s);
        } else {
            throw new UnsupportedOperationException();
        }
        return null;
    }

    private static final String[][] sortedFiles = {
        {"w_acos.bc", "e_acos"},
        {"e_acos.bc", "w_sqrt"},
        {"w_asin.bc", "e_asin"},
        {"e_asin.bc", "s_fabs", "w_sqrt"},
        {"s_atan.bc", "s_fabs"},
        {"w_atan2.bc", "e_atan2"},
        {"e_atan2.bc", "s_fabs", "s_atan"},
        {"s_cbrt.bc"},
        {"s_copysign.bc"},
        {"s_cos.bc", "k_cos", "k_sin", "e_rem_pio2"},
        {"k_cos.bc"},
        {"w_cosh.bc", "e_cosh"},
        {"e_cosh.bc", "s_fabs", "s_expm1", "e_exp"},
        {"w_exp.bc", "e_exp"},
        {"e_exp.bc"},
        {"s_expm1.bc"},
        {"s_fabs.bc"},
        {"s_floor.bc"},
        {"w_hypot.bc", "e_hypot"},
        {"e_hypot.bc", "w_sqrt"},
        {"w_log.bc", "e_log"},
        {"e_log.bc"},
        {"w_log10.bc", "e_log10"},
        {"e_log10.bc", "e_log"},
        {"s_log1p.bc"},
        {"w_pow.bc", "e_pow"},
        {"e_pow.bc", "w_sqrt", "s_fabs", "s_scalbn"},
        {"e_rem_pio2.bc", "s_fabs", "k_rem_pio2"},
        {"k_rem_pio2.bc", "s_floor", "s_scalbn"},
        {"s_scalbn.bc", "s_copysign"},
        {"s_sin.bc", "k_sin", "k_cos", "e_rem_pio2"},
        {"k_sin.bc"},
        {"w_sinh.bc", "e_sinh"},
        {"e_sinh.bc", "s_fabs", "s_expm1", "e_exp"},
        {"w_sqrt.bc", "e_sqrt"},
        {"e_sqrt.bc"},
        {"s_tan.bc", "k_tan", "e_rem_pio2"},
        {"k_tan.bc", "s_fabs"},
        {"s_tanh.bc", "s_fabs", "s_expm1"}
    };

    public static void main(String[] args) throws IOException {
        for (String[] filenames : sortedFiles) {
            String filename = filenames[0];
            String[] deps = Arrays.copyOfRange(filenames, 1, filenames.length);
            System.out.println(filename);
            dumpFile("netlib.llvm/", filename, deps, "acl2/llvms/");
        }
    }
}
