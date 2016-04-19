(in-package "ACL2")
(include-book "../llvm")
(include-book "e_atan2")

(defconst *atan2-globals* '())

(defund @atan2-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'y 1 mem))
    (mem (store-double (g '%y loc) '(ret . 0) mem))
    (mem (store-double (g '%x loc) '(y . 0) mem))
    (loc (s '%3 (load-double '(ret . 0) mem) loc))
    (loc (s '%4 (load-double '(y . 0) mem) loc))
    (loc (s '%5 (@__ieee754_atan2 (g '%3 loc) (g '%4 loc)) loc)))
  (mv 'ret mem loc)))

(defund @atan2-step (label mem loc)
  (case label
    (%-0 (@atan2-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @atan2-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%5 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@atan2-step label mem loc)
        (@atan2-steps label mem loc (1- n))))))

(defund @atan2 (%y %x)
  (declare (ignore %y %x))
   nil)
