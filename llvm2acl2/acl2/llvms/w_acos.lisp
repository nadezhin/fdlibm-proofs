(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_acos")

(defconst *acos-globals* '())

(defconst *acos-labels* '(%0))

(defund @acos-%0-mem (s0)
  (car s0))
(defund @acos-%0-loc (s0)
  (cadr s0))
(defund @acos-%0-pred (s0)
  (caddr s0))
(defund @acos-%1-mem (s0)
  (alloca-double 'ret 1 (@acos-%0-mem s0)))
(defund @acos-%1-loc (s0)
  (s '%1 '(ret . 0) (@acos-%0-loc s0)))
(defund @acos-m0.1-mem (s0)
  (store-double (g '%x (@acos-%1-loc s0)) (g '%1 (@acos-%1-loc s0)) (@acos-%1-mem s0)))
(defund @acos-%2-val (s0)
  (load-double (g '%1 (@acos-%1-loc s0)) (@acos-m0.1-mem s0)))
(defund @acos-%2-loc (s0)
  (s '%2 (@acos-%2-val s0) (@acos-%1-loc s0)))
(defund @acos-%3-val (s0)
  (@__ieee754_acos (g '%2 (@acos-%2-loc s0))))
(defund @acos-%3-loc (s0)
  (s '%3 (@acos-%3-val s0) (@acos-%2-loc s0)))
(defund @acos-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @acos-%0-fwd (mem loc pred)
  (let ((s0 (list mem loc pred)))
    (mv (@acos-succ0-lab s0) (@acos-m0.1-mem s0) (@acos-%3-loc s0))))

(defund @acos-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @acos-%3-rev (mem loc pred)
  (@acos-succ0-rev mem (s '%3 (@__ieee754_acos (g '%2 loc)) loc) pred))
(defund @acos-%2-rev (mem loc pred)
  (@acos-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @acos-m0.1-rev (mem loc pred)
  (@acos-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @acos-%1-rev (mem loc pred)
  (@acos-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @acos-%0-rev (mem loc pred)
  (@acos-%1-rev mem loc pred))

(defruled @acos-%0-expand-rev-as-@acos-%1-rev
  (equal (@acos-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@acos-%1-rev
            (@acos-%0-mem s0)
            (@acos-%0-loc s0)
            (@acos-%0-pred s0))))
  :enable (@acos-%0-rev @acos-%0-mem @acos-%0-loc @acos-%0-pred))
(defruled @acos-%0-expand-rev-as-@acos-m0.1-rev
  (equal (@acos-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@acos-m0.1-rev
            (@acos-%1-mem s0)
            (@acos-%1-loc s0)
            (@acos-%0-pred s0))))
  :enable (@acos-%0-expand-rev-as-@acos-%1-rev @acos-%1-rev @acos-%1-mem @acos-%1-loc))
(defruled @acos-%0-expand-rev-as-@acos-%2-rev
  (equal (@acos-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@acos-%2-rev
            (@acos-m0.1-mem s0)
            (@acos-%1-loc s0)
            (@acos-%0-pred s0))))
  :enable (@acos-%0-expand-rev-as-@acos-m0.1-rev @acos-m0.1-rev @acos-m0.1-mem))
(defruled @acos-%0-expand-rev-as-@acos-%3-rev
  (equal (@acos-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@acos-%3-rev
            (@acos-m0.1-mem s0)
            (@acos-%2-loc s0)
            (@acos-%0-pred s0))))
  :enable (@acos-%0-expand-rev-as-@acos-%2-rev @acos-%2-rev @acos-%2-loc @acos-%2-val))
(defruled @acos-%0-expand-rev-as-@acos-succ0-rev
  (equal (@acos-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@acos-succ0-rev
            (@acos-m0.1-mem s0)
            (@acos-%3-loc s0)
            (@acos-%0-pred s0))))
  :enable (@acos-%0-expand-rev-as-@acos-%3-rev @acos-%3-rev @acos-%3-loc @acos-%3-val))
(defruled @acos-%0-expand-rev-as-fwd
  (equal (@acos-%0-rev mem loc pred)
         (@acos-%0-fwd mem loc pred))
  :enable (@acos-%0-expand-rev-as-@acos-succ0-rev @acos-succ0-rev @acos-succ0-lab @acos-%0-fwd))

(defund @acos-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_acos (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defund @acos-step (label mem loc pred)
  (case label
    (%0 (@acos-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @acos-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@acos-step label mem loc pred)
        (@acos-steps new-label new-mem new-loc label (1- n))))))

(defund @acos (%x)
  (declare (ignore %x))
   nil)
