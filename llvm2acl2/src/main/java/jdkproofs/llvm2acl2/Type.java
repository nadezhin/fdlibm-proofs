package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;

import java.util.HashMap;
import java.util.Map;
import org.bridj.Pointer;

/**
 *
 */
public class Type {

    private final static Map<Long, Type> allTypes = new HashMap<>();
    private final long peer;
    public final String typeStr;

    Type(long peer) {
        this.peer = peer;
        Pointer<Byte> typeStr = LLVMPrintTypeToString(getTypeRef());
        this.typeStr = typeStr.getCString();
        typeStr.release();
    }

    long getPeer() {
        return peer;
    }

    LLVMTypeRef getTypeRef() {
        return new LLVMTypeRef(peer);
    }
    
    @Override
    public String toString() {
        return typeStr + ":" + Long.toHexString(peer);
    }
    
    static void clear() {
        allTypes.clear();
    }

    static Type valueOf(long peer) {
        if (peer == 0) {
            return null;
        }
        Type t = allTypes.get(peer);
        if (t == null) {
            t = new Type(peer);
            allTypes.put(peer, t);
        }
        return t;
    }
}
