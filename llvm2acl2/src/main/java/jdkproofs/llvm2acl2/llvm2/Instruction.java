package jdkproofs.llvm2acl2.llvm2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.List;

/**
 *
 */
public class Instruction extends User implements Comparable<Instruction> {

    public final LLVMOpcode opcode;
    public final String refName;
    public final int refNum;
    public final Value[] operands;
    public final int alignment;

    Instruction(Function fun, long peer) {
        super(peer);
        opcode = Utils.opcodeOf(LLVMGetInstructionOpcode(peer));
        checkOpcode();
        int ind = representation.indexOf('=');
        if (ind >= 0) {
            refName = representation.substring(0, ind).trim();
            assert refName.charAt(0) == '%';
            int refNum;
            try {
                refNum = Integer.valueOf(refName.substring(1));
            } catch (NumberFormatException e) {
                refNum = 0;
            }
            this.refNum = refNum;
        } else {
            refName = null;
            refNum = 0;
        }
        operands = new Value[LLVMGetNumOperands(peer)];
        for (int i = 0; i < operands.length; i++) {
            operands[i] = Value.valueOf(fun, LLVMGetOperand(peer, i));
        }
        alignment = LLVMGetAlignment(peer);
    }

    public boolean typesMatch(String retType, String... argTypes) {
        if (argTypes.length != operands.length) {
            return false;
        }
        if (!type.typeStr.equals(retType)) {
            return false;
        }
        for (int i = 0; i < operands.length; i++) {
            if (!operands[i].type.typeStr.equals(argTypes[i])) {
                return false;
            }
        }
        return true;
    }

    private static final EnumSet<LLVMOpcode> IsAInstruction = EnumSet.allOf(LLVMOpcode.class);
    private static final EnumSet<LLVMOpcode> IsATerminatorInst = EnumSet.of(
            LLVMOpcode.LLVMRet,
            LLVMOpcode.LLVMBr,
            LLVMOpcode.LLVMSwitch,
            LLVMOpcode.LLVMIndirectBr,
            LLVMOpcode.LLVMInvoke,
            LLVMOpcode.LLVMUnreachable);
    private static final EnumSet<LLVMOpcode> IsABinaryOperator = EnumSet.of(
            LLVMOpcode.LLVMAdd,
            LLVMOpcode.LLVMFAdd,
            LLVMOpcode.LLVMSub,
            LLVMOpcode.LLVMFSub,
            LLVMOpcode.LLVMMul,
            LLVMOpcode.LLVMFMul,
            LLVMOpcode.LLVMUDiv,
            LLVMOpcode.LLVMSDiv,
            LLVMOpcode.LLVMFDiv,
            LLVMOpcode.LLVMURem,
            LLVMOpcode.LLVMSRem,
            LLVMOpcode.LLVMFRem,
            LLVMOpcode.LLVMShl,
            LLVMOpcode.LLVMLShr,
            LLVMOpcode.LLVMAShr,
            LLVMOpcode.LLVMAnd,
            LLVMOpcode.LLVMOr,
            LLVMOpcode.LLVMXor);
    private static final EnumSet<LLVMOpcode> IsACmpInst = EnumSet.of(
            LLVMOpcode.LLVMICmp,
            LLVMOpcode.LLVMFCmp);
    private static final EnumSet<LLVMOpcode> IsAUnaryInstruction = EnumSet.of(
            LLVMOpcode.LLVMAlloca,
            LLVMOpcode.LLVMLoad,
            LLVMOpcode.LLVMTrunc,
            LLVMOpcode.LLVMZExt,
            LLVMOpcode.LLVMSExt,
            LLVMOpcode.LLVMFPToUI,
            LLVMOpcode.LLVMFPToSI,
            LLVMOpcode.LLVMUIToFP,
            LLVMOpcode.LLVMSIToFP,
            LLVMOpcode.LLVMFPTrunc,
            LLVMOpcode.LLVMFPExt,
            LLVMOpcode.LLVMPtrToInt,
            LLVMOpcode.LLVMIntToPtr,
            LLVMOpcode.LLVMBitCast,
            LLVMOpcode.LLVMAddrSpaceCast,
            LLVMOpcode.LLVMVAArg
    );
    private static final EnumSet<LLVMOpcode> IsACastInstuction = EnumSet.of(
            LLVMOpcode.LLVMTrunc,
            LLVMOpcode.LLVMZExt,
            LLVMOpcode.LLVMSExt,
            LLVMOpcode.LLVMFPToUI,
            LLVMOpcode.LLVMFPToSI,
            LLVMOpcode.LLVMUIToFP,
            LLVMOpcode.LLVMSIToFP,
            LLVMOpcode.LLVMFPTrunc,
            LLVMOpcode.LLVMFPExt,
            LLVMOpcode.LLVMPtrToInt,
            LLVMOpcode.LLVMIntToPtr,
            LLVMOpcode.LLVMBitCast,
            LLVMOpcode.LLVMAddrSpaceCast
    );

    private void checkOpcode() {
        long peer = getPeer();
        // Instruction groups
        checkOpcode(LLVMIsAInstruction(peer), IsAInstruction, Instruction.class);
        checkOpcode(LLVMIsATerminatorInst(peer), IsATerminatorInst, TerminatorInst.class);
        checkOpcode(LLVMIsABinaryOperator(peer), IsABinaryOperator, BinaryOperator.class);
        checkOpcode(LLVMIsAUnaryInstruction(peer), IsAUnaryInstruction, UnaryInstruction.class);
        checkOpcode(LLVMIsACastInst(peer), IsACastInstuction, CastInst.class);
        checkOpcode(LLVMIsACmpInst(peer), IsACmpInst, CmpInst.class);

        // Instructions
        checkOpcode(LLVMIsAReturnInst(peer), LLVMOpcode.LLVMRet, TerminatorInst.ReturnInst.class);
        checkOpcode(LLVMIsABranchInst(peer), LLVMOpcode.LLVMBr, TerminatorInst.BranchInst.class);
        checkOpcode(LLVMIsASwitchInst(peer), LLVMOpcode.LLVMSwitch, TerminatorInst.SwitchInst.class);
        checkOpcode(LLVMIsAIndirectBrInst(peer), LLVMOpcode.LLVMIndirectBr, TerminatorInst.IndirectBrInst.class);
        checkOpcode(LLVMIsAInvokeInst(peer), LLVMOpcode.LLVMInvoke, TerminatorInst.InvokeInst.class);
        checkOpcode(LLVMIsAUnreachableInst(peer), LLVMOpcode.LLVMUnreachable, TerminatorInst.UnreachableInst.class);
        /* binary operations have no subclasses . . . */
        checkOpcode(LLVMIsAAllocaInst(peer), LLVMOpcode.LLVMAlloca, AllocaInst.class);
        checkOpcode(LLVMIsALoadInst(peer), LLVMOpcode.LLVMLoad, LoadInst.class);
        checkOpcode(LLVMIsAStoreInst(peer), LLVMOpcode.LLVMStore, StoreInst.class);
        checkOpcode(LLVMIsAGetElementPtrInst(peer), LLVMOpcode.LLVMGetElementPtr, GetElementPtrInst.class);
        checkOpcode(LLVMIsATruncInst(peer), LLVMOpcode.LLVMTrunc, TruncInst.class);
        checkOpcode(LLVMIsAZExtInst(peer), LLVMOpcode.LLVMZExt, ZExtInst.class);
        checkOpcode(LLVMIsASExtInst(peer), LLVMOpcode.LLVMSExt, SExtInst.class);
        checkOpcode(LLVMIsAFPToUIInst(peer), LLVMOpcode.LLVMFPToUI, FPToUIInst.class);
        checkOpcode(LLVMIsAFPToSIInst(peer), LLVMOpcode.LLVMFPToSI, FPToSIInst.class);
        checkOpcode(LLVMIsAUIToFPInst(peer), LLVMOpcode.LLVMUIToFP, UIToFPInst.class);
        checkOpcode(LLVMIsASIToFPInst(peer), LLVMOpcode.LLVMSIToFP, SIToFPInst.class);
        checkOpcode(LLVMIsAFPTruncInst(peer), LLVMOpcode.LLVMFPTrunc, FPTruncInst.class);
        checkOpcode(LLVMIsAFPExtInst(peer), LLVMOpcode.LLVMFPExt, FPExtInst.class);
        checkOpcode(LLVMIsAPtrToIntInst(peer), LLVMOpcode.LLVMPtrToInt, PtrToIntInst.class);
        checkOpcode(LLVMIsAIntToPtrInst(peer), LLVMOpcode.LLVMIntToPtr, IntToPtrInst.class);
        checkOpcode(LLVMIsABitCastInst(peer), LLVMOpcode.LLVMBitCast, BitCastInst.class);
        checkOpcode(LLVMIsAAddrSpaceCastInst(peer), LLVMOpcode.LLVMAddrSpaceCast, AddrSpaceCastInst.class);
        checkOpcode(LLVMIsAICmpInst(peer), LLVMOpcode.LLVMICmp, ICmpInst.class);
        checkOpcode(LLVMIsAFCmpInst(peer), LLVMOpcode.LLVMFCmp, FCmpInst.class);
        checkOpcode(LLVMIsAPHINode(peer), LLVMOpcode.LLVMPHI, PHINode.class);

        checkOpcode(LLVMIsACallInst(peer), LLVMOpcode.LLVMCall, CallInst.class);
        checkOpcode(LLVMIsAIntrinsicInst(peer), LLVMOpcode.LLVMCall, IntrinsicInst.class);
        checkOpcode(LLVMIsADbgInfoIntrinsic(peer), LLVMOpcode.LLVMCall, DbgInfoIntrinsic.class);
        checkOpcode(LLVMIsADbgDeclareInst(peer), LLVMOpcode.LLVMCall, DbgDeclareInst.class);
        checkOpcode(LLVMIsAMemIntrinsic(peer), LLVMOpcode.LLVMCall, MemIntrinsic.class);
        checkOpcode(LLVMIsAMemCpyInst(peer), LLVMOpcode.LLVMCall, MemCpyInst.class);
        checkOpcode(LLVMIsAMemMoveInst(peer), LLVMOpcode.LLVMCall, MemMoveInst.class);
        checkOpcode(LLVMIsAMemSetInst(peer), LLVMOpcode.LLVMCall, MemSetInst.class);

        checkOpcode(LLVMIsASelectInst(peer), LLVMOpcode.LLVMSelect, SelectInst.class);
        /* LLVMOpcode.UserOp1 */
 /* LLVMOpcode.UserOp2 */
        checkOpcode(LLVMIsAVAArgInst(peer), LLVMOpcode.LLVMVAArg, VAArgInst.class);
        checkOpcode(LLVMIsAExtractElementInst(peer), LLVMOpcode.LLVMExtractElement, ExtractElementInst.class);
        checkOpcode(LLVMIsAInsertElementInst(peer), LLVMOpcode.LLVMInsertElement, InsertElementInst.class);
        checkOpcode(LLVMIsAShuffleVectorInst(peer), LLVMOpcode.LLVMShuffleVector, ShuffleVectorInst.class);
        checkOpcode(LLVMIsAExtractValueInst(peer), LLVMOpcode.LLVMExtractValue, ExtractValueInst.class);
        checkOpcode(LLVMIsAInsertValueInst(peer), LLVMOpcode.LLVMInsertValue, InsertValueInst.class);
        /* LLVMCode.Fence */
 /* LLVMCode.AtomicCmpXchg */
 /* LLVMCode.RMW */
        checkOpcode(LLVMIsAResumeInst(peer), LLVMOpcode.LLVMResume, TerminatorInst.ResumeInst.class);
        checkOpcode(LLVMIsALandingPadInst(peer), LLVMOpcode.LLVMLandingPad, LandingPadInst.class);
    }

    private void checkOpcode(long check, EnumSet<LLVMOpcode> enumSet, Class<? extends Instruction> cls) {
        assert check == (enumSet.contains(opcode) ? getPeer() : 0);
        assert check == (cls.isInstance(this) ? getPeer() : 0);
    }

    private void checkOpcode(long check, LLVMOpcode opcode, Class<? extends Instruction> cls) {
        assert opcode == this.opcode || check == 0;
        assert check == (cls.isInstance(this) ? getPeer() : 0);
    }

    @Override
    public int compareTo(Instruction o) {
        if (this.refNum == 0 && o.refNum == 0) {
            return this.refName.compareTo(o.refName);
        } else {
            return Integer.compare(this.refNum, o.refNum);
        }
    }

    public static class BinaryOperator extends Instruction {

        BinaryOperator(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitBinaryOperator(this, p);
        }
    }

    public static class CallInst extends Instruction {

        public final String attributeGroup;

        CallInst(Function fun, long peer) {
            super(fun, peer);
            int indSharp = this.representation.indexOf('#');
            attributeGroup = indSharp >= 0
                    ? this.representation.substring(indSharp)
                    : null;
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitCallInst(this, p);
        }
    }

    public static class IntrinsicInst extends CallInst {

        IntrinsicInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class DbgInfoIntrinsic extends IntrinsicInst {

        DbgInfoIntrinsic(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class DbgDeclareInst extends IntrinsicInst {

        DbgDeclareInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class MemIntrinsic extends IntrinsicInst {

        MemIntrinsic(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class MemCpyInst extends MemIntrinsic {

        MemCpyInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class MemMoveInst extends MemIntrinsic {

        MemMoveInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class MemSetInst extends MemIntrinsic {

        MemSetInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class CmpInst extends Instruction {

        CmpInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class FCmpInst extends CmpInst {

        FCmpInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitFCmpInst(this, p);
        }
    }

    public static class ICmpInst extends CmpInst {

        ICmpInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitICmpInst(this, p);
        }
    }

    public static class ExtractElementInst extends Instruction {

        ExtractElementInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class GetElementPtrInst extends Instruction {

        GetElementPtrInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitGetElementPtrInst(this, p);
        }
    }

    public static class InsertElementInst extends Instruction {

        InsertElementInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class InsertValueInst extends Instruction {

        InsertValueInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class LandingPadInst extends Instruction {

        LandingPadInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class PHINode extends Instruction {

        public BasicBlock[] incomingBlocks;
        public User[] incomingValues;

        PHINode(Function fun, long peer) {
            super(fun, peer);
            incomingBlocks = new BasicBlock[LLVMCountIncoming(peer)];
            incomingValues = new User[incomingBlocks.length];
            for (int i = 0; i < incomingBlocks.length; i++) {
                incomingBlocks[i] = BasicBlock.valueOf(fun, LLVMGetIncomingBlock(getPeer(), i));
                incomingValues[i] = User.valueOf(fun, LLVMGetIncomingValue(peer, i));
            }
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitPHINode(this, p);
        }
    }

    public static class SelectInst extends Instruction {

        SelectInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitSelectInst(this, p);
        }
    }

    public static class ShuffleVectorInst extends Instruction {

        ShuffleVectorInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class StoreInst extends Instruction {

        StoreInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitStoreInst(this, p);
        }
    }

    public static class UnaryInstruction extends Instruction {

        UnaryInstruction(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class AllocaInst extends UnaryInstruction {

        AllocaInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitAllocaInst(this, p);
        }
    }

    public static class CastInst extends UnaryInstruction {

        CastInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class AddrSpaceCastInst extends CastInst {

        AddrSpaceCastInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class BitCastInst extends CastInst {

        BitCastInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitBitCastInst(this, p);
        }
    }

    public static class FPExtInst extends CastInst {

        FPExtInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitFPExtInst(this, p);
        }
    }

    public static class FPToSIInst extends CastInst {

        FPToSIInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitFPToSIInst(this, p);
        }
    }

    public static class FPToUIInst extends CastInst {

        FPToUIInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class FPTruncInst extends CastInst {

        FPTruncInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class IntToPtrInst extends CastInst {

        IntToPtrInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class PtrToIntInst extends CastInst {

        PtrToIntInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class SExtInst extends CastInst {

        SExtInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitSExtInst(this, p);
        }
    }

    public static class SIToFPInst extends CastInst {

        SIToFPInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitSIToFPInst(this, p);
        }
    }

    public static class TruncInst extends CastInst {

        TruncInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class UIToFPInst extends CastInst {

        UIToFPInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitUIToFPInst(this, p);
        }
    }

    public static class ZExtInst extends CastInst {

        ZExtInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitZExtInst(this, p);
        }
    }

    public static class ExtractValueInst extends UnaryInstruction {

        ExtractValueInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class LoadInst extends UnaryInstruction {

        LoadInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitLoadInst(this, p);
        }
    }

    public static class VAArgInst extends UnaryInstruction {

        VAArgInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static Instruction valueOf(Function fun, long peer) {
        assert LLVMIsAUser(peer) == peer;
        assert LLVMIsAArgument(peer) == 0;
        assert LLVMIsAInlineAsm(peer) == 0;
        assert LLVMIsAConstant(peer) == 0;
        assert LLVMIsAInstruction(peer) == peer;
        assert LLVMIsAMDNode(peer) == 0;
        assert LLVMIsAMDString(peer) == 0;
        Instruction inst = findValue(peer, Instruction.class);
        if (inst != null) {
            return inst;
        }
        List<Instruction> ret = new ArrayList<>(1);
        long newPeer;
        if ((newPeer = LLVMIsABinaryOperator(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new BinaryOperator(fun, peer));
        }
        if ((newPeer = LLVMIsACallInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new CallInst(fun, peer));
        }
//        if ((newPeer = LLVMIsAIntrinsicInst(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new IntrinsicInst(fun, peer));
//        }
        if ((newPeer = LLVMIsADbgInfoIntrinsic(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new DbgInfoIntrinsic(fun, peer));
        }
        if ((newPeer = LLVMIsADbgDeclareInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new DbgDeclareInst(fun, peer));
        }
//        if ((newPeer = LLVMIsAMemIntrinsic(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new MemIntrinsic(fun, peer));
//        }
        if ((newPeer = LLVMIsAMemCpyInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new MemCpyInst(fun, peer));
        }
        if ((newPeer = LLVMIsAMemMoveInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new MemMoveInst(fun, peer));
        }
        if ((newPeer = LLVMIsAMemSetInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new MemSetInst(fun, peer));
        }
//        if ((newPeer = LLVMIsACmpInst(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new CmpInst(fun, peer));
//        }
        if ((newPeer = LLVMIsAFCmpInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new FCmpInst(fun, peer));
        }
        if ((newPeer = LLVMIsAICmpInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ICmpInst(fun, peer));
        }
        if ((newPeer = LLVMIsAExtractElementInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ExtractElementInst(fun, peer));
        }
        if ((newPeer = LLVMIsAGetElementPtrInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new GetElementPtrInst(fun, peer));
        }
        if ((newPeer = LLVMIsAInsertElementInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new InsertElementInst(fun, peer));
        }
        if ((newPeer = LLVMIsAInsertValueInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new InsertValueInst(fun, peer));
        }
        if ((newPeer = LLVMIsALandingPadInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new LandingPadInst(fun, peer));
        }
        if ((newPeer = LLVMIsAPHINode(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new PHINode(fun, peer));
        }
        if ((newPeer = LLVMIsASelectInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new SelectInst(fun, peer));
        }
        if ((newPeer = LLVMIsAShuffleVectorInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ShuffleVectorInst(fun, peer));
        }
        if ((newPeer = LLVMIsAStoreInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new StoreInst(fun, peer));
        }
        if ((newPeer = LLVMIsATerminatorInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(TerminatorInst.valueOf(fun, peer));
        }
//        if ((newPeer = LLVMIsAUnaryInstruction(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new UnaryInstruction(fun, peer));
//        }
        if ((newPeer = LLVMIsAAllocaInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new AllocaInst(fun, peer));
        }
//        if ((newPeer = LLVMIsACastInst(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new CastInst(fun, peer));
//        }
        if ((newPeer = LLVMIsAAddrSpaceCastInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new AddrSpaceCastInst(fun, peer));
        }
        if ((newPeer = LLVMIsABitCastInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new BitCastInst(fun, peer));
        }
        if ((newPeer = LLVMIsAFPExtInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new FPExtInst(fun, peer));
        }
        if ((newPeer = LLVMIsAFPToSIInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new FPToSIInst(fun, peer));
        }
        if ((newPeer = LLVMIsAFPToUIInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new FPToUIInst(fun, peer));
        }
        if ((newPeer = LLVMIsAFPTruncInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new FPTruncInst(fun, peer));
        }
        if ((newPeer = LLVMIsAIntToPtrInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new IntToPtrInst(fun, peer));
        }
        if ((newPeer = LLVMIsAPtrToIntInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new PtrToIntInst(fun, peer));
        }
        if ((newPeer = LLVMIsASExtInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new SExtInst(fun, peer));
        }
        if ((newPeer = LLVMIsASIToFPInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new SIToFPInst(fun, peer));
        }
        if ((newPeer = LLVMIsATruncInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new TruncInst(fun, peer));
        }
        if ((newPeer = LLVMIsAUIToFPInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new UIToFPInst(fun, peer));
        }
        if ((newPeer = LLVMIsAZExtInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ZExtInst(fun, peer));
        }
        if ((newPeer = LLVMIsAExtractValueInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ExtractValueInst(fun, peer));
        }
        if ((newPeer = LLVMIsALoadInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new LoadInst(fun, peer));
        }
        if ((newPeer = LLVMIsAVAArgInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new VAArgInst(fun, peer));
        }
        assert ret.size() == 1;
        Instruction retu = ret.get(0);
        assert (retu instanceof MemIntrinsic) == (LLVMIsAMemIntrinsic(peer) != 0);
        assert (retu instanceof IntrinsicInst) == (LLVMIsAIntrinsicInst(peer) != 0);
        assert (retu instanceof CmpInst) == (LLVMIsACmpInst(peer) != 0);
        assert (retu instanceof TerminatorInst) == (LLVMIsATerminatorInst(peer) != 0);
        assert (retu instanceof CastInst) == (LLVMIsACastInst(peer) != 0);
        assert (retu instanceof UnaryInstruction) == (LLVMIsAUnaryInstruction(peer) != 0);
        return retu;
    }

    /**
     *
     */
    public static interface Visitor<R, P> {

        R visitBinaryOperator(BinaryOperator inst, P p);

        R visitCallInst(CallInst inst, P p);

        R visitFCmpInst(CmpInst inst, P p);

        R visitICmpInst(ICmpInst inst, P p);

        R visitGetElementPtrInst(GetElementPtrInst inst, P p);

        R visitPHINode(PHINode inst, P p);

        R visitSelectInst(SelectInst inst, P p);

        R visitStoreInst(StoreInst inst, P p);

        R visitAllocaInst(AllocaInst inst, P p);

        R visitBitCastInst(BitCastInst inst, P p);

        R visitFPExtInst(FPExtInst inst, P p);

        R visitFPToSIInst(FPToSIInst inst, P p);

        R visitSExtInst(SExtInst inst, P p);

        R visitSIToFPInst(SIToFPInst inst, P p);

        R visitUIToFPInst(UIToFPInst inst, P p);

        R visitZExtInst(ZExtInst inst, P p);

        R visitLoadInst(LoadInst inst, P p);

        R visitBranchInst(TerminatorInst.BranchInst inst, P p);

        R visitReturnInst(TerminatorInst.ReturnInst inst, P p);

        R visitSwitchInst(TerminatorInst.SwitchInst inst, P p);
    }

    public <R, P> R accept(Visitor<R, P> visitor, P p) {
        throw new UnsupportedOperationException();
    }
}
