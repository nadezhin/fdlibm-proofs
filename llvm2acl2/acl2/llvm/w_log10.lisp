(in-package "ACL2")
(include-book "../llvm")
(include-book "e_log10")

(defconst *log10-globals* '())

(defund @log10-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (load-double '(ret . 0) mem))
    (%3 (@__ieee754_log10 %2)))
  %3))

(defund @log10 (%x)
  (@log10-%0 *log10-globals*  %x))
