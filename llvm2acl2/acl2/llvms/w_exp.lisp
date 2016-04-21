(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_exp")

(defconst *exp-globals* '())

(defconst *exp-labels* '(%0))

(defund @exp-%0-mem (s0)
  (car s0))
(defund @exp-%0-loc (s0)
  (cadr s0))
(defund @exp-%0-pred (s0)
  (caddr s0))
(defund @exp-%1-mem (s0)
  (alloca-double 'ret 1 (@exp-%0-mem s0)))
(defund @exp-%1-loc (s0)
  (s '%1 '(ret . 0) (@exp-%0-loc s0)))
(defund @exp-m0.1-mem (s0)
  (store-double (g '%x (@exp-%1-loc s0)) (g '%1 (@exp-%1-loc s0)) (@exp-%1-mem s0)))
(defund @exp-%2-val (s0)
  (load-double (g '%1 (@exp-%1-loc s0)) (@exp-m0.1-mem s0)))
(defund @exp-%2-loc (s0)
  (s '%2 (@exp-%2-val s0) (@exp-%1-loc s0)))
(defund @exp-%3-val (s0)
  (@__ieee754_exp (g '%2 (@exp-%2-loc s0))))
(defund @exp-%3-loc (s0)
  (s '%3 (@exp-%3-val s0) (@exp-%2-loc s0)))
(defund @exp-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @exp-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @exp-%3-rev (mem loc pred)
  (@exp-succ0-rev mem (s '%3 (@__ieee754_exp (g '%2 loc)) loc) pred))
(defund @exp-%2-rev (mem loc pred)
  (@exp-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @exp-m0.1-rev (mem loc pred)
  (@exp-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @exp-%1-rev (mem loc pred)
  (@exp-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @exp-%0-rev (mem loc pred)
  (@exp-%1-rev mem loc pred))

(defund @exp-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_exp (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @exp-%0-expand-bb
  (equal (@exp-%0-bb mem loc pred)
         (@exp-%0-rev mem loc pred))
  :enable (@exp-%0-bb @exp-%0-rev
    @exp-%1-rev
    @exp-m0.1-rev
    @exp-%2-rev
    @exp-%3-rev
    @exp-succ0-rev)
  :disable s-diff-s)

(defund @exp-step (label mem loc pred)
  (case label
    (%0 (@exp-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @exp-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@exp-step label mem loc pred)
        (@exp-steps new-label new-mem new-loc label (1- n))))))

(defund @exp (%x)
  (declare (ignore %x))
   nil)
