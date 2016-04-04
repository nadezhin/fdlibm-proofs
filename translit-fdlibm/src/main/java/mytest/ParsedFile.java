package mytest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import mytest.ast.AST;
import org.bridj.Pointer;
import org.llvm.clang.CXString;
import org.llvm.clang.CXUnsavedFile;
import org.llvm.clang.Libclang37Library;
import static org.llvm.clang.Libclang37Library.*;

/**
 *
 */
public class ParsedFile {

    final String fileName;
    final byte[] contents;
    final Libclang37Library.CXTranslationUnit tu;
    final AST.TranslationUnit ast;

    private ParsedFile(String fileName, byte[] contentsBytes, Libclang37Library.CXTranslationUnit tu, AST.TranslationUnit ast) {
        this.fileName = fileName;
        this.contents = contentsBytes;
        this.tu = tu;
        this.ast = ast;
    }

    public static ParsedFile parseTranslationUnit(Pointer<?> Index, String dirName, String fileName) throws IOException {
        byte[] contents = Files.readAllBytes(Paths.get(dirName + fileName));
        Pointer<Byte> source_filename = Pointer.pointerToCString(dirName + fileName);
        Pointer<Pointer<Byte>> command_line_args = null;
        int num_command_line_args = 0;
        Pointer<CXUnsavedFile> unsaved_files = null;
        int num_unsaved_files = 0;
        CXTranslationUnit_Flags options = CXTranslationUnit_Flags.CXTranslationUnit_None;
//        CXTranslationUnit_Flags options = CXTranslationUnit_Flags.CXTranslationUnit_DetailedPreprocessingRecord;
        Libclang37Library.CXTranslationUnit TU = clang_parseTranslationUnit(
                Index,
                source_filename,
                command_line_args,
                num_command_line_args,
                unsaved_files,
                num_unsaved_files,
                (int) options.value());
        int N = clang_getNumDiagnostics(TU);
        if (N != 0) {
            System.out.println(N + " diagnostics");
            for (int i = 0; i < N; i++) {
                Pointer<?> diag = clang_getDiagnostic(TU, i);
                CXString diagCxstr = clang_formatDiagnostic(diag, clang_defaultDiagnosticDisplayOptions());
                System.out.println("  " + clang_getCString(diagCxstr).getCString());
                clang_disposeDiagnostic(diag);
            }
        }
        AST.TranslationUnit ast = AST.makeAst(TU);
        return new ParsedFile(fileName, contents, TU, ast);
    }

}
