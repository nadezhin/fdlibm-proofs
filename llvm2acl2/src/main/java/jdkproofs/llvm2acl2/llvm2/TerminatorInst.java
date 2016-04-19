package jdkproofs.llvm2acl2.llvm2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 *
 */
public class TerminatorInst extends Instruction {

    public List<BasicBlock> successors;

    TerminatorInst(Function fun, long peer) {
        super(fun, peer);
        List<BasicBlock> successors = new ArrayList<>();
        int numSuccessors = LLVMGetNumSuccessors(peer);
        for (int i = 0; i < numSuccessors; i++) {
            successors.add(BasicBlock.valueOf(fun, LLVMGetSuccessor(peer, i)));
        }
        this.successors = Collections.unmodifiableList(successors);
    }

    public static class BranchInst extends TerminatorInst {

        BranchInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitBranchInst(this, p);
        }
    }

    public static class IndirectBrInst extends TerminatorInst {

        IndirectBrInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class InvokeInst extends TerminatorInst {

        InvokeInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class ReturnInst extends TerminatorInst {

        ReturnInst(Function fun, long peer) {
            super(fun, peer);
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitReturnInst(this, p);
        }
    }

    public static class SwitchInst extends TerminatorInst {

        public final String[] tags;
        public final BasicBlock[] labels;
        public final BasicBlock defaultDest;

        SwitchInst(Function fun, long peer) {
            super(fun, peer);
            defaultDest = BasicBlock.valueOf(fun, LLVMGetSwitchDefaultDest(peer));
            assert defaultDest == successors.get(0);
            int numCases = successors.size() - 1;
            String[] lines = representation.split("\n");
            assert lines.length == numCases + 2;
            assert lines[0].startsWith("  switch ");
            assert lines[numCases + 1].equals("  ]");
            tags = new String[numCases];
            labels = Arrays.copyOfRange(successors.toArray(new BasicBlock[numCases + 1]), 1, numCases + 1);
            assert labels.length == numCases;
            for (int i = 0; i < numCases; i++) {
                String line = lines[i + 1];
                int ind = line.indexOf(',');
                line = line.substring(0, ind).trim();
                assert line.startsWith("i32 ");
                tags[i] = line.substring("i32 ".length());
            }
        }

        @Override
        public <R, P> R accept(Visitor<R, P> visitor, P p) {
            return visitor.visitSwitchInst(this, p);
        }
    }

    public static class UnreachableInst extends TerminatorInst {

        UnreachableInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static class ResumeInst extends TerminatorInst {

        ResumeInst(Function fun, long peer) {
            super(fun, peer);
        }
    }

    public static TerminatorInst valueOf(Function fun, long peer) {
        assert LLVMIsAUser(peer) == peer;
        assert LLVMIsAInstruction(peer) == peer;
        assert LLVMIsATerminatorInst(peer) == peer;
        List<TerminatorInst> ret = new ArrayList<>(1);
        long newPeer;
        if ((newPeer = LLVMIsABranchInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new BranchInst(fun, peer));
        }
        if ((newPeer = LLVMIsAIndirectBrInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new IndirectBrInst(fun, peer));
        }
        if ((newPeer = LLVMIsAInvokeInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new InvokeInst(fun, peer));
        }
        if ((newPeer = LLVMIsAReturnInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ReturnInst(fun, peer));
        }
        if ((newPeer = LLVMIsASwitchInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new SwitchInst(fun, peer));
        }
        if ((newPeer = LLVMIsAUnreachableInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new UnreachableInst(fun, peer));
        }
        if ((newPeer = LLVMIsAResumeInst(peer)) != 0) {
            assert newPeer == peer;
            ret.add(new ResumeInst(fun, peer));
        }
        assert ret.size() == 1;
        return ret.get(0);
    }
}
