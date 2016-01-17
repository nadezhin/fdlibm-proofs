(in-package "ACL2")
(include-book "../llvm")
(include-book "e_log")

(defund @log-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_log %2)))
  %3))

(defund @log (%x)
  (@log-%0 () %x))
