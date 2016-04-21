(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_pow")

(defconst *pow-globals* '())

(defconst *pow-labels* '(%0))

(defund @pow-%0-mem (s0)
  (car s0))
(defund @pow-%0-loc (s0)
  (cadr s0))
(defund @pow-%0-pred (s0)
  (caddr s0))
(defund @pow-%1-mem (s0)
  (alloca-double 'ret 1 (@pow-%0-mem s0)))
(defund @pow-%1-loc (s0)
  (s '%1 '(ret . 0) (@pow-%0-loc s0)))
(defund @pow-%2-mem (s0)
  (alloca-double 'x 1 (@pow-%1-mem s0)))
(defund @pow-%2-loc (s0)
  (s '%2 '(x . 0) (@pow-%1-loc s0)))
(defund @pow-m0.1-mem (s0)
  (store-double (g '%x (@pow-%2-loc s0)) (g '%1 (@pow-%2-loc s0)) (@pow-%2-mem s0)))
(defund @pow-m0.2-mem (s0)
  (store-double (g '%y (@pow-%2-loc s0)) (g '%2 (@pow-%2-loc s0)) (@pow-m0.1-mem s0)))
(defund @pow-%3-val (s0)
  (load-double (g '%1 (@pow-%2-loc s0)) (@pow-m0.2-mem s0)))
(defund @pow-%3-loc (s0)
  (s '%3 (@pow-%3-val s0) (@pow-%2-loc s0)))
(defund @pow-%4-val (s0)
  (load-double (g '%2 (@pow-%3-loc s0)) (@pow-m0.2-mem s0)))
(defund @pow-%4-loc (s0)
  (s '%4 (@pow-%4-val s0) (@pow-%3-loc s0)))
(defund @pow-%5-val (s0)
  (@__ieee754_pow (g '%3 (@pow-%4-loc s0)) (g '%4 (@pow-%4-loc s0))))
(defund @pow-%5-loc (s0)
  (s '%5 (@pow-%5-val s0) (@pow-%4-loc s0)))
(defund @pow-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @pow-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @pow-%5-rev (mem loc pred)
  (@pow-succ0-rev mem (s '%5 (@__ieee754_pow (g '%3 loc) (g '%4 loc)) loc) pred))
(defund @pow-%4-rev (mem loc pred)
  (@pow-%5-rev mem (s '%4 (load-double (g '%2 loc) mem) loc) pred))
(defund @pow-%3-rev (mem loc pred)
  (@pow-%4-rev mem (s '%3 (load-double (g '%1 loc) mem) loc) pred))
(defund @pow-m0.2-rev (mem loc pred)
  (@pow-%3-rev (store-double (g '%y loc) (g '%2 loc) mem) loc pred))
(defund @pow-m0.1-rev (mem loc pred)
  (@pow-m0.2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @pow-%2-rev (mem loc pred)
  (@pow-m0.1-rev (alloca-double 'x 1 mem) (s '%2 '(x . 0) loc) pred))
(defund @pow-%1-rev (mem loc pred)
  (@pow-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @pow-%0-rev (mem loc pred)
  (@pow-%1-rev mem loc pred))

(defund @pow-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (alloca-double 'x 1 mem))
    (loc (s '%2 '(x . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (mem (store-double (g '%y loc) (g '%2 loc) mem))
    (loc (s '%3 (load-double (g '%1 loc) mem) loc))
    (loc (s '%4 (load-double (g '%2 loc) mem) loc))
    (loc (s '%5 (@__ieee754_pow (g '%3 loc) (g '%4 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @pow-%0-expand-bb
  (equal (@pow-%0-bb mem loc pred)
         (@pow-%0-rev mem loc pred))
  :enable (@pow-%0-bb @pow-%0-rev
    @pow-%1-rev
    @pow-%2-rev
    @pow-m0.1-rev
    @pow-m0.2-rev
    @pow-%3-rev
    @pow-%4-rev
    @pow-%5-rev
    @pow-succ0-rev)
  :disable s-diff-s)

(defund @pow-step (label mem loc pred)
  (case label
    (%0 (@pow-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @pow-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%5 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@pow-step label mem loc pred)
        (@pow-steps new-label new-mem new-loc label (1- n))))))

(defund @pow (%x %y)
  (declare (ignore %x %y))
   nil)
