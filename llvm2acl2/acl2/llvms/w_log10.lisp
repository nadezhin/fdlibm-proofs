(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_log10")

(defconst *log10-globals* '())

(defconst *log10-labels* '(%0))

(defund @log10-%0-mem (s0)
  (car s0))
(defund @log10-%0-loc (s0)
  (cadr s0))
(defund @log10-%0-pred (s0)
  (caddr s0))
(defund @log10-%1-mem (s0)
  (alloca-double 'ret 1 (@log10-%0-mem s0)))
(defund @log10-%1-loc (s0)
  (s '%1 '(ret . 0) (@log10-%0-loc s0)))
(defund @log10-m0.1-mem (s0)
  (store-double (g '%x (@log10-%1-loc s0)) (g '%1 (@log10-%1-loc s0)) (@log10-%1-mem s0)))
(defund @log10-%2-val (s0)
  (load-double (g '%1 (@log10-%1-loc s0)) (@log10-m0.1-mem s0)))
(defund @log10-%2-loc (s0)
  (s '%2 (@log10-%2-val s0) (@log10-%1-loc s0)))
(defund @log10-%3-val (s0)
  (@__ieee754_log10 (g '%2 (@log10-%2-loc s0))))
(defund @log10-%3-loc (s0)
  (s '%3 (@log10-%3-val s0) (@log10-%2-loc s0)))
(defund @log10-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @log10-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @log10-%3-rev (mem loc pred)
  (@log10-succ0-rev mem (s '%3 (@__ieee754_log10 (g '%2 loc)) loc) pred))
(defund @log10-%2-rev (mem loc pred)
  (@log10-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @log10-m0.1-rev (mem loc pred)
  (@log10-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @log10-%1-rev (mem loc pred)
  (@log10-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @log10-%0-rev (mem loc pred)
  (@log10-%1-rev mem loc pred))

(defund @log10-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_log10 (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @log10-%0-expand-bb
  (equal (@log10-%0-bb mem loc pred)
         (@log10-%0-rev mem loc pred))
  :enable (@log10-%0-bb @log10-%0-rev
    @log10-%1-rev
    @log10-m0.1-rev
    @log10-%2-rev
    @log10-%3-rev
    @log10-succ0-rev)
  :disable s-diff-s)

(defund @log10-step (label mem loc pred)
  (case label
    (%0 (@log10-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @log10-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@log10-step label mem loc pred)
        (@log10-steps new-label new-mem new-loc label (1- n))))))

(defund @log10 (%x)
  (declare (ignore %x))
   nil)
