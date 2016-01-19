(in-package "ACL2")
(include-book "../llvm")
(include-book "e_pow")

(defconst *pow-globals* '())

(defund @pow-%0 (mem %x %y)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    (mem (store-double %x %1 mem))
    (mem (store-double %y %2 mem))
    (%3 (load-double %1 mem))
    (%4 (load-double %2 mem))
    (%5 (@__ieee754_pow %3 %4)))
  %5))

(defund @pow (%x %y)
  (@pow-%0 *pow-globals* %x %y))
