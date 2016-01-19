(in-package "ACL2")
(include-book "../llvm")
(include-book "e_cosh")

(defconst *cosh-globals* '())

(defund @cosh-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_cosh %2)))
  %3))

(defund @cosh (%x)
  (@cosh-%0 *cosh-globals* %x))
