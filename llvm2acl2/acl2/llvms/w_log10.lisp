(in-package "ACL2")
(include-book "../llvm")
(include-book "e_log10")

(defconst *log10-globals* '())

(defund @log10-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double (g '%x loc) '(ret . 0) mem))
    (loc (s '%2 (load-double '(ret . 0) mem) loc))
    (loc (s '%3 (@__ieee754_log10 (g '%2 loc)) loc)))
  (mv 'ret mem loc)))

(defund @log10-step (label mem loc)
  (case label
    (%-0 (@log10-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @log10-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@log10-step label mem loc)
        (@log10-steps label mem loc (1- n))))))

(defund @log10 (%x)
  (declare (ignore %x))
   nil)
