(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_hypot")

(defconst *hypot-globals* '())

(defconst *hypot-labels* '(%0))

(defund @hypot-%0-mem (s0)
  (car s0))
(defund @hypot-%0-loc (s0)
  (cadr s0))
(defund @hypot-%0-pred (s0)
  (caddr s0))
(defund @hypot-%1-mem (s0)
  (alloca-double 'ret 1 (@hypot-%0-mem s0)))
(defund @hypot-%1-loc (s0)
  (s '%1 '(ret . 0) (@hypot-%0-loc s0)))
(defund @hypot-%2-mem (s0)
  (alloca-double 'x 1 (@hypot-%1-mem s0)))
(defund @hypot-%2-loc (s0)
  (s '%2 '(x . 0) (@hypot-%1-loc s0)))
(defund @hypot-m0.1-mem (s0)
  (store-double (g '%x (@hypot-%2-loc s0)) (g '%1 (@hypot-%2-loc s0)) (@hypot-%2-mem s0)))
(defund @hypot-m0.2-mem (s0)
  (store-double (g '%y (@hypot-%2-loc s0)) (g '%2 (@hypot-%2-loc s0)) (@hypot-m0.1-mem s0)))
(defund @hypot-%3-val (s0)
  (load-double (g '%1 (@hypot-%2-loc s0)) (@hypot-m0.2-mem s0)))
(defund @hypot-%3-loc (s0)
  (s '%3 (@hypot-%3-val s0) (@hypot-%2-loc s0)))
(defund @hypot-%4-val (s0)
  (load-double (g '%2 (@hypot-%3-loc s0)) (@hypot-m0.2-mem s0)))
(defund @hypot-%4-loc (s0)
  (s '%4 (@hypot-%4-val s0) (@hypot-%3-loc s0)))
(defund @hypot-%5-val (s0)
  (@__ieee754_hypot (g '%3 (@hypot-%4-loc s0)) (g '%4 (@hypot-%4-loc s0))))
(defund @hypot-%5-loc (s0)
  (s '%5 (@hypot-%5-val s0) (@hypot-%4-loc s0)))
(defund @hypot-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @hypot-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @hypot-%5-rev (mem loc pred)
  (@hypot-succ0-rev mem (s '%5 (@__ieee754_hypot (g '%3 loc) (g '%4 loc)) loc) pred))
(defund @hypot-%4-rev (mem loc pred)
  (@hypot-%5-rev mem (s '%4 (load-double (g '%2 loc) mem) loc) pred))
(defund @hypot-%3-rev (mem loc pred)
  (@hypot-%4-rev mem (s '%3 (load-double (g '%1 loc) mem) loc) pred))
(defund @hypot-m0.2-rev (mem loc pred)
  (@hypot-%3-rev (store-double (g '%y loc) (g '%2 loc) mem) loc pred))
(defund @hypot-m0.1-rev (mem loc pred)
  (@hypot-m0.2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @hypot-%2-rev (mem loc pred)
  (@hypot-m0.1-rev (alloca-double 'x 1 mem) (s '%2 '(x . 0) loc) pred))
(defund @hypot-%1-rev (mem loc pred)
  (@hypot-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @hypot-%0-rev (mem loc pred)
  (@hypot-%1-rev mem loc pred))

(defund @hypot-%0-bb (mem loc pred)
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
    (loc (s '%5 (@__ieee754_hypot (g '%3 loc) (g '%4 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @hypot-%0-expand-bb
  (equal (@hypot-%0-bb mem loc pred)
         (@hypot-%0-rev mem loc pred))
  :enable (@hypot-%0-bb @hypot-%0-rev
    @hypot-%1-rev
    @hypot-%2-rev
    @hypot-m0.1-rev
    @hypot-m0.2-rev
    @hypot-%3-rev
    @hypot-%4-rev
    @hypot-%5-rev
    @hypot-succ0-rev)
  :disable s-diff-s)

(defund @hypot-step (label mem loc pred)
  (case label
    (%0 (@hypot-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @hypot-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%5 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@hypot-step label mem loc pred)
        (@hypot-steps new-label new-mem new-loc label (1- n))))))

(defund @hypot (%x %y)
  (declare (ignore %x %y))
   nil)
