(in-package "ACL2")
(include-book "../llvm")
(include-book "e_sqrt")

(defconst *sqrt-globals* '())

(defund @sqrt-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double-1 'ret mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_sqrt %2)))
  %3))

(defund @sqrt (%x)
  (@sqrt-%0 *sqrt-globals* %x))
