package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.io.File;
import org.bridj.Pointer;

/**
 *
 */
public class Main {

    private static void showFile(String file) {
        System.out.println(file);
        int ok;

        Pointer<Byte> path = Pointer.pointerToCString(file);
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
                module.show();
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

    private static void showDir(String dir) {
        File dirFile = new File(dir);
        for (String file : dirFile.list()) {
            if (file.endsWith(".bc")) {
                showFile(dir + '/' + file);
            }
        }
    }

    public static void main(String[] args) {
        showDir("../../t/ole71/jvm/fdlibm/netlib.llvm");
        for (Class cls: Value.usedSubclasses) {
            System.out.println(cls.getName());
        }
    }
}
/*
com.github.nadezhin.llvm2acl2.Value$FPExtInst
com.github.nadezhin.llvm2acl2.Value$BitCastInst
com.github.nadezhin.llvm2acl2.Value$ReturnInst
com.github.nadezhin.llvm2acl2.Function
com.github.nadezhin.llvm2acl2.BasicBlock
com.github.nadezhin.llvm2acl2.Value$ZExtInst
com.github.nadezhin.llvm2acl2.Value$SelectInst
com.github.nadezhin.llvm2acl2.Value$SwitchInst
com.github.nadezhin.llvm2acl2.Value$AllocaInst
com.github.nadezhin.llvm2acl2.Value$SExtInst
com.github.nadezhin.llvm2acl2.Value$FPToSIInst
com.github.nadezhin.llvm2acl2.Value$SIToFPInst
com.github.nadezhin.llvm2acl2.Value$StoreInst
com.github.nadezhin.llvm2acl2.Value$PHINode
com.github.nadezhin.llvm2acl2.Value$LoadInst
com.github.nadezhin.llvm2acl2.Value$UIToFPInst
com.github.nadezhin.llvm2acl2.Value$CallInst
com.github.nadezhin.llvm2acl2.Value$ConstantFP
com.github.nadezhin.llvm2acl2.Value$GetElementPtrInst
com.github.nadezhin.llvm2acl2.Value$ICmpInst
com.github.nadezhin.llvm2acl2.Value$FCmpInst
com.github.nadezhin.llvm2acl2.Value$ConstantInt
com.github.nadezhin.llvm2acl2.Value$BinaryOperator
com.github.nadezhin.llvm2acl2.Value$GlobalVariable
com.github.nadezhin.llvm2acl2.Value$ConstantExpr
com.github.nadezhin.llvm2acl2.Value$Argument
com.github.nadezhin.llvm2acl2.Value$BranchInst
*/
