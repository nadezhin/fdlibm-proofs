(in-package "ACL2")
(include-book "../llvm")

(defconst *fabs-globals* '())

(defund @fabs-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (store-double (g '%x loc) '(ret . 0) mem))
    (loc (s '%2 (bitcast-double*-to-i32* '(ret . 0)) loc))
    (loc (s '%3 (getelementptr-i32 (g '%2 loc) 1) loc))
    (loc (s '%4 (load-i32 (g '%3 loc) mem) loc))
    (loc (s '%5 (and-i32 (g '%4 loc) 2147483647) loc))
    (mem (store-i32 (g '%5 loc) (g '%3 loc) mem))
    (loc (s '%6 (load-double '(ret . 0) mem) loc)))
  (mv 'ret mem loc)))

(defund @fabs-step (label mem loc)
  (case label
    (%-0 (@fabs-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @fabs-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%6 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@fabs-step label mem loc)
        (@fabs-steps label mem loc (1- n))))))

(defund @fabs (%x)
  (declare (ignore %x))
   nil)
