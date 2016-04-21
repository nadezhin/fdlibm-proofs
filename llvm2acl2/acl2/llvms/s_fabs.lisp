(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")

(defconst *fabs-globals* '())

(defconst *fabs-labels* '(%0))

(defund @fabs-%0-mem (s0)
  (car s0))
(defund @fabs-%0-loc (s0)
  (cadr s0))
(defund @fabs-%0-pred (s0)
  (caddr s0))
(defund @fabs-%1-mem (s0)
  (alloca-double 'ret 1 (@fabs-%0-mem s0)))
(defund @fabs-%1-loc (s0)
  (s '%1 '(ret . 0) (@fabs-%0-loc s0)))
(defund @fabs-m0.1-mem (s0)
  (store-double (g '%x (@fabs-%1-loc s0)) (g '%1 (@fabs-%1-loc s0)) (@fabs-%1-mem s0)))
(defund @fabs-%2-val (s0)
  (bitcast-double*-to-i32* (g '%1 (@fabs-%1-loc s0))))
(defund @fabs-%2-loc (s0)
  (s '%2 (@fabs-%2-val s0) (@fabs-%1-loc s0)))
(defund @fabs-%3-val (s0)
  (getelementptr-i32 (g '%2 (@fabs-%2-loc s0)) 1))
(defund @fabs-%3-loc (s0)
  (s '%3 (@fabs-%3-val s0) (@fabs-%2-loc s0)))
(defund @fabs-%4-val (s0)
  (load-i32 (g '%3 (@fabs-%3-loc s0)) (@fabs-m0.1-mem s0)))
(defund @fabs-%4-loc (s0)
  (s '%4 (@fabs-%4-val s0) (@fabs-%3-loc s0)))
(defund @fabs-%5-val (s0)
  (and-i32 (g '%4 (@fabs-%4-loc s0)) 2147483647))
(defund @fabs-%5-loc (s0)
  (s '%5 (@fabs-%5-val s0) (@fabs-%4-loc s0)))
(defund @fabs-m0.2-mem (s0)
  (store-i32 (g '%5 (@fabs-%5-loc s0)) (g '%3 (@fabs-%5-loc s0)) (@fabs-m0.1-mem s0)))
(defund @fabs-%6-val (s0)
  (load-double (g '%1 (@fabs-%5-loc s0)) (@fabs-m0.2-mem s0)))
(defund @fabs-%6-loc (s0)
  (s '%6 (@fabs-%6-val s0) (@fabs-%5-loc s0)))
(defund @fabs-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @fabs-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @fabs-%6-rev (mem loc pred)
  (@fabs-succ0-rev mem (s '%6 (load-double (g '%1 loc) mem) loc) pred))
(defund @fabs-m0.2-rev (mem loc pred)
  (@fabs-%6-rev (store-i32 (g '%5 loc) (g '%3 loc) mem) loc pred))
(defund @fabs-%5-rev (mem loc pred)
  (@fabs-m0.2-rev mem (s '%5 (and-i32 (g '%4 loc) 2147483647) loc) pred))
(defund @fabs-%4-rev (mem loc pred)
  (@fabs-%5-rev mem (s '%4 (load-i32 (g '%3 loc) mem) loc) pred))
(defund @fabs-%3-rev (mem loc pred)
  (@fabs-%4-rev mem (s '%3 (getelementptr-i32 (g '%2 loc) 1) loc) pred))
(defund @fabs-%2-rev (mem loc pred)
  (@fabs-%3-rev mem (s '%2 (bitcast-double*-to-i32* (g '%1 loc)) loc) pred))
(defund @fabs-m0.1-rev (mem loc pred)
  (@fabs-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @fabs-%1-rev (mem loc pred)
  (@fabs-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @fabs-%0-rev (mem loc pred)
  (@fabs-%1-rev mem loc pred))

(defund @fabs-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (bitcast-double*-to-i32* (g '%1 loc)) loc))
    (loc (s '%3 (getelementptr-i32 (g '%2 loc) 1) loc))
    (loc (s '%4 (load-i32 (g '%3 loc) mem) loc))
    (loc (s '%5 (and-i32 (g '%4 loc) 2147483647) loc))
    (mem (store-i32 (g '%5 loc) (g '%3 loc) mem))
    (loc (s '%6 (load-double (g '%1 loc) mem) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @fabs-%0-expand-bb
  (equal (@fabs-%0-bb mem loc pred)
         (@fabs-%0-rev mem loc pred))
  :enable (@fabs-%0-bb @fabs-%0-rev
    @fabs-%1-rev
    @fabs-m0.1-rev
    @fabs-%2-rev
    @fabs-%3-rev
    @fabs-%4-rev
    @fabs-%5-rev
    @fabs-m0.2-rev
    @fabs-%6-rev
    @fabs-succ0-rev)
  :disable s-diff-s)

(defund @fabs-step (label mem loc pred)
  (case label
    (%0 (@fabs-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @fabs-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%6 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@fabs-step label mem loc pred)
        (@fabs-steps new-label new-mem new-loc label (1- n))))))

(defund @fabs (%x)
  (declare (ignore %x))
   nil)