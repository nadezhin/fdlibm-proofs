package mytest;

import java.io.PrintStream;
import java.util.Map;
import java.util.TreeMap;
import mytest.ast.AST;
import org.bridj.Pointer;
import org.llvm.clang.CXCursor;
import org.llvm.clang.CXSourceLocation;
import org.llvm.clang.CXSourceRange;
import org.llvm.clang.CXString;
import org.llvm.clang.CXToken;
import org.llvm.clang.Libclang37Library;
import static org.llvm.clang.Libclang37Library.clang_getCString;
import static org.llvm.clang.Libclang37Library.clang_getCursorExtent;
import static org.llvm.clang.Libclang37Library.clang_getExpansionLocation;
import static org.llvm.clang.Libclang37Library.clang_getRangeEnd;
import static org.llvm.clang.Libclang37Library.clang_getRangeStart;
import static org.llvm.clang.Libclang37Library.clang_getTokenExtent;
import static org.llvm.clang.Libclang37Library.clang_getTokenKind;
import static org.llvm.clang.Libclang37Library.clang_getTokenSpelling;

/**
 *
 */
public class Tokens {

    private final Libclang37Library.CXTranslationUnit tu;
    private final int numTokens;
    private final Pointer<CXToken> tokens;
    private final Map<Integer, String> inserts = new TreeMap<>();

    Tokens(Libclang37Library.CXTranslationUnit tu, Pointer<CXToken> tokens, int numTokens) {
        this.tu = tu;
        this.numTokens = numTokens;
        this.tokens = tokens;
    }

    void printSkipped(CXToken token) {
        if (clang_getTokenKind(token).equals(Libclang37Library.CXTokenKind.CXToken_Comment)) {
            int offset = getLocationOffset(clang_getRangeEnd(clang_getTokenExtent(tu, token)));
            String old = inserts.put(offset - 1, "=");
            assert old == null;
        }
    }

    void replace(CXSourceLocation before, CXSourceLocation after, String text) {
        int bo = getLocationOffset(before);
        int ao = getLocationOffset(after);
        String old;
        if (bo < ao) {
            old = inserts.put(bo, "/*<");
            assert old == null;
            if (text.isEmpty()) {
                old = inserts.put(ao, "/>*/");
                assert old == null;
            } else {
                old = inserts.put(ao, "*/" + text + "/*>*/");
                assert old == null;
            }
        } else {
            assert bo == ao;
            if (!text.isEmpty()) {
                old = inserts.put(bo, "/*<*/" + text + "/*>*/");
                assert old == null;
            }
        }
    }

    void replace(CXToken tkB, CXToken tkA, String text) {
        replace(clang_getRangeStart(clang_getTokenExtent(tu, tkB)),
                clang_getRangeEnd(clang_getTokenExtent(tu, tkA)),
                text);
    }

    void replace(CXToken tk, String text) {
        replace(tk, tk, text);
    }

    void replace(AST.Node nodeB, AST.Node nodeA, String text) {
        replace(nodeB.getLocationBefore(), nodeA.getLocationAfter(), text);
    }

    void replace(AST.Node node, String text) {
        replace(node, node, text);
    }

    void insertBefore(CXToken tk, String text) {
        CXSourceLocation loc = clang_getRangeStart(clang_getTokenExtent(tu, tk));
        replace(loc, loc, text);
    }

    void insertAfter(CXToken tk, String text) {
        CXSourceLocation loc = clang_getRangeEnd(clang_getTokenExtent(tu, tk));
        replace(loc, loc, text);
    }

    void insertBefore(AST.Node node, String text) {
        CXSourceLocation loc = clang_getRangeStart(clang_getCursorExtent(node.getCXCursor()));
        replace(loc, loc, text);
    }

    void insertAfter(AST.Node node, String text) {
        CXSourceLocation loc = clang_getRangeEnd(clang_getCursorExtent(node.getCXCursor()));
        replace(loc, loc, text);
    }

    boolean match(int tokenNo, Libclang37Library.CXTokenKind kind, String spelling) {
        if (tokenNo >= numTokens) {
            return false;
        }
        CXToken token = tokens.get(tokenNo);
        if (!clang_getTokenKind(token).equals(kind)) {
            return false;
        }
        CXString cxSpelling = clang_getTokenSpelling(tu, token);
        return spelling.equals(clang_getCString(cxSpelling).getCString());
    }

    private static int getLocationOffset(CXSourceLocation loc) {
        Pointer<Pointer<?>> filePtr = null; //Pointer.allocatePointer();
        Pointer<Integer> linePtr = null;
        Pointer<Integer> columnPtr = null;
        Pointer<Integer> offsetPtr = Pointer.allocateInt();
        clang_getExpansionLocation(loc, filePtr, linePtr, columnPtr, offsetPtr);
        return offsetPtr.get();
    }

    public void close(PrintStream out, byte[] contentsBytes) {
        int offset = 0;
        for (Map.Entry<Integer, String> e : inserts.entrySet()) {
            int newOffset = e.getKey();
            String insert = e.getValue();
            out.write(contentsBytes, offset, newOffset - offset);
            offset = newOffset;
            out.print(insert);
        }
        out.write(contentsBytes, offset, contentsBytes.length - offset);
    }
}
