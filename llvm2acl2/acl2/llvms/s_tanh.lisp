(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")

(defconst *tanh-globals* '())

(defconst *tanh-labels* '(%0 %10 %13 %17 %21 %24 %27 %32 %35 %44 %54 %55 %56 %59 %61 %64 %66))

(defund @tanh-%0-mem (s0)
  (car s0))
(defund @tanh-%0-loc (s0)
  (cadr s0))
(defund @tanh-%0-pred (s0)
  (caddr s0))
(defund @tanh-%1-mem (s0)
  (alloca-double 'ret 1 (@tanh-%0-mem s0)))
(defund @tanh-%1-loc (s0)
  (s '%1 '(ret . 0) (@tanh-%0-loc s0)))
(defund @tanh-%2-mem (s0)
  (alloca-double 'x 1 (@tanh-%1-mem s0)))
(defund @tanh-%2-loc (s0)
  (s '%2 '(x . 0) (@tanh-%1-loc s0)))
(defund @tanh-%t-mem (s0)
  (alloca-double 't 1 (@tanh-%2-mem s0)))
(defund @tanh-%t-loc (s0)
  (s '%t '(t . 0) (@tanh-%2-loc s0)))
(defund @tanh-%z-mem (s0)
  (alloca-double 'z 1 (@tanh-%t-mem s0)))
(defund @tanh-%z-loc (s0)
  (s '%z '(z . 0) (@tanh-%t-loc s0)))
(defund @tanh-%jx-mem (s0)
  (alloca-i32 'jx 1 (@tanh-%z-mem s0)))
(defund @tanh-%jx-loc (s0)
  (s '%jx '(jx . 0) (@tanh-%z-loc s0)))
(defund @tanh-%ix-mem (s0)
  (alloca-i32 'ix 1 (@tanh-%jx-mem s0)))
(defund @tanh-%ix-loc (s0)
  (s '%ix '(ix . 0) (@tanh-%jx-loc s0)))
(defund @tanh-m0.1-mem (s0)
  (store-double (g '%x (@tanh-%ix-loc s0)) (g '%2 (@tanh-%ix-loc s0)) (@tanh-%ix-mem s0)))
(defund @tanh-%3-val (s0)
  (bitcast-double*-to-i32* (g '%2 (@tanh-%ix-loc s0))))
(defund @tanh-%3-loc (s0)
  (s '%3 (@tanh-%3-val s0) (@tanh-%ix-loc s0)))
(defund @tanh-%4-val (s0)
  (getelementptr-i32 (g '%3 (@tanh-%3-loc s0)) 1))
(defund @tanh-%4-loc (s0)
  (s '%4 (@tanh-%4-val s0) (@tanh-%3-loc s0)))
(defund @tanh-%5-val (s0)
  (load-i32 (g '%4 (@tanh-%4-loc s0)) (@tanh-m0.1-mem s0)))
(defund @tanh-%5-loc (s0)
  (s '%5 (@tanh-%5-val s0) (@tanh-%4-loc s0)))
(defund @tanh-m0.2-mem (s0)
  (store-i32 (g '%5 (@tanh-%5-loc s0)) (g '%jx (@tanh-%5-loc s0)) (@tanh-m0.1-mem s0)))
(defund @tanh-%6-val (s0)
  (load-i32 (g '%jx (@tanh-%5-loc s0)) (@tanh-m0.2-mem s0)))
(defund @tanh-%6-loc (s0)
  (s '%6 (@tanh-%6-val s0) (@tanh-%5-loc s0)))
(defund @tanh-%7-val (s0)
  (and-i32 (g '%6 (@tanh-%6-loc s0)) 2147483647))
(defund @tanh-%7-loc (s0)
  (s '%7 (@tanh-%7-val s0) (@tanh-%6-loc s0)))
(defund @tanh-m0.3-mem (s0)
  (store-i32 (g '%7 (@tanh-%7-loc s0)) (g '%ix (@tanh-%7-loc s0)) (@tanh-m0.2-mem s0)))
(defund @tanh-%8-val (s0)
  (load-i32 (g '%ix (@tanh-%7-loc s0)) (@tanh-m0.3-mem s0)))
(defund @tanh-%8-loc (s0)
  (s '%8 (@tanh-%8-val s0) (@tanh-%7-loc s0)))
(defund @tanh-%9-val (s0)
  (icmp-sge-i32 (g '%8 (@tanh-%8-loc s0)) 2146435072))
(defund @tanh-%9-loc (s0)
  (s '%9 (@tanh-%9-val s0) (@tanh-%8-loc s0)))
(defund @tanh-succ0-lab (s0)
  (case (g '%9 (@tanh-%9-loc s0)) (-1 '%10) (0 '%21)))

(defund @tanh-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%9 loc) (-1 '%10) (0 '%21)) mem loc))
(defund @tanh-%9-rev (mem loc pred)
  (@tanh-succ0-rev mem (s '%9 (icmp-sge-i32 (g '%8 loc) 2146435072) loc) pred))
(defund @tanh-%8-rev (mem loc pred)
  (@tanh-%9-rev mem (s '%8 (load-i32 (g '%ix loc) mem) loc) pred))
(defund @tanh-m0.3-rev (mem loc pred)
  (@tanh-%8-rev (store-i32 (g '%7 loc) (g '%ix loc) mem) loc pred))
(defund @tanh-%7-rev (mem loc pred)
  (@tanh-m0.3-rev mem (s '%7 (and-i32 (g '%6 loc) 2147483647) loc) pred))
(defund @tanh-%6-rev (mem loc pred)
  (@tanh-%7-rev mem (s '%6 (load-i32 (g '%jx loc) mem) loc) pred))
(defund @tanh-m0.2-rev (mem loc pred)
  (@tanh-%6-rev (store-i32 (g '%5 loc) (g '%jx loc) mem) loc pred))
(defund @tanh-%5-rev (mem loc pred)
  (@tanh-m0.2-rev mem (s '%5 (load-i32 (g '%4 loc) mem) loc) pred))
(defund @tanh-%4-rev (mem loc pred)
  (@tanh-%5-rev mem (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc) pred))
(defund @tanh-%3-rev (mem loc pred)
  (@tanh-%4-rev mem (s '%3 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @tanh-m0.1-rev (mem loc pred)
  (@tanh-%3-rev (store-double (g '%x loc) (g '%2 loc) mem) loc pred))
(defund @tanh-%ix-rev (mem loc pred)
  (@tanh-m0.1-rev (alloca-i32 'ix 1 mem) (s '%ix '(ix . 0) loc) pred))
(defund @tanh-%jx-rev (mem loc pred)
  (@tanh-%ix-rev (alloca-i32 'jx 1 mem) (s '%jx '(jx . 0) loc) pred))
(defund @tanh-%z-rev (mem loc pred)
  (@tanh-%jx-rev (alloca-double 'z 1 mem) (s '%z '(z . 0) loc) pred))
(defund @tanh-%t-rev (mem loc pred)
  (@tanh-%z-rev (alloca-double 't 1 mem) (s '%t '(t . 0) loc) pred))
(defund @tanh-%2-rev (mem loc pred)
  (@tanh-%t-rev (alloca-double 'x 1 mem) (s '%2 '(x . 0) loc) pred))
(defund @tanh-%1-rev (mem loc pred)
  (@tanh-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @tanh-%0-rev (mem loc pred)
  (@tanh-%1-rev mem loc pred))

(defund @tanh-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (alloca-double 'x 1 mem))
    (loc (s '%2 '(x . 0) loc))
    (mem (alloca-double 't 1 mem))
    (loc (s '%t '(t . 0) loc))
    (mem (alloca-double 'z 1 mem))
    (loc (s '%z '(z . 0) loc))
    (mem (alloca-i32 'jx 1 mem))
    (loc (s '%jx '(jx . 0) loc))
    (mem (alloca-i32 'ix 1 mem))
    (loc (s '%ix '(ix . 0) loc))
    (mem (store-double (g '%x loc) (g '%2 loc) mem))
    (loc (s '%3 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc))
    (loc (s '%5 (load-i32 (g '%4 loc) mem) loc))
    (mem (store-i32 (g '%5 loc) (g '%jx loc) mem))
    (loc (s '%6 (load-i32 (g '%jx loc) mem) loc))
    (loc (s '%7 (and-i32 (g '%6 loc) 2147483647) loc))
    (mem (store-i32 (g '%7 loc) (g '%ix loc) mem))
    (loc (s '%8 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%9 (icmp-sge-i32 (g '%8 loc) 2146435072) loc))
    (succ (case (g '%9 loc) (-1 '%10) (0 '%21))))
  (mv succ mem loc)))

(defruled @tanh-%0-expand-bb
  (equal (@tanh-%0-bb mem loc pred)
         (@tanh-%0-rev mem loc pred))
  :enable (@tanh-%0-bb @tanh-%0-rev
    @tanh-%1-rev
    @tanh-%2-rev
    @tanh-%t-rev
    @tanh-%z-rev
    @tanh-%jx-rev
    @tanh-%ix-rev
    @tanh-m0.1-rev
    @tanh-%3-rev
    @tanh-%4-rev
    @tanh-%5-rev
    @tanh-m0.2-rev
    @tanh-%6-rev
    @tanh-%7-rev
    @tanh-m0.3-rev
    @tanh-%8-rev
    @tanh-%9-rev
    @tanh-succ0-rev)
  :disable s-diff-s)

(defund @tanh-%10-mem (s10)
  (car s10))
(defund @tanh-%10-loc (s10)
  (cadr s10))
(defund @tanh-%10-pred (s10)
  (caddr s10))
(defund @tanh-%11-val (s10)
  (load-i32 (g '%jx (@tanh-%10-loc s10)) (@tanh-%10-mem s10)))
(defund @tanh-%11-loc (s10)
  (s '%11 (@tanh-%11-val s10) (@tanh-%10-loc s10)))
(defund @tanh-%12-val (s10)
  (icmp-sge-i32 (g '%11 (@tanh-%11-loc s10)) 0))
(defund @tanh-%12-loc (s10)
  (s '%12 (@tanh-%12-val s10) (@tanh-%11-loc s10)))
(defund @tanh-succ10-lab (s10)
  (case (g '%12 (@tanh-%12-loc s10)) (-1 '%13) (0 '%17)))

(defund @tanh-succ10-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%12 loc) (-1 '%13) (0 '%17)) mem loc))
(defund @tanh-%12-rev (mem loc pred)
  (@tanh-succ10-rev mem (s '%12 (icmp-sge-i32 (g '%11 loc) 0) loc) pred))
(defund @tanh-%11-rev (mem loc pred)
  (@tanh-%12-rev mem (s '%11 (load-i32 (g '%jx loc) mem) loc) pred))

(defund @tanh-%10-rev (mem loc pred)
  (@tanh-%11-rev mem loc pred))

(defund @tanh-%10-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%11 (load-i32 (g '%jx loc) mem) loc))
    (loc (s '%12 (icmp-sge-i32 (g '%11 loc) 0) loc))
    (succ (case (g '%12 loc) (-1 '%13) (0 '%17))))
  (mv succ mem loc)))

(defruled @tanh-%10-expand-bb
  (equal (@tanh-%10-bb mem loc pred)
         (@tanh-%10-rev mem loc pred))
  :enable (@tanh-%10-bb @tanh-%10-rev
    @tanh-%11-rev
    @tanh-%12-rev
    @tanh-succ10-rev)
  :disable s-diff-s)

(defund @tanh-%13-mem (s13)
  (car s13))
(defund @tanh-%13-loc (s13)
  (cadr s13))
(defund @tanh-%13-pred (s13)
  (caddr s13))
(defund @tanh-%14-val (s13)
  (load-double (g '%2 (@tanh-%13-loc s13)) (@tanh-%13-mem s13)))
(defund @tanh-%14-loc (s13)
  (s '%14 (@tanh-%14-val s13) (@tanh-%13-loc s13)))
(defund @tanh-%15-val (s13)
  (fdiv-double #x3ff0000000000000 (g '%14 (@tanh-%14-loc s13))))
(defund @tanh-%15-loc (s13)
  (s '%15 (@tanh-%15-val s13) (@tanh-%14-loc s13)))
(defund @tanh-%16-val (s13)
  (fadd-double (g '%15 (@tanh-%15-loc s13)) #x3ff0000000000000))
(defund @tanh-%16-loc (s13)
  (s '%16 (@tanh-%16-val s13) (@tanh-%15-loc s13)))
(defund @tanh-m13.1-mem (s13)
  (store-double (g '%16 (@tanh-%16-loc s13)) (g '%1 (@tanh-%16-loc s13)) (@tanh-%13-mem s13)))
(defund @tanh-succ13-lab (s13)
  (declare (ignore s13))
  '%66)

(defund @tanh-succ13-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%66 mem loc))
(defund @tanh-m13.1-rev (mem loc pred)
  (@tanh-succ13-rev (store-double (g '%16 loc) (g '%1 loc) mem) loc pred))
(defund @tanh-%16-rev (mem loc pred)
  (@tanh-m13.1-rev mem (s '%16 (fadd-double (g '%15 loc) #x3ff0000000000000) loc) pred))
(defund @tanh-%15-rev (mem loc pred)
  (@tanh-%16-rev mem (s '%15 (fdiv-double #x3ff0000000000000 (g '%14 loc)) loc) pred))
(defund @tanh-%14-rev (mem loc pred)
  (@tanh-%15-rev mem (s '%14 (load-double (g '%2 loc) mem) loc) pred))

(defund @tanh-%13-rev (mem loc pred)
  (@tanh-%14-rev mem loc pred))

(defund @tanh-%13-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%14 (load-double (g '%2 loc) mem) loc))
    (loc (s '%15 (fdiv-double #x3ff0000000000000 (g '%14 loc)) loc))
    (loc (s '%16 (fadd-double (g '%15 loc) #x3ff0000000000000) loc))
    (mem (store-double (g '%16 loc) (g '%1 loc) mem))
    (succ '%66))
  (mv succ mem loc)))

(defruled @tanh-%13-expand-bb
  (equal (@tanh-%13-bb mem loc pred)
         (@tanh-%13-rev mem loc pred))
  :enable (@tanh-%13-bb @tanh-%13-rev
    @tanh-%14-rev
    @tanh-%15-rev
    @tanh-%16-rev
    @tanh-m13.1-rev
    @tanh-succ13-rev)
  :disable s-diff-s)

(defund @tanh-%17-mem (s17)
  (car s17))
(defund @tanh-%17-loc (s17)
  (cadr s17))
(defund @tanh-%17-pred (s17)
  (caddr s17))
(defund @tanh-%18-val (s17)
  (load-double (g '%2 (@tanh-%17-loc s17)) (@tanh-%17-mem s17)))
(defund @tanh-%18-loc (s17)
  (s '%18 (@tanh-%18-val s17) (@tanh-%17-loc s17)))
(defund @tanh-%19-val (s17)
  (fdiv-double #x3ff0000000000000 (g '%18 (@tanh-%18-loc s17))))
(defund @tanh-%19-loc (s17)
  (s '%19 (@tanh-%19-val s17) (@tanh-%18-loc s17)))
(defund @tanh-%20-val (s17)
  (fsub-double (g '%19 (@tanh-%19-loc s17)) #x3ff0000000000000))
(defund @tanh-%20-loc (s17)
  (s '%20 (@tanh-%20-val s17) (@tanh-%19-loc s17)))
(defund @tanh-m17.1-mem (s17)
  (store-double (g '%20 (@tanh-%20-loc s17)) (g '%1 (@tanh-%20-loc s17)) (@tanh-%17-mem s17)))
(defund @tanh-succ17-lab (s17)
  (declare (ignore s17))
  '%66)

(defund @tanh-succ17-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%66 mem loc))
(defund @tanh-m17.1-rev (mem loc pred)
  (@tanh-succ17-rev (store-double (g '%20 loc) (g '%1 loc) mem) loc pred))
(defund @tanh-%20-rev (mem loc pred)
  (@tanh-m17.1-rev mem (s '%20 (fsub-double (g '%19 loc) #x3ff0000000000000) loc) pred))
(defund @tanh-%19-rev (mem loc pred)
  (@tanh-%20-rev mem (s '%19 (fdiv-double #x3ff0000000000000 (g '%18 loc)) loc) pred))
(defund @tanh-%18-rev (mem loc pred)
  (@tanh-%19-rev mem (s '%18 (load-double (g '%2 loc) mem) loc) pred))

(defund @tanh-%17-rev (mem loc pred)
  (@tanh-%18-rev mem loc pred))

(defund @tanh-%17-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%18 (load-double (g '%2 loc) mem) loc))
    (loc (s '%19 (fdiv-double #x3ff0000000000000 (g '%18 loc)) loc))
    (loc (s '%20 (fsub-double (g '%19 loc) #x3ff0000000000000) loc))
    (mem (store-double (g '%20 loc) (g '%1 loc) mem))
    (succ '%66))
  (mv succ mem loc)))

(defruled @tanh-%17-expand-bb
  (equal (@tanh-%17-bb mem loc pred)
         (@tanh-%17-rev mem loc pred))
  :enable (@tanh-%17-bb @tanh-%17-rev
    @tanh-%18-rev
    @tanh-%19-rev
    @tanh-%20-rev
    @tanh-m17.1-rev
    @tanh-succ17-rev)
  :disable s-diff-s)

(defund @tanh-%21-mem (s21)
  (car s21))
(defund @tanh-%21-loc (s21)
  (cadr s21))
(defund @tanh-%21-pred (s21)
  (caddr s21))
(defund @tanh-%22-val (s21)
  (load-i32 (g '%ix (@tanh-%21-loc s21)) (@tanh-%21-mem s21)))
(defund @tanh-%22-loc (s21)
  (s '%22 (@tanh-%22-val s21) (@tanh-%21-loc s21)))
(defund @tanh-%23-val (s21)
  (icmp-slt-i32 (g '%22 (@tanh-%22-loc s21)) 1077280768))
(defund @tanh-%23-loc (s21)
  (s '%23 (@tanh-%23-val s21) (@tanh-%22-loc s21)))
(defund @tanh-succ21-lab (s21)
  (case (g '%23 (@tanh-%23-loc s21)) (-1 '%24) (0 '%55)))

(defund @tanh-succ21-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%23 loc) (-1 '%24) (0 '%55)) mem loc))
(defund @tanh-%23-rev (mem loc pred)
  (@tanh-succ21-rev mem (s '%23 (icmp-slt-i32 (g '%22 loc) 1077280768) loc) pred))
(defund @tanh-%22-rev (mem loc pred)
  (@tanh-%23-rev mem (s '%22 (load-i32 (g '%ix loc) mem) loc) pred))

(defund @tanh-%21-rev (mem loc pred)
  (@tanh-%22-rev mem loc pred))

(defund @tanh-%21-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%22 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%23 (icmp-slt-i32 (g '%22 loc) 1077280768) loc))
    (succ (case (g '%23 loc) (-1 '%24) (0 '%55))))
  (mv succ mem loc)))

(defruled @tanh-%21-expand-bb
  (equal (@tanh-%21-bb mem loc pred)
         (@tanh-%21-rev mem loc pred))
  :enable (@tanh-%21-bb @tanh-%21-rev
    @tanh-%22-rev
    @tanh-%23-rev
    @tanh-succ21-rev)
  :disable s-diff-s)

(defund @tanh-%24-mem (s24)
  (car s24))
(defund @tanh-%24-loc (s24)
  (cadr s24))
(defund @tanh-%24-pred (s24)
  (caddr s24))
(defund @tanh-%25-val (s24)
  (load-i32 (g '%ix (@tanh-%24-loc s24)) (@tanh-%24-mem s24)))
(defund @tanh-%25-loc (s24)
  (s '%25 (@tanh-%25-val s24) (@tanh-%24-loc s24)))
(defund @tanh-%26-val (s24)
  (icmp-slt-i32 (g '%25 (@tanh-%25-loc s24)) 1015021568))
(defund @tanh-%26-loc (s24)
  (s '%26 (@tanh-%26-val s24) (@tanh-%25-loc s24)))
(defund @tanh-succ24-lab (s24)
  (case (g '%26 (@tanh-%26-loc s24)) (-1 '%27) (0 '%32)))

(defund @tanh-succ24-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%26 loc) (-1 '%27) (0 '%32)) mem loc))
(defund @tanh-%26-rev (mem loc pred)
  (@tanh-succ24-rev mem (s '%26 (icmp-slt-i32 (g '%25 loc) 1015021568) loc) pred))
(defund @tanh-%25-rev (mem loc pred)
  (@tanh-%26-rev mem (s '%25 (load-i32 (g '%ix loc) mem) loc) pred))

(defund @tanh-%24-rev (mem loc pred)
  (@tanh-%25-rev mem loc pred))

(defund @tanh-%24-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%25 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%26 (icmp-slt-i32 (g '%25 loc) 1015021568) loc))
    (succ (case (g '%26 loc) (-1 '%27) (0 '%32))))
  (mv succ mem loc)))

(defruled @tanh-%24-expand-bb
  (equal (@tanh-%24-bb mem loc pred)
         (@tanh-%24-rev mem loc pred))
  :enable (@tanh-%24-bb @tanh-%24-rev
    @tanh-%25-rev
    @tanh-%26-rev
    @tanh-succ24-rev)
  :disable s-diff-s)

(defund @tanh-%27-mem (s27)
  (car s27))
(defund @tanh-%27-loc (s27)
  (cadr s27))
(defund @tanh-%27-pred (s27)
  (caddr s27))
(defund @tanh-%28-val (s27)
  (load-double (g '%2 (@tanh-%27-loc s27)) (@tanh-%27-mem s27)))
(defund @tanh-%28-loc (s27)
  (s '%28 (@tanh-%28-val s27) (@tanh-%27-loc s27)))
(defund @tanh-%29-val (s27)
  (load-double (g '%2 (@tanh-%28-loc s27)) (@tanh-%27-mem s27)))
(defund @tanh-%29-loc (s27)
  (s '%29 (@tanh-%29-val s27) (@tanh-%28-loc s27)))
(defund @tanh-%30-val (s27)
  (fadd-double #x3ff0000000000000 (g '%29 (@tanh-%29-loc s27))))
(defund @tanh-%30-loc (s27)
  (s '%30 (@tanh-%30-val s27) (@tanh-%29-loc s27)))
(defund @tanh-%31-val (s27)
  (fmul-double (g '%28 (@tanh-%30-loc s27)) (g '%30 (@tanh-%30-loc s27))))
(defund @tanh-%31-loc (s27)
  (s '%31 (@tanh-%31-val s27) (@tanh-%30-loc s27)))
(defund @tanh-m27.1-mem (s27)
  (store-double (g '%31 (@tanh-%31-loc s27)) (g '%1 (@tanh-%31-loc s27)) (@tanh-%27-mem s27)))
(defund @tanh-succ27-lab (s27)
  (declare (ignore s27))
  '%66)

(defund @tanh-succ27-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%66 mem loc))
(defund @tanh-m27.1-rev (mem loc pred)
  (@tanh-succ27-rev (store-double (g '%31 loc) (g '%1 loc) mem) loc pred))
(defund @tanh-%31-rev (mem loc pred)
  (@tanh-m27.1-rev mem (s '%31 (fmul-double (g '%28 loc) (g '%30 loc)) loc) pred))
(defund @tanh-%30-rev (mem loc pred)
  (@tanh-%31-rev mem (s '%30 (fadd-double #x3ff0000000000000 (g '%29 loc)) loc) pred))
(defund @tanh-%29-rev (mem loc pred)
  (@tanh-%30-rev mem (s '%29 (load-double (g '%2 loc) mem) loc) pred))
(defund @tanh-%28-rev (mem loc pred)
  (@tanh-%29-rev mem (s '%28 (load-double (g '%2 loc) mem) loc) pred))

(defund @tanh-%27-rev (mem loc pred)
  (@tanh-%28-rev mem loc pred))

(defund @tanh-%27-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%28 (load-double (g '%2 loc) mem) loc))
    (loc (s '%29 (load-double (g '%2 loc) mem) loc))
    (loc (s '%30 (fadd-double #x3ff0000000000000 (g '%29 loc)) loc))
    (loc (s '%31 (fmul-double (g '%28 loc) (g '%30 loc)) loc))
    (mem (store-double (g '%31 loc) (g '%1 loc) mem))
    (succ '%66))
  (mv succ mem loc)))

(defruled @tanh-%27-expand-bb
  (equal (@tanh-%27-bb mem loc pred)
         (@tanh-%27-rev mem loc pred))
  :enable (@tanh-%27-bb @tanh-%27-rev
    @tanh-%28-rev
    @tanh-%29-rev
    @tanh-%30-rev
    @tanh-%31-rev
    @tanh-m27.1-rev
    @tanh-succ27-rev)
  :disable s-diff-s)

(defund @tanh-%32-mem (s32)
  (car s32))
(defund @tanh-%32-loc (s32)
  (cadr s32))
(defund @tanh-%32-pred (s32)
  (caddr s32))
(defund @tanh-%33-val (s32)
  (load-i32 (g '%ix (@tanh-%32-loc s32)) (@tanh-%32-mem s32)))
(defund @tanh-%33-loc (s32)
  (s '%33 (@tanh-%33-val s32) (@tanh-%32-loc s32)))
(defund @tanh-%34-val (s32)
  (icmp-sge-i32 (g '%33 (@tanh-%33-loc s32)) 1072693248))
(defund @tanh-%34-loc (s32)
  (s '%34 (@tanh-%34-val s32) (@tanh-%33-loc s32)))
(defund @tanh-succ32-lab (s32)
  (case (g '%34 (@tanh-%34-loc s32)) (-1 '%35) (0 '%44)))

(defund @tanh-succ32-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%34 loc) (-1 '%35) (0 '%44)) mem loc))
(defund @tanh-%34-rev (mem loc pred)
  (@tanh-succ32-rev mem (s '%34 (icmp-sge-i32 (g '%33 loc) 1072693248) loc) pred))
(defund @tanh-%33-rev (mem loc pred)
  (@tanh-%34-rev mem (s '%33 (load-i32 (g '%ix loc) mem) loc) pred))

(defund @tanh-%32-rev (mem loc pred)
  (@tanh-%33-rev mem loc pred))

(defund @tanh-%32-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%33 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%34 (icmp-sge-i32 (g '%33 loc) 1072693248) loc))
    (succ (case (g '%34 loc) (-1 '%35) (0 '%44))))
  (mv succ mem loc)))

(defruled @tanh-%32-expand-bb
  (equal (@tanh-%32-bb mem loc pred)
         (@tanh-%32-rev mem loc pred))
  :enable (@tanh-%32-bb @tanh-%32-rev
    @tanh-%33-rev
    @tanh-%34-rev
    @tanh-succ32-rev)
  :disable s-diff-s)

(defund @tanh-%35-mem (s35)
  (car s35))
(defund @tanh-%35-loc (s35)
  (cadr s35))
(defund @tanh-%35-pred (s35)
  (caddr s35))
(defund @tanh-%36-val (s35)
  (load-double (g '%2 (@tanh-%35-loc s35)) (@tanh-%35-mem s35)))
(defund @tanh-%36-loc (s35)
  (s '%36 (@tanh-%36-val s35) (@tanh-%35-loc s35)))
(defund @tanh-%37-val (s35)
  (@fabs (g '%36 (@tanh-%36-loc s35))))
(defund @tanh-%37-loc (s35)
  (s '%37 (@tanh-%37-val s35) (@tanh-%36-loc s35)))
(defund @tanh-%38-val (s35)
  (fmul-double #x4000000000000000 (g '%37 (@tanh-%37-loc s35))))
(defund @tanh-%38-loc (s35)
  (s '%38 (@tanh-%38-val s35) (@tanh-%37-loc s35)))
(defund @tanh-%39-val (s35)
  (@expm1 (g '%38 (@tanh-%38-loc s35))))
(defund @tanh-%39-loc (s35)
  (s '%39 (@tanh-%39-val s35) (@tanh-%38-loc s35)))
(defund @tanh-m35.1-mem (s35)
  (store-double (g '%39 (@tanh-%39-loc s35)) (g '%t (@tanh-%39-loc s35)) (@tanh-%35-mem s35)))
(defund @tanh-%40-val (s35)
  (load-double (g '%t (@tanh-%39-loc s35)) (@tanh-m35.1-mem s35)))
(defund @tanh-%40-loc (s35)
  (s '%40 (@tanh-%40-val s35) (@tanh-%39-loc s35)))
(defund @tanh-%41-val (s35)
  (fadd-double (g '%40 (@tanh-%40-loc s35)) #x4000000000000000))
(defund @tanh-%41-loc (s35)
  (s '%41 (@tanh-%41-val s35) (@tanh-%40-loc s35)))
(defund @tanh-%42-val (s35)
  (fdiv-double #x4000000000000000 (g '%41 (@tanh-%41-loc s35))))
(defund @tanh-%42-loc (s35)
  (s '%42 (@tanh-%42-val s35) (@tanh-%41-loc s35)))
(defund @tanh-%43-val (s35)
  (fsub-double #x3ff0000000000000 (g '%42 (@tanh-%42-loc s35))))
(defund @tanh-%43-loc (s35)
  (s '%43 (@tanh-%43-val s35) (@tanh-%42-loc s35)))
(defund @tanh-m35.2-mem (s35)
  (store-double (g '%43 (@tanh-%43-loc s35)) (g '%z (@tanh-%43-loc s35)) (@tanh-m35.1-mem s35)))
(defund @tanh-succ35-lab (s35)
  (declare (ignore s35))
  '%54)

(defund @tanh-succ35-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%54 mem loc))
(defund @tanh-m35.2-rev (mem loc pred)
  (@tanh-succ35-rev (store-double (g '%43 loc) (g '%z loc) mem) loc pred))
(defund @tanh-%43-rev (mem loc pred)
  (@tanh-m35.2-rev mem (s '%43 (fsub-double #x3ff0000000000000 (g '%42 loc)) loc) pred))
(defund @tanh-%42-rev (mem loc pred)
  (@tanh-%43-rev mem (s '%42 (fdiv-double #x4000000000000000 (g '%41 loc)) loc) pred))
(defund @tanh-%41-rev (mem loc pred)
  (@tanh-%42-rev mem (s '%41 (fadd-double (g '%40 loc) #x4000000000000000) loc) pred))
(defund @tanh-%40-rev (mem loc pred)
  (@tanh-%41-rev mem (s '%40 (load-double (g '%t loc) mem) loc) pred))
(defund @tanh-m35.1-rev (mem loc pred)
  (@tanh-%40-rev (store-double (g '%39 loc) (g '%t loc) mem) loc pred))
(defund @tanh-%39-rev (mem loc pred)
  (@tanh-m35.1-rev mem (s '%39 (@expm1 (g '%38 loc)) loc) pred))
(defund @tanh-%38-rev (mem loc pred)
  (@tanh-%39-rev mem (s '%38 (fmul-double #x4000000000000000 (g '%37 loc)) loc) pred))
(defund @tanh-%37-rev (mem loc pred)
  (@tanh-%38-rev mem (s '%37 (@fabs (g '%36 loc)) loc) pred))
(defund @tanh-%36-rev (mem loc pred)
  (@tanh-%37-rev mem (s '%36 (load-double (g '%2 loc) mem) loc) pred))

(defund @tanh-%35-rev (mem loc pred)
  (@tanh-%36-rev mem loc pred))

(defund @tanh-%35-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%36 (load-double (g '%2 loc) mem) loc))
    (loc (s '%37 (@fabs (g '%36 loc)) loc))
    (loc (s '%38 (fmul-double #x4000000000000000 (g '%37 loc)) loc))
    (loc (s '%39 (@expm1 (g '%38 loc)) loc))
    (mem (store-double (g '%39 loc) (g '%t loc) mem))
    (loc (s '%40 (load-double (g '%t loc) mem) loc))
    (loc (s '%41 (fadd-double (g '%40 loc) #x4000000000000000) loc))
    (loc (s '%42 (fdiv-double #x4000000000000000 (g '%41 loc)) loc))
    (loc (s '%43 (fsub-double #x3ff0000000000000 (g '%42 loc)) loc))
    (mem (store-double (g '%43 loc) (g '%z loc) mem))
    (succ '%54))
  (mv succ mem loc)))

(defruled @tanh-%35-expand-bb
  (equal (@tanh-%35-bb mem loc pred)
         (@tanh-%35-rev mem loc pred))
  :enable (@tanh-%35-bb @tanh-%35-rev
    @tanh-%36-rev
    @tanh-%37-rev
    @tanh-%38-rev
    @tanh-%39-rev
    @tanh-m35.1-rev
    @tanh-%40-rev
    @tanh-%41-rev
    @tanh-%42-rev
    @tanh-%43-rev
    @tanh-m35.2-rev
    @tanh-succ35-rev)
  :disable s-diff-s)

(defund @tanh-%44-mem (s44)
  (car s44))
(defund @tanh-%44-loc (s44)
  (cadr s44))
(defund @tanh-%44-pred (s44)
  (caddr s44))
(defund @tanh-%45-val (s44)
  (load-double (g '%2 (@tanh-%44-loc s44)) (@tanh-%44-mem s44)))
(defund @tanh-%45-loc (s44)
  (s '%45 (@tanh-%45-val s44) (@tanh-%44-loc s44)))
(defund @tanh-%46-val (s44)
  (@fabs (g '%45 (@tanh-%45-loc s44))))
(defund @tanh-%46-loc (s44)
  (s '%46 (@tanh-%46-val s44) (@tanh-%45-loc s44)))
(defund @tanh-%47-val (s44)
  (fmul-double #xc000000000000000 (g '%46 (@tanh-%46-loc s44))))
(defund @tanh-%47-loc (s44)
  (s '%47 (@tanh-%47-val s44) (@tanh-%46-loc s44)))
(defund @tanh-%48-val (s44)
  (@expm1 (g '%47 (@tanh-%47-loc s44))))
(defund @tanh-%48-loc (s44)
  (s '%48 (@tanh-%48-val s44) (@tanh-%47-loc s44)))
(defund @tanh-m44.1-mem (s44)
  (store-double (g '%48 (@tanh-%48-loc s44)) (g '%t (@tanh-%48-loc s44)) (@tanh-%44-mem s44)))
(defund @tanh-%49-val (s44)
  (load-double (g '%t (@tanh-%48-loc s44)) (@tanh-m44.1-mem s44)))
(defund @tanh-%49-loc (s44)
  (s '%49 (@tanh-%49-val s44) (@tanh-%48-loc s44)))
(defund @tanh-%50-val (s44)
  (fsub-double #x8000000000000000 (g '%49 (@tanh-%49-loc s44))))
(defund @tanh-%50-loc (s44)
  (s '%50 (@tanh-%50-val s44) (@tanh-%49-loc s44)))
(defund @tanh-%51-val (s44)
  (load-double (g '%t (@tanh-%50-loc s44)) (@tanh-m44.1-mem s44)))
(defund @tanh-%51-loc (s44)
  (s '%51 (@tanh-%51-val s44) (@tanh-%50-loc s44)))
(defund @tanh-%52-val (s44)
  (fadd-double (g '%51 (@tanh-%51-loc s44)) #x4000000000000000))
(defund @tanh-%52-loc (s44)
  (s '%52 (@tanh-%52-val s44) (@tanh-%51-loc s44)))
(defund @tanh-%53-val (s44)
  (fdiv-double (g '%50 (@tanh-%52-loc s44)) (g '%52 (@tanh-%52-loc s44))))
(defund @tanh-%53-loc (s44)
  (s '%53 (@tanh-%53-val s44) (@tanh-%52-loc s44)))
(defund @tanh-m44.2-mem (s44)
  (store-double (g '%53 (@tanh-%53-loc s44)) (g '%z (@tanh-%53-loc s44)) (@tanh-m44.1-mem s44)))
(defund @tanh-succ44-lab (s44)
  (declare (ignore s44))
  '%54)

(defund @tanh-succ44-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%54 mem loc))
(defund @tanh-m44.2-rev (mem loc pred)
  (@tanh-succ44-rev (store-double (g '%53 loc) (g '%z loc) mem) loc pred))
(defund @tanh-%53-rev (mem loc pred)
  (@tanh-m44.2-rev mem (s '%53 (fdiv-double (g '%50 loc) (g '%52 loc)) loc) pred))
(defund @tanh-%52-rev (mem loc pred)
  (@tanh-%53-rev mem (s '%52 (fadd-double (g '%51 loc) #x4000000000000000) loc) pred))
(defund @tanh-%51-rev (mem loc pred)
  (@tanh-%52-rev mem (s '%51 (load-double (g '%t loc) mem) loc) pred))
(defund @tanh-%50-rev (mem loc pred)
  (@tanh-%51-rev mem (s '%50 (fsub-double #x8000000000000000 (g '%49 loc)) loc) pred))
(defund @tanh-%49-rev (mem loc pred)
  (@tanh-%50-rev mem (s '%49 (load-double (g '%t loc) mem) loc) pred))
(defund @tanh-m44.1-rev (mem loc pred)
  (@tanh-%49-rev (store-double (g '%48 loc) (g '%t loc) mem) loc pred))
(defund @tanh-%48-rev (mem loc pred)
  (@tanh-m44.1-rev mem (s '%48 (@expm1 (g '%47 loc)) loc) pred))
(defund @tanh-%47-rev (mem loc pred)
  (@tanh-%48-rev mem (s '%47 (fmul-double #xc000000000000000 (g '%46 loc)) loc) pred))
(defund @tanh-%46-rev (mem loc pred)
  (@tanh-%47-rev mem (s '%46 (@fabs (g '%45 loc)) loc) pred))
(defund @tanh-%45-rev (mem loc pred)
  (@tanh-%46-rev mem (s '%45 (load-double (g '%2 loc) mem) loc) pred))

(defund @tanh-%44-rev (mem loc pred)
  (@tanh-%45-rev mem loc pred))

(defund @tanh-%44-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%45 (load-double (g '%2 loc) mem) loc))
    (loc (s '%46 (@fabs (g '%45 loc)) loc))
    (loc (s '%47 (fmul-double #xc000000000000000 (g '%46 loc)) loc))
    (loc (s '%48 (@expm1 (g '%47 loc)) loc))
    (mem (store-double (g '%48 loc) (g '%t loc) mem))
    (loc (s '%49 (load-double (g '%t loc) mem) loc))
    (loc (s '%50 (fsub-double #x8000000000000000 (g '%49 loc)) loc))
    (loc (s '%51 (load-double (g '%t loc) mem) loc))
    (loc (s '%52 (fadd-double (g '%51 loc) #x4000000000000000) loc))
    (loc (s '%53 (fdiv-double (g '%50 loc) (g '%52 loc)) loc))
    (mem (store-double (g '%53 loc) (g '%z loc) mem))
    (succ '%54))
  (mv succ mem loc)))

(defruled @tanh-%44-expand-bb
  (equal (@tanh-%44-bb mem loc pred)
         (@tanh-%44-rev mem loc pred))
  :enable (@tanh-%44-bb @tanh-%44-rev
    @tanh-%45-rev
    @tanh-%46-rev
    @tanh-%47-rev
    @tanh-%48-rev
    @tanh-m44.1-rev
    @tanh-%49-rev
    @tanh-%50-rev
    @tanh-%51-rev
    @tanh-%52-rev
    @tanh-%53-rev
    @tanh-m44.2-rev
    @tanh-succ44-rev)
  :disable s-diff-s)

(defund @tanh-%54-mem (s54)
  (car s54))
(defund @tanh-%54-loc (s54)
  (cadr s54))
(defund @tanh-%54-pred (s54)
  (caddr s54))
(defund @tanh-succ54-lab (s54)
  (declare (ignore s54))
  '%56)

(defund @tanh-succ54-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%56 mem loc))

(defund @tanh-%54-rev (mem loc pred)
  (@tanh-succ54-rev mem loc pred))

(defund @tanh-%54-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%56))
  (mv succ mem loc)))

(defruled @tanh-%54-expand-bb
  (equal (@tanh-%54-bb mem loc pred)
         (@tanh-%54-rev mem loc pred))
  :enable (@tanh-%54-bb @tanh-%54-rev
    @tanh-succ54-rev)
  :disable s-diff-s)

(defund @tanh-%55-mem (s55)
  (car s55))
(defund @tanh-%55-loc (s55)
  (cadr s55))
(defund @tanh-%55-pred (s55)
  (caddr s55))
(defund @tanh-m55.1-mem (s55)
  (store-double #x3ff0000000000000 (g '%z (@tanh-%55-loc s55)) (@tanh-%55-mem s55)))
(defund @tanh-succ55-lab (s55)
  (declare (ignore s55))
  '%56)

(defund @tanh-succ55-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%56 mem loc))
(defund @tanh-m55.1-rev (mem loc pred)
  (@tanh-succ55-rev (store-double #x3ff0000000000000 (g '%z loc) mem) loc pred))

(defund @tanh-%55-rev (mem loc pred)
  (@tanh-m55.1-rev mem loc pred))

(defund @tanh-%55-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x3ff0000000000000 (g '%z loc) mem))
    (succ '%56))
  (mv succ mem loc)))

(defruled @tanh-%55-expand-bb
  (equal (@tanh-%55-bb mem loc pred)
         (@tanh-%55-rev mem loc pred))
  :enable (@tanh-%55-bb @tanh-%55-rev
    @tanh-m55.1-rev
    @tanh-succ55-rev)
  :disable s-diff-s)

(defund @tanh-%56-mem (s56)
  (car s56))
(defund @tanh-%56-loc (s56)
  (cadr s56))
(defund @tanh-%56-pred (s56)
  (caddr s56))
(defund @tanh-%57-val (s56)
  (load-i32 (g '%jx (@tanh-%56-loc s56)) (@tanh-%56-mem s56)))
(defund @tanh-%57-loc (s56)
  (s '%57 (@tanh-%57-val s56) (@tanh-%56-loc s56)))
(defund @tanh-%58-val (s56)
  (icmp-sge-i32 (g '%57 (@tanh-%57-loc s56)) 0))
(defund @tanh-%58-loc (s56)
  (s '%58 (@tanh-%58-val s56) (@tanh-%57-loc s56)))
(defund @tanh-succ56-lab (s56)
  (case (g '%58 (@tanh-%58-loc s56)) (-1 '%59) (0 '%61)))

(defund @tanh-succ56-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%58 loc) (-1 '%59) (0 '%61)) mem loc))
(defund @tanh-%58-rev (mem loc pred)
  (@tanh-succ56-rev mem (s '%58 (icmp-sge-i32 (g '%57 loc) 0) loc) pred))
(defund @tanh-%57-rev (mem loc pred)
  (@tanh-%58-rev mem (s '%57 (load-i32 (g '%jx loc) mem) loc) pred))

(defund @tanh-%56-rev (mem loc pred)
  (@tanh-%57-rev mem loc pred))

(defund @tanh-%56-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%57 (load-i32 (g '%jx loc) mem) loc))
    (loc (s '%58 (icmp-sge-i32 (g '%57 loc) 0) loc))
    (succ (case (g '%58 loc) (-1 '%59) (0 '%61))))
  (mv succ mem loc)))

(defruled @tanh-%56-expand-bb
  (equal (@tanh-%56-bb mem loc pred)
         (@tanh-%56-rev mem loc pred))
  :enable (@tanh-%56-bb @tanh-%56-rev
    @tanh-%57-rev
    @tanh-%58-rev
    @tanh-succ56-rev)
  :disable s-diff-s)

(defund @tanh-%59-mem (s59)
  (car s59))
(defund @tanh-%59-loc (s59)
  (cadr s59))
(defund @tanh-%59-pred (s59)
  (caddr s59))
(defund @tanh-%60-val (s59)
  (load-double (g '%z (@tanh-%59-loc s59)) (@tanh-%59-mem s59)))
(defund @tanh-%60-loc (s59)
  (s '%60 (@tanh-%60-val s59) (@tanh-%59-loc s59)))
(defund @tanh-succ59-lab (s59)
  (declare (ignore s59))
  '%64)

(defund @tanh-succ59-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))
(defund @tanh-%60-rev (mem loc pred)
  (@tanh-succ59-rev mem (s '%60 (load-double (g '%z loc) mem) loc) pred))

(defund @tanh-%59-rev (mem loc pred)
  (@tanh-%60-rev mem loc pred))

(defund @tanh-%59-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%60 (load-double (g '%z loc) mem) loc))
    (succ '%64))
  (mv succ mem loc)))

(defruled @tanh-%59-expand-bb
  (equal (@tanh-%59-bb mem loc pred)
         (@tanh-%59-rev mem loc pred))
  :enable (@tanh-%59-bb @tanh-%59-rev
    @tanh-%60-rev
    @tanh-succ59-rev)
  :disable s-diff-s)

(defund @tanh-%61-mem (s61)
  (car s61))
(defund @tanh-%61-loc (s61)
  (cadr s61))
(defund @tanh-%61-pred (s61)
  (caddr s61))
(defund @tanh-%62-val (s61)
  (load-double (g '%z (@tanh-%61-loc s61)) (@tanh-%61-mem s61)))
(defund @tanh-%62-loc (s61)
  (s '%62 (@tanh-%62-val s61) (@tanh-%61-loc s61)))
(defund @tanh-%63-val (s61)
  (fsub-double #x8000000000000000 (g '%62 (@tanh-%62-loc s61))))
(defund @tanh-%63-loc (s61)
  (s '%63 (@tanh-%63-val s61) (@tanh-%62-loc s61)))
(defund @tanh-succ61-lab (s61)
  (declare (ignore s61))
  '%64)

(defund @tanh-succ61-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))
(defund @tanh-%63-rev (mem loc pred)
  (@tanh-succ61-rev mem (s '%63 (fsub-double #x8000000000000000 (g '%62 loc)) loc) pred))
(defund @tanh-%62-rev (mem loc pred)
  (@tanh-%63-rev mem (s '%62 (load-double (g '%z loc) mem) loc) pred))

(defund @tanh-%61-rev (mem loc pred)
  (@tanh-%62-rev mem loc pred))

(defund @tanh-%61-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%62 (load-double (g '%z loc) mem) loc))
    (loc (s '%63 (fsub-double #x8000000000000000 (g '%62 loc)) loc))
    (succ '%64))
  (mv succ mem loc)))

(defruled @tanh-%61-expand-bb
  (equal (@tanh-%61-bb mem loc pred)
         (@tanh-%61-rev mem loc pred))
  :enable (@tanh-%61-bb @tanh-%61-rev
    @tanh-%62-rev
    @tanh-%63-rev
    @tanh-succ61-rev)
  :disable s-diff-s)

(defund @tanh-%64-mem (s64)
  (car s64))
(defund @tanh-%64-loc (s64)
  (cadr s64))
(defund @tanh-%64-pred (s64)
  (caddr s64))
(defund @tanh-%65-val (s64)
  (case (@tanh-%64-pred s64) (%59 (g '%60 (@tanh-%64-loc s64))) (%61 (g '%63 (@tanh-%64-loc s64)))))
(defund @tanh-%65-loc (s64)
  (s '%65 (@tanh-%65-val s64) (@tanh-%64-loc s64)))
(defund @tanh-m64.1-mem (s64)
  (store-double (g '%65 (@tanh-%65-loc s64)) (g '%1 (@tanh-%65-loc s64)) (@tanh-%64-mem s64)))
(defund @tanh-succ64-lab (s64)
  (declare (ignore s64))
  '%66)

(defund @tanh-succ64-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%66 mem loc))
(defund @tanh-m64.1-rev (mem loc pred)
  (@tanh-succ64-rev (store-double (g '%65 loc) (g '%1 loc) mem) loc pred))
(defund @tanh-%65-rev (mem loc pred)
  (@tanh-m64.1-rev mem (s '%65 (case pred (%59 (g '%60 loc)) (%61 (g '%63 loc))) loc) pred))

(defund @tanh-%64-rev (mem loc pred)
  (@tanh-%65-rev mem loc pred))

(defund @tanh-%64-bb (mem loc pred)
  (b* (
    (loc (s '%65 (case pred (%59 (g '%60 loc)) (%61 (g '%63 loc))) loc))
    (mem (store-double (g '%65 loc) (g '%1 loc) mem))
    (succ '%66))
  (mv succ mem loc)))

(defruled @tanh-%64-expand-bb
  (equal (@tanh-%64-bb mem loc pred)
         (@tanh-%64-rev mem loc pred))
  :enable (@tanh-%64-bb @tanh-%64-rev
    @tanh-%65-rev
    @tanh-m64.1-rev
    @tanh-succ64-rev)
  :disable s-diff-s)

(defund @tanh-%66-mem (s66)
  (car s66))
(defund @tanh-%66-loc (s66)
  (cadr s66))
(defund @tanh-%66-pred (s66)
  (caddr s66))
(defund @tanh-%67-val (s66)
  (load-double (g '%1 (@tanh-%66-loc s66)) (@tanh-%66-mem s66)))
(defund @tanh-%67-loc (s66)
  (s '%67 (@tanh-%67-val s66) (@tanh-%66-loc s66)))
(defund @tanh-succ66-lab (s66)
  (declare (ignore s66))
  'ret)

(defund @tanh-succ66-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @tanh-%67-rev (mem loc pred)
  (@tanh-succ66-rev mem (s '%67 (load-double (g '%1 loc) mem) loc) pred))

(defund @tanh-%66-rev (mem loc pred)
  (@tanh-%67-rev mem loc pred))

(defund @tanh-%66-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%67 (load-double (g '%1 loc) mem) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @tanh-%66-expand-bb
  (equal (@tanh-%66-bb mem loc pred)
         (@tanh-%66-rev mem loc pred))
  :enable (@tanh-%66-bb @tanh-%66-rev
    @tanh-%67-rev
    @tanh-succ66-rev)
  :disable s-diff-s)

(defund @tanh-step (label mem loc pred)
  (case label
    (%0 (@tanh-%0-bb mem loc pred))
    (%10 (@tanh-%10-bb mem loc pred))
    (%13 (@tanh-%13-bb mem loc pred))
    (%17 (@tanh-%17-bb mem loc pred))
    (%21 (@tanh-%21-bb mem loc pred))
    (%24 (@tanh-%24-bb mem loc pred))
    (%27 (@tanh-%27-bb mem loc pred))
    (%32 (@tanh-%32-bb mem loc pred))
    (%35 (@tanh-%35-bb mem loc pred))
    (%44 (@tanh-%44-bb mem loc pred))
    (%54 (@tanh-%54-bb mem loc pred))
    (%55 (@tanh-%55-bb mem loc pred))
    (%56 (@tanh-%56-bb mem loc pred))
    (%59 (@tanh-%59-bb mem loc pred))
    (%61 (@tanh-%61-bb mem loc pred))
    (%64 (@tanh-%64-bb mem loc pred))
    (%66 (@tanh-%66-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @tanh-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%67 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@tanh-step label mem loc pred)
        (@tanh-steps new-label new-mem new-loc label (1- n))))))

(defund @tanh (%x)
  (declare (ignore %x))
   nil)
