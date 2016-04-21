(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_sinh")

(defconst *sinh-globals* '())

(defconst *sinh-labels* '(%0))

(defund @sinh-%0-mem (s0)
  (car s0))
(defund @sinh-%0-loc (s0)
  (cadr s0))
(defund @sinh-%0-pred (s0)
  (caddr s0))
(defund @sinh-%1-mem (s0)
  (alloca-double 'ret 1 (@sinh-%0-mem s0)))
(defund @sinh-%1-loc (s0)
  (s '%1 '(ret . 0) (@sinh-%0-loc s0)))
(defund @sinh-m0.1-mem (s0)
  (store-double (g '%x (@sinh-%1-loc s0)) (g '%1 (@sinh-%1-loc s0)) (@sinh-%1-mem s0)))
(defund @sinh-%2-val (s0)
  (load-double (g '%1 (@sinh-%1-loc s0)) (@sinh-m0.1-mem s0)))
(defund @sinh-%2-loc (s0)
  (s '%2 (@sinh-%2-val s0) (@sinh-%1-loc s0)))
(defund @sinh-%3-val (s0)
  (@__ieee754_sinh (g '%2 (@sinh-%2-loc s0))))
(defund @sinh-%3-loc (s0)
  (s '%3 (@sinh-%3-val s0) (@sinh-%2-loc s0)))
(defund @sinh-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @sinh-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @sinh-%3-rev (mem loc pred)
  (@sinh-succ0-rev mem (s '%3 (@__ieee754_sinh (g '%2 loc)) loc) pred))
(defund @sinh-%2-rev (mem loc pred)
  (@sinh-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @sinh-m0.1-rev (mem loc pred)
  (@sinh-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @sinh-%1-rev (mem loc pred)
  (@sinh-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @sinh-%0-rev (mem loc pred)
  (@sinh-%1-rev mem loc pred))

(defund @sinh-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_sinh (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @sinh-%0-expand-bb
  (equal (@sinh-%0-bb mem loc pred)
         (@sinh-%0-rev mem loc pred))
  :enable (@sinh-%0-bb @sinh-%0-rev
    @sinh-%1-rev
    @sinh-m0.1-rev
    @sinh-%2-rev
    @sinh-%3-rev
    @sinh-succ0-rev)
  :disable s-diff-s)

(defund @sinh-step (label mem loc pred)
  (case label
    (%0 (@sinh-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @sinh-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@sinh-step label mem loc pred)
        (@sinh-steps new-label new-mem new-loc label (1- n))))))

(defund @sinh (%x)
  (declare (ignore %x))
   nil)
