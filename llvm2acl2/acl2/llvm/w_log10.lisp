(in-package "ACL2")
(include-book "../llvm")
(include-book "e_log10")

(defund @log10-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_log10 %2)))
  %3))

(defund @log10 (%x)
  (@log10-%0 () %x))
