(in-package "ACL2")
(include-book "../llvm")
(include-book "e_asin")

(defconst *asin-globals* '())

(defund @asin-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    (mem (store-double %x %1 mem))
    (%2 (load-double %1 mem))
    (%3 (@__ieee754_asin %2)))
  %3))

(defund @asin (%x)
  (@asin-%0 *asin-globals* %x))
