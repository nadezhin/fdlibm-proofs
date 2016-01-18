(in-package "ACL2")
(include-book "../llvm")
(include-book "e_atan2")

(defconst *atan2-globals* '())

(defund @atan2-%0 (mem %y %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    ((mv %2 mem) (alloca-double-1 'y mem))
    (mem (store-double %y %1 mem))
    (mem (store-double %x %2 mem))
    (%3 (load-double %1 mem))
    (%4 (load-double %2 mem))
    (%5 (@__ieee754_atan2 %3 %4)))
  %5))

(defund @atan2 (%y %x)
  (@atan2-%0 *atan2-globals* %y %x))
