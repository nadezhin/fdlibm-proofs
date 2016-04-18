package jdkproofs.llvm2acl2;

import com.sun.tools.classfile.Code_attribute;
import com.sun.tools.classfile.Instruction;
import com.sun.tools.classfile.Method;
import com.sun.tools.classfile.Opcode;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

/**
 *
 */
public class JavaCFG {

    public static class JBasicBlock {

        public int blockLabel;
        public List<Instruction> instrs = new ArrayList<>();
        public Instruction lastInst;
        public Opcode cond;
        public List<Integer> labels = new ArrayList<>();
    }

    public List<JBasicBlock> blocks = new ArrayList<JBasicBlock>();

    JavaCFG(Method m, int... additionalLabels) {
        Code_attribute code = (Code_attribute) m.attributes.get("Code");
        Map<Integer, Integer> labels = collectLabels(code, additionalLabels);
        Iterator<Map.Entry<Integer, Integer>> labIt = labels.entrySet().iterator();
        Iterator<Instruction> instrIt = code.getInstructions().iterator();
        Map.Entry<Integer, Integer> startE = labIt.next();
        int startLab = startE.getKey();
        assert startLab == 0;
        while (labIt.hasNext()) {
            Map.Entry<Integer, Integer> endE = labIt.next();
            int endLab = endE.getKey();
            if (endLab == Integer.MAX_VALUE) {
                endLab = code.code_length;
            }
            JBasicBlock jbb = new JBasicBlock();
            jbb.blockLabel = startE.getValue();
            for (;;) {
                Instruction inst = instrIt.next();
                int pc = inst.getPC();
                assert pc < endLab;
                jbb.instrs.add(inst);
                if (pc + inst.length() >= endLab) {
                    break;
                }
            }
            assert jbb.instrs.get(0).getPC() == startLab;
            jbb.lastInst = jbb.instrs.get(jbb.instrs.size() - 1);

            LabelVisitor labelVisitor = new LabelVisitor();
            jbb.lastInst.accept(labelVisitor, jbb.lastInst.getPC());
            if (labelVisitor.labels.isEmpty()) {
                jbb.labels.add(labels.get(jbb.lastInst.getPC() + jbb.lastInst.length()));
            } else {
                for (int lab : labelVisitor.labels) {
                    jbb.labels.add(labels.get(lab));
                }
            }
            blocks.add(jbb);
            startE = endE;
            startLab = endLab;
        }
        assert !instrIt.hasNext();
    }

    private static Map<Integer, Integer> collectLabels(Code_attribute code, int[] addotionalLabels) {
        final Map<Integer, Integer> labels = new TreeMap<>();
        labels.put(0, null);
        for (int lab : addotionalLabels) {
            labels.put(lab, null);
        }
        LabelVisitor labelVisitor = new LabelVisitor();
        for (Instruction inst : code.getInstructions()) {
            inst.accept(labelVisitor, inst.getPC());
        }
        for (int lab : labelVisitor.labels) {
            labels.put(lab, null);
        }
        int ind = 0;
        for (Map.Entry<Integer, Integer> e : labels.entrySet()) {
            if (e.getKey() == Integer.MAX_VALUE) {
                e.setValue(Integer.MAX_VALUE);
            } else {
                e.setValue(ind++);
            }
        }
        assert ind == labels.size() - 1;
        return labels;
    }

    static class LabelVisitor extends AbstractInstructionVisitor<Void, Integer> {

        List<Integer> labels = new ArrayList<>();

        @Override
        public Void visitNoOperands(Instruction instr, Integer pc) {
            switch (instr.getOpcode()) {
                case ARETURN:
                case DRETURN:
                case FRETURN:
                case IRETURN:
                case LRETURN:
                case RETURN:
                    labels.add(Integer.MAX_VALUE);
                    break;
                default:
            }
            return null;
        }

        @Override
        public Void visitBranch(Instruction instr, int offset, Integer pc) {
            switch (instr.getOpcode()) {
                case GOTO:
                case GOTO_W:
                case JSR:
                case JSR_W:
                    break;
                default:
                    labels.add(pc + instr.length());
            }
            labels.add(pc + offset);
            return null;
        }

        @Override
        public Void visitLookupSwitch(Instruction instr, int default_, int npairs, int[] matches, int[] offsets, Integer pc) {
            labels.add(pc + default_);
            for (int offset : offsets) {
                labels.add(pc + offset);
            }
            return null;
        }

        @Override
        public Void visitTableSwitch(Instruction instr, int default_, int low, int high, int[] offsets, Integer pc) {
            labels.add(pc + default_);
            for (int offset : offsets) {
                labels.add(pc + offset);
            }
            return null;
        }

    }
}
