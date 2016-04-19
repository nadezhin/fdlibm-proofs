package jdkproofs.llvm2acl2.llvm2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import org.bridj.Pointer;

/**
 *
 */
public class Utils {

    static LLVMOpcode opcodeOf(int opcodeValue) {
        for (LLVMOpcode opcode : LLVMOpcode.values()) {
            if (opcode.value() == opcodeValue) {
                return opcode;
            }
        }
        throw new AssertionError();
    }

    public static LLVMIntPredicate intPredicateOf(int intPredicateValue) {
        for (LLVMIntPredicate ip : LLVMIntPredicate.values()) {
            if (ip.value() == intPredicateValue) {
                return ip;
            }
        }
        throw new AssertionError();
    }

    public static LLVMRealPredicate realPredicateOf(int realPredicateValue) {
        for (LLVMRealPredicate rp : LLVMRealPredicate.values()) {
            if (rp.value() == realPredicateValue) {
                return rp;
            }
        }
        throw new AssertionError();
    }

    static String typeRefStr(LLVMTypeRef typeRef) {
        Pointer<Byte> typeStr = LLVMPrintTypeToString(typeRef);
        String s = typeStr.getCString() + ":" + Long.toHexString(Pointer.getPeer(typeRef));
        typeStr.release();
        return s;
    }

    static String valueStr(LLVMValueRef value) {
        LLVMTypeRef typeRef = LLVMTypeOf(value);
        return "[" + typeRefStr(typeRef) + "@" + Long.toHexString(Pointer.getPeer(value)) + "]";
    }
}
