(in-package "ACL2")
(include-book "../llvm")
(include-book "e_sinh")

(defconst *sinh-globals* '())

(defund @sinh-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (load-double '(ret . 0) mem))
    (%3 (@__ieee754_sinh %2)))
  %3))

(defund @sinh (%x)
  (@sinh-%0 *sinh-globals*  %x))
