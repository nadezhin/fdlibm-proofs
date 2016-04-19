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
import java.nio.file.Files;
import java.nio.file.Paths;
import jdkproofs.llvm2acl2.llvm2.BasicBlock;
import jdkproofs.llvm2acl2.llvm2.Function;
import jdkproofs.llvm2acl2.llvm2.Instruction;
import jdkproofs.llvm2acl2.llvm2.Instruction.SelectInst;
import jdkproofs.llvm2acl2.llvm2.Module;
import jdkproofs.llvm2acl2.llvm2.Value;
import org.bridj.Pointer;

/**
 *
 */
public class CheckClassfiles {

    private static ClassFile readCF(String suffix) throws IOException, ConstantPoolException {
        String name = "class/9/FdlibmTranslitN";
        if (suffix != null) {
            name += "$" + suffix;
        }
        try (InputStream in = Files.newInputStream(Paths.get(name + ".class"))) {
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

        private static String labS(int lab) {
            switch (lab) {
                case -1:
                    return "_";
                case Integer.MAX_VALUE:
                    return "RET";
                default:
                    return "B" + lab;
            }
        }

        ModuleMatch(String name, String className) throws IOException, ConstantPoolException, DescriptorException {
            this.name = name;
            cf = readCF(className);
            cp = cf.constant_pool;

            for (Field field : cf.fields) {
                assert !field.access_flags.is(AccessFlags.ACC_PRIVATE);
                assert field.access_flags.is(AccessFlags.ACC_STATIC);
                if (!((className.equals("Log") || className.equals("Log10") || className.equals("Log1p"))
                        && field.getName(cp).equals("zero"))) {
                    assert field.access_flags.is(AccessFlags.ACC_FINAL);
                }
            }
            init = cf.methods[0];
            compute = cf.methods[1];
            if (cf.methods.length > 2) {
                assert cf.methods.length == 3;
                clinit = cf.methods[2];
                assert clinit.descriptor.getValue(cp).equals("()V");
                JavaCFG clinitCFG = new JavaCFG(clinit);
                assert clinitCFG.blocks.size() == 1 && clinitCFG.blocks.get(0).instrs.get(0).getPC() == 0;
            } else {
                clinit = null;
            }
            assert init.descriptor.getValue(cp).equals("()V");
            JavaCFG initCFG = new JavaCFG(init);
            assert initCFG.blocks.size() == 1 && initCFG.blocks.get(0).instrs.get(0).getPC() == 0;
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
            Code_attribute computeCode = (Code_attribute) compute.attributes.get(Attribute.Code);

            assert init.getName(cp).equals("<init>");
            assert compute.getName(cp).equals("compute");
            nM = readModule("netlib.llvm/", "../netlib/", name + ".bc");
            nF = nM.funs.get(0);
            nName = nF.name;
            assert nF.args.size() == params.length;
            assert nF.returnType.typeStr.equals(mapType(retType));
            jM = readModule("jdk8.llvm/", "../jdk8/src", name + ".bc");
            jF = jM.funs.get(0);
            jName = jF.name;
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
            int[] additionalLabels = {};
            if (name.equals("e_rem_pio2")) {
                additionalLabels = new int[]{532};
            } else if (name.equals("k_rem_pio2")) {
                additionalLabels = new int[]{112, 165, 178, 244, 584, 609, 682, 695, 849, 907, 923, 982, 1029, 1080, 1156, 1214, 1243};
            } else if (name.equals("e_sqrt")) {
                additionalLabels = new int[]{126};
            }
            JavaCFG computeCFG = new JavaCFG(compute, additionalLabels);
            for (JavaCFG.JBasicBlock jbb : computeCFG.blocks) {
                System.out.print(" " + labS(jbb.blockLabel)
                        + " [" + jbb.instrs.get(0).getPC()
                        + "," + jbb.lastInst.getPC()
                        + "] " + jbb.lastInst.getMnemonic());
                for (int lab : jbb.labels) {
                    System.out.print(" " + labS(lab));
                }
                System.out.println();
            }
            System.out.println(" RET [" + computeCode.code_length + "]");
            System.out.println();

            int[] mapBlocks = new int[nF.blocks.size()];
            int k = computeCFG.blocks.size();
            int ii = nF.blocks.size();
            if (mapBlocks.length != 1 && !name.equals("k_rem_pio2")) {
                mapBlocks[--ii] = Integer.MAX_VALUE;
            }
            while (ii > 0) {
                BasicBlock nB = nF.blocks.get(--ii);
                if (nB.insts.size() == 1 && nB.terminator.successors.size() == 1) {
                    int succ = nF.blocks.indexOf(nB.terminator.successors.get(0));
                    assert succ > ii;
                    if (name.equals("k_rem_pio2") && nB.label == 39) {
                    } else if (k > 0 && computeCFG.blocks.get(k - 1).instrs.size() != 1) {
                        mapBlocks[ii] = -1;
                        continue;
                    }
                }
                if (name.equals("k_rem_pio2") && nB.label == 458) {
                    mapBlocks[ii] = -1;
                    continue;
                }
                for (Instruction inst : nB.insts) {
                    if (inst instanceof SelectInst) {
                        System.out.println("**** " + nB.label + " SELECT");
                        k -= 3;
                    }
                }
                mapBlocks[ii] = --k;
            }
            if (k != 0) {
                System.out.println("???????????????????????????");
            }

            for (int i = 0; i < nF.blocks.size(); i++) {
                BasicBlock nB = nF.blocks.get(i);
                if (nB.insts.size() == 1) {
                    System.out.print(" " + nB.label + " " + labS(mapBlocks[i]) + " -> " + nB.terminator.representation);
                } else {
                    System.out.print(" " + nB.label + " " + labS(mapBlocks[i]) + " " + nB.terminator.representation);
                }
                for (BasicBlock succB : nB.terminator.successors) {
                    int succ = nF.blocks.indexOf(succB);
                    int lab = mapBlocks[succ];
                    if (lab == -1) {
                        System.out.print(" (");
                        for (BasicBlock succB2 : nF.blocks.get(succ).terminator.successors) {
                            int succ2 = nF.blocks.indexOf(succB2);
                            System.out.print(" " + labS(mapBlocks[succ2]));
                        }
                        System.out.print(")");
                    } else {
                        System.out.print(" " + labS(mapBlocks[succ]));
                    }
                }
                System.out.println();
            }
            System.out.println();
            int nBlocks = computeCFG.blocks.size();
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
//                        System.out.println("  Skip " + nB.label);
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

    private static final String[][] modNames = {
        {"w_acos"},
        {"e_acos", "Acos"},
        {"w_asin"},
        {"e_asin", "Asin"},
        {"s_atan", "Atan"},
        {"w_atan2"},
        {"e_atan2", "Atan2"},
        {"s_cbrt", "Cbrt"},
        {"s_copysign", "Copysign"},
        {"s_cos", "Cos"},
        {"k_cos", "KernelCos"},
        {"w_cosh"},
        {"e_cosh", "Cosh"},
        {"w_exp"},
        {"e_exp", "Exp"},
        {"s_expm1", "Expm1"},
        {"s_fabs", "Fabs"},
        {"s_floor", "Floor"},
        {"w_hypot"},
        {"e_hypot", "Hypot"},
        {"w_log"},
        {"e_log", "Log"},
        {"w_log10"},
        {"e_log10", "Log10"},
        {"s_log1p", "Log1p"},
        {"w_pow"},
        {"e_pow", "Pow"},
        {"e_rem_pio2", "RemPio2"},
        {"k_rem_pio2", "KernelRemPio2"},
        {"s_scalbn", "Scalbn"},
        {"s_sin", "Sin"},
        {"k_sin", "KernelSin"},
        {"w_sinh"},
        {"e_sinh", "Sinh"},
        {"w_sqrt"},
        {"e_sqrt", "Sqrt"},
        {"s_tan"},
        {"k_tan", "KernelTan"},
        {"s_tanh", "Tanh"}
    };

    public static void main(String[] args) throws IOException, ConstantPoolException, DescriptorException {
//        printMethods(null);
        for (String[] modNames : modNames) {
            if (modNames.length != 2) {
                continue;
            }
            String modName = modNames[0];
            String className = modNames[1];
            System.out.println(modName + " " + className);
            ModuleMatch m = new ModuleMatch(modName, className);
        }
    }
}
