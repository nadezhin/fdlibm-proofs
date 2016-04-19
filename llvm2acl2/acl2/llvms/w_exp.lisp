(in-package "ACL2")
(include-book "../llvm")
(include-book "e_exp")

(defconst *exp-globals* '())

(defund @exp-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double (g '%x loc) '(ret . 0) mem))
    (loc (s '%2 (load-double '(ret . 0) mem) loc))
    (loc (s '%3 (@__ieee754_exp (g '%2 loc)) loc)))
  (mv 'ret mem loc)))

(defund @exp-step (label mem loc)
  (case label
    (%-0 (@exp-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @exp-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@exp-step label mem loc)
        (@exp-steps label mem loc (1- n))))))

(defund @exp (%x)
  (declare (ignore %x))
   nil)
