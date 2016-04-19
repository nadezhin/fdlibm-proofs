(in-package "ACL2")
(include-book "../llvm")
(include-book "e_pow")

(defconst *pow-globals* '())

(defund @pow-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (store-double (g '%x loc) '(ret . 0) mem))
    (mem (store-double (g '%y loc) '(x . 0) mem))
    (loc (s '%3 (load-double '(ret . 0) mem) loc))
    (loc (s '%4 (load-double '(x . 0) mem) loc))
    (loc (s '%5 (@__ieee754_pow (g '%3 loc) (g '%4 loc)) loc)))
  (mv 'ret mem loc)))

(defund @pow-step (label mem loc)
  (case label
    (%-0 (@pow-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @pow-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%5 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@pow-step label mem loc)
        (@pow-steps label mem loc (1- n))))))

(defund @pow (%x %y)
  (declare (ignore %x %y))
   nil)
