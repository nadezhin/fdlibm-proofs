(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_atan2")

(defconst *atan2-globals* '())

(defconst *atan2-labels* '(%0))

(defund @atan2-%0-mem (s0)
  (car s0))
(defund @atan2-%0-loc (s0)
  (cadr s0))
(defund @atan2-%0-pred (s0)
  (caddr s0))
(defund @atan2-%1-mem (s0)
  (alloca-double 'ret 1 (@atan2-%0-mem s0)))
(defund @atan2-%1-loc (s0)
  (s '%1 '(ret . 0) (@atan2-%0-loc s0)))
(defund @atan2-%2-mem (s0)
  (alloca-double 'y 1 (@atan2-%1-mem s0)))
(defund @atan2-%2-loc (s0)
  (s '%2 '(y . 0) (@atan2-%1-loc s0)))
(defund @atan2-m0.1-mem (s0)
  (store-double (g '%y (@atan2-%2-loc s0)) (g '%1 (@atan2-%2-loc s0)) (@atan2-%2-mem s0)))
(defund @atan2-m0.2-mem (s0)
  (store-double (g '%x (@atan2-%2-loc s0)) (g '%2 (@atan2-%2-loc s0)) (@atan2-m0.1-mem s0)))
(defund @atan2-%3-val (s0)
  (load-double (g '%1 (@atan2-%2-loc s0)) (@atan2-m0.2-mem s0)))
(defund @atan2-%3-loc (s0)
  (s '%3 (@atan2-%3-val s0) (@atan2-%2-loc s0)))
(defund @atan2-%4-val (s0)
  (load-double (g '%2 (@atan2-%3-loc s0)) (@atan2-m0.2-mem s0)))
(defund @atan2-%4-loc (s0)
  (s '%4 (@atan2-%4-val s0) (@atan2-%3-loc s0)))
(defund @atan2-%5-val (s0)
  (@__ieee754_atan2 (g '%3 (@atan2-%4-loc s0)) (g '%4 (@atan2-%4-loc s0))))
(defund @atan2-%5-loc (s0)
  (s '%5 (@atan2-%5-val s0) (@atan2-%4-loc s0)))
(defund @atan2-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @atan2-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @atan2-%5-rev (mem loc pred)
  (@atan2-succ0-rev mem (s '%5 (@__ieee754_atan2 (g '%3 loc) (g '%4 loc)) loc) pred))
(defund @atan2-%4-rev (mem loc pred)
  (@atan2-%5-rev mem (s '%4 (load-double (g '%2 loc) mem) loc) pred))
(defund @atan2-%3-rev (mem loc pred)
  (@atan2-%4-rev mem (s '%3 (load-double (g '%1 loc) mem) loc) pred))
(defund @atan2-m0.2-rev (mem loc pred)
  (@atan2-%3-rev (store-double (g '%x loc) (g '%2 loc) mem) loc pred))
(defund @atan2-m0.1-rev (mem loc pred)
  (@atan2-m0.2-rev (store-double (g '%y loc) (g '%1 loc) mem) loc pred))
(defund @atan2-%2-rev (mem loc pred)
  (@atan2-m0.1-rev (alloca-double 'y 1 mem) (s '%2 '(y . 0) loc) pred))
(defund @atan2-%1-rev (mem loc pred)
  (@atan2-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @atan2-%0-rev (mem loc pred)
  (@atan2-%1-rev mem loc pred))

(defund @atan2-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (alloca-double 'y 1 mem))
    (loc (s '%2 '(y . 0) loc))
    (mem (store-double (g '%y loc) (g '%1 loc) mem))
    (mem (store-double (g '%x loc) (g '%2 loc) mem))
    (loc (s '%3 (load-double (g '%1 loc) mem) loc))
    (loc (s '%4 (load-double (g '%2 loc) mem) loc))
    (loc (s '%5 (@__ieee754_atan2 (g '%3 loc) (g '%4 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @atan2-%0-expand-bb
  (equal (@atan2-%0-bb mem loc pred)
         (@atan2-%0-rev mem loc pred))
  :enable (@atan2-%0-bb @atan2-%0-rev
    @atan2-%1-rev
    @atan2-%2-rev
    @atan2-m0.1-rev
    @atan2-m0.2-rev
    @atan2-%3-rev
    @atan2-%4-rev
    @atan2-%5-rev
    @atan2-succ0-rev)
  :disable s-diff-s)

(defund @atan2-step (label mem loc pred)
  (case label
    (%0 (@atan2-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @atan2-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%5 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@atan2-step label mem loc pred)
        (@atan2-steps new-label new-mem new-loc label (1- n))))))

(defund @atan2 (%y %x)
  (declare (ignore %y %x))
   nil)