package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.bridj.Pointer;

/**
 *
 */
public class Module {
    public final String dataLayout;
    public final String target;
    public final List<Value> globals;
    public final List<Function> funs;
    public final Context context;
    public final String tail;
    
    private final long peer;
    
    Module(long peer) {
        this.peer = peer;
        Type.clear();
        Value.clear();
        Pointer<Byte> repRef = LLVMPrintModuleToString(getModuleRef());
        String rep = repRef.getCString();
        repRef.release();
        LLVMModuleRef module = new LLVMModuleRef(peer); 
        Pointer<Byte> dataLayoutRef = LLVMGetDataLayout(module);
        assert Pointer.getPeer(LLVMGetDataLayout(module)) == Pointer.getPeer(dataLayoutRef);
        dataLayout = dataLayoutRef.getCString();
        Pointer<Byte> targetRef = LLVMGetTarget(module);
        assert Pointer.getPeer(LLVMGetTarget(module)) == Pointer.getPeer(targetRef);
        target = targetRef.getCString();
        LLVMContextRef contextRef = LLVMGetModuleContext(module);
        assert Pointer.getPeer(LLVMGetModuleContext(module)) == Pointer.getPeer(contextRef);
        context = new Context(Pointer.getPeer(contextRef));
//        int metadataLength = LLVMGetNamedMetadataNumOperands(module);

        List<Value> globals = new ArrayList<>();
        long prevGlobalRef = 0;
        long globalRef = LLVMGetFirstGlobal(peer);
        while (globalRef != 0) {
            assert LLVMGetPreviousGlobal(globalRef) == prevGlobalRef;
            globals.add(Value.valueOf(null, globalRef));
            prevGlobalRef = globalRef;
            globalRef = LLVMGetNextGlobal(globalRef);
        }
        assert LLVMGetLastGlobal(peer) == prevGlobalRef;
        this.globals = Collections.unmodifiableList(globals);

        List<Function> funs = new ArrayList<>();
        long prevFunRef = 0;
        long funRef = LLVMGetFirstFunction(peer);
        while (funRef != 0) {
            assert LLVMGetPreviousFunction(funRef) == prevFunRef;
            funs.add(Function.valueOf(funRef));
            prevFunRef = funRef;
            funRef = LLVMGetNextFunction(funRef);
        }
        assert LLVMGetLastFunction(peer) == prevFunRef;
        for (Function fun: funs) {
            Pointer<Byte> nameRef = Pointer.pointerToCString(fun.getName());
            assert Pointer.getPeer(LLVMGetNamedFunction(module, nameRef)) == fun.getPeer();
            nameRef.release();
        }
        this.funs = Collections.unmodifiableList(funs);
        
        tail = rep.substring(rep.indexOf(funs.isEmpty() ? "!llvm.ident =" : "attributes #0 ="));
    }
    
    long getPeer() {
        return peer;
    }
    
    LLVMModuleRef getModuleRef() {
        return new LLVMModuleRef(peer);
    }
    
    String getDataLayout() {
        return dataLayout;
    }
    
    String getTarget() {
        return target;
    }
    
    Context getContext() {
        return context;
    }
    
    public void show() {
        System.out.println("target datalayout = \"" + dataLayout + "\"");
        System.out.println("target triple = \"" + target + "\"");
        context.show();
        for (Function fun: funs) {
            fun.show();
        }
        System.out.println("====================");
    }
}
