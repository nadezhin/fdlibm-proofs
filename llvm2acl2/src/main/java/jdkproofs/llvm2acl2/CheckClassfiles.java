package jdkproofs.llvm2acl2;

import static jdkproofs.llvm2acl2.LLVM37Library.*;
import com.sun.tools.classfile.AccessFlags;
import com.sun.tools.classfile.Annotation;
import com.sun.tools.classfile.Attribute;
import com.sun.tools.classfile.ClassFile;
import com.sun.tools.classfile.Code_attribute;
import com.sun.tools.classfile.ConstantPool;
import com.sun.tools.classfile.ConstantPoolException;
import com.sun.tools.classfile.DescriptorException;
import com.sun.tools.classfile.Field;
import com.sun.tools.classfile.Method;
import com.sun.tools.classfile.RuntimeInvisibleAnnotations_attribute;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.Set;
import java.util.TreeSet;
import org.bridj.Pointer;

/**
 *
 */
public class CheckClassfiles {

    private static ClassFile readCF(String suffix) throws IOException, ConstantPoolException {
        String name = "FdlibmTranslit";
        if (suffix != null) {
            name += "$" + suffix;
        }
        try (InputStream in = ClassLoader.getSystemResourceAsStream(name + ".class")) {
            return ClassFile.read(in);
        }
    }

    private static Module readModule(String dir, String idPrefix, String file) throws IOException {
        int ok;

        Pointer<Byte> path = Pointer.pointerToCString(dir + file);
        Pointer<LLVM37Library.LLVMMemoryBufferRef> outMemBuf = Pointer.allocate(LLVM37Library.LLVMMemoryBufferRef.class);
        Pointer<Pointer<Byte>> outMessage = Pointer.allocatePointer(Byte.class);
        ok = LLVMCreateMemoryBufferWithContentsOfFile(path, outMemBuf, outMessage);
        LLVM37Library.LLVMMemoryBufferRef memBuf = outMemBuf.get();
        Pointer<Byte> message = outMessage.get();
        Pointer.release(path, outMemBuf, outMessage);

        if (ok == 0) {
            assert message == null;
            Pointer<LLVM37Library.LLVMModuleRef> outModule = Pointer.allocate(LLVM37Library.LLVMModuleRef.class);
            outMessage = Pointer.allocatePointer(Byte.class);
            ok = LLVMParseBitcode(memBuf, outModule, outMessage);
            LLVM37Library.LLVMModuleRef moduleRef = outModule.get();
            message = outMessage.get();
            LLVMDisposeMemoryBuffer(memBuf);
            Pointer.release(outModule, outMessage);

            if (ok == 0) {
                assert message == null;
                Module module = new Module(Pointer.getPeer(moduleRef));
                LLVMDisposeModule(moduleRef);
                return module;
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
        return null;
    }

    private static class ModuleMatch {

        private final String name;
        private final ClassFile cf;
        private final ConstantPool cp;
        private final Method init;
        private final Method compute;
        private final Method clinit;
        private final String retType;
        private final String[] params;
        private final String nName;
        private final Module nM;
        private final Function nF;
        private final String jName;
        private final Module jM;
        private final Function jF;

        ModuleMatch(String name) throws IOException, ConstantPoolException, DescriptorException {
            this.name = name;
            cf = readCF(name);
            cp = cf.constant_pool;

            for (Field field : cf.fields) {
                assert field.access_flags.is(AccessFlags.ACC_PRIVATE);
                assert field.access_flags.is(AccessFlags.ACC_STATIC);
                assert field.access_flags.is(AccessFlags.ACC_FINAL);
            }
            init = cf.methods[0];
            compute = cf.methods[1];
            if (cf.methods.length > 2) {
                assert cf.methods.length == 3;
                clinit = cf.methods[2];
                assert clinit.descriptor.getValue(cp).equals("()V");
                assert makeBasicBlocks(clinit).equals(Collections.<Integer>singleton(0));
            } else {
                clinit = null;
            }
            assert init.descriptor.getValue(cp).equals("()V");
            assert makeBasicBlocks(init).equals(Collections.<Integer>singleton(0));
            retType = compute.descriptor.getReturnType(cp);
            String paramTypes = compute.descriptor.getParameterTypes(cp);
            assert paramTypes.charAt(0) == '(';
            assert paramTypes.charAt(paramTypes.length() - 1) == ')';
            paramTypes = paramTypes.substring(1, paramTypes.length() - 1);
            if (paramTypes.isEmpty()) {
                params = new String[0];
            } else {
                params = paramTypes.split(", ");
            }

            assert init.getName(cp).equals("<init>");
            assert compute.getName(cp).equals("compute");
            RuntimeInvisibleAnnotations_attribute ria
                    = (RuntimeInvisibleAnnotations_attribute) compute.attributes.get("RuntimeInvisibleAnnotations");
            assert ria.annotations.length == 1;
            assert cp.getUTF8Value(ria.annotations[0].type_index).equals("LFdlibmTranslit$CNames;");
            assert ria.annotations[0].element_value_pairs.length == 2;

            assert cp.getUTF8Value(ria.annotations[0].element_value_pairs[0].element_name_index).equals("netlib");
            nName = cp.getUTF8Value(((Annotation.Primitive_element_value) ria.annotations[0].element_value_pairs[0].value).const_value_index);
            nM = readModule("../../t/ole71/jvm/fdlibm/netlib.llvm/", "../netlib/", name + ".bc");
            nF = nM.funs.get(0);
            assert nF.name.equals(nName);
            assert nF.args.size() == params.length;
            assert nF.returnType.typeStr.equals(mapType(retType));

            assert cp.getUTF8Value(ria.annotations[0].element_value_pairs[1].element_name_index).equals("jdk8");
            jName = cp.getUTF8Value(((Annotation.Primitive_element_value) ria.annotations[0].element_value_pairs[1].value).const_value_index);
            jM = readModule("../../t/ole71/jvm/fdlibm/jdk8.llvm/", "../netlib/src", name + ".bc");
            jF = jM.funs.get(0);
            assert jF.name.equals(jName);
            assert jF.args.size() == params.length;
            assert jF.returnType.typeStr.equals(mapType(retType));

            assert nM.globals.size() == jM.globals.size();
            for (int i = 0; i < nM.globals.size(); i++) {
                Value nG = nM.globals.get(i);
                Value jG = jM.globals.get(i);
                if (name.equals("k_tan")) {
                    assert nG.name.equals("xxx");
                    assert jG.name.equals("T");
                    assert nG.type.typeStr.equals("[16 x double]*");
                    assert jG.type.typeStr.equals("[13 x double]*");
                    assert findField("xxx").descriptor.getFieldType(cp).equals("double[]");
                    assert findField("T").descriptor.getFieldType(cp).equals("double[]");
                } else {
                    System.out.println("  " + nG.name);
                    assert nG.name.equals(jG.name);
                    assert nG.type.typeStr.equals(jG.type.typeStr);
                    assert nG.representation.equals(jG.representation);
                    if (nG.type.typeStr.equals("double*")) {
                        assert nG.name.equals("zero")
                                || nG.name.equals("one");
                        assert findField(nG.name).descriptor.getFieldType(cp).equals("double");
                    } else {
                        assert mapCToJ(nG.type.typeStr)
                                .equals(findField(nG.name).descriptor.getFieldType(cp));
                    }
                }
            }

            String prefix
                    = nName.equals("copysign") || nName.equals("scalbn") ? ""
                            : nName.startsWith("__") ? "__j"
                                    : "j";
            assert jName.equals(prefix + nName);
            for (int i = 0; i < params.length; i++) {
                assert nF.args.get(i).type.typeStr.equals(mapType(params[i]));
                assert jF.args.get(i).type.typeStr.equals(mapType(params[i]));
            }
            Set<Integer> basicBlocks = makeBasicBlocks(compute);
            int nBlocks = basicBlocks.size();
            if (name.equals("s_log1p")) {
                assert nBlocks == 37;
                assert nF.blocks.size() == 39;
                assert jF.blocks.size() == 40;
            } else {
                assert nF.blocks.size() == jF.blocks.size();
                for (int i = 0; i < nF.blocks.size(); i++) {
                    BasicBlock nB = nF.blocks.get(i);
                    BasicBlock jB = jF.blocks.get(i);
                    assert nB.terminator.opcode == jB.terminator.opcode;
                    assert nB.terminator.successors.size() == jB.terminator.successors.size();
                    if (nB.terminator.opcode.equals(LLVMOpcode.LLVMBr)
                            && nB.terminator.operands.length == 1
                            && nB.insts.size() == 1) {
                        System.out.println("  Skip " + nB.label);
                    }

                    switch (name) {
                        case "e_asin":
                        case "e_exp":
                        case "s_expm1":
                            if (i == 0) {
                                continue;
                            }
                            break;
                        case "k_tan":
                            if (i == 3 || i == 6 || i == 11) {
                                continue;
                            }
                            break;
                        default:
                    }
                    assert nB.insts.size() == jB.insts.size();
                    for (int j = 0; j < nB.insts.size(); j++) {
                        Instruction nI = nB.insts.get(j);
                        Instruction jI = jB.insts.get(j);
                        if (name.equals("e_pow") && i == 59 && j == 1) {
                            assert nI.opcode.equals(LLVMOpcode.LLVMFSub);
                            assert jI.opcode.equals(LLVMOpcode.LLVMFMul);
                            assert nI.representation.equals("  %213 = fsub double -0.000000e+00, %212");
                            assert jI.representation.equals("  %213 = fmul double -1.000000e+00, %212");
                        } else {
                            assert nI.opcode == jI.opcode;
                        }
                    }
                }
            }
        }

        private Field findField(String name) throws ConstantPoolException {
            for (Field field : cf.fields) {
                if (field.getName(cp).equals(name)) {
                    return field;
                }
            }
            return null;
        }
    }

    private static String mapCToJ(String cType) {
        switch (cType) {
            case "i32":
                return "int";
            case "i32*":
            case "[4 x i32]*":
            case "[32 x i32]*":
            case "[66 x i32]*":
                return "int[]";
            case "double":
                return "double";
            case "double*":
            case "[2 x double]*":
            case "[4 x double]*":
            case "[8 x double]*":
            case "[11 x double]*":
                return "double[]";
            default:
                throw new AssertionError();
        }
    }

    private static String mapType(String javaType) {
        switch (javaType) {
            case "int":
                return "i32";
            case "int[]":
                return "i32*";
            case "double":
                return "double";
            case "double[]":
                return "double*";
            default:
                throw new AssertionError();
        }
    }

    private static Set<Integer> makeBasicBlocks(Method m) {
        Code_attribute code = (Code_attribute) m.attributes.get("Code");
        final Set<Integer> labels = new TreeSet<>();
        labels.add(0);
        com.sun.tools.classfile.Instruction.KindVisitor<Void, Integer> labelVisitor
                = new AbstractInstructionVisitor<Void, Integer>() {

                    @Override
                    public Void visitBranch(com.sun.tools.classfile.Instruction instr, int offset, Integer pc) {
                        labels.add(pc + offset);
                        switch (instr.getOpcode()) {
                            case GOTO:
                            case GOTO_W:
                            case JSR:
                            case JSR_W:
                                break;
                            default:
                                labels.add(pc + instr.length());
                        }
                        return null;
                    }

                    public Void visitLookupSwitch(com.sun.tools.classfile.Instruction instr, int default_, int npairs, int[] matches, int[] offsets, Integer pc) {
                        labels.add(pc + default_);
                        for (int offset : offsets) {
                            labels.add(pc + offset);
                        }
                        labels.add(pc + instr.length());
                        return null;
                    }

                    public Void visitTableSwitch(com.sun.tools.classfile.Instruction instr, int default_, int low, int high, int[] offsets, Integer pc) {
                        labels.add(pc + default_);
                        for (int offset : offsets) {
                            labels.add(pc + offset);
                        }
                        labels.add(pc + instr.length());
                        return null;
                    }
                };
        for (com.sun.tools.classfile.Instruction inst : code.getInstructions()) {
            inst.accept(labelVisitor, inst.getPC());
        }
        return labels;
    }

    private static void printMethods(String suffix) throws IOException, ConstantPoolException {
        ClassFile cf = readCF(suffix);
        ConstantPool cp = cf.constant_pool;
        System.out.println(cf.getName());
        for (Method m : cf.methods) {
            System.out.println("  " + m.getName(cp));
            for (Attribute attr : m.attributes.attrs) {
                System.out.println("    " + attr.getName(cp));
            }
            RuntimeInvisibleAnnotations_attribute ria
                    = (RuntimeInvisibleAnnotations_attribute) m.attributes.get("RuntimeInvisibleAnnotations");
            if (ria != null) {
                for (Annotation a : ria.annotations) {
                    System.out.println("     " + cp.getUTF8Value(a.type_index));
                    for (Annotation.element_value_pair ev : a.element_value_pairs) {
                        Annotation.Primitive_element_value v
                                = (Annotation.Primitive_element_value) ev.value;
                        System.out.println("       " + cp.getUTF8Value(ev.element_name_index) + "->" + cp.get(v.const_value_index));
                    }
                }
            }
        }
    }

    private static final String[] modNames = {
        "w_acos",
        "e_acos",
        "w_asin",
        "e_asin",
        "s_atan",
        "w_atan2",
        "e_atan2",
        "s_cbrt",
        "s_copysign",
        "s_cos",
        "k_cos",
        "w_cosh",
        "e_cosh",
        "w_exp",
        "e_exp",
        "s_expm1",
        "s_fabs",
        "s_floor",
        "w_hypot",
        "e_hypot",
        "w_log",
        "e_log",
        "w_log10",
        "e_log10",
        "s_log1p",
        "w_pow",
        "e_pow",
        "e_rem_pio2",
        "k_rem_pio2",
        "s_scalbn",
        "s_sin",
        "k_sin",
        "w_sinh",
        "e_sinh",
        "w_sqrt",
        "e_sqrt",
        "s_tan",
        "k_tan",
        "s_tanh"
    };

    public static void main(String[] args) throws IOException, ConstantPoolException, DescriptorException {
//        printMethods(null);
        for (String modName : modNames) {
            System.out.println(modName);
            ModuleMatch m = new ModuleMatch(modName);
        }
    }
}
