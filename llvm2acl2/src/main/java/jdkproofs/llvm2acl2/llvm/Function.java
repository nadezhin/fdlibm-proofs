package jdkproofs.llvm2acl2.llvm;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 *
 */
public class Function extends Constant.GlobalObject {

    public final Type funType;
    public final Type returnType;
    public final List<Value.Argument> args;
    public final List<BasicBlock> blocks;
    public final int attribute;
    public final String attributesGroup;

    Function(long peer) {
        super(peer);
        funType = Type.valueOf(LLVMGetReturnType(type.getPeer()));
        returnType = Type.valueOf(LLVMGetReturnType(funType.getPeer()));

        List<Value.Argument> params = new ArrayList<>();
        long prevParamRef = 0;
        long paramRef = LLVMGetFirstParam(peer);
        while (paramRef != 0) {
            assert LLVMGetPreviousParam(paramRef) == prevParamRef;
            params.add((Value.Argument) Value.valueOf(this, paramRef));
            prevParamRef = paramRef;
            paramRef = LLVMGetNextParam(paramRef);
        }
        assert LLVMGetLastParam(peer) == prevParamRef;
        args = Collections.unmodifiableList(params);

        List<BasicBlock> blocks = new ArrayList<>();
        long prevBbRef = 0;
        long bbRef = LLVMGetFirstBasicBlock(peer);
        long entry = LLVMGetEntryBasicBlock(peer);
        assert bbRef == 0 || entry == bbRef;
        while (bbRef != 0) {
            assert LLVMGetPreviousBasicBlock(bbRef) == prevBbRef;
            BasicBlock bb = BasicBlock.valueOf(this, bbRef);
            blocks.add(bb);
            prevBbRef = bbRef;
            bbRef = LLVMGetNextBasicBlock(bbRef);
            int indLabel = representation.indexOf("\n; <label>:" + bb.label + " ");
            if (indLabel >= 0) {
                int indPreds = representation.indexOf("; preds =", indLabel);
                int indEol = representation.indexOf("\n", indPreds);
                bb.preds = representation.substring(indPreds + "; preds =".length(), indEol);
            }
        }
        assert LLVMGetLastBasicBlock(peer) == prevBbRef;
        this.blocks = Collections.unmodifiableList(blocks);
        int indSharp = representation.indexOf('#');
        int indSp = representation.indexOf(' ', indSharp);
        if (indSp < 0) {
            assert representation.endsWith("\n");
            indSp = representation.length() - 1;
        }
        attribute = LLVMGetFunctionAttr(peer);
        attributesGroup = representation.substring(indSharp, indSp);

        if (!blocks.isEmpty()) {
            for (int i = blocks.size() - 1; i >= 0; i--) {
                BasicBlock bb = blocks.get(i);
                for (BasicBlock succ : bb.terminator.successors) {
                    if (succ.label > bb.label) {
                        for (Map.Entry<Integer, BasicBlock> e : succ.inLoops.entrySet()) {
                            if (e.getKey() <= bb.label) {
                                bb.inLoops.put(e.getKey(), e.getValue());
                            }
                        }
                    } else {
                        bb.inLoops.put(succ.label, succ);
                    }
                }
                bb.updateUse();
//                if (!bb.inLoops.isEmpty()) {
//                    System.out.print("  " + bb.label + " in loops");
//                    for (Integer label: bb.inLoops.keySet()) {
//                        System.out.print(" " + label);
//                        if (label == bb.label) {
//                            System.out.print('!');
//                        }
//                    }
//                    System.out.println();
//                }
            }
        }
    }

    static Function valueOf(long peer) {
        Function fun = findValue(peer, Function.class);
        if (fun == null) {
            fun = new Function(peer);
        }
        return fun;
    }

    @Override
    <R, P> R accept(Visitor<R, P> visitor, P p) {
        return visitor.visitFunction(this, p);
    }

    public void show() {
        LLVMValueRef fun = getValueRef();
        System.out.print("function " + name + " " + Utils.valueStr(fun));
        if (blocks.isEmpty()) {
            System.out.println(" external");
            return;
        }
        System.out.println();
        for (BasicBlock bb : blocks) {
            bb.show();
        }
    }
}
