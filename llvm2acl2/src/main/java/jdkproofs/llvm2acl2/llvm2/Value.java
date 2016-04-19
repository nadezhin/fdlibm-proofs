package jdkproofs.llvm2acl2.llvm2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.bridj.Pointer;

/**
 *
 */
public class Value {

    public final String name;
    public final Type type;
    public final boolean isConstant;
    public final boolean isUndef;
    public final String representation;

    private final long peer;

    public static Set<Class> usedSubclasses = new HashSet<>();
    static Map<Long, Value> allValues = new HashMap<>();

    Value(long peer) {
        this.peer = peer;
        allValues.put(peer, this);
        name = Pointer.pointerToAddress(LLVMGetValueName(peer)).getCString();
        type = Type.valueOf(LLVMTypeOf(peer));
        isConstant = LLVMIsAConstant(peer) != 0;
        isUndef = LLVMIsUndef(peer) != 0;
        usedSubclasses.add(getClass());
        Pointer<Byte> rep = LLVMPrintValueToString(getValueRef());
        String r = rep.getCString();
        representation = r;
        rep.release();
    }

    public long getPeer() {
        return peer;
    }

    LLVMValueRef getValueRef() {
        return new LLVMValueRef(peer);
    }

    public String getName() {
        return name;
    }

    public static class Argument extends Value {

        Argument(long peer) {
            super(peer);
            assert LLVMIsAUser(peer) == 0;
        }
    }

    public static class InlineAsm extends Value {

        InlineAsm(long peer) {
            super(peer);
        }
    }

    public static class MDNode extends Value {

        MDNode(long peer) {
            super(peer);
        }
    }

    public static class MDString extends Value {

        MDString(long peer) {
            super(peer);
        }
    }

    static void clear() {
        allValues.clear();
    }

    static <C extends Value> C findValue(long peer, Class<C> cls) {
        return cls.cast(allValues.get(peer));
    }

    public static Value valueOf(Function fun, long peer) {
        Value v = findValue(peer, Value.class);
        if (v != null) {
            return v;
        }
        List<Value> ret = new ArrayList<>(1);
        long newPeer;
        if ((newPeer = LLVMIsAArgument(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new Argument(peer));
        }
        if ((newPeer = LLVMIsABasicBlock(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new BasicBlock(fun, peer));
        }
        if ((newPeer = LLVMIsAInlineAsm(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new InlineAsm(peer));
        }
        if ((newPeer = LLVMIsAUser(peer)) != 0) {
            assert newPeer == peer;
            ret.add(User.valueOf(fun, peer));
        }
        if ((newPeer = LLVMIsAMDNode(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new MDNode(peer));
        }
        if ((newPeer = LLVMIsAMDString(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new MDString(peer));
        }
        assert ret.size() == 1;
        return ret.get(0);
    }
}
