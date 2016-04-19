package jdkproofs.llvm2acl2.llvm2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
public class User extends Value {

    User(long peer) {
        super(peer);
    }

    public static User valueOf(Function fun, long peer) {
        assert LLVMIsAArgument(peer) == 0;
        assert LLVMIsAInlineAsm(peer) == 0;
        assert LLVMIsAUser(peer) == peer;
        assert LLVMIsAMDNode(peer) == 0;
        assert LLVMIsAMDString(peer) == 0;
        User u = findValue(peer, User.class);
        if (u != null) {
            return u;
        }
        List<User> ret = new ArrayList<>(1);
        long newPeer;
        if ((newPeer = LLVMIsAConstant(peer)) != 0) {
            assert newPeer == peer;
            ret.add(Constant.valueOf(fun, peer));
        }
        if ((newPeer = LLVMIsAInstruction(peer)) != 0) {
            assert newPeer == peer;
            ret.add(Instruction.valueOf(fun, peer));
        }
        assert ret.size() == 1;
        return ret.get(0);
    }

    public static interface Visitor<R, P> extends Instruction.Visitor<R, P> {

        R visitConstantExpr(Constant.ConstantExpr c, P p);

        R visitConstantFP(Constant.ConstantFP c, P p);

        R visitConstantInt(Constant.ConstantInt c, P p);

        R visitGlobalVariable(Constant.GlobalVariable c, P p);

        R visitFunction(Function c, P p);
    }

    /*
     com.github.nadezhin.llvm2acl2.Value$Argument
     */

    <R, P> R accept(Visitor<R, P> visitor, P p) {
        throw new UnsupportedOperationException();
    }
}
