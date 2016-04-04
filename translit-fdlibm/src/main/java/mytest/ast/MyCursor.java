package mytest.ast;

import java.util.NoSuchElementException;
import java.util.Objects;
import mytest.Main;
import org.bridj.IntValuedEnum;
import org.llvm.clang.CXCursor;
import org.llvm.clang.Libclang37Library;

/**
 *
 */
public class MyCursor {

    private static Libclang37Library.CXCursorKind cursorKind(CXCursor cursor) {
        IntValuedEnum<Libclang37Library.CXCursorKind> raw = cursor.kind();
        for (Libclang37Library.CXCursorKind c : Libclang37Library.CXCursorKind.values()) {
            if (c.value() == raw.value()) {
                return c;
            }
        }
        throw new NoSuchElementException();
    }

    public final Libclang37Library.CXCursorKind kind;
    public final int xdata;
    public final long data0;
    public final long data1;
    public final long data2;

    MyCursor(Libclang37Library.CXCursorKind kind, int xdata, long data0, long data1, long data2) {
        this.kind = kind;
        this.xdata = xdata;
        this.data0 = data0;
        this.data1 = data1;
        this.data2 = data2;
    }

    public MyCursor(CXCursor cursor) {
        this(cursorKind(cursor), cursor.xdata(),
                cursor.data().getLongAtIndex(0),
                cursor.data().getLongAtIndex(1),
                cursor.data().getLongAtIndex(2));
    }
    
    public CXCursor impl() {
        CXCursor c = new CXCursor();
        c.kind(kind);
        c.xdata(xdata);
        c.data().setLongAtIndex(0, data0);
        c.data().setLongAtIndex(1, data1);
        c.data().setLongAtIndex(2, data2);
        return c;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof MyCursor)) {
            return false;
        }
        MyCursor that = (MyCursor) o;
        return this.kind == that.kind
                && this.xdata == that.xdata
                && this.data0 == that.data0
                && this.data1 == that.data1
                && this.data2 == that.data2;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 53 * hash + Objects.hashCode(this.kind);
        hash = 53 * hash + this.xdata;
        hash = 53 * hash + (int) (this.data0 ^ (this.data0 >>> 32));
        hash = 53 * hash + (int) (this.data1 ^ (this.data1 >>> 32));
        hash = 53 * hash + (int) (this.data2 ^ (this.data2 >>> 32));
        return hash;
    }
}
