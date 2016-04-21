(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_cosh")

(defconst *cosh-globals* '())

(defconst *cosh-labels* '(%0))

(defund @cosh-%0-mem (s0)
  (car s0))
(defund @cosh-%0-loc (s0)
  (cadr s0))
(defund @cosh-%0-pred (s0)
  (caddr s0))
(defund @cosh-%1-mem (s0)
  (alloca-double 'ret 1 (@cosh-%0-mem s0)))
(defund @cosh-%1-loc (s0)
  (s '%1 '(ret . 0) (@cosh-%0-loc s0)))
(defund @cosh-m0.1-mem (s0)
  (store-double (g '%x (@cosh-%1-loc s0)) (g '%1 (@cosh-%1-loc s0)) (@cosh-%1-mem s0)))
(defund @cosh-%2-val (s0)
  (load-double (g '%1 (@cosh-%1-loc s0)) (@cosh-m0.1-mem s0)))
(defund @cosh-%2-loc (s0)
  (s '%2 (@cosh-%2-val s0) (@cosh-%1-loc s0)))
(defund @cosh-%3-val (s0)
  (@__ieee754_cosh (g '%2 (@cosh-%2-loc s0))))
(defund @cosh-%3-loc (s0)
  (s '%3 (@cosh-%3-val s0) (@cosh-%2-loc s0)))
(defund @cosh-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @cosh-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @cosh-%3-rev (mem loc pred)
  (@cosh-succ0-rev mem (s '%3 (@__ieee754_cosh (g '%2 loc)) loc) pred))
(defund @cosh-%2-rev (mem loc pred)
  (@cosh-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @cosh-m0.1-rev (mem loc pred)
  (@cosh-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @cosh-%1-rev (mem loc pred)
  (@cosh-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @cosh-%0-rev (mem loc pred)
  (@cosh-%1-rev mem loc pred))

(defund @cosh-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_cosh (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @cosh-%0-expand-bb
  (equal (@cosh-%0-bb mem loc pred)
         (@cosh-%0-rev mem loc pred))
  :enable (@cosh-%0-bb @cosh-%0-rev
    @cosh-%1-rev
    @cosh-m0.1-rev
    @cosh-%2-rev
    @cosh-%3-rev
    @cosh-succ0-rev)
  :disable s-diff-s)

(defund @cosh-step (label mem loc pred)
  (case label
    (%0 (@cosh-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @cosh-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@cosh-step label mem loc pred)
        (@cosh-steps new-label new-mem new-loc label (1- n))))))

(defund @cosh (%x)
  (declare (ignore %x))
   nil)
