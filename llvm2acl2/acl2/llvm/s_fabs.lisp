(in-package "ACL2")
(include-book "../llvm")

(defund @fabs-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    (mem (store-double %x %1 mem))
    (%2 (bitcast-double*-to-i32* %1))
    (%3 (getelementptr-i32 %2 1))
    (%4 (load-i32 %3 mem))
    (%5 (and-i32 %4 2147483647))
    (mem (store-i32 %5 %3 mem))
    (%6 (load-double %1 mem)))
  %6))

(defund @fabs (%x)
  (@fabs-%0 () %x))
