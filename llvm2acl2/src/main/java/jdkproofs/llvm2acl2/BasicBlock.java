package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.BitSet;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;
import org.bridj.IntValuedEnum;
import org.bridj.Pointer;

/**
 *
 */
public class BasicBlock extends Value {

    public final Function function;
    public final int label;
    public final Constant.BlockAddress addr;
    public final List<Instruction> insts;
    public final int numPhi;
    public final TerminatorInst terminator;
    public String preds;
    public Map<Integer, BasicBlock> inLoops = new TreeMap<>();
    // use
    public final BitSet useArgs = new BitSet();
    public final SortedSet<Instruction> useInstructions = new TreeSet<>();

    BasicBlock(Function function, long peer) {
        super(peer);
        this.function = function;
        assert LLVMGetBasicBlockParent(peer) == function.getPeer();
        if (representation.startsWith("\n; <label>:")) {
            assert representation.startsWith("\n; <label>:");
            int index = representation.indexOf(' ', 11);
            label = Integer.valueOf(representation.substring(11, index));
        } else {
            label = 0;
        }

        addr = (Constant.BlockAddress) Constant.valueOf(function, LLVMBlockAddress(function.getPeer(), peer));
        List<Instruction> insts = new ArrayList<>();
        long prevInstRef = 0;
        long instRef = LLVMGetFirstInstruction(peer);
        while (instRef != 0) {
            assert LLVMGetPreviousInstruction(instRef) == prevInstRef;
            insts.add(Instruction.valueOf(function, instRef));
            prevInstRef = instRef;
            instRef = LLVMGetNextInstruction(instRef);
        }
        assert LLVMGetLastInstruction(peer) == prevInstRef;
        assert LLVMGetBasicBlockTerminator(peer) == prevInstRef;
        int numPhi = 0;
        for (int i = 0; i < insts.size() - 1; i++) {
            Instruction instr = insts.get(i);
            assert !(instr instanceof TerminatorInst);
            if (instr instanceof Instruction.PHINode) {
                assert i == numPhi;
                numPhi++;
            }
        }
        this.numPhi = numPhi;
        this.insts = Collections.unmodifiableList(insts);
        terminator = (TerminatorInst) insts.get(insts.size() - 1);
    }

    LLVMBasicBlockRef getBasicBlockRef() {
        return new LLVMBasicBlockRef(getPeer());
    }

    public static BasicBlock valueOf(Function fun, long peer) {
        BasicBlock bb = findValue(peer, BasicBlock.class);
        if (bb != null) {
            assert bb.function == fun;
            return bb;
        }
        return new BasicBlock(fun, peer);
    }

    void updateUse() {
        for (BasicBlock succ : terminator.successors) {
            useArgs.or(succ.useArgs);
            for (Instruction inst : succ.useInstructions) {
                if (inst instanceof Instruction.PHINode) {
                    Instruction.PHINode phi = (Instruction.PHINode) inst;
                    for (int i = 0; i < phi.incomingBlocks.length; i++) {
                        if (phi.incomingBlocks[i] == this) {
                            User value = phi.incomingValues[i];
                            if (value instanceof Instruction) {
                                assert ((Instruction) value).refName != null;
                                useInstructions.add((Instruction) value);
                            }
                        }
                    }
                } else {
                    useInstructions.add(inst);
                }
            }
        }
        for (int i = insts.size() - 1; i >= 0; i--) {
            Instruction inst = insts.get(i);
            if (inst instanceof Instruction.PHINode) {
                assert useInstructions.contains(inst);
                continue;
            }
            if (inst.refName != null) {
                useInstructions.remove(inst);
            }
            for (Value operand : inst.operands) {
                if (operand instanceof Argument) {
                    useArgs.set(function.args.indexOf(operand));
//                } else if (operand instanceof Instruction.PHINode) {
                } else if (operand instanceof Instruction) {
                    Instruction operandI = (Instruction) operand;
                    assert operandI.refName != null;
                    assert inst.refName == null || operandI.refNum < inst.refNum;
                    useInstructions.add(operandI);
                } else {
                    assert operand instanceof Constant || operand instanceof BasicBlock;
                }
            }
        }
    }

    String getDefArgs() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < function.args.size(); i++) {
            if (useArgs.get(i)) {
                if (sb.length() > 0) {
                    sb.append(' ');
                }
                sb.append('%').append(function.args.get(i).name);
            }
        }
        for (Instruction inst : useInstructions) {
            if (sb.length() > 0) {
                sb.append(' ');
            }
            sb.append(inst.refName);
        }
        return sb.toString();
    }

    private void showInstruction(LLVMValueRef inst) {
        IntValuedEnum<LLVMOpcode> opcodeVal = LLVMGetInstructionOpcode(inst);
        LLVMOpcode opcode = null;
        for (LLVMOpcode op : LLVMOpcode.values()) {
            if (op.value() == opcodeVal.value()) {
                opcode = op;
                break;
            }
        }
        Pointer<Byte> name = LLVMGetValueName(inst);
        int numOperands = LLVMGetNumOperands(inst);
        System.out.print("    " + Utils.valueStr(inst) + " " + name.getCString() + " " + opcode);
        for (int i = 0; i < numOperands; i++) {
            LLVMValueRef user = LLVMGetOperand(inst, i);
            Value.valueOf(function, Pointer.getPeer(user));
            IntValuedEnum<LLVMOpcode> userOpcodeVal = LLVMGetInstructionOpcode(user);
            System.out.print(" " + Utils.valueStr(user));
        }
        System.out.println();
    }

    void show() {
        LLVMValueRef addr = LLVMBlockAddress(function.getValueRef(), getBasicBlockRef());
        System.out.println("  basic block " + Utils.valueStr(getValueRef()) + " " + label);
//        LLVMDumpValue(addr);
        System.out.print("  use:");
        for (int i = 0; i < function.args.size(); i++) {
            if (useArgs.get(i)) {
                System.out.print(" " + function.args.get(i).name);
            }
        }
        for (Instruction inst : useInstructions) {
            System.out.print(" " + inst.refName);
        }
        System.out.println();
        for (Value inst : insts) {
            showInstruction(inst.getValueRef());
        }
    }
}
