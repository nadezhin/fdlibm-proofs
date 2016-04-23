(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_log")

(defconst *log-globals* '())

(defconst *log-labels* '(%0))

(defund @log-%0-mem (s0)
  (car s0))
(defund @log-%0-loc (s0)
  (cadr s0))
(defund @log-%0-pred (s0)
  (caddr s0))
(defund @log-%1-mem (s0)
  (alloca-double 'ret 1 (@log-%0-mem s0)))
(defund @log-%1-loc (s0)
  (s '%1 '(ret . 0) (@log-%0-loc s0)))
(defund @log-m0.1-mem (s0)
  (store-double (g '%x (@log-%1-loc s0)) (g '%1 (@log-%1-loc s0)) (@log-%1-mem s0)))
(defund @log-%2-val (s0)
  (load-double (g '%1 (@log-%1-loc s0)) (@log-m0.1-mem s0)))
(defund @log-%2-loc (s0)
  (s '%2 (@log-%2-val s0) (@log-%1-loc s0)))
(defund @log-%3-val (s0)
  (@__ieee754_log (g '%2 (@log-%2-loc s0))))
(defund @log-%3-loc (s0)
  (s '%3 (@log-%3-val s0) (@log-%2-loc s0)))
(defund @log-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @log-%0-fwd (mem loc pred)
  (let ((s0 (list mem loc pred)))
    (mv (@log-succ0-lab s0) (@log-m0.1-mem s0) (@log-%3-loc s0))))

(defund @log-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @log-%3-rev (mem loc pred)
  (@log-succ0-rev mem (s '%3 (@__ieee754_log (g '%2 loc)) loc) pred))
(defund @log-%2-rev (mem loc pred)
  (@log-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @log-m0.1-rev (mem loc pred)
  (@log-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @log-%1-rev (mem loc pred)
  (@log-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @log-%0-rev (mem loc pred)
  (@log-%1-rev mem loc pred))

(defruled @log-%0-expand-rev-as-@log-%1-rev
  (equal (@log-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@log-%1-rev
            (@log-%0-mem s0)
            (@log-%0-loc s0)
            (@log-%0-pred s0))))
  :enable (@log-%0-rev @log-%0-mem @log-%0-loc @log-%0-pred))
(defruled @log-%0-expand-rev-as-@log-m0.1-rev
  (equal (@log-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@log-m0.1-rev
            (@log-%1-mem s0)
            (@log-%1-loc s0)
            (@log-%0-pred s0))))
  :enable (@log-%0-expand-rev-as-@log-%1-rev @log-%1-rev @log-%1-mem @log-%1-loc))
(defruled @log-%0-expand-rev-as-@log-%2-rev
  (equal (@log-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@log-%2-rev
            (@log-m0.1-mem s0)
            (@log-%1-loc s0)
            (@log-%0-pred s0))))
  :enable (@log-%0-expand-rev-as-@log-m0.1-rev @log-m0.1-rev @log-m0.1-mem))
(defruled @log-%0-expand-rev-as-@log-%3-rev
  (equal (@log-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@log-%3-rev
            (@log-m0.1-mem s0)
            (@log-%2-loc s0)
            (@log-%0-pred s0))))
  :enable (@log-%0-expand-rev-as-@log-%2-rev @log-%2-rev @log-%2-loc @log-%2-val))
(defruled @log-%0-expand-rev-as-@log-succ0-rev
  (equal (@log-%0-rev mem loc pred)
         (let ((s0 (list mem loc pred)))
           (@log-succ0-rev
            (@log-m0.1-mem s0)
            (@log-%3-loc s0)
            (@log-%0-pred s0))))
  :enable (@log-%0-expand-rev-as-@log-%3-rev @log-%3-rev @log-%3-loc @log-%3-val))
(defruled @log-%0-expand-rev-as-fwd
  (equal (@log-%0-rev mem loc pred)
         (@log-%0-fwd mem loc pred))
  :enable (@log-%0-expand-rev-as-@log-succ0-rev @log-succ0-rev @log-succ0-lab @log-%0-fwd))

(defund @log-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_log (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defund @log-step (label mem loc pred)
  (case label
    (%0 (@log-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @log-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@log-step label mem loc pred)
        (@log-steps new-label new-mem new-loc label (1- n))))))

(defund @log (%x)
  (declare (ignore %x))
   nil)
