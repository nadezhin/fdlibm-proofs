(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_asin")

(defconst *asin-globals* '())

(defconst *asin-labels* '(%0))

(defund @asin-%0-mem (s0)
  (car s0))
(defund @asin-%0-loc (s0)
  (cadr s0))
(defund @asin-%0-pred (s0)
  (caddr s0))
(defund @asin-%1-mem (s0)
  (alloca-double 'ret 1 (@asin-%0-mem s0)))
(defund @asin-%1-loc (s0)
  (s '%1 '(ret . 0) (@asin-%0-loc s0)))
(defund @asin-m0.1-mem (s0)
  (store-double (g '%x (@asin-%1-loc s0)) (g '%1 (@asin-%1-loc s0)) (@asin-%1-mem s0)))
(defund @asin-%2-val (s0)
  (load-double (g '%1 (@asin-%1-loc s0)) (@asin-m0.1-mem s0)))
(defund @asin-%2-loc (s0)
  (s '%2 (@asin-%2-val s0) (@asin-%1-loc s0)))
(defund @asin-%3-val (s0)
  (@__ieee754_asin (g '%2 (@asin-%2-loc s0))))
(defund @asin-%3-loc (s0)
  (s '%3 (@asin-%3-val s0) (@asin-%2-loc s0)))
(defund @asin-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @asin-%0-fwd (mem loc pred)
  (let ((s0 (list mem loc pred)))
    (mv (@asin-succ0-lab s0) (@asin-m0.1-mem s0) (@asin-%3-loc s0))))

(defund @asin-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @asin-%3-rev (mem loc pred)
  (@asin-succ0-rev mem (s '%3 (@__ieee754_asin (g '%2 loc)) loc) pred))
(defund @asin-%2-rev (mem loc pred)
  (@asin-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @asin-m0.1-rev (mem loc pred)
  (@asin-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @asin-%1-rev (mem loc pred)
  (@asin-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @asin-%0-rev (mem loc pred)
  (@asin-%1-rev mem loc pred))

(defruled @asin-%0-expand-rev-as-@asin-%1-rev
  (equal (@asin-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@asin-%1-rev
            (@asin-%0-mem s0)
            (@asin-%0-loc s0)
            (@asin-%0-pred s0))))
  :enable (@asin-%0-rev @asin-%0-mem @asin-%0-loc @asin-%0-pred))
(defruled @asin-%0-expand-rev-as-@asin-m0.1-rev
  (equal (@asin-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@asin-m0.1-rev
            (@asin-%1-mem s0)
            (@asin-%1-loc s0)
            (@asin-%0-pred s0))))
  :enable (@asin-%0-expand-rev-as-@asin-%1-rev @asin-%1-rev @asin-%1-mem @asin-%1-loc))
(defruled @asin-%0-expand-rev-as-@asin-%2-rev
  (equal (@asin-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@asin-%2-rev
            (@asin-m0.1-mem s0)
            (@asin-%1-loc s0)
            (@asin-%0-pred s0))))
  :enable (@asin-%0-expand-rev-as-@asin-m0.1-rev @asin-m0.1-rev @asin-m0.1-mem))
(defruled @asin-%0-expand-rev-as-@asin-%3-rev
  (equal (@asin-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@asin-%3-rev
            (@asin-m0.1-mem s0)
            (@asin-%2-loc s0)
            (@asin-%0-pred s0))))
  :enable (@asin-%0-expand-rev-as-@asin-%2-rev @asin-%2-rev @asin-%2-loc @asin-%2-val))
(defruled @asin-%0-expand-rev-as-@asin-succ0-rev
  (equal (@asin-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@asin-succ0-rev
            (@asin-m0.1-mem s0)
            (@asin-%3-loc s0)
            (@asin-%0-pred s0))))
  :enable (@asin-%0-expand-rev-as-@asin-%3-rev @asin-%3-rev @asin-%3-loc @asin-%3-val))
(defruled @asin-%0-expand-rev-as-fwd
  (equal (@asin-%0-rev mem loc pred)
         (@asin-%0-fwd mem loc pred))
  :enable (@asin-%0-expand-rev-as-@asin-succ0-rev @asin-succ0-rev @asin-succ0-lab @asin-%0-fwd))

(defund @asin-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_asin (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defund @asin-step (label mem loc pred)
  (case label
    (%0 (@asin-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @asin-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@asin-step label mem loc pred)
        (@asin-steps new-label new-mem new-loc label (1- n))))))

(defund @asin (%x)
  (declare (ignore %x))
   nil)
