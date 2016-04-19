package jdkproofs.llvm2acl2.llvm;

import static jdkproofs.llvm2acl2.LLVM37Library.*;

/**
 *
 */
public class Context {

    public LLVMTypeRef voidTypeRef;
    public LLVMTypeRef labelTypeRef;

    private final long peer;

    Context(long peer) {
        this.peer = peer;
        voidTypeRef = LLVMVoidTypeInContext(getContextRef());
        labelTypeRef = LLVMLabelTypeInContext(getContextRef());
    }

    long getPeer() {
        return peer;
    }

    LLVMContextRef getContextRef() {
        return new LLVMContextRef(peer);
    }

    public void show() {
        System.out.println("  voidTypeRef=" + Utils.typeRefStr(voidTypeRef));
        System.out.println("  labelTypeRef=" + Utils.typeRefStr(labelTypeRef));
    }

}
