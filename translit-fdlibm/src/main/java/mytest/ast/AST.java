/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mytest.ast;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.bridj.Pointer;
import org.bridj.ann.Ptr;
import org.llvm.clang.CXCursor;
import org.llvm.clang.CXString;
import org.llvm.clang.CXType;
import org.llvm.clang.Libclang37Library;
import static org.llvm.clang.Libclang37Library.*;

/**
 *
 */
public class AST {

    public static class Node implements Iterable<Node> {

        private final MyCursor cursor;
        public final String path;
        private final List<Node> children = new ArrayList<>();

        private Node(MyCursor cursor, String path) {
            this.cursor = cursor;
            this.path = path;
        }
        
        public CXCursorKind getKind () {
            return cursor.kind;
        }
        
        public int getNumChildren() {
            return children.size();
        }
        
        public Node getChild(int i) {
            return children.get(i);
        }
        
        public MyCursor getMyCursor() {
            return cursor;
        }
        
        public CXCursor getCXCursor() {
            return cursor.impl();
        }
        
        public String getTypeSpelling() {
            CXType type = clang_getCursorType(getCXCursor());
            CXString typeCstr = clang_getTypeSpelling(type);
            return clang_getCString(typeCstr).getCString();
        }

        @Override
        public Iterator<Node> iterator() {
            return children.iterator();
        }
    }

    public static class StructDecl extends Node {

        StructDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class EnumDecl extends Node {

        EnumDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class FieldDecl extends Node {

        FieldDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class EnumConstantDecl extends Node {

        EnumConstantDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class FunctionDecl extends Node {

        FunctionDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class VarDecl extends Node {

        VarDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ParmDecl extends Node {

        ParmDecl(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class TypeRef extends Node {

        TypeRef(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class LabelRef extends Node {

        LabelRef(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class FirstExpr extends Node {

        FirstExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class DeclRefExpr extends Node {

        DeclRefExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class CallExpr extends Node {

        CallExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class IntegerLiteral extends Node {

        IntegerLiteral(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class FloatingLiteral extends Node {

        FloatingLiteral(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class StringLiteral extends Node {

        StringLiteral(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ParenExpr extends Node {

        ParenExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class UnaryOperator extends Node {

        UnaryOperator(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ArraySubscriptExpr extends Node {

        ArraySubscriptExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class BinaryOperator extends Node {

        BinaryOperator(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class CompoundAssignOperator extends Node {

        CompoundAssignOperator(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ConditionalOperator extends Node {

        ConditionalOperator(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class CStyleCastExpr extends Node {

        CStyleCastExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class InitListExpr extends Node {

        InitListExpr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class LabelStmt extends Node {

        LabelStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class CompoundStmt extends Node {

        CompoundStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class CaseStmt extends Node {

        CaseStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class DefaultStmt extends Node {

        DefaultStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class IfStmt extends Node {

        IfStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class SwitchStmt extends Node {

        SwitchStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class WhileStmt extends Node {

        WhileStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ForStmt extends Node {

        ForStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class GotoStmt extends Node {

        GotoStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class BreakStmt extends Node {

        BreakStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ReturnStmt extends Node {

        ReturnStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class NullStmt extends Node {

        NullStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class DeclStmt extends Node {

        DeclStmt(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class TranslationUnit extends Node {

        TranslationUnit(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class FirstAttr extends Node {

        FirstAttr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class ConstAttr extends Node {

        ConstAttr(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class MacroDefinition extends Node {

        MacroDefinition(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class MacroExpansion extends Node {

        MacroExpansion(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static class InclusionDirective extends Node {

        InclusionDirective(MyCursor cursor, String path) {
            super(cursor, path);
        }
    }

    public static TranslationUnit newRoot(MyCursor c) {
        return new TranslationUnit(c, "");
    }
    
    public static Node newNode(Node parent, MyCursor c) {
        String path = parent.path + "." + parent.children.size();
        Node n;
        switch (c.kind) {
            case CXCursor_StructDecl:
                n = new StructDecl(c, path);
                break;
            case CXCursor_EnumDecl:
                n = new EnumDecl(c, path);
                break;
            case CXCursor_FieldDecl:
                n = new FieldDecl(c, path);
                break;
            case CXCursor_EnumConstantDecl:
                n = new EnumConstantDecl(c, path);
                break;
            case CXCursor_FunctionDecl:
                n = new FunctionDecl(c, path);
                break;
            case CXCursor_VarDecl:
                n = new VarDecl(c, path);
                break;
            case CXCursor_ParmDecl:
                n = new ParmDecl(c, path);
                break;
            case CXCursor_TypeRef:
                n = new TypeRef(c, path);
                break;
            case CXCursor_LabelRef:
                n = new LabelRef(c, path);
                break;
            case CXCursor_FirstExpr:
                n = new FirstExpr(c, path);
                break;
            case CXCursor_DeclRefExpr:
                n = new DeclRefExpr(c, path);
                break;
            case CXCursor_CallExpr:
                n = new CallExpr(c, path);
                break;
            case CXCursor_IntegerLiteral:
                n = new IntegerLiteral(c, path);
                break;
            case CXCursor_FloatingLiteral:
                n = new FloatingLiteral(c, path);
                break;
            case CXCursor_StringLiteral:
                n = new StringLiteral(c, path);
                break;
            case CXCursor_ParenExpr:
                n = new ParenExpr(c, path);
                break;
            case CXCursor_UnaryOperator:
                n = new UnaryOperator(c, path);
                break;
            case CXCursor_ArraySubscriptExpr:
                n = new ArraySubscriptExpr(c, path);
                break;
            case CXCursor_BinaryOperator:
                n = new BinaryOperator(c, path);
                break;
            case CXCursor_CompoundAssignOperator:
                n = new CompoundAssignOperator(c, path);
                break;
            case CXCursor_ConditionalOperator:
                n = new ConditionalOperator(c, path);
                break;
            case CXCursor_CStyleCastExpr:
                n = new CStyleCastExpr(c, path);
                break;
            case CXCursor_InitListExpr:
                n = new InitListExpr(c, path);
                break;
            case CXCursor_LabelStmt:
                n = new LabelStmt(c, path);
                break;
            case CXCursor_CompoundStmt:
                n = new CompoundStmt(c, path);
                break;
            case CXCursor_CaseStmt:
                n = new CaseStmt(c, path);
                break;
            case CXCursor_DefaultStmt:
                n = new DefaultStmt(c, path);
                break;
            case CXCursor_IfStmt:
                n = new IfStmt(c, path);
                break;
            case CXCursor_SwitchStmt:
                n = new SwitchStmt(c, path);
                break;
            case CXCursor_WhileStmt:
                n = new WhileStmt(c, path);
                break;
            case CXCursor_ForStmt:
                n = new ForStmt(c, path);
                break;
            case CXCursor_GotoStmt:
                n = new GotoStmt(c, path);
                break;
            case CXCursor_BreakStmt:
                n = new BreakStmt(c, path);
                break;
            case CXCursor_ReturnStmt:
                n = new ReturnStmt(c, path);
                break;
            case CXCursor_NullStmt:
                n = new NullStmt(c, path);
                break;
            case CXCursor_DeclStmt:
                n = new DeclStmt(c, path);
                break;
            case CXCursor_FirstAttr:
                n = new FirstAttr(c, path);
                break;
            case CXCursor_ConstAttr:
                n = new ConstAttr(c, path);
                break;
            case CXCursor_MacroDefinition:
                n = new MacroDefinition(c, path);
                break;
            case CXCursor_MacroExpansion:
                n = new MacroExpansion(c, path);
                break;
            case CXCursor_InclusionDirective:
                n = new InclusionDirective(c, path);
                break;
            default:
                throw new AssertionError();
        }
        parent.children.add(n);
        return n;
    }

    public static TranslationUnit makeAst(Libclang37Library.CXTranslationUnit TU) {
        CXCursor rawRoot = clang_getTranslationUnitCursor(TU);
        MyCursor root = new MyCursor(rawRoot);
        AST.TranslationUnit astRoot = AST.newRoot(root);
        List<MyCursor> stack = new ArrayList<>();
        List<AST.Node> stackAST = new ArrayList<>();
        stack.add(root);
        stackAST.add(astRoot);
        Libclang37Library.CXCursorVisitor myVisitor = new Libclang37Library.CXCursorVisitor() {
            @Override
            public int apply(CXCursor cursor, CXCursor parent, @Ptr long client_data) {
                MyCursor myCursor = new MyCursor(cursor);
                MyCursor myParent = new MyCursor(parent);
                while (!stack.get(stack.size() - 1).equals(myParent)) {
                    stack.remove(stack.size() - 1);
                    stackAST.remove(stackAST.size() - 1);
                }
                assert myCursor.data2 == root.data2;
                stack.add(myCursor);
                stackAST.add(AST.newNode(stackAST.get(stackAST.size() - 1), myCursor));
                return (int) Libclang37Library.CXChildVisitResult.CXChildVisit_Recurse.value();
            }
        };
        Pointer<Libclang37Library.CXCursorVisitor> myVisitorPtr = Pointer.getPointer(myVisitor);
        clang_visitChildren(rawRoot, myVisitorPtr, null);

        //clang_disposeTranslationUnit(TU);
        return astRoot;
    }
}
