package jdkproofs.llvm2acl2.llvm;

import com.sun.tools.classfile.Instruction;

/**
 *
 */
public class AbstractInstructionVisitor<R,P> implements Instruction.KindVisitor<R,P> {

    @Override
    public R visitNoOperands(Instruction i, P p) {
        return null;
    }

    @Override
    public R visitArrayType(Instruction i, Instruction.TypeKind tk, P p) {
        return null;
    }

    @Override
    public R visitBranch(Instruction i, int i1, P p) {
        return null;
    }

    @Override
    public R visitConstantPoolRef(Instruction i, int i1, P p) {
        return null;
    }

    @Override
    public R visitConstantPoolRefAndValue(Instruction i, int i1, int i2, P p) {
        return null;
    }

    @Override
    public R visitLocal(Instruction i, int i1, P p) {
        return null;
    }

    @Override
    public R visitLocalAndValue(Instruction i, int i1, int i2, P p) {
        return null;
    }

    @Override
    public R visitLookupSwitch(Instruction i, int i1, int i2, int[] ints, int[] ints1, P p) {
        return null;
    }

    @Override
    public R visitTableSwitch(Instruction i, int i1, int i2, int i3, int[] ints, P p) {
        return null;
    }

    @Override
    public R visitValue(Instruction i, int i1, P p) {
        return null;
    }

    @Override
    public R visitUnknown(Instruction i, P p) {
        return null;
    }
}
