(in-package "ACL2")
(include-book "../llvm")
(include-book "e_exp")

(defconst *exp-globals* '())

(defund @exp-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (load-double '(ret . 0) mem))
    (%3 (@__ieee754_exp %2)))
  %3))

(defund @exp (%x)
  (@exp-%0 *exp-globals*  %x))
