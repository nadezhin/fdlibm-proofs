(in-package "ACL2")
(include-book "../llvm")
(include-book "e_log")

(defconst *log-globals* '())

(defund @log-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double %x '(ret . 0) mem))
    (%2 (load-double '(ret . 0) mem))
    (%3 (@__ieee754_log %2)))
  %3))

(defund @log (%x)
  (@log-%0 *log-globals*  %x))
