package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
public class Constant extends User {

    Constant(long peer) {
        super(peer);
    }

    public static class BlockAddress extends Constant {

        BlockAddress(long peer) {
            super(peer);
        }
    }

    public static class ConstantAggregateZero extends Constant {

        ConstantAggregateZero(long peer) {
            super(peer);
        }
    }

    public static class ConstantArray extends Constant {

        ConstantArray(long peer) {
            super(peer);
        }
    }

    public static class ConstantDataSequential extends Constant {

        ConstantDataSequential(long peer) {
            super(peer);
        }
    }

    public static class ConstantDataArray extends ConstantDataSequential {

        ConstantDataArray(long peer) {
            super(peer);
        }
    }

    public static class ConstantDataVector extends ConstantDataSequential {

        ConstantDataVector(long peer) {
            super(peer);
        }
    }

    public static class ConstantExpr extends Constant {

        ConstantExpr(long peer) {
            super(peer);
        }

        @Override
        <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitConstantExpr(this, p);
        }
    }

    public static class ConstantFP extends Constant {

        ConstantFP(long peer) {
            super(peer);
        }

        @Override
        <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitConstantFP(this, p);
        }
    }

    public static class ConstantInt extends Constant {

        ConstantInt(long peer) {
            super(peer);
        }

        @Override
        <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitConstantInt(this, p);
        }
    }

    public static class ConstantPointerNull extends Constant {

        ConstantPointerNull(long peer) {
            super(peer);
        }
    }

    public static class ConstantStruct extends Constant {

        ConstantStruct(long peer) {
            super(peer);
        }
    }

    public static class ConstantVector extends Constant {

        ConstantVector(long peer) {
            super(peer);
        }
    }

    public static class GlobalValue extends Constant {

        GlobalValue(long peer) {
            super(peer);
        }
    }

    public static class GlobalAlias extends GlobalValue {

        GlobalAlias(long peer) {
            super(peer);
        }
    }

    public static class GlobalObject extends GlobalValue {

        GlobalObject(long peer) {
            super(peer);
        }
    }

    public static class GlobalVariable extends GlobalObject {

        GlobalVariable(long peer) {
            super(peer);
        }

        @Override
        <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitGlobalVariable(this, p);
        }
    }

    public static class UndefValue extends Constant {

        UndefValue(long peer) {
            super(peer);
        }
    }

    public static Constant valueOf(Function fun, long peer) {
        assert LLVMIsAUser(peer) == peer;
        assert LLVMIsAArgument(peer) == 0;
        assert LLVMIsAInlineAsm(peer) == 0;
        assert LLVMIsAConstant(peer) == peer;
        assert LLVMIsAInstruction(peer) == 0;
        assert LLVMIsAMDNode(peer) == 0;
        assert LLVMIsAMDString(peer) == 0;
        Constant c = findValue(peer, Constant.class);
        if (c != null) {
            return c;
        }
        List<Constant> ret = new ArrayList<>(1);
        long newPeer;
        if ((newPeer = LLVMIsABlockAddress(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new BlockAddress(peer));
        }
        if ((newPeer = LLVMIsAConstantAggregateZero(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantAggregateZero(peer));
        }
        if ((newPeer = LLVMIsAConstantArray(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantArray(peer));
        }
//        if ((newPeer = LLVMIsAConstantDataSequential(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new ConstantDataSequential(peer));
//        }
        if ((newPeer = LLVMIsAConstantDataArray(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantDataArray(peer));
        }
        if ((newPeer = LLVMIsAConstantDataVector(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantDataVector(peer));
        }
        if ((newPeer = LLVMIsAConstantExpr(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantExpr(peer));
        }
        if ((newPeer = LLVMIsAConstantFP(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantFP(peer));
        }
        if ((newPeer = LLVMIsAConstantInt(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantInt(peer));
        }
        if ((newPeer = LLVMIsAConstantPointerNull(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantPointerNull(peer));
        }
        if ((newPeer = LLVMIsAConstantStruct(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantStruct(peer));
        }
        if ((newPeer = LLVMIsAConstantVector(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ConstantVector(peer));
        }
//        if ((newPeer = LLVMIsAGlobalValue(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new GlobalValue(peer));
//        }
        if ((newPeer = LLVMIsAGlobalAlias(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new GlobalAlias(peer));
        }
//        if ((newPeer = LLVMIsAGlobalObject(peer)) != 0) {
//            assert newPeer == peer;
//            ret.add(new GlobalObject(peer));
//        }
        if ((newPeer = LLVMIsAFunction(peer)) != 0) {
            assert newPeer == peer;
            ret.add(Function.valueOf(peer));
        }
        if ((newPeer = LLVMIsAGlobalVariable(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new GlobalVariable(peer));
        }
        if ((newPeer = LLVMIsAUndefValue(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new UndefValue(peer));
        }
        assert ret.size() == 1;
        Constant retu = ret.get(0);
        assert (retu instanceof ConstantDataSequential) == (LLVMIsAConstantDataSequential(peer) != 0);
        assert (retu instanceof GlobalValue) == (LLVMIsAGlobalValue(peer) != 0);
        assert (retu instanceof GlobalObject) == (LLVMIsAGlobalObject(peer) != 0);
        return retu;
    }
}
