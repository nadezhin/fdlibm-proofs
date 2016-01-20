(in-package "ACL2")
(include-book "../llvm")
(include-book "e_atan2")

(defconst *atan2-globals* '())

(defund @atan2-%0 (mem %y %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'y 1 mem))
    (mem (store-double %y '(ret . 0) mem))
    (mem (store-double %x '(y . 0) mem))
    (%3 (load-double '(ret . 0) mem))
    (%4 (load-double '(y . 0) mem))
    (%5 (@__ieee754_atan2 %3 %4)))
  %5))

(defund @atan2 (%y %x)
  (@atan2-%0 *atan2-globals*  %y %x))
