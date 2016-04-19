(in-package "ACL2")
(include-book "../llvm")

(defconst *copysign-globals* '())

(defund @copysign-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (store-double (g '%x loc) '(ret . 0) mem))
    (mem (store-double (g '%y loc) '(x . 0) mem))
    (loc (s '%3 (bitcast-double*-to-i32* '(ret . 0)) loc))
    (loc (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc))
    (loc (s '%5 (load-i32 (g '%4 loc) mem) loc))
    (loc (s '%6 (and-i32 (g '%5 loc) 2147483647) loc))
    (loc (s '%7 (bitcast-double*-to-i32* '(x . 0)) loc))
    (loc (s '%8 (getelementptr-i32 (g '%7 loc) 1) loc))
    (loc (s '%9 (load-i32 (g '%8 loc) mem) loc))
    (loc (s '%10 (and-i32 (g '%9 loc) -2147483648) loc))
    (loc (s '%11 (or-i32 (g '%6 loc) (g '%10 loc)) loc))
    (loc (s '%12 (bitcast-double*-to-i32* '(ret . 0)) loc))
    (loc (s '%13 (getelementptr-i32 (g '%12 loc) 1) loc))
    (mem (store-i32 (g '%11 loc) (g '%13 loc) mem))
    (loc (s '%14 (load-double '(ret . 0) mem) loc)))
  (mv 'ret mem loc)))

(defund @copysign-step (label mem loc)
  (case label
    (%-0 (@copysign-%0-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @copysign-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%14 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@copysign-step label mem loc)
        (@copysign-steps label mem loc (1- n))))))

(defund @copysign (%x %y)
  (declare (ignore %x %y))
   nil)
