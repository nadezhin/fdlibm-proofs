(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "e_sqrt")

(defconst *sqrt-globals* '())

(defconst *sqrt-labels* '(%0))

(defund @sqrt-%0-mem (s0)
  (car s0))
(defund @sqrt-%0-loc (s0)
  (cadr s0))
(defund @sqrt-%0-pred (s0)
  (caddr s0))
(defund @sqrt-%1-mem (s0)
  (alloca-double 'ret 1 (@sqrt-%0-mem s0)))
(defund @sqrt-%1-loc (s0)
  (s '%1 '(ret . 0) (@sqrt-%0-loc s0)))
(defund @sqrt-m0.1-mem (s0)
  (store-double (g '%x (@sqrt-%1-loc s0)) (g '%1 (@sqrt-%1-loc s0)) (@sqrt-%1-mem s0)))
(defund @sqrt-%2-val (s0)
  (load-double (g '%1 (@sqrt-%1-loc s0)) (@sqrt-m0.1-mem s0)))
(defund @sqrt-%2-loc (s0)
  (s '%2 (@sqrt-%2-val s0) (@sqrt-%1-loc s0)))
(defund @sqrt-%3-val (s0)
  (@__ieee754_sqrt (g '%2 (@sqrt-%2-loc s0))))
(defund @sqrt-%3-loc (s0)
  (s '%3 (@sqrt-%3-val s0) (@sqrt-%2-loc s0)))
(defund @sqrt-succ0-lab (s0)
  (declare (ignore s0))
  'ret)

(defund @sqrt-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @sqrt-%3-rev (mem loc pred)
  (@sqrt-succ0-rev mem (s '%3 (@__ieee754_sqrt (g '%2 loc)) loc) pred))
(defund @sqrt-%2-rev (mem loc pred)
  (@sqrt-%3-rev mem (s '%2 (load-double (g '%1 loc) mem) loc) pred))
(defund @sqrt-m0.1-rev (mem loc pred)
  (@sqrt-%2-rev (store-double (g '%x loc) (g '%1 loc) mem) loc pred))
(defund @sqrt-%1-rev (mem loc pred)
  (@sqrt-m0.1-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @sqrt-%0-rev (mem loc pred)
  (@sqrt-%1-rev mem loc pred))

(defund @sqrt-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (store-double (g '%x loc) (g '%1 loc) mem))
    (loc (s '%2 (load-double (g '%1 loc) mem) loc))
    (loc (s '%3 (@__ieee754_sqrt (g '%2 loc)) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @sqrt-%0-expand-bb
  (equal (@sqrt-%0-bb mem loc pred)
         (@sqrt-%0-rev mem loc pred))
  :enable (@sqrt-%0-bb @sqrt-%0-rev
    @sqrt-%1-rev
    @sqrt-m0.1-rev
    @sqrt-%2-rev
    @sqrt-%3-rev
    @sqrt-succ0-rev)
  :disable s-diff-s)

(defund @sqrt-step (label mem loc pred)
  (case label
    (%0 (@sqrt-%0-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @sqrt-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%3 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@sqrt-step label mem loc pred)
        (@sqrt-steps new-label new-mem new-loc label (1- n))))))

(defund @sqrt (%x)
  (declare (ignore %x))
   nil)
