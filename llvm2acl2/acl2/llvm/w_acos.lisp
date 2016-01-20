(in-package "ACL2")
(include-book "../llvm")
(include-book "e_acos")

(defconst *acos-globals* '())

(defund @acos-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (load-double '(ret . 0) mem))
    (%3 (@__ieee754_acos %2)))
  %3))

(defund @acos (%x)
  (@acos-%0 *acos-globals*  %x))
