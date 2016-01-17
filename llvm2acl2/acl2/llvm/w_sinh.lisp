(in-package "ACL2")
(include-book "../llvm")
(include-book "e_sinh")

(defund @sinh-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_sinh %2)))
  %3))

(defund @sinh (%x)
  (@sinh-%0 () %x))
