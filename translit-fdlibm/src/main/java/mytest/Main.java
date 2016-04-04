package mytest;

import java.io.IOException;
import java.io.PrintStream;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import mytest.ast.AST;
import mytest.ast.MyCursor;
import org.bridj.IntValuedEnum;
import org.bridj.Pointer;
import org.llvm.clang.CXComment;
import org.llvm.clang.CXCursor;
import org.llvm.clang.CXSourceLocation;
import org.llvm.clang.CXSourceRange;
import org.llvm.clang.CXString;
import org.llvm.clang.CXToken;
import org.llvm.clang.CXType;
import static org.llvm.clang.Libclang.*;

/**
 *
 */
public class Main {

    private static void collectUsedKinds(AST.Node top, Set<CXCursorKind> usedKinds) {
        usedKinds.add(top.getKind());
        for (AST.Node child : top) {
            collectUsedKinds(child, usedKinds);
        }
    }

    private static void showAST(PrintStream out, int indent, AST.Node top) {
        for (int i = 0; i < indent; i++) {
            out.print("  ");
        }
        MyCursor mc = top.getMyCursor();
        out.print(top.getKind().toString().replace("CXCursor_", "")
                + " " + Integer.toHexString(mc.xdata)
                + " " + Long.toHexString(mc.data0)
                + " " + Long.toHexString(mc.data1));
        CXCursor cx = top.getCXCursor();
        CXString cxstr = clang_getCursorSpelling(cx);
        if (cxstr != null) {
            out.print(" " + clang_getCString(cxstr).getCString());
        }
        out.println();
        indent++;
        for (AST.Node child : top) {
            showAST(out, indent, child);
        }
    }

    private static ParsedFile parseFile(Pointer<?> Index, String fileName) throws IOException {
        String dirName = "../llvm2acl2/netlib/";
        return ParsedFile.parseTranslationUnit(Index, dirName, fileName);
    }

    private static final String[][] sortedWFiles = {
        {"w_acos.bc", "e_acos"},
        {"w_asin.bc", "e_asin"},
        {"w_atan2.bc", "e_atan2"},
        {"w_cosh.bc", "e_cosh"},
        {"w_exp.bc", "e_exp"},
        {"w_hypot.bc", "e_hypot"},
        {"w_log.bc", "e_log"},
        {"w_log10.bc", "e_log10"},
        {"w_pow.bc", "e_pow"},
        {"w_sinh.bc", "e_sinh"},
        {"w_sqrt.bc", "e_sqrt"},};

    private static final String[][] sortedFiles = {
        {"e_acos.bc", "w_sqrt"},
        {"e_asin.bc", "s_fabs", "w_sqrt"},
        {"s_atan.bc", "s_fabs"},
        {"e_atan2.bc", "s_fabs", "s_atan"},
        {"s_cbrt.bc"},
        {"s_copysign.bc"},
        {"s_cos.bc", "k_cos", "k_sin", "e_rem_pio2"},
        {"k_cos.bc"},
        {"e_cosh.bc", "s_fabs", "s_expm1", "e_exp"},
        {"e_exp.bc"},
        {"s_expm1.bc"},
        {"s_fabs.bc"},
        {"s_floor.bc"},
        {"e_hypot.bc", "w_sqrt"},
        {"e_log.bc"},
        {"e_log10.bc", "e_log"},
        {"s_log1p.bc"},
        {"e_pow.bc", "w_sqrt", "s_fabs", "s_scalbn"},
        {"e_rem_pio2.bc"},
        {"k_rem_pio2.bc"},
        {"s_scalbn.bc", "s_copysign"},
        {"s_sin.bc", "k_sin", "k_cos", "e_rem_pio2"},
        {"k_sin.bc"},
        {"e_sinh.bc", "s_fabs", "s_expm1", "e_exp"},
        {"e_sqrt.bc"},
        {"s_tan.bc", "k_tan", "e_rem_pio2"},
        {"k_tan.bc", "s_fabs"},
        {"s_tanh.bc", "s_fabs", "s_expm1"}
    };

    private static Map<String, ParsedFile> parseFiles(Pointer<?> Index) throws IOException {
        Map<String, ParsedFile> result = new LinkedHashMap<>();
        String dirName = System.getProperty("user.home") + "/dist/fdlibm-proofs/llvm2acl2/netlib/";
        for (String[] fileNames : sortedFiles) {
            String fileName = fileNames[0].replace(".bc", ".c");
            System.out.println(fileName);
            ParsedFile pf = ParsedFile.parseTranslationUnit(Index, dirName, fileName);
            result.put(fileName, pf);
        }
        return result;
    }

    private static void printUsedKinds() throws IOException {
        Pointer<?> Index = clang_createIndex(0, 0);
        Set<CXCursorKind> usedKinds = new TreeSet<>();
        for (ParsedFile pf : parseFiles(Index).values()) {
            collectUsedKinds(pf.ast, usedKinds);
        }
        System.out.println(usedKinds.size());
        for (CXCursorKind kind : usedKinds) {
            System.out.println(kind);
        }
        clang_disposeIndex(Index);
    }

    private static void showTrees() throws IOException {
        Pointer<?> Index = clang_createIndex(0, 0);
        for (Map.Entry<String, ParsedFile> e : parseFiles(Index).entrySet()) {
            System.out.println("===== " + e.getKey());
            showAST(System.out, 0, e.getValue().ast);
        }
        clang_disposeIndex(Index);
    }

    private static String pullFromSourceRange(byte[] contentsBytes, CXSourceRange range) {
        CXSourceLocation rangeStart = clang_getRangeStart(range);
        CXSourceLocation rangeEnd = clang_getRangeEnd(range);
        if (clang_Location_isFromMainFile(rangeStart) == 0
                || clang_Location_isFromMainFile(rangeEnd) == 0) {
            return null;
        }
        Pointer<Pointer<?>> file = null; //Pointer.allocatePointer();
        Pointer<Integer> line = null;
        Pointer<Integer> column = null;
        Pointer<Integer> offset = Pointer.allocateInt();
        clang_getExpansionLocation(rangeStart, file, line, column, offset);
        int startOffset = offset.get();
        clang_getExpansionLocation(rangeEnd, file, line, column, offset);
        int endOffset = offset.get();
        return new String(contentsBytes, startOffset, endOffset - startOffset, StandardCharsets.ISO_8859_1);
    }

    private static void exploreCursorNames(byte[] contents, CXCursor cursor) {
        CXString initSpelling = clang_getCursorSpelling(cursor);
        String initSpellingStr = clang_getCString(initSpelling).getCString();
        CXString initDisplayName = clang_getCursorDisplayName(cursor);
        String initDisplayStr = clang_getCString(initDisplayName).getCString();
        CXString initRawComment = clang_Cursor_getRawCommentText(cursor);
        Pointer<Byte> initRawCommentCStr = clang_getCString(initRawComment);
        String initCommentStr = initRawCommentCStr != null ? initRawCommentCStr.getCString() : null;
        CXString initMangling = clang_Cursor_getMangling(cursor);
        String initManglingStr = clang_getCString(initMangling).getCString();
        CXString usr = clang_getCursorUSR(cursor);
        String usrStr = clang_getCString(usr).getCString();
        CXSourceRange range = clang_getCursorExtent(cursor);
        String s = pullFromSourceRange(contents, range);
        System.out.print(" = " + s);
    }

    private static void showStaticVars(PrintStream out, ParsedFile pf) {
        for (AST.Node child : pf.ast) {
            if (child instanceof AST.VarDecl) {
                CXCursor cx = child.getCXCursor();
                IntValuedEnum<CXLinkageKind> linkage = clang_getCursorLinkage(cx);
                if (linkage.equals(CXLinkageKind.CXLinkage_Internal)) {
                    CXType type = clang_getCursorType(cx);
                    CXString typeSpelling = clang_getTypeSpelling(type);
                    String typeStr = clang_getCString(typeSpelling).getCString();
                    String array = null;
                    if (typeStr.endsWith("]")) {
                        int ind = typeStr.indexOf('[');
                        array = typeStr.substring(ind + 1, typeStr.length() - 1);
                        typeStr = typeStr.substring(0, ind) + "[]";
                    }
                    typeStr = typeStr.replace("const ", "");
                    CXString spelling = clang_getCursorSpelling(cx);
                    out.print("  private static final "
                            + typeStr
                            + " " + clang_getCString(spelling).getCString());
                    for (AST.Node init : child) {
                        if (init instanceof AST.IntegerLiteral) {
                            assert array != null;
                            array = null;
//                            CXString intSpelling = clang_getCursorDisplayName(init.getCXCursor());
//                            String intStr = clang_getCString(intSpelling).getCString();
//                            System.out.print("[" + clang_getCString(intSpelling).getCString() + "]");
                        } else if (init instanceof AST.FloatingLiteral
                                || init instanceof AST.StringLiteral
                                || init instanceof AST.UnaryOperator
                                || init instanceof AST.InitListExpr) {
                            CXSourceRange range = clang_getCursorExtent(init.getCXCursor());
                            String s = pullFromSourceRange(pf.contents, range);
                            int indElse = s.indexOf("#else\n");
                            int indEndif = s.indexOf("#endif\n");
                            if (indElse >= 0 && indEndif >= 0) {
                                s = s.substring(0, indElse) + s.substring(indEndif + "#endif\n".length());
                            }
                            System.out.print(" = " + s);
//                        } else if (init instanceof AST.InitListExpr) {
//                            for (AST.Node sub: init) {
//                                CXSourceRange range = clang_getCursorExtent(sub.getCXCursor());
//                                System.out.print("<" + sub.getKind() + ">[" + pullFromSourceRange(pf.contents, range) + "]");
//                            }
                        } else if (false) {
                            CXCursor initCX = init.getCXCursor();
                            CXString initSpelling = clang_getCursorSpelling(initCX);
                            String initSpellingStr = clang_getCString(initSpelling).getCString();
                            CXString initDisplayName = clang_getCursorDisplayName(initCX);
                            String initDisplayStr = clang_getCString(initDisplayName).getCString();
                            CXString initRawComment = clang_Cursor_getRawCommentText(initCX);
                            Pointer<Byte> initRawCommentCStr = clang_getCString(initRawComment);
                            String initCommentStr = initRawCommentCStr != null ? initRawCommentCStr.getCString() : null;
                            CXString initMangling = clang_Cursor_getMangling(initCX);
                            String initManglingStr = clang_getCString(initMangling).getCString();
                            CXString usr = clang_getCursorUSR(initCX);
                            String usrStr = clang_getCString(usr).getCString();
                            CXSourceRange range = clang_getCursorExtent(initCX);
                            String s = pullFromSourceRange(pf.contents, range);
                            System.out.print(" = " + s);
                        } else {
                            System.out.println(" <" + init.getKind() + "> ");
                        }
                    }
                    out.println(";");
                }
            } else if (child instanceof AST.EnumDecl) {
            } else if (child instanceof AST.StructDecl) {
            } else if (child instanceof AST.FunctionDecl) {
            } else {
                assert false;
            }
        }
    }

    private static String javaClassName(String fileName) {
        assert fileName.endsWith(".c");
        fileName = fileName.substring(0, fileName.length() - 2);
        fileName = fileName.replace("_pio2", "Pio2");
        if (fileName.startsWith("k_")) {
            return "Kernel" + Character.toUpperCase(fileName.charAt(2)) + fileName.substring(3);
        } else {
            assert fileName.startsWith("s_") || fileName.startsWith("e_");
            return Character.toUpperCase(fileName.charAt(2)) + fileName.substring(3);
        }
    }

    private static String cFunName(String fileName) {
        assert fileName.endsWith(".c");
        fileName = fileName.substring(0, fileName.length() - 2);
        if (fileName.startsWith("k_")) {
            return "__kernel_" + fileName.substring(2);
        } else if (fileName.startsWith("e_")) {
            return "__ieee754_" + fileName.substring(2);
        } else {
            assert fileName.startsWith("s_");
            return fileName.substring(2);
        }
    }

    private static void showVars() throws IOException {
        String dirName = System.getProperty("user.home") + "/dist/fdlibm-proofs/llvm2acl2/netlib/";
        Pointer<?> Index = clang_createIndex(0, 0);
        for (Map.Entry<String, ParsedFile> e : parseFiles(Index).entrySet()) {
            ParsedFile pf = e.getValue();
            CXComment comment = clang_Cursor_getParsedComment(pf.ast.getCXCursor());
            CXSourceRange commentRange = clang_Cursor_getCommentRange(pf.ast.getCXCursor());
            String s = clang_Range_isNull(commentRange) != 0 ? null : pullFromSourceRange(pf.contents, commentRange);
            System.out.println("private static class " + javaClassName(e.getKey()) + " {");
            showStaticVars(System.out, e.getValue());
            System.out.println("}");
        }
        clang_disposeIndex(Index);
    }

    private static void showExtents(ParsedFile pf, int indent, AST.Node top) {
        for (int i = 0; i < indent; i++) {
            System.out.print("  ");
        }
        CXType cxType = clang_getCursorType(top.getCXCursor());
        CXString cxTypeS = clang_getTypeSpelling(cxType);
        String cxTypeStr = clang_getCString(cxTypeS).getCString();
        System.out.print(top.getKind().toString().replace("CX_Cursor", "") + " " + top.path + " " + cxTypeStr);

        if (top.getKind().equals(CXCursorKind.CXCursor_BinaryOperator)) {
            exploreCursorNames(pf.contents, top.getCXCursor());
        }
        CXSourceRange extent = clang_getCursorExtent(top.getCXCursor());
        String extentStr = pullFromSourceRange(pf.contents, extent);

        if (extentStr != null) {
            System.out.print(" <" + extentStr + ">");
        }
        System.out.println();
        indent++;
        for (AST.Node child : top) {
            showExtents(pf, indent, child);
        }
    }

    private static final Map<String, String> fun2class = new HashMap<>();

    static {
        fun2class.put("copysign", "Copysign");
        fun2class.put("__kernel_cos", "KernelCos");
        fun2class.put("__ieee754_exp", "Exp");
        fun2class.put("fabs", "Fabs");
        fun2class.put("floor", "Floor");
        fun2class.put("__ieee754_log", "Log");
        fun2class.put("__ieee754_rem_pio2", "RemPio2");
        fun2class.put("__kernel_rem_pio2", "KernelRemPio2");
        fun2class.put("scalbn", "Scalbn");
        fun2class.put("__kernel_sin", "KernelSin");
        fun2class.put("sqrt", "Sqrt");
        fun2class.put("__kernel_tan", "KernelTan");
    }

    enum IfdefState {
        OutOf, InTrue, InFalse
    }

    private static boolean needInitialization(String fileName, String id) {
        boolean init = false;
        switch (cFunName(fileName)) {
            case "__ieee754_asin":
                init = id.equals("t");
                break;
            case "__kernel_cos":
                init = id.equals("qx");
                break;
            case "__ieee754_exp":
                init = id.equals("hi")
                        || id.equals("lo")
                        || id.equals("k");
                break;
            case "expm1":
                init = id.equals("c");
                break;
            case "log1p":
                init = id.equals("f")
                        || id.equals("c")
                        || id.equals("hu");
                break;
            case "__ieee754_rem_pio2":
                init = id.equals("z");
                break;
            case "__ieee754_sqrt":
                init = id.equals("z");
                break;
        }
        return init;
    }

    private static void convertByTokens(PrintStream out, ParsedFile pf) {
        System.out.println("convert " + pf.fileName);
        CXSourceRange range = clang_getCursorExtent(pf.ast.getCXCursor());
        Pointer<Pointer<CXToken>> tokensPtr = Pointer.allocatePointer(CXToken.class);
        Pointer<Integer> numTokensPtr = Pointer.allocateInt();
        clang_tokenize(pf.tu, range, tokensPtr, numTokensPtr);
        int numTokens = numTokensPtr.get();
        Pointer<CXToken> tokens = tokensPtr.get();
        Pointer<CXCursor> cursors = Pointer.allocateArray(CXCursor.class, numTokens);
        clang_annotateTokens(pf.tu, tokens, numTokens, cursors);
        Tokens ts = new Tokens(pf.tu, tokens, numTokens);

        Map<MyCursor, AST.Node> cursorPaths = new HashMap<>();
        makeCursorMap(cursorPaths, pf.ast);
        IfdefState ifdef = IfdefState.OutOf;
        for (int tokNo = 0; tokNo < numTokens; tokNo++) {
            CXToken token = tokens.get(tokNo);
            String tokenSpelling = clang_getCString(clang_getTokenSpelling(pf.tu, token)).getCString();
            if (tokenSpelling.equals("#")) {
                if (ts.match(tokNo + 1, CXTokenKind.CXToken_Identifier, "include")
                        && ts.match(tokNo + 2, CXTokenKind.CXToken_Literal, "\"fdlibm.h\"")) {
                    ts.printBefore(token, "/*<");
                    token = tokens.get(tokNo += 2);
                    ts.printAfter(token, "*/private static class " + javaClassName(pf.fileName) + " {/*>*/");
                } else if (ts.match(tokNo + 1, CXTokenKind.CXToken_Identifier, "ifdef")
                        && ts.match(tokNo + 2, CXTokenKind.CXToken_Identifier, "__STDC__")) {
                    ts.printBefore(token, "/*<");
                    token = tokens.get(tokNo += 2);
                    ts.printAfter(token, "/>*/");
                    assert ifdef == IfdefState.OutOf;
                    ifdef = IfdefState.InTrue;
                } else if (ts.match(tokNo + 1, CXTokenKind.CXToken_Identifier, "ifndef")
                        && ts.match(tokNo + 2, CXTokenKind.CXToken_Identifier, "lint")) {
                    ts.printBefore(token, "/*<");
                    tokNo += 2;
                    assert ifdef == IfdefState.OutOf;
                    ifdef = IfdefState.InFalse;
                } else if (ts.match(tokNo + 1, CXTokenKind.CXToken_Keyword, "else")) {
                    ts.printBefore(token, "/*<");
                    tokNo += 1;
                    assert ifdef == IfdefState.InTrue;
                    ifdef = IfdefState.InFalse;
                } else if (ts.match(tokNo + 1, CXTokenKind.CXToken_Identifier, "endif")) {
                    token = tokens.get(tokNo += 1);
                    ts.printAfter(token, "/>*/");
                    assert ifdef == IfdefState.InTrue || ifdef == IfdefState.InFalse;
                    ifdef = IfdefState.OutOf;
                } else if (ts.match(tokNo + 1, CXTokenKind.CXToken_Identifier, "pragma")
                        && ts.match(tokNo + 2, CXTokenKind.CXToken_Identifier, "ident")) {
                    ts.printBefore(token, "/*<");
                    token = tokens.get(tokNo += 3);
                    assert clang_getTokenKind(token).equals(CXTokenKind.CXToken_Literal);
                    ts.printAfter(token, "/>*/");
                } else if (ts.match(tokNo + 1, CXTokenKind.CXToken_Identifier, "define")) {
                    ts.printBefore(token, "/*<");
                    if (ts.match(tokNo + 4, CXTokenKind.CXToken_Punctuation, "[")
                            && ts.match(tokNo + 6, CXTokenKind.CXToken_Punctuation, "]")) {
                        token = tokens.get(tokNo += 6);
                    } else {
                        token = tokens.get(tokNo += 3);
                    }
                    ts.printAfter(token, "/>*/");
                } else {
                    assert false;
                }
                continue;
            }
            if (ifdef == IfdefState.InFalse) {
                ts.printSkipped(token);
                continue;
            }
            MyCursor myCursor = new MyCursor(cursors.get(tokNo));
            switch (tokenSpelling) {
                case "=": {
                    AST.Node ast = cursorPaths.get(myCursor);
                    if (ast == null) {
                    } else if (ast instanceof AST.VarDecl) {
                    } else if (ast instanceof AST.BinaryOperator) {
                        assert ast.getNumChildren() == 2;
                        AST.Node child0 = ast.getChild(0);
                        AST.Node child1 = ast.getChild(1);
                        if (child1 instanceof AST.FirstExpr) {
                            assert child1.getNumChildren() == 1;
                            AST.Node child10 = child1.getChild(0);
                            String t0 = child0.getTypeSpelling();
                            String t1 = child1.getTypeSpelling();
                            String t10 = child10.getTypeSpelling();
                            if (t0.equals("int") && t1.equals("int") && t10.equals("double")) {
                                ts.printBefore(child10, "/*<*/(int)(/*>*/");
                                ts.printAfter(child10, "/*<*/)/*>*/");
                            }
                        }
                    } else if (ast instanceof AST.InitListExpr) {
                    } else {
                        assert false;
                    }
                    break;
                }
                case "<=":
                case ">=":
                case "<":
                case ">": {
                    AST.Node ast = (AST.BinaryOperator) cursorPaths.get(myCursor);
                    assert ast.getNumChildren() == 2;
                    AST.Node child0 = ast.getChild(0);
                    AST.Node child1 = ast.getChild(1);
                    if (child0.getTypeSpelling().equals("unsigned int")
                            || child1.getTypeSpelling().equals("unsigned int")) {
                        if (child1 instanceof AST.CStyleCastExpr && child1.getTypeSpelling().equals("unsigned int")) {
                            assert child1.getNumChildren() == 1;
                            child1 = child1.getChild(0);
                        }
                        ts.printBefore(child0, "/*<*/Integer.compareUnsigned(/*>*/");
                        ts.printAfter(child0, "/*<");
                        ts.printBefore(child1, "*/,/*>*/");
                        ts.printAfter(child1, "/*<*/)" + tokenSpelling + "0/*>*/");
                    }
                    break;
                }
                case "==": {
                    AST.Node ast = (AST.BinaryOperator) cursorPaths.get(myCursor);
                    assert ast.getNumChildren() == 2;
                    AST.Node child1 = ast.getChild(1);
                    if (child1 instanceof AST.CStyleCastExpr
                            && child1.getTypeSpelling().equals("unsigned int")) {
                        assert child1.getNumChildren() == 1;
                        AST.Node child10 = child1.getChild(0);
                        ts.printBefore(child1, "/*<");
                        ts.printBefore(child10, "/>*/");
                    }
                    break;
                }
                case "*": {
                    AST.Node ast = cursorPaths.get(myCursor);
                    if (ast instanceof AST.ParmDecl) {
                        CXToken tok = tokens.get(tokNo);
                        ts.printBefore(tok, "/*<");
                        ts.printAfter(tok, "*/[]/*>*/");
                    } else if (ast instanceof AST.UnaryOperator) {
                        assert ast.getNumChildren() == 1;
                        AST.Node child0 = ast.getChild(0);
                        if (child0 instanceof AST.ParenExpr) {
                            assert child0.getNumChildren() == 1;
                            AST.Node child00 = (AST.BinaryOperator) child0.getChild(0);
                            assert child00.getNumChildren() == 2;
                            AST.Node child000 = (AST.ParenExpr) child00.getChild(0);
                            assert child000.getNumChildren() == 1;
                            AST.Node child0000 = child000.getChild(0);
                            AST.Node child001 = (AST.CStyleCastExpr) child00.getChild(1);
                            assert child001.getNumChildren() == 1;
                            AST.Node child0010 = (AST.UnaryOperator) child001.getChild(0);
                            assert child0010.getNumChildren() == 1;
                            AST.Node child00100 = (AST.DeclRefExpr) child0010.getChild(0);
                            assert child00100.getNumChildren() == 0;
                            String var = clang_getCString(clang_getCursorSpelling(child00100.getCXCursor())).getCString();
                            String t = ast.getTypeSpelling();
                            String t0 = child0.getTypeSpelling();
                            String t00 = child00.getTypeSpelling();
                            String t000 = child000.getTypeSpelling();
                            String t0000 = child0000.getTypeSpelling();
                            String t001 = child001.getTypeSpelling();
                            String t0010 = child0010.getTypeSpelling();
                            String t00100 = child00100.getTypeSpelling();
                            assert t.equals("unsigned int")
                                    && t0.equals("unsigned int *") && t00.equals("unsigned int *")
                                    && t000.equals("unsigned int") && t0000.equals("unsigned int")
                                    && t001.equals("unsigned int *")
                                    && t0010.equals("double *") && t00100.equals("double");
                            ts.printBefore(ast, "/*<");
                            ts.printBefore(child0000, "*/__AMP(" + var + ")[/*>*/");
                            ts.printAfter(child0000, "]/*<");
                            ts.printAfter(ast, "/>*/");
                            ast = ast;
                        } else if (child0 instanceof AST.CStyleCastExpr) {
                            assert child0.getNumChildren() == 1;
                            AST.Node child00 = (AST.UnaryOperator) child0.getChild(0);
                            assert child00.getNumChildren() == 1;
                            AST.Node child000 = (AST.DeclRefExpr) child00.getChild(0);
                            assert child000.getNumChildren() == 0;
                            String var = clang_getCString(clang_getCursorSpelling(child000.getCXCursor())).getCString();
                            String t = ast.getTypeSpelling();
                            String t0 = child0.getTypeSpelling();
                            String t00 = child00.getTypeSpelling();
                            String t000 = child000.getTypeSpelling();
                            assert (t.equals("unsigned int") && t0.equals("unsigned int *")
                                    || t.equals("int") && t0.equals("int *"))
                                    && t00.equals("const double *") && t000.equals("const double");
                            ts.printBefore(ast, "/*<");
                            ts.printAfter(ast, "*/__AMP(" + var + ")[0]/*>*/");
                        }
                    }
                    break;
                }
                case "[": {
                    AST.Node ast = cursorPaths.get(myCursor);
                    if (ast == null) {
                    } else if (ast instanceof AST.ArraySubscriptExpr) {
                    } else if (ast instanceof AST.InitListExpr) {
                    } else if (ast instanceof AST.VarDecl) {
                        if (ast.getNumChildren() == 2) {
                            AST.Node child0 = (AST.IntegerLiteral) ast.getChild(0);
                            AST.Node child1 = (AST.InitListExpr) ast.getChild(1);
                            ts.printBefore(child0, "/*<");
                            ts.printAfter(child0, "/>*/");
                        } else {
                            assert ast.getNumChildren() == 1;
                            AST.Node child0 = ast.getChild(0);
                            if (child0 instanceof AST.IntegerLiteral) {
                                String t = ast.getTypeSpelling();
                                ts.printBefore(child0, "/*<");
                                ts.printAfter(child0, "/>*/");
                                ts.printAfter(ast, "/*<*/= new " + t + "/*>*/");
                            }
                        }
                    } else if (ast instanceof AST.FunctionDecl) {
                    }
                    break;
                }
                case ">>": {
                    AST.Node ast = cursorPaths.get(myCursor);
                    if (ast.getTypeSpelling().equals("unsigned int")) {
                        assert ast.getNumChildren() == 2;
                        AST.Node child0 = ast.getChild(0);
                        assert child0.getTypeSpelling().equals("unsigned int");
                        AST.Node child1 = ast.getChild(1);
                        assert child1.getTypeSpelling().equals("unsigned int") || child1.getTypeSpelling().equals("int");
                        if (child0 instanceof AST.ParenExpr) {
                            assert child0.getNumChildren() == 1;
                            AST.Node child00 = child0.getChild(0);
                            if (child00 instanceof AST.CStyleCastExpr) {
                                AST.Node child000 = child00.getChild(0);
                                String t = ast.getTypeSpelling();
                                String t0 = child0.getTypeSpelling();
                                String t00 = child00.getTypeSpelling();
                                String t000 = child000.getTypeSpelling();
                                assert t.equals("unsigned int") && t0.equals("unsigned int")
                                        && t00.equals("unsigned int") && t000.equals("unsigned int");
                                ts.printBefore(child00, "/*<");
                                ts.printBefore(child000, "/>*/");
                            } else if (child00 instanceof AST.BinaryOperator) {
                                AST.Node child000 = child00.getChild(0);
                                AST.Node child001 = child00.getChild(1);
                                if (child000 instanceof AST.CStyleCastExpr) {
                                    AST.Node child0000 = child000.getChild(0);
                                    String t = ast.getTypeSpelling();
                                    String t0 = child0.getTypeSpelling();
                                    String t00 = child00.getTypeSpelling();
                                    String t000 = child000.getTypeSpelling();
                                    String t001 = child001.getTypeSpelling();
                                    String t0000 = child0000.getTypeSpelling();
                                    assert t.equals("unsigned int") && t0.equals("unsigned int")
                                            && t00.equals("unsigned int") && t000.equals("unsigned int")
                                            && t001.equals("unsigned int") && t0000.equals("int");
                                    ts.printBefore(child000, "/*<");
                                    ts.printBefore(child0000, "/>*/");
                                }
                            }
                        }
                        ts.printAfter(child0, "/*<");
                        ts.printBefore(child1, "*/>>>/*>*/");
                    }
                    break;
                }
                case "const": {
                    ts.printBefore(token, "/*<");
                    ts.printAfter(token, "/>*/");
                    break;
                }
                case "unsigned": {
                    AST.Node ast = cursorPaths.get(myCursor);
                    if (ast instanceof AST.VarDecl) {
                        ts.printBefore(token, "/*<");
                        ts.printAfter(token, "*/int/*>*/");
                    }
                    break;
                }
                case "__LO":
                case "__HI": {
                    String fun = tokenSpelling;
                    CXToken varToken = tokens.get(tokNo + 2);
                    String op = clang_getCString(clang_getTokenSpelling(pf.tu, tokens.get(tokNo + 4))).getCString();
                    if (ts.match(tokNo + 1, CXTokenKind.CXToken_Punctuation, "(")
                            && clang_getTokenKind(varToken).equals(CXTokenKind.CXToken_Identifier)
                            && ts.match(tokNo + 3, CXTokenKind.CXToken_Punctuation, ")")) {
                        String var = clang_getCString(clang_getTokenSpelling(pf.tu, varToken)).getCString();
                        MyCursor varCursor = new MyCursor(cursors.get(tokNo + 2));
                        AST.Node varAst = cursorPaths.get(varCursor);
                        if (varAst instanceof AST.BinaryOperator && op.equals("=")
                                || varAst instanceof AST.CompoundAssignOperator) {
                            assert varAst.getNumChildren() == 2;
                            AST.Node child0 = varAst.getChild(0);
                            AST.Node child1 = varAst.getChild(1);
                            ts.printBefore(child0, "/*<");
                            String s = "*/" + var + "=" + fun + "(" + var + ",";
                            switch (op) {
                                case "+=":
                                    ts.printBefore(child1, s + fun + "(" + var + ")+/*>*/");
                                    break;
                                case "^=":
                                    ts.printBefore(child1, s + fun + "(" + var + ")^/*>*/");
                                    break;
                                case "|=":
                                    ts.printBefore(child1, s + fun + "(" + var + ")|/*>*/");
                                    break;
                                case "&=":
                                    ts.printBefore(child1, s + fun + "(" + var + ")&/*>*/");
                                    break;
                                default:
                                    ts.printBefore(child1, s + "/*>*/");
                            }
                            ts.printAfter(child1, "/*<*/)/*>*/");
                        }
                    }
                    break;
                }
                case "T":
                case "one":
                case "pio4":
                case "pio4lo":
                    if (pf.fileName.equals("k_tan.c") && cursorPaths.get(myCursor) != null) {
                        String s;
                        switch (tokenSpelling) {
                            case "one":
                                s = "[13]";
                                break;
                            case "pio4":
                                s = "[14]";
                                break;
                            case "pio4lo":
                                s = "[15]";
                                break;
                            case "T":
                            default:
                                s = "";
                        }
                        ts.printBefore(token, "/*<");
                        ts.printAfter(token, "*/xxx" + s + "/*>*/");
                    }
                    break;
                default:
                    if (clang_getTokenKind(token).equals(CXTokenKind.CXToken_Identifier)) {
                        String id = tokenSpelling;
                        AST.Node ast = cursorPaths.get(myCursor);
                        if (ast instanceof AST.VarDecl) {
                            if (ast.getNumChildren() == 0 && needInitialization(pf.fileName, id)) {
                                String type = ast.getTypeSpelling();
                                ts.printAfter(ast, "/*<*/=U_" + type.toUpperCase() + "/*>*/");
                            }
                        } else if (ast instanceof AST.FunctionDecl) {
                            assert cFunName(pf.fileName).equals(id);
                            ts.printBefore(ast, "/*<*/static strictfp/*>*/");
                            ts.printBefore(token, "/*<");
                            ts.printAfter(token, "*/compute/*>*/");
                        } else if (ast instanceof AST.DeclRefExpr) {
                            if (fun2class.containsKey(id)) {
                                ts.printBefore(token, "/*<");
                                ts.printAfter(token, "*/" + fun2class.get(id) + ".compute/*>*/");
                            } else if (cFunName(pf.fileName).equals("__kernel_tan")
                                    && (id.equals("T")
                                    || id.equals("one")
                                    || id.equals("pio4")
                                    || id.equals("pio4lo"))) {
                                ts.printBefore(token, "/*<");
                                switch (id) {
                                    case "T":
                                        ts.printAfter(token, "*/xxx/*>*/");
                                        break;
                                    case "one":
                                        ts.printAfter(token, "*/xxx[13]/*>*/");
                                        break;
                                    case "pio4":
                                        ts.printAfter(token, "*/xxx[14]/*>*/");
                                        break;
                                    case "pio4lo":
                                        ts.printAfter(token, "*/xxx[15]/*>*/");
                                        break;
                                }
                            }
                        }
                    }
            }
        }
        switch (pf.fileName) {
            case "k_rem_pio2.c": {
                AST.Node labelStmt = (AST.LabelStmt) pf.ast.getChild(93).getChild(6).getChild(13);
                CXToken labelTok = tokens.get(409);
                ts.printAfter(labelTok, "/*<*/for(;;){/*>*/");
                AST.Node gotoStmt = (AST.GotoStmt) pf.ast.getChild(93).getChild(6).getChild(21).getChild(1).getChild(2).getChild(1).getChild(3);
                CXToken gotoTok = tokens.get(907);
                ts.printBefore(gotoTok, "/*<");
                ts.printAfter(gotoTok, "*/continue/*>*/");
                AST.Node gotoEnclStmt = (AST.IfStmt) pf.ast.getChild(93).getChild(6).getChild(21);
                ts.printAfter(gotoEnclStmt, "/*<*/break recompute;}/*>*/");
                break;
            }
            case "e_sqrt.c": { // .89.1.12.0 m&1
                AST.Node expr = (AST.BinaryOperator) pf.ast.getChild(89).getChild(1).getChild(12).getChild(0);
                ts.printBefore(expr, "/*<");
                ts.printAfter(expr, "*/(m&1)!=0/*>*/");
                break;
            }
        }
        ts.close(out, pf.contents);

        out.println("}");
        clang_disposeTokens(pf.tu, tokens, numTokens);
    }

    private static void copyResource(PrintStream out, String resourceName) throws IOException, URISyntaxException {
        Path path = Paths.get(Main.class
                .getResource(resourceName).toURI());
        for (String line : Files.readAllLines(path, StandardCharsets.ISO_8859_1)) {
            out.println(line);
        }
    }

    private static void convertByTokens(PrintStream out) throws IOException, URISyntaxException {
        Pointer<?> Index = clang_createIndex(0, 0);
        copyResource(out, "FdlibmTranslit.java.header");
        for (Map.Entry<String, ParsedFile> e : parseFiles(Index).entrySet()) {
            ParsedFile pf = e.getValue();
            convertByTokens(out, pf);
        }
        copyResource(out, "FdlibmTranslit.java.trailer");
        clang_disposeIndex(Index);
    }

    private static void makeCursorMap(Map<MyCursor, AST.Node> map, AST.Node top) {
        AST.Node old = map.put(top.getMyCursor(), top);
        assert old == null;
        for (AST.Node child : top) {
            makeCursorMap(map, child);
        }
    }

    private static void tokenize(String fileName) throws IOException {
        Pointer<?> Index = clang_createIndex(0, 0);
        ParsedFile pf = parseFile(Index, fileName);
        System.out.println("=========");
        showExtents(pf, 0, pf.ast);
        System.out.println("=========");
//        showAST(System.out, 0, pf.ast);
//        System.out.println("=========");
        CXSourceRange range = clang_getCursorExtent(pf.ast.getCXCursor());
        Pointer<Pointer<CXToken>> tokensPtr = Pointer.allocatePointer(CXToken.class
        );
        Pointer<Integer> numTokensPtr = Pointer.allocateInt();
        clang_tokenize(pf.tu, range, tokensPtr, numTokensPtr);
        int numTokens = numTokensPtr.get();
        Pointer<CXToken> tokens = tokensPtr.get();
        Pointer<CXCursor> cursors = Pointer.allocateArray(CXCursor.class, numTokens);
        clang_annotateTokens(pf.tu, tokens, numTokens, cursors);
        Map<MyCursor, AST.Node> cursorPaths = new HashMap<>();
        makeCursorMap(cursorPaths, pf.ast);
        for (int i = 0; i < numTokens; i++) {
            CXToken token = tokens.get(i);
            CXString tokenSpelling = clang_getTokenSpelling(pf.tu, token);
            String tokenSpellingStr = clang_getCString(tokenSpelling).getCString();
            MyCursor myCursor = new MyCursor(cursors.get(i));
            System.out.println(i + " " + clang_getTokenKind(token) + " "
                    + myCursor.kind + " " + cursorPaths.get(myCursor)
                    + " <" + tokenSpellingStr + ">");
        }
        clang_disposeTokens(pf.tu, tokens, numTokens);
        clang_disposeIndex(Index);
    }

    public static void main(String[] args) throws IOException, URISyntaxException {
        System.setProperty("bridj.structsByValue", "true");
        String outFile = "../llvm2acl2/class/FdlibmTranslitN.java";
//        String outFile = "../llvm2acl2/src/main/java/FdlibmTranslitN.java;
        PrintStream out = new PrintStream(outFile);
        convertByTokens(out);
        out.flush();
        out.close();
//        tokenize("e_acos.c");
//        tokenize("s_cbrt.c");
//        tokenize("e_cosh.c");
//        tokenize("s_expm1.c");
//        tokenize("s_floor.c");
//        tokenize("e_log10.c");
//        tokenize("e_pow.c");
//        tokenize("k_rem_pio2.c");
//        tokenize("e_sinh.c");
//        tokenize("e_sqrt.c");
//        printUsedKinds();
//        showTrees();
//        showVars();
    }
}
