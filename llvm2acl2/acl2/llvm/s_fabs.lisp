(in-package "ACL2")
(include-book "../llvm")

(defconst *fabs-globals* '())

(defund @fabs-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (bitcast-double*-to-i32* '(ret . 0)))
    (%3 (getelementptr-i32 %2 1))
    (%4 (load-i32 %3 mem))
    (%5 (and-i32 %4 2147483647))
    (mem (store-i32 %5 %3 mem))
    (%6 (load-double '(ret . 0) mem)))
  %6))

(defund @fabs (%x)
  (@fabs-%0 *fabs-globals*  %x))
