(in-package "ACL2")
(include-book "../llvm")

(defconst *copysign-globals* '())

(defund @copysign-%0 (mem %x %y)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (mem (store-double %y '(x . 0) mem))
    (%3 (bitcast-double*-to-i32* '(ret . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (%6 (and-i32 %5 2147483647))
    (%7 (bitcast-double*-to-i32* '(x . 0)))
    (%8 (getelementptr-i32 %7 1))
    (%9 (load-i32 %8 mem))
    (%10 (and-i32 %9 -2147483648))
    (%11 (or-i32 %6 %10))
    (%12 (bitcast-double*-to-i32* '(ret . 0)))
    (%13 (getelementptr-i32 %12 1))
    (mem (store-i32 %11 %13 mem))
    (%14 (load-double '(ret . 0) mem)))
  %14))

(defund @copysign (%x %y)
  (@copysign-%0 *copysign-globals*  %x %y))
