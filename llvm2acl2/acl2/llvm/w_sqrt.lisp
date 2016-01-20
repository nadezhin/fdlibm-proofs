(in-package "ACL2")
(include-book "../llvm")
(include-book "e_sqrt")

(defconst *sqrt-globals* '())

(defund @sqrt-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (load-double '(ret . 0) mem))
    (%3 (@__ieee754_sqrt %2)))
  %3))

(defund @sqrt (%x)
  (@sqrt-%0 *sqrt-globals*  %x))
