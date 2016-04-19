(in-package "ACL2")
(include-book "../llvm")
(include-book "e_cosh")

(defconst *cosh-globals* '())

(defund @cosh-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double (g '%x loc) '(ret . 0) mem))
    (loc (s '%2 (load-double '(ret . 0) mem) loc))
    (loc (s '%3 (@__ieee754_cosh (g '%2 loc)) loc)))
  (mv 'ret mem loc)))

(defund @cosh-step (label mem loc)
  (case label
    (%-0 (@cosh-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @cosh-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@cosh-step label mem loc)
        (@cosh-steps label mem loc (1- n))))))

(defund @cosh (%x)
  (declare (ignore %x))
   nil)
