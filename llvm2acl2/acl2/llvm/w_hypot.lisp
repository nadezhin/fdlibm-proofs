(in-package "ACL2")
(include-book "../llvm")
(include-book "e_hypot")

(defconst *hypot-globals* '())

(defund @hypot-%0 (mem %x %y)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (mem (store-double %y '(x . 0) mem))
    (%3 (load-double '(ret . 0) mem))
    (%4 (load-double '(x . 0) mem))
    (%5 (@__ieee754_hypot %3 %4)))
  %5))

(defund @hypot (%x %y)
  (@hypot-%0 *hypot-globals*  %x %y))
