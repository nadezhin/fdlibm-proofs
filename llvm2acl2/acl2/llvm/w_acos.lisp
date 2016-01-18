(in-package "ACL2")
(include-book "../llvm")
(include-book "e_acos")

(defconst *acos-globals* '())

(defund @acos-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_acos %2)))
  %3))

(defund @acos (%x)
  (@acos-%0 *acos-globals* %x))
