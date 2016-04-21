(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")

(defconst *floor-globals* '())

(defconst *floor-labels* '(%0 %14 %17 %21 %24 %25 %31 %32 %33 %34 %35 %44 %46 %50 %53 %58 %63 %64 %65 %68 %71 %75 %77 %85 %87 %91 %94 %97 %100 %109 %112 %114 %115 %120 %121 %122 %129))

(defund @floor-%0-mem (s0)
  (car s0))
(defund @floor-%0-loc (s0)
  (cadr s0))
(defund @floor-%0-pred (s0)
  (caddr s0))
(defund @floor-%1-mem (s0)
  (alloca-double 'ret 1 (@floor-%0-mem s0)))
(defund @floor-%1-loc (s0)
  (s '%1 '(ret . 0) (@floor-%0-loc s0)))
(defund @floor-%2-mem (s0)
  (alloca-double 'x 1 (@floor-%1-mem s0)))
(defund @floor-%2-loc (s0)
  (s '%2 '(x . 0) (@floor-%1-loc s0)))
(defund @floor-%i0-mem (s0)
  (alloca-i32 'i0 1 (@floor-%2-mem s0)))
(defund @floor-%i0-loc (s0)
  (s '%i0 '(i0 . 0) (@floor-%2-loc s0)))
(defund @floor-%i1-mem (s0)
  (alloca-i32 'i1 1 (@floor-%i0-mem s0)))
(defund @floor-%i1-loc (s0)
  (s '%i1 '(i1 . 0) (@floor-%i0-loc s0)))
(defund @floor-%j0-mem (s0)
  (alloca-i32 'j0 1 (@floor-%i1-mem s0)))
(defund @floor-%j0-loc (s0)
  (s '%j0 '(j0 . 0) (@floor-%i1-loc s0)))
(defund @floor-%i-mem (s0)
  (alloca-i32 'i 1 (@floor-%j0-mem s0)))
(defund @floor-%i-loc (s0)
  (s '%i '(i . 0) (@floor-%j0-loc s0)))
(defund @floor-%j-mem (s0)
  (alloca-i32 'j 1 (@floor-%i-mem s0)))
(defund @floor-%j-loc (s0)
  (s '%j '(j . 0) (@floor-%i-loc s0)))
(defund @floor-m0.1-mem (s0)
  (store-double (g '%x (@floor-%j-loc s0)) (g '%2 (@floor-%j-loc s0)) (@floor-%j-mem s0)))
(defund @floor-%3-val (s0)
  (bitcast-double*-to-i32* (g '%2 (@floor-%j-loc s0))))
(defund @floor-%3-loc (s0)
  (s '%3 (@floor-%3-val s0) (@floor-%j-loc s0)))
(defund @floor-%4-val (s0)
  (getelementptr-i32 (g '%3 (@floor-%3-loc s0)) 1))
(defund @floor-%4-loc (s0)
  (s '%4 (@floor-%4-val s0) (@floor-%3-loc s0)))
(defund @floor-%5-val (s0)
  (load-i32 (g '%4 (@floor-%4-loc s0)) (@floor-m0.1-mem s0)))
(defund @floor-%5-loc (s0)
  (s '%5 (@floor-%5-val s0) (@floor-%4-loc s0)))
(defund @floor-m0.2-mem (s0)
  (store-i32 (g '%5 (@floor-%5-loc s0)) (g '%i0 (@floor-%5-loc s0)) (@floor-m0.1-mem s0)))
(defund @floor-%6-val (s0)
  (bitcast-double*-to-i32* (g '%2 (@floor-%5-loc s0))))
(defund @floor-%6-loc (s0)
  (s '%6 (@floor-%6-val s0) (@floor-%5-loc s0)))
(defund @floor-%7-val (s0)
  (load-i32 (g '%6 (@floor-%6-loc s0)) (@floor-m0.2-mem s0)))
(defund @floor-%7-loc (s0)
  (s '%7 (@floor-%7-val s0) (@floor-%6-loc s0)))
(defund @floor-m0.3-mem (s0)
  (store-i32 (g '%7 (@floor-%7-loc s0)) (g '%i1 (@floor-%7-loc s0)) (@floor-m0.2-mem s0)))
(defund @floor-%8-val (s0)
  (load-i32 (g '%i0 (@floor-%7-loc s0)) (@floor-m0.3-mem s0)))
(defund @floor-%8-loc (s0)
  (s '%8 (@floor-%8-val s0) (@floor-%7-loc s0)))
(defund @floor-%9-val (s0)
  (ashr-i32 (g '%8 (@floor-%8-loc s0)) 20))
(defund @floor-%9-loc (s0)
  (s '%9 (@floor-%9-val s0) (@floor-%8-loc s0)))
(defund @floor-%10-val (s0)
  (and-i32 (g '%9 (@floor-%9-loc s0)) 2047))
(defund @floor-%10-loc (s0)
  (s '%10 (@floor-%10-val s0) (@floor-%9-loc s0)))
(defund @floor-%11-val (s0)
  (sub-i32 (g '%10 (@floor-%10-loc s0)) 1023))
(defund @floor-%11-loc (s0)
  (s '%11 (@floor-%11-val s0) (@floor-%10-loc s0)))
(defund @floor-m0.4-mem (s0)
  (store-i32 (g '%11 (@floor-%11-loc s0)) (g '%j0 (@floor-%11-loc s0)) (@floor-m0.3-mem s0)))
(defund @floor-%12-val (s0)
  (load-i32 (g '%j0 (@floor-%11-loc s0)) (@floor-m0.4-mem s0)))
(defund @floor-%12-loc (s0)
  (s '%12 (@floor-%12-val s0) (@floor-%11-loc s0)))
(defund @floor-%13-val (s0)
  (icmp-slt-i32 (g '%12 (@floor-%12-loc s0)) 20))
(defund @floor-%13-loc (s0)
  (s '%13 (@floor-%13-val s0) (@floor-%12-loc s0)))
(defund @floor-succ0-lab (s0)
  (case (g '%13 (@floor-%13-loc s0)) (-1 '%14) (0 '%65)))

(defund @floor-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%13 loc) (-1 '%14) (0 '%65)) mem loc))
(defund @floor-%13-rev (mem loc pred)
  (@floor-succ0-rev mem (s '%13 (icmp-slt-i32 (g '%12 loc) 20) loc) pred))
(defund @floor-%12-rev (mem loc pred)
  (@floor-%13-rev mem (s '%12 (load-i32 (g '%j0 loc) mem) loc) pred))
(defund @floor-m0.4-rev (mem loc pred)
  (@floor-%12-rev (store-i32 (g '%11 loc) (g '%j0 loc) mem) loc pred))
(defund @floor-%11-rev (mem loc pred)
  (@floor-m0.4-rev mem (s '%11 (sub-i32 (g '%10 loc) 1023) loc) pred))
(defund @floor-%10-rev (mem loc pred)
  (@floor-%11-rev mem (s '%10 (and-i32 (g '%9 loc) 2047) loc) pred))
(defund @floor-%9-rev (mem loc pred)
  (@floor-%10-rev mem (s '%9 (ashr-i32 (g '%8 loc) 20) loc) pred))
(defund @floor-%8-rev (mem loc pred)
  (@floor-%9-rev mem (s '%8 (load-i32 (g '%i0 loc) mem) loc) pred))
(defund @floor-m0.3-rev (mem loc pred)
  (@floor-%8-rev (store-i32 (g '%7 loc) (g '%i1 loc) mem) loc pred))
(defund @floor-%7-rev (mem loc pred)
  (@floor-m0.3-rev mem (s '%7 (load-i32 (g '%6 loc) mem) loc) pred))
(defund @floor-%6-rev (mem loc pred)
  (@floor-%7-rev mem (s '%6 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @floor-m0.2-rev (mem loc pred)
  (@floor-%6-rev (store-i32 (g '%5 loc) (g '%i0 loc) mem) loc pred))
(defund @floor-%5-rev (mem loc pred)
  (@floor-m0.2-rev mem (s '%5 (load-i32 (g '%4 loc) mem) loc) pred))
(defund @floor-%4-rev (mem loc pred)
  (@floor-%5-rev mem (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc) pred))
(defund @floor-%3-rev (mem loc pred)
  (@floor-%4-rev mem (s '%3 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @floor-m0.1-rev (mem loc pred)
  (@floor-%3-rev (store-double (g '%x loc) (g '%2 loc) mem) loc pred))
(defund @floor-%j-rev (mem loc pred)
  (@floor-m0.1-rev (alloca-i32 'j 1 mem) (s '%j '(j . 0) loc) pred))
(defund @floor-%i-rev (mem loc pred)
  (@floor-%j-rev (alloca-i32 'i 1 mem) (s '%i '(i . 0) loc) pred))
(defund @floor-%j0-rev (mem loc pred)
  (@floor-%i-rev (alloca-i32 'j0 1 mem) (s '%j0 '(j0 . 0) loc) pred))
(defund @floor-%i1-rev (mem loc pred)
  (@floor-%j0-rev (alloca-i32 'i1 1 mem) (s '%i1 '(i1 . 0) loc) pred))
(defund @floor-%i0-rev (mem loc pred)
  (@floor-%i1-rev (alloca-i32 'i0 1 mem) (s '%i0 '(i0 . 0) loc) pred))
(defund @floor-%2-rev (mem loc pred)
  (@floor-%i0-rev (alloca-double 'x 1 mem) (s '%2 '(x . 0) loc) pred))
(defund @floor-%1-rev (mem loc pred)
  (@floor-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @floor-%0-rev (mem loc pred)
  (@floor-%1-rev mem loc pred))

(defund @floor-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (alloca-double 'x 1 mem))
    (loc (s '%2 '(x . 0) loc))
    (mem (alloca-i32 'i0 1 mem))
    (loc (s '%i0 '(i0 . 0) loc))
    (mem (alloca-i32 'i1 1 mem))
    (loc (s '%i1 '(i1 . 0) loc))
    (mem (alloca-i32 'j0 1 mem))
    (loc (s '%j0 '(j0 . 0) loc))
    (mem (alloca-i32 'i 1 mem))
    (loc (s '%i '(i . 0) loc))
    (mem (alloca-i32 'j 1 mem))
    (loc (s '%j '(j . 0) loc))
    (mem (store-double (g '%x loc) (g '%2 loc) mem))
    (loc (s '%3 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc))
    (loc (s '%5 (load-i32 (g '%4 loc) mem) loc))
    (mem (store-i32 (g '%5 loc) (g '%i0 loc) mem))
    (loc (s '%6 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%7 (load-i32 (g '%6 loc) mem) loc))
    (mem (store-i32 (g '%7 loc) (g '%i1 loc) mem))
    (loc (s '%8 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%9 (ashr-i32 (g '%8 loc) 20) loc))
    (loc (s '%10 (and-i32 (g '%9 loc) 2047) loc))
    (loc (s '%11 (sub-i32 (g '%10 loc) 1023) loc))
    (mem (store-i32 (g '%11 loc) (g '%j0 loc) mem))
    (loc (s '%12 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%13 (icmp-slt-i32 (g '%12 loc) 20) loc))
    (succ (case (g '%13 loc) (-1 '%14) (0 '%65))))
  (mv succ mem loc)))

(defruled @floor-%0-expand-bb
  (equal (@floor-%0-bb mem loc pred)
         (@floor-%0-rev mem loc pred))
  :enable (@floor-%0-bb @floor-%0-rev
    @floor-%1-rev
    @floor-%2-rev
    @floor-%i0-rev
    @floor-%i1-rev
    @floor-%j0-rev
    @floor-%i-rev
    @floor-%j-rev
    @floor-m0.1-rev
    @floor-%3-rev
    @floor-%4-rev
    @floor-%5-rev
    @floor-m0.2-rev
    @floor-%6-rev
    @floor-%7-rev
    @floor-m0.3-rev
    @floor-%8-rev
    @floor-%9-rev
    @floor-%10-rev
    @floor-%11-rev
    @floor-m0.4-rev
    @floor-%12-rev
    @floor-%13-rev
    @floor-succ0-rev)
  :disable s-diff-s)

(defund @floor-%14-mem (s14)
  (car s14))
(defund @floor-%14-loc (s14)
  (cadr s14))
(defund @floor-%14-pred (s14)
  (caddr s14))
(defund @floor-%15-val (s14)
  (load-i32 (g '%j0 (@floor-%14-loc s14)) (@floor-%14-mem s14)))
(defund @floor-%15-loc (s14)
  (s '%15 (@floor-%15-val s14) (@floor-%14-loc s14)))
(defund @floor-%16-val (s14)
  (icmp-slt-i32 (g '%15 (@floor-%15-loc s14)) 0))
(defund @floor-%16-loc (s14)
  (s '%16 (@floor-%16-val s14) (@floor-%15-loc s14)))
(defund @floor-succ14-lab (s14)
  (case (g '%16 (@floor-%16-loc s14)) (-1 '%17) (0 '%35)))

(defund @floor-succ14-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%16 loc) (-1 '%17) (0 '%35)) mem loc))
(defund @floor-%16-rev (mem loc pred)
  (@floor-succ14-rev mem (s '%16 (icmp-slt-i32 (g '%15 loc) 0) loc) pred))
(defund @floor-%15-rev (mem loc pred)
  (@floor-%16-rev mem (s '%15 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%14-rev (mem loc pred)
  (@floor-%15-rev mem loc pred))

(defund @floor-%14-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%15 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%16 (icmp-slt-i32 (g '%15 loc) 0) loc))
    (succ (case (g '%16 loc) (-1 '%17) (0 '%35))))
  (mv succ mem loc)))

(defruled @floor-%14-expand-bb
  (equal (@floor-%14-bb mem loc pred)
         (@floor-%14-rev mem loc pred))
  :enable (@floor-%14-bb @floor-%14-rev
    @floor-%15-rev
    @floor-%16-rev
    @floor-succ14-rev)
  :disable s-diff-s)

(defund @floor-%17-mem (s17)
  (car s17))
(defund @floor-%17-loc (s17)
  (cadr s17))
(defund @floor-%17-pred (s17)
  (caddr s17))
(defund @floor-%18-val (s17)
  (load-double (g '%2 (@floor-%17-loc s17)) (@floor-%17-mem s17)))
(defund @floor-%18-loc (s17)
  (s '%18 (@floor-%18-val s17) (@floor-%17-loc s17)))
(defund @floor-%19-val (s17)
  (fadd-double #x7e37e43c8800759c (g '%18 (@floor-%18-loc s17))))
(defund @floor-%19-loc (s17)
  (s '%19 (@floor-%19-val s17) (@floor-%18-loc s17)))
(defund @floor-%20-val (s17)
  (fcmp-ogt-double (g '%19 (@floor-%19-loc s17)) #x0000000000000000))
(defund @floor-%20-loc (s17)
  (s '%20 (@floor-%20-val s17) (@floor-%19-loc s17)))
(defund @floor-succ17-lab (s17)
  (case (g '%20 (@floor-%20-loc s17)) (-1 '%21) (0 '%34)))

(defund @floor-succ17-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%20 loc) (-1 '%21) (0 '%34)) mem loc))
(defund @floor-%20-rev (mem loc pred)
  (@floor-succ17-rev mem (s '%20 (fcmp-ogt-double (g '%19 loc) #x0000000000000000) loc) pred))
(defund @floor-%19-rev (mem loc pred)
  (@floor-%20-rev mem (s '%19 (fadd-double #x7e37e43c8800759c (g '%18 loc)) loc) pred))
(defund @floor-%18-rev (mem loc pred)
  (@floor-%19-rev mem (s '%18 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%17-rev (mem loc pred)
  (@floor-%18-rev mem loc pred))

(defund @floor-%17-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%18 (load-double (g '%2 loc) mem) loc))
    (loc (s '%19 (fadd-double #x7e37e43c8800759c (g '%18 loc)) loc))
    (loc (s '%20 (fcmp-ogt-double (g '%19 loc) #x0000000000000000) loc))
    (succ (case (g '%20 loc) (-1 '%21) (0 '%34))))
  (mv succ mem loc)))

(defruled @floor-%17-expand-bb
  (equal (@floor-%17-bb mem loc pred)
         (@floor-%17-rev mem loc pred))
  :enable (@floor-%17-bb @floor-%17-rev
    @floor-%18-rev
    @floor-%19-rev
    @floor-%20-rev
    @floor-succ17-rev)
  :disable s-diff-s)

(defund @floor-%21-mem (s21)
  (car s21))
(defund @floor-%21-loc (s21)
  (cadr s21))
(defund @floor-%21-pred (s21)
  (caddr s21))
(defund @floor-%22-val (s21)
  (load-i32 (g '%i0 (@floor-%21-loc s21)) (@floor-%21-mem s21)))
(defund @floor-%22-loc (s21)
  (s '%22 (@floor-%22-val s21) (@floor-%21-loc s21)))
(defund @floor-%23-val (s21)
  (icmp-sge-i32 (g '%22 (@floor-%22-loc s21)) 0))
(defund @floor-%23-loc (s21)
  (s '%23 (@floor-%23-val s21) (@floor-%22-loc s21)))
(defund @floor-succ21-lab (s21)
  (case (g '%23 (@floor-%23-loc s21)) (-1 '%24) (0 '%25)))

(defund @floor-succ21-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%23 loc) (-1 '%24) (0 '%25)) mem loc))
(defund @floor-%23-rev (mem loc pred)
  (@floor-succ21-rev mem (s '%23 (icmp-sge-i32 (g '%22 loc) 0) loc) pred))
(defund @floor-%22-rev (mem loc pred)
  (@floor-%23-rev mem (s '%22 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%21-rev (mem loc pred)
  (@floor-%22-rev mem loc pred))

(defund @floor-%21-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%22 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%23 (icmp-sge-i32 (g '%22 loc) 0) loc))
    (succ (case (g '%23 loc) (-1 '%24) (0 '%25))))
  (mv succ mem loc)))

(defruled @floor-%21-expand-bb
  (equal (@floor-%21-bb mem loc pred)
         (@floor-%21-rev mem loc pred))
  :enable (@floor-%21-bb @floor-%21-rev
    @floor-%22-rev
    @floor-%23-rev
    @floor-succ21-rev)
  :disable s-diff-s)

(defund @floor-%24-mem (s24)
  (car s24))
(defund @floor-%24-loc (s24)
  (cadr s24))
(defund @floor-%24-pred (s24)
  (caddr s24))
(defund @floor-m24.1-mem (s24)
  (store-i32 0 (g '%i1 (@floor-%24-loc s24)) (@floor-%24-mem s24)))
(defund @floor-m24.2-mem (s24)
  (store-i32 0 (g '%i0 (@floor-%24-loc s24)) (@floor-m24.1-mem s24)))
(defund @floor-succ24-lab (s24)
  (declare (ignore s24))
  '%33)

(defund @floor-succ24-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%33 mem loc))
(defund @floor-m24.2-rev (mem loc pred)
  (@floor-succ24-rev (store-i32 0 (g '%i0 loc) mem) loc pred))
(defund @floor-m24.1-rev (mem loc pred)
  (@floor-m24.2-rev (store-i32 0 (g '%i1 loc) mem) loc pred))

(defund @floor-%24-rev (mem loc pred)
  (@floor-m24.1-rev mem loc pred))

(defund @floor-%24-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-i32 0 (g '%i1 loc) mem))
    (mem (store-i32 0 (g '%i0 loc) mem))
    (succ '%33))
  (mv succ mem loc)))

(defruled @floor-%24-expand-bb
  (equal (@floor-%24-bb mem loc pred)
         (@floor-%24-rev mem loc pred))
  :enable (@floor-%24-bb @floor-%24-rev
    @floor-m24.1-rev
    @floor-m24.2-rev
    @floor-succ24-rev)
  :disable s-diff-s)

(defund @floor-%25-mem (s25)
  (car s25))
(defund @floor-%25-loc (s25)
  (cadr s25))
(defund @floor-%25-pred (s25)
  (caddr s25))
(defund @floor-%26-val (s25)
  (load-i32 (g '%i0 (@floor-%25-loc s25)) (@floor-%25-mem s25)))
(defund @floor-%26-loc (s25)
  (s '%26 (@floor-%26-val s25) (@floor-%25-loc s25)))
(defund @floor-%27-val (s25)
  (and-i32 (g '%26 (@floor-%26-loc s25)) 2147483647))
(defund @floor-%27-loc (s25)
  (s '%27 (@floor-%27-val s25) (@floor-%26-loc s25)))
(defund @floor-%28-val (s25)
  (load-i32 (g '%i1 (@floor-%27-loc s25)) (@floor-%25-mem s25)))
(defund @floor-%28-loc (s25)
  (s '%28 (@floor-%28-val s25) (@floor-%27-loc s25)))
(defund @floor-%29-val (s25)
  (or-i32 (g '%27 (@floor-%28-loc s25)) (g '%28 (@floor-%28-loc s25))))
(defund @floor-%29-loc (s25)
  (s '%29 (@floor-%29-val s25) (@floor-%28-loc s25)))
(defund @floor-%30-val (s25)
  (icmp-ne-i32 (g '%29 (@floor-%29-loc s25)) 0))
(defund @floor-%30-loc (s25)
  (s '%30 (@floor-%30-val s25) (@floor-%29-loc s25)))
(defund @floor-succ25-lab (s25)
  (case (g '%30 (@floor-%30-loc s25)) (-1 '%31) (0 '%32)))

(defund @floor-succ25-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%30 loc) (-1 '%31) (0 '%32)) mem loc))
(defund @floor-%30-rev (mem loc pred)
  (@floor-succ25-rev mem (s '%30 (icmp-ne-i32 (g '%29 loc) 0) loc) pred))
(defund @floor-%29-rev (mem loc pred)
  (@floor-%30-rev mem (s '%29 (or-i32 (g '%27 loc) (g '%28 loc)) loc) pred))
(defund @floor-%28-rev (mem loc pred)
  (@floor-%29-rev mem (s '%28 (load-i32 (g '%i1 loc) mem) loc) pred))
(defund @floor-%27-rev (mem loc pred)
  (@floor-%28-rev mem (s '%27 (and-i32 (g '%26 loc) 2147483647) loc) pred))
(defund @floor-%26-rev (mem loc pred)
  (@floor-%27-rev mem (s '%26 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%25-rev (mem loc pred)
  (@floor-%26-rev mem loc pred))

(defund @floor-%25-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%26 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%27 (and-i32 (g '%26 loc) 2147483647) loc))
    (loc (s '%28 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%29 (or-i32 (g '%27 loc) (g '%28 loc)) loc))
    (loc (s '%30 (icmp-ne-i32 (g '%29 loc) 0) loc))
    (succ (case (g '%30 loc) (-1 '%31) (0 '%32))))
  (mv succ mem loc)))

(defruled @floor-%25-expand-bb
  (equal (@floor-%25-bb mem loc pred)
         (@floor-%25-rev mem loc pred))
  :enable (@floor-%25-bb @floor-%25-rev
    @floor-%26-rev
    @floor-%27-rev
    @floor-%28-rev
    @floor-%29-rev
    @floor-%30-rev
    @floor-succ25-rev)
  :disable s-diff-s)

(defund @floor-%31-mem (s31)
  (car s31))
(defund @floor-%31-loc (s31)
  (cadr s31))
(defund @floor-%31-pred (s31)
  (caddr s31))
(defund @floor-m31.1-mem (s31)
  (store-i32 -1074790400 (g '%i0 (@floor-%31-loc s31)) (@floor-%31-mem s31)))
(defund @floor-m31.2-mem (s31)
  (store-i32 0 (g '%i1 (@floor-%31-loc s31)) (@floor-m31.1-mem s31)))
(defund @floor-succ31-lab (s31)
  (declare (ignore s31))
  '%32)

(defund @floor-succ31-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%32 mem loc))
(defund @floor-m31.2-rev (mem loc pred)
  (@floor-succ31-rev (store-i32 0 (g '%i1 loc) mem) loc pred))
(defund @floor-m31.1-rev (mem loc pred)
  (@floor-m31.2-rev (store-i32 -1074790400 (g '%i0 loc) mem) loc pred))

(defund @floor-%31-rev (mem loc pred)
  (@floor-m31.1-rev mem loc pred))

(defund @floor-%31-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-i32 -1074790400 (g '%i0 loc) mem))
    (mem (store-i32 0 (g '%i1 loc) mem))
    (succ '%32))
  (mv succ mem loc)))

(defruled @floor-%31-expand-bb
  (equal (@floor-%31-bb mem loc pred)
         (@floor-%31-rev mem loc pred))
  :enable (@floor-%31-bb @floor-%31-rev
    @floor-m31.1-rev
    @floor-m31.2-rev
    @floor-succ31-rev)
  :disable s-diff-s)

(defund @floor-%32-mem (s32)
  (car s32))
(defund @floor-%32-loc (s32)
  (cadr s32))
(defund @floor-%32-pred (s32)
  (caddr s32))
(defund @floor-succ32-lab (s32)
  (declare (ignore s32))
  '%33)

(defund @floor-succ32-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%33 mem loc))

(defund @floor-%32-rev (mem loc pred)
  (@floor-succ32-rev mem loc pred))

(defund @floor-%32-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%33))
  (mv succ mem loc)))

(defruled @floor-%32-expand-bb
  (equal (@floor-%32-bb mem loc pred)
         (@floor-%32-rev mem loc pred))
  :enable (@floor-%32-bb @floor-%32-rev
    @floor-succ32-rev)
  :disable s-diff-s)

(defund @floor-%33-mem (s33)
  (car s33))
(defund @floor-%33-loc (s33)
  (cadr s33))
(defund @floor-%33-pred (s33)
  (caddr s33))
(defund @floor-succ33-lab (s33)
  (declare (ignore s33))
  '%34)

(defund @floor-succ33-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%34 mem loc))

(defund @floor-%33-rev (mem loc pred)
  (@floor-succ33-rev mem loc pred))

(defund @floor-%33-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%34))
  (mv succ mem loc)))

(defruled @floor-%33-expand-bb
  (equal (@floor-%33-bb mem loc pred)
         (@floor-%33-rev mem loc pred))
  :enable (@floor-%33-bb @floor-%33-rev
    @floor-succ33-rev)
  :disable s-diff-s)

(defund @floor-%34-mem (s34)
  (car s34))
(defund @floor-%34-loc (s34)
  (cadr s34))
(defund @floor-%34-pred (s34)
  (caddr s34))
(defund @floor-succ34-lab (s34)
  (declare (ignore s34))
  '%64)

(defund @floor-succ34-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))

(defund @floor-%34-rev (mem loc pred)
  (@floor-succ34-rev mem loc pred))

(defund @floor-%34-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%64))
  (mv succ mem loc)))

(defruled @floor-%34-expand-bb
  (equal (@floor-%34-bb mem loc pred)
         (@floor-%34-rev mem loc pred))
  :enable (@floor-%34-bb @floor-%34-rev
    @floor-succ34-rev)
  :disable s-diff-s)

(defund @floor-%35-mem (s35)
  (car s35))
(defund @floor-%35-loc (s35)
  (cadr s35))
(defund @floor-%35-pred (s35)
  (caddr s35))
(defund @floor-%36-val (s35)
  (load-i32 (g '%j0 (@floor-%35-loc s35)) (@floor-%35-mem s35)))
(defund @floor-%36-loc (s35)
  (s '%36 (@floor-%36-val s35) (@floor-%35-loc s35)))
(defund @floor-%37-val (s35)
  (ashr-i32 1048575 (g '%36 (@floor-%36-loc s35))))
(defund @floor-%37-loc (s35)
  (s '%37 (@floor-%37-val s35) (@floor-%36-loc s35)))
(defund @floor-m35.1-mem (s35)
  (store-i32 (g '%37 (@floor-%37-loc s35)) (g '%i (@floor-%37-loc s35)) (@floor-%35-mem s35)))
(defund @floor-%38-val (s35)
  (load-i32 (g '%i0 (@floor-%37-loc s35)) (@floor-m35.1-mem s35)))
(defund @floor-%38-loc (s35)
  (s '%38 (@floor-%38-val s35) (@floor-%37-loc s35)))
(defund @floor-%39-val (s35)
  (load-i32 (g '%i (@floor-%38-loc s35)) (@floor-m35.1-mem s35)))
(defund @floor-%39-loc (s35)
  (s '%39 (@floor-%39-val s35) (@floor-%38-loc s35)))
(defund @floor-%40-val (s35)
  (and-i32 (g '%38 (@floor-%39-loc s35)) (g '%39 (@floor-%39-loc s35))))
(defund @floor-%40-loc (s35)
  (s '%40 (@floor-%40-val s35) (@floor-%39-loc s35)))
(defund @floor-%41-val (s35)
  (load-i32 (g '%i1 (@floor-%40-loc s35)) (@floor-m35.1-mem s35)))
(defund @floor-%41-loc (s35)
  (s '%41 (@floor-%41-val s35) (@floor-%40-loc s35)))
(defund @floor-%42-val (s35)
  (or-i32 (g '%40 (@floor-%41-loc s35)) (g '%41 (@floor-%41-loc s35))))
(defund @floor-%42-loc (s35)
  (s '%42 (@floor-%42-val s35) (@floor-%41-loc s35)))
(defund @floor-%43-val (s35)
  (icmp-eq-i32 (g '%42 (@floor-%42-loc s35)) 0))
(defund @floor-%43-loc (s35)
  (s '%43 (@floor-%43-val s35) (@floor-%42-loc s35)))
(defund @floor-succ35-lab (s35)
  (case (g '%43 (@floor-%43-loc s35)) (-1 '%44) (0 '%46)))

(defund @floor-succ35-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%43 loc) (-1 '%44) (0 '%46)) mem loc))
(defund @floor-%43-rev (mem loc pred)
  (@floor-succ35-rev mem (s '%43 (icmp-eq-i32 (g '%42 loc) 0) loc) pred))
(defund @floor-%42-rev (mem loc pred)
  (@floor-%43-rev mem (s '%42 (or-i32 (g '%40 loc) (g '%41 loc)) loc) pred))
(defund @floor-%41-rev (mem loc pred)
  (@floor-%42-rev mem (s '%41 (load-i32 (g '%i1 loc) mem) loc) pred))
(defund @floor-%40-rev (mem loc pred)
  (@floor-%41-rev mem (s '%40 (and-i32 (g '%38 loc) (g '%39 loc)) loc) pred))
(defund @floor-%39-rev (mem loc pred)
  (@floor-%40-rev mem (s '%39 (load-i32 (g '%i loc) mem) loc) pred))
(defund @floor-%38-rev (mem loc pred)
  (@floor-%39-rev mem (s '%38 (load-i32 (g '%i0 loc) mem) loc) pred))
(defund @floor-m35.1-rev (mem loc pred)
  (@floor-%38-rev (store-i32 (g '%37 loc) (g '%i loc) mem) loc pred))
(defund @floor-%37-rev (mem loc pred)
  (@floor-m35.1-rev mem (s '%37 (ashr-i32 1048575 (g '%36 loc)) loc) pred))
(defund @floor-%36-rev (mem loc pred)
  (@floor-%37-rev mem (s '%36 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%35-rev (mem loc pred)
  (@floor-%36-rev mem loc pred))

(defund @floor-%35-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%36 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%37 (ashr-i32 1048575 (g '%36 loc)) loc))
    (mem (store-i32 (g '%37 loc) (g '%i loc) mem))
    (loc (s '%38 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%39 (load-i32 (g '%i loc) mem) loc))
    (loc (s '%40 (and-i32 (g '%38 loc) (g '%39 loc)) loc))
    (loc (s '%41 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%42 (or-i32 (g '%40 loc) (g '%41 loc)) loc))
    (loc (s '%43 (icmp-eq-i32 (g '%42 loc) 0) loc))
    (succ (case (g '%43 loc) (-1 '%44) (0 '%46))))
  (mv succ mem loc)))

(defruled @floor-%35-expand-bb
  (equal (@floor-%35-bb mem loc pred)
         (@floor-%35-rev mem loc pred))
  :enable (@floor-%35-bb @floor-%35-rev
    @floor-%36-rev
    @floor-%37-rev
    @floor-m35.1-rev
    @floor-%38-rev
    @floor-%39-rev
    @floor-%40-rev
    @floor-%41-rev
    @floor-%42-rev
    @floor-%43-rev
    @floor-succ35-rev)
  :disable s-diff-s)

(defund @floor-%44-mem (s44)
  (car s44))
(defund @floor-%44-loc (s44)
  (cadr s44))
(defund @floor-%44-pred (s44)
  (caddr s44))
(defund @floor-%45-val (s44)
  (load-double (g '%2 (@floor-%44-loc s44)) (@floor-%44-mem s44)))
(defund @floor-%45-loc (s44)
  (s '%45 (@floor-%45-val s44) (@floor-%44-loc s44)))
(defund @floor-m44.1-mem (s44)
  (store-double (g '%45 (@floor-%45-loc s44)) (g '%1 (@floor-%45-loc s44)) (@floor-%44-mem s44)))
(defund @floor-succ44-lab (s44)
  (declare (ignore s44))
  '%129)

(defund @floor-succ44-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%129 mem loc))
(defund @floor-m44.1-rev (mem loc pred)
  (@floor-succ44-rev (store-double (g '%45 loc) (g '%1 loc) mem) loc pred))
(defund @floor-%45-rev (mem loc pred)
  (@floor-m44.1-rev mem (s '%45 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%44-rev (mem loc pred)
  (@floor-%45-rev mem loc pred))

(defund @floor-%44-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%45 (load-double (g '%2 loc) mem) loc))
    (mem (store-double (g '%45 loc) (g '%1 loc) mem))
    (succ '%129))
  (mv succ mem loc)))

(defruled @floor-%44-expand-bb
  (equal (@floor-%44-bb mem loc pred)
         (@floor-%44-rev mem loc pred))
  :enable (@floor-%44-bb @floor-%44-rev
    @floor-%45-rev
    @floor-m44.1-rev
    @floor-succ44-rev)
  :disable s-diff-s)

(defund @floor-%46-mem (s46)
  (car s46))
(defund @floor-%46-loc (s46)
  (cadr s46))
(defund @floor-%46-pred (s46)
  (caddr s46))
(defund @floor-%47-val (s46)
  (load-double (g '%2 (@floor-%46-loc s46)) (@floor-%46-mem s46)))
(defund @floor-%47-loc (s46)
  (s '%47 (@floor-%47-val s46) (@floor-%46-loc s46)))
(defund @floor-%48-val (s46)
  (fadd-double #x7e37e43c8800759c (g '%47 (@floor-%47-loc s46))))
(defund @floor-%48-loc (s46)
  (s '%48 (@floor-%48-val s46) (@floor-%47-loc s46)))
(defund @floor-%49-val (s46)
  (fcmp-ogt-double (g '%48 (@floor-%48-loc s46)) #x0000000000000000))
(defund @floor-%49-loc (s46)
  (s '%49 (@floor-%49-val s46) (@floor-%48-loc s46)))
(defund @floor-succ46-lab (s46)
  (case (g '%49 (@floor-%49-loc s46)) (-1 '%50) (0 '%63)))

(defund @floor-succ46-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%49 loc) (-1 '%50) (0 '%63)) mem loc))
(defund @floor-%49-rev (mem loc pred)
  (@floor-succ46-rev mem (s '%49 (fcmp-ogt-double (g '%48 loc) #x0000000000000000) loc) pred))
(defund @floor-%48-rev (mem loc pred)
  (@floor-%49-rev mem (s '%48 (fadd-double #x7e37e43c8800759c (g '%47 loc)) loc) pred))
(defund @floor-%47-rev (mem loc pred)
  (@floor-%48-rev mem (s '%47 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%46-rev (mem loc pred)
  (@floor-%47-rev mem loc pred))

(defund @floor-%46-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%47 (load-double (g '%2 loc) mem) loc))
    (loc (s '%48 (fadd-double #x7e37e43c8800759c (g '%47 loc)) loc))
    (loc (s '%49 (fcmp-ogt-double (g '%48 loc) #x0000000000000000) loc))
    (succ (case (g '%49 loc) (-1 '%50) (0 '%63))))
  (mv succ mem loc)))

(defruled @floor-%46-expand-bb
  (equal (@floor-%46-bb mem loc pred)
         (@floor-%46-rev mem loc pred))
  :enable (@floor-%46-bb @floor-%46-rev
    @floor-%47-rev
    @floor-%48-rev
    @floor-%49-rev
    @floor-succ46-rev)
  :disable s-diff-s)

(defund @floor-%50-mem (s50)
  (car s50))
(defund @floor-%50-loc (s50)
  (cadr s50))
(defund @floor-%50-pred (s50)
  (caddr s50))
(defund @floor-%51-val (s50)
  (load-i32 (g '%i0 (@floor-%50-loc s50)) (@floor-%50-mem s50)))
(defund @floor-%51-loc (s50)
  (s '%51 (@floor-%51-val s50) (@floor-%50-loc s50)))
(defund @floor-%52-val (s50)
  (icmp-slt-i32 (g '%51 (@floor-%51-loc s50)) 0))
(defund @floor-%52-loc (s50)
  (s '%52 (@floor-%52-val s50) (@floor-%51-loc s50)))
(defund @floor-succ50-lab (s50)
  (case (g '%52 (@floor-%52-loc s50)) (-1 '%53) (0 '%58)))

(defund @floor-succ50-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%52 loc) (-1 '%53) (0 '%58)) mem loc))
(defund @floor-%52-rev (mem loc pred)
  (@floor-succ50-rev mem (s '%52 (icmp-slt-i32 (g '%51 loc) 0) loc) pred))
(defund @floor-%51-rev (mem loc pred)
  (@floor-%52-rev mem (s '%51 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%50-rev (mem loc pred)
  (@floor-%51-rev mem loc pred))

(defund @floor-%50-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%51 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%52 (icmp-slt-i32 (g '%51 loc) 0) loc))
    (succ (case (g '%52 loc) (-1 '%53) (0 '%58))))
  (mv succ mem loc)))

(defruled @floor-%50-expand-bb
  (equal (@floor-%50-bb mem loc pred)
         (@floor-%50-rev mem loc pred))
  :enable (@floor-%50-bb @floor-%50-rev
    @floor-%51-rev
    @floor-%52-rev
    @floor-succ50-rev)
  :disable s-diff-s)

(defund @floor-%53-mem (s53)
  (car s53))
(defund @floor-%53-loc (s53)
  (cadr s53))
(defund @floor-%53-pred (s53)
  (caddr s53))
(defund @floor-%54-val (s53)
  (load-i32 (g '%j0 (@floor-%53-loc s53)) (@floor-%53-mem s53)))
(defund @floor-%54-loc (s53)
  (s '%54 (@floor-%54-val s53) (@floor-%53-loc s53)))
(defund @floor-%55-val (s53)
  (ashr-i32 1048576 (g '%54 (@floor-%54-loc s53))))
(defund @floor-%55-loc (s53)
  (s '%55 (@floor-%55-val s53) (@floor-%54-loc s53)))
(defund @floor-%56-val (s53)
  (load-i32 (g '%i0 (@floor-%55-loc s53)) (@floor-%53-mem s53)))
(defund @floor-%56-loc (s53)
  (s '%56 (@floor-%56-val s53) (@floor-%55-loc s53)))
(defund @floor-%57-val (s53)
  (add-i32 (g '%56 (@floor-%56-loc s53)) (g '%55 (@floor-%56-loc s53))))
(defund @floor-%57-loc (s53)
  (s '%57 (@floor-%57-val s53) (@floor-%56-loc s53)))
(defund @floor-m53.1-mem (s53)
  (store-i32 (g '%57 (@floor-%57-loc s53)) (g '%i0 (@floor-%57-loc s53)) (@floor-%53-mem s53)))
(defund @floor-succ53-lab (s53)
  (declare (ignore s53))
  '%58)

(defund @floor-succ53-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%58 mem loc))
(defund @floor-m53.1-rev (mem loc pred)
  (@floor-succ53-rev (store-i32 (g '%57 loc) (g '%i0 loc) mem) loc pred))
(defund @floor-%57-rev (mem loc pred)
  (@floor-m53.1-rev mem (s '%57 (add-i32 (g '%56 loc) (g '%55 loc)) loc) pred))
(defund @floor-%56-rev (mem loc pred)
  (@floor-%57-rev mem (s '%56 (load-i32 (g '%i0 loc) mem) loc) pred))
(defund @floor-%55-rev (mem loc pred)
  (@floor-%56-rev mem (s '%55 (ashr-i32 1048576 (g '%54 loc)) loc) pred))
(defund @floor-%54-rev (mem loc pred)
  (@floor-%55-rev mem (s '%54 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%53-rev (mem loc pred)
  (@floor-%54-rev mem loc pred))

(defund @floor-%53-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%54 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%55 (ashr-i32 1048576 (g '%54 loc)) loc))
    (loc (s '%56 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%57 (add-i32 (g '%56 loc) (g '%55 loc)) loc))
    (mem (store-i32 (g '%57 loc) (g '%i0 loc) mem))
    (succ '%58))
  (mv succ mem loc)))

(defruled @floor-%53-expand-bb
  (equal (@floor-%53-bb mem loc pred)
         (@floor-%53-rev mem loc pred))
  :enable (@floor-%53-bb @floor-%53-rev
    @floor-%54-rev
    @floor-%55-rev
    @floor-%56-rev
    @floor-%57-rev
    @floor-m53.1-rev
    @floor-succ53-rev)
  :disable s-diff-s)

(defund @floor-%58-mem (s58)
  (car s58))
(defund @floor-%58-loc (s58)
  (cadr s58))
(defund @floor-%58-pred (s58)
  (caddr s58))
(defund @floor-%59-val (s58)
  (load-i32 (g '%i (@floor-%58-loc s58)) (@floor-%58-mem s58)))
(defund @floor-%59-loc (s58)
  (s '%59 (@floor-%59-val s58) (@floor-%58-loc s58)))
(defund @floor-%60-val (s58)
  (xor-i32 (g '%59 (@floor-%59-loc s58)) -1))
(defund @floor-%60-loc (s58)
  (s '%60 (@floor-%60-val s58) (@floor-%59-loc s58)))
(defund @floor-%61-val (s58)
  (load-i32 (g '%i0 (@floor-%60-loc s58)) (@floor-%58-mem s58)))
(defund @floor-%61-loc (s58)
  (s '%61 (@floor-%61-val s58) (@floor-%60-loc s58)))
(defund @floor-%62-val (s58)
  (and-i32 (g '%61 (@floor-%61-loc s58)) (g '%60 (@floor-%61-loc s58))))
(defund @floor-%62-loc (s58)
  (s '%62 (@floor-%62-val s58) (@floor-%61-loc s58)))
(defund @floor-m58.1-mem (s58)
  (store-i32 (g '%62 (@floor-%62-loc s58)) (g '%i0 (@floor-%62-loc s58)) (@floor-%58-mem s58)))
(defund @floor-m58.2-mem (s58)
  (store-i32 0 (g '%i1 (@floor-%62-loc s58)) (@floor-m58.1-mem s58)))
(defund @floor-succ58-lab (s58)
  (declare (ignore s58))
  '%63)

(defund @floor-succ58-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%63 mem loc))
(defund @floor-m58.2-rev (mem loc pred)
  (@floor-succ58-rev (store-i32 0 (g '%i1 loc) mem) loc pred))
(defund @floor-m58.1-rev (mem loc pred)
  (@floor-m58.2-rev (store-i32 (g '%62 loc) (g '%i0 loc) mem) loc pred))
(defund @floor-%62-rev (mem loc pred)
  (@floor-m58.1-rev mem (s '%62 (and-i32 (g '%61 loc) (g '%60 loc)) loc) pred))
(defund @floor-%61-rev (mem loc pred)
  (@floor-%62-rev mem (s '%61 (load-i32 (g '%i0 loc) mem) loc) pred))
(defund @floor-%60-rev (mem loc pred)
  (@floor-%61-rev mem (s '%60 (xor-i32 (g '%59 loc) -1) loc) pred))
(defund @floor-%59-rev (mem loc pred)
  (@floor-%60-rev mem (s '%59 (load-i32 (g '%i loc) mem) loc) pred))

(defund @floor-%58-rev (mem loc pred)
  (@floor-%59-rev mem loc pred))

(defund @floor-%58-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%59 (load-i32 (g '%i loc) mem) loc))
    (loc (s '%60 (xor-i32 (g '%59 loc) -1) loc))
    (loc (s '%61 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%62 (and-i32 (g '%61 loc) (g '%60 loc)) loc))
    (mem (store-i32 (g '%62 loc) (g '%i0 loc) mem))
    (mem (store-i32 0 (g '%i1 loc) mem))
    (succ '%63))
  (mv succ mem loc)))

(defruled @floor-%58-expand-bb
  (equal (@floor-%58-bb mem loc pred)
         (@floor-%58-rev mem loc pred))
  :enable (@floor-%58-bb @floor-%58-rev
    @floor-%59-rev
    @floor-%60-rev
    @floor-%61-rev
    @floor-%62-rev
    @floor-m58.1-rev
    @floor-m58.2-rev
    @floor-succ58-rev)
  :disable s-diff-s)

(defund @floor-%63-mem (s63)
  (car s63))
(defund @floor-%63-loc (s63)
  (cadr s63))
(defund @floor-%63-pred (s63)
  (caddr s63))
(defund @floor-succ63-lab (s63)
  (declare (ignore s63))
  '%64)

(defund @floor-succ63-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))

(defund @floor-%63-rev (mem loc pred)
  (@floor-succ63-rev mem loc pred))

(defund @floor-%63-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%64))
  (mv succ mem loc)))

(defruled @floor-%63-expand-bb
  (equal (@floor-%63-bb mem loc pred)
         (@floor-%63-rev mem loc pred))
  :enable (@floor-%63-bb @floor-%63-rev
    @floor-succ63-rev)
  :disable s-diff-s)

(defund @floor-%64-mem (s64)
  (car s64))
(defund @floor-%64-loc (s64)
  (cadr s64))
(defund @floor-%64-pred (s64)
  (caddr s64))
(defund @floor-succ64-lab (s64)
  (declare (ignore s64))
  '%122)

(defund @floor-succ64-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%122 mem loc))

(defund @floor-%64-rev (mem loc pred)
  (@floor-succ64-rev mem loc pred))

(defund @floor-%64-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%122))
  (mv succ mem loc)))

(defruled @floor-%64-expand-bb
  (equal (@floor-%64-bb mem loc pred)
         (@floor-%64-rev mem loc pred))
  :enable (@floor-%64-bb @floor-%64-rev
    @floor-succ64-rev)
  :disable s-diff-s)

(defund @floor-%65-mem (s65)
  (car s65))
(defund @floor-%65-loc (s65)
  (cadr s65))
(defund @floor-%65-pred (s65)
  (caddr s65))
(defund @floor-%66-val (s65)
  (load-i32 (g '%j0 (@floor-%65-loc s65)) (@floor-%65-mem s65)))
(defund @floor-%66-loc (s65)
  (s '%66 (@floor-%66-val s65) (@floor-%65-loc s65)))
(defund @floor-%67-val (s65)
  (icmp-sgt-i32 (g '%66 (@floor-%66-loc s65)) 51))
(defund @floor-%67-loc (s65)
  (s '%67 (@floor-%67-val s65) (@floor-%66-loc s65)))
(defund @floor-succ65-lab (s65)
  (case (g '%67 (@floor-%67-loc s65)) (-1 '%68) (0 '%77)))

(defund @floor-succ65-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%67 loc) (-1 '%68) (0 '%77)) mem loc))
(defund @floor-%67-rev (mem loc pred)
  (@floor-succ65-rev mem (s '%67 (icmp-sgt-i32 (g '%66 loc) 51) loc) pred))
(defund @floor-%66-rev (mem loc pred)
  (@floor-%67-rev mem (s '%66 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%65-rev (mem loc pred)
  (@floor-%66-rev mem loc pred))

(defund @floor-%65-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%66 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%67 (icmp-sgt-i32 (g '%66 loc) 51) loc))
    (succ (case (g '%67 loc) (-1 '%68) (0 '%77))))
  (mv succ mem loc)))

(defruled @floor-%65-expand-bb
  (equal (@floor-%65-bb mem loc pred)
         (@floor-%65-rev mem loc pred))
  :enable (@floor-%65-bb @floor-%65-rev
    @floor-%66-rev
    @floor-%67-rev
    @floor-succ65-rev)
  :disable s-diff-s)

(defund @floor-%68-mem (s68)
  (car s68))
(defund @floor-%68-loc (s68)
  (cadr s68))
(defund @floor-%68-pred (s68)
  (caddr s68))
(defund @floor-%69-val (s68)
  (load-i32 (g '%j0 (@floor-%68-loc s68)) (@floor-%68-mem s68)))
(defund @floor-%69-loc (s68)
  (s '%69 (@floor-%69-val s68) (@floor-%68-loc s68)))
(defund @floor-%70-val (s68)
  (icmp-eq-i32 (g '%69 (@floor-%69-loc s68)) 1024))
(defund @floor-%70-loc (s68)
  (s '%70 (@floor-%70-val s68) (@floor-%69-loc s68)))
(defund @floor-succ68-lab (s68)
  (case (g '%70 (@floor-%70-loc s68)) (-1 '%71) (0 '%75)))

(defund @floor-succ68-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%70 loc) (-1 '%71) (0 '%75)) mem loc))
(defund @floor-%70-rev (mem loc pred)
  (@floor-succ68-rev mem (s '%70 (icmp-eq-i32 (g '%69 loc) 1024) loc) pred))
(defund @floor-%69-rev (mem loc pred)
  (@floor-%70-rev mem (s '%69 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%68-rev (mem loc pred)
  (@floor-%69-rev mem loc pred))

(defund @floor-%68-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%69 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%70 (icmp-eq-i32 (g '%69 loc) 1024) loc))
    (succ (case (g '%70 loc) (-1 '%71) (0 '%75))))
  (mv succ mem loc)))

(defruled @floor-%68-expand-bb
  (equal (@floor-%68-bb mem loc pred)
         (@floor-%68-rev mem loc pred))
  :enable (@floor-%68-bb @floor-%68-rev
    @floor-%69-rev
    @floor-%70-rev
    @floor-succ68-rev)
  :disable s-diff-s)

(defund @floor-%71-mem (s71)
  (car s71))
(defund @floor-%71-loc (s71)
  (cadr s71))
(defund @floor-%71-pred (s71)
  (caddr s71))
(defund @floor-%72-val (s71)
  (load-double (g '%2 (@floor-%71-loc s71)) (@floor-%71-mem s71)))
(defund @floor-%72-loc (s71)
  (s '%72 (@floor-%72-val s71) (@floor-%71-loc s71)))
(defund @floor-%73-val (s71)
  (load-double (g '%2 (@floor-%72-loc s71)) (@floor-%71-mem s71)))
(defund @floor-%73-loc (s71)
  (s '%73 (@floor-%73-val s71) (@floor-%72-loc s71)))
(defund @floor-%74-val (s71)
  (fadd-double (g '%72 (@floor-%73-loc s71)) (g '%73 (@floor-%73-loc s71))))
(defund @floor-%74-loc (s71)
  (s '%74 (@floor-%74-val s71) (@floor-%73-loc s71)))
(defund @floor-m71.1-mem (s71)
  (store-double (g '%74 (@floor-%74-loc s71)) (g '%1 (@floor-%74-loc s71)) (@floor-%71-mem s71)))
(defund @floor-succ71-lab (s71)
  (declare (ignore s71))
  '%129)

(defund @floor-succ71-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%129 mem loc))
(defund @floor-m71.1-rev (mem loc pred)
  (@floor-succ71-rev (store-double (g '%74 loc) (g '%1 loc) mem) loc pred))
(defund @floor-%74-rev (mem loc pred)
  (@floor-m71.1-rev mem (s '%74 (fadd-double (g '%72 loc) (g '%73 loc)) loc) pred))
(defund @floor-%73-rev (mem loc pred)
  (@floor-%74-rev mem (s '%73 (load-double (g '%2 loc) mem) loc) pred))
(defund @floor-%72-rev (mem loc pred)
  (@floor-%73-rev mem (s '%72 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%71-rev (mem loc pred)
  (@floor-%72-rev mem loc pred))

(defund @floor-%71-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%72 (load-double (g '%2 loc) mem) loc))
    (loc (s '%73 (load-double (g '%2 loc) mem) loc))
    (loc (s '%74 (fadd-double (g '%72 loc) (g '%73 loc)) loc))
    (mem (store-double (g '%74 loc) (g '%1 loc) mem))
    (succ '%129))
  (mv succ mem loc)))

(defruled @floor-%71-expand-bb
  (equal (@floor-%71-bb mem loc pred)
         (@floor-%71-rev mem loc pred))
  :enable (@floor-%71-bb @floor-%71-rev
    @floor-%72-rev
    @floor-%73-rev
    @floor-%74-rev
    @floor-m71.1-rev
    @floor-succ71-rev)
  :disable s-diff-s)

(defund @floor-%75-mem (s75)
  (car s75))
(defund @floor-%75-loc (s75)
  (cadr s75))
(defund @floor-%75-pred (s75)
  (caddr s75))
(defund @floor-%76-val (s75)
  (load-double (g '%2 (@floor-%75-loc s75)) (@floor-%75-mem s75)))
(defund @floor-%76-loc (s75)
  (s '%76 (@floor-%76-val s75) (@floor-%75-loc s75)))
(defund @floor-m75.1-mem (s75)
  (store-double (g '%76 (@floor-%76-loc s75)) (g '%1 (@floor-%76-loc s75)) (@floor-%75-mem s75)))
(defund @floor-succ75-lab (s75)
  (declare (ignore s75))
  '%129)

(defund @floor-succ75-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%129 mem loc))
(defund @floor-m75.1-rev (mem loc pred)
  (@floor-succ75-rev (store-double (g '%76 loc) (g '%1 loc) mem) loc pred))
(defund @floor-%76-rev (mem loc pred)
  (@floor-m75.1-rev mem (s '%76 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%75-rev (mem loc pred)
  (@floor-%76-rev mem loc pred))

(defund @floor-%75-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%76 (load-double (g '%2 loc) mem) loc))
    (mem (store-double (g '%76 loc) (g '%1 loc) mem))
    (succ '%129))
  (mv succ mem loc)))

(defruled @floor-%75-expand-bb
  (equal (@floor-%75-bb mem loc pred)
         (@floor-%75-rev mem loc pred))
  :enable (@floor-%75-bb @floor-%75-rev
    @floor-%76-rev
    @floor-m75.1-rev
    @floor-succ75-rev)
  :disable s-diff-s)

(defund @floor-%77-mem (s77)
  (car s77))
(defund @floor-%77-loc (s77)
  (cadr s77))
(defund @floor-%77-pred (s77)
  (caddr s77))
(defund @floor-%78-val (s77)
  (load-i32 (g '%j0 (@floor-%77-loc s77)) (@floor-%77-mem s77)))
(defund @floor-%78-loc (s77)
  (s '%78 (@floor-%78-val s77) (@floor-%77-loc s77)))
(defund @floor-%79-val (s77)
  (sub-i32 (g '%78 (@floor-%78-loc s77)) 20))
(defund @floor-%79-loc (s77)
  (s '%79 (@floor-%79-val s77) (@floor-%78-loc s77)))
(defund @floor-%80-val (s77)
  (lshr-i32 -1 (g '%79 (@floor-%79-loc s77))))
(defund @floor-%80-loc (s77)
  (s '%80 (@floor-%80-val s77) (@floor-%79-loc s77)))
(defund @floor-m77.1-mem (s77)
  (store-i32 (g '%80 (@floor-%80-loc s77)) (g '%i (@floor-%80-loc s77)) (@floor-%77-mem s77)))
(defund @floor-%81-val (s77)
  (load-i32 (g '%i1 (@floor-%80-loc s77)) (@floor-m77.1-mem s77)))
(defund @floor-%81-loc (s77)
  (s '%81 (@floor-%81-val s77) (@floor-%80-loc s77)))
(defund @floor-%82-val (s77)
  (load-i32 (g '%i (@floor-%81-loc s77)) (@floor-m77.1-mem s77)))
(defund @floor-%82-loc (s77)
  (s '%82 (@floor-%82-val s77) (@floor-%81-loc s77)))
(defund @floor-%83-val (s77)
  (and-i32 (g '%81 (@floor-%82-loc s77)) (g '%82 (@floor-%82-loc s77))))
(defund @floor-%83-loc (s77)
  (s '%83 (@floor-%83-val s77) (@floor-%82-loc s77)))
(defund @floor-%84-val (s77)
  (icmp-eq-i32 (g '%83 (@floor-%83-loc s77)) 0))
(defund @floor-%84-loc (s77)
  (s '%84 (@floor-%84-val s77) (@floor-%83-loc s77)))
(defund @floor-succ77-lab (s77)
  (case (g '%84 (@floor-%84-loc s77)) (-1 '%85) (0 '%87)))

(defund @floor-succ77-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%84 loc) (-1 '%85) (0 '%87)) mem loc))
(defund @floor-%84-rev (mem loc pred)
  (@floor-succ77-rev mem (s '%84 (icmp-eq-i32 (g '%83 loc) 0) loc) pred))
(defund @floor-%83-rev (mem loc pred)
  (@floor-%84-rev mem (s '%83 (and-i32 (g '%81 loc) (g '%82 loc)) loc) pred))
(defund @floor-%82-rev (mem loc pred)
  (@floor-%83-rev mem (s '%82 (load-i32 (g '%i loc) mem) loc) pred))
(defund @floor-%81-rev (mem loc pred)
  (@floor-%82-rev mem (s '%81 (load-i32 (g '%i1 loc) mem) loc) pred))
(defund @floor-m77.1-rev (mem loc pred)
  (@floor-%81-rev (store-i32 (g '%80 loc) (g '%i loc) mem) loc pred))
(defund @floor-%80-rev (mem loc pred)
  (@floor-m77.1-rev mem (s '%80 (lshr-i32 -1 (g '%79 loc)) loc) pred))
(defund @floor-%79-rev (mem loc pred)
  (@floor-%80-rev mem (s '%79 (sub-i32 (g '%78 loc) 20) loc) pred))
(defund @floor-%78-rev (mem loc pred)
  (@floor-%79-rev mem (s '%78 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%77-rev (mem loc pred)
  (@floor-%78-rev mem loc pred))

(defund @floor-%77-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%78 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%79 (sub-i32 (g '%78 loc) 20) loc))
    (loc (s '%80 (lshr-i32 -1 (g '%79 loc)) loc))
    (mem (store-i32 (g '%80 loc) (g '%i loc) mem))
    (loc (s '%81 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%82 (load-i32 (g '%i loc) mem) loc))
    (loc (s '%83 (and-i32 (g '%81 loc) (g '%82 loc)) loc))
    (loc (s '%84 (icmp-eq-i32 (g '%83 loc) 0) loc))
    (succ (case (g '%84 loc) (-1 '%85) (0 '%87))))
  (mv succ mem loc)))

(defruled @floor-%77-expand-bb
  (equal (@floor-%77-bb mem loc pred)
         (@floor-%77-rev mem loc pred))
  :enable (@floor-%77-bb @floor-%77-rev
    @floor-%78-rev
    @floor-%79-rev
    @floor-%80-rev
    @floor-m77.1-rev
    @floor-%81-rev
    @floor-%82-rev
    @floor-%83-rev
    @floor-%84-rev
    @floor-succ77-rev)
  :disable s-diff-s)

(defund @floor-%85-mem (s85)
  (car s85))
(defund @floor-%85-loc (s85)
  (cadr s85))
(defund @floor-%85-pred (s85)
  (caddr s85))
(defund @floor-%86-val (s85)
  (load-double (g '%2 (@floor-%85-loc s85)) (@floor-%85-mem s85)))
(defund @floor-%86-loc (s85)
  (s '%86 (@floor-%86-val s85) (@floor-%85-loc s85)))
(defund @floor-m85.1-mem (s85)
  (store-double (g '%86 (@floor-%86-loc s85)) (g '%1 (@floor-%86-loc s85)) (@floor-%85-mem s85)))
(defund @floor-succ85-lab (s85)
  (declare (ignore s85))
  '%129)

(defund @floor-succ85-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%129 mem loc))
(defund @floor-m85.1-rev (mem loc pred)
  (@floor-succ85-rev (store-double (g '%86 loc) (g '%1 loc) mem) loc pred))
(defund @floor-%86-rev (mem loc pred)
  (@floor-m85.1-rev mem (s '%86 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%85-rev (mem loc pred)
  (@floor-%86-rev mem loc pred))

(defund @floor-%85-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%86 (load-double (g '%2 loc) mem) loc))
    (mem (store-double (g '%86 loc) (g '%1 loc) mem))
    (succ '%129))
  (mv succ mem loc)))

(defruled @floor-%85-expand-bb
  (equal (@floor-%85-bb mem loc pred)
         (@floor-%85-rev mem loc pred))
  :enable (@floor-%85-bb @floor-%85-rev
    @floor-%86-rev
    @floor-m85.1-rev
    @floor-succ85-rev)
  :disable s-diff-s)

(defund @floor-%87-mem (s87)
  (car s87))
(defund @floor-%87-loc (s87)
  (cadr s87))
(defund @floor-%87-pred (s87)
  (caddr s87))
(defund @floor-%88-val (s87)
  (load-double (g '%2 (@floor-%87-loc s87)) (@floor-%87-mem s87)))
(defund @floor-%88-loc (s87)
  (s '%88 (@floor-%88-val s87) (@floor-%87-loc s87)))
(defund @floor-%89-val (s87)
  (fadd-double #x7e37e43c8800759c (g '%88 (@floor-%88-loc s87))))
(defund @floor-%89-loc (s87)
  (s '%89 (@floor-%89-val s87) (@floor-%88-loc s87)))
(defund @floor-%90-val (s87)
  (fcmp-ogt-double (g '%89 (@floor-%89-loc s87)) #x0000000000000000))
(defund @floor-%90-loc (s87)
  (s '%90 (@floor-%90-val s87) (@floor-%89-loc s87)))
(defund @floor-succ87-lab (s87)
  (case (g '%90 (@floor-%90-loc s87)) (-1 '%91) (0 '%120)))

(defund @floor-succ87-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%90 loc) (-1 '%91) (0 '%120)) mem loc))
(defund @floor-%90-rev (mem loc pred)
  (@floor-succ87-rev mem (s '%90 (fcmp-ogt-double (g '%89 loc) #x0000000000000000) loc) pred))
(defund @floor-%89-rev (mem loc pred)
  (@floor-%90-rev mem (s '%89 (fadd-double #x7e37e43c8800759c (g '%88 loc)) loc) pred))
(defund @floor-%88-rev (mem loc pred)
  (@floor-%89-rev mem (s '%88 (load-double (g '%2 loc) mem) loc) pred))

(defund @floor-%87-rev (mem loc pred)
  (@floor-%88-rev mem loc pred))

(defund @floor-%87-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%88 (load-double (g '%2 loc) mem) loc))
    (loc (s '%89 (fadd-double #x7e37e43c8800759c (g '%88 loc)) loc))
    (loc (s '%90 (fcmp-ogt-double (g '%89 loc) #x0000000000000000) loc))
    (succ (case (g '%90 loc) (-1 '%91) (0 '%120))))
  (mv succ mem loc)))

(defruled @floor-%87-expand-bb
  (equal (@floor-%87-bb mem loc pred)
         (@floor-%87-rev mem loc pred))
  :enable (@floor-%87-bb @floor-%87-rev
    @floor-%88-rev
    @floor-%89-rev
    @floor-%90-rev
    @floor-succ87-rev)
  :disable s-diff-s)

(defund @floor-%91-mem (s91)
  (car s91))
(defund @floor-%91-loc (s91)
  (cadr s91))
(defund @floor-%91-pred (s91)
  (caddr s91))
(defund @floor-%92-val (s91)
  (load-i32 (g '%i0 (@floor-%91-loc s91)) (@floor-%91-mem s91)))
(defund @floor-%92-loc (s91)
  (s '%92 (@floor-%92-val s91) (@floor-%91-loc s91)))
(defund @floor-%93-val (s91)
  (icmp-slt-i32 (g '%92 (@floor-%92-loc s91)) 0))
(defund @floor-%93-loc (s91)
  (s '%93 (@floor-%93-val s91) (@floor-%92-loc s91)))
(defund @floor-succ91-lab (s91)
  (case (g '%93 (@floor-%93-loc s91)) (-1 '%94) (0 '%115)))

(defund @floor-succ91-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%93 loc) (-1 '%94) (0 '%115)) mem loc))
(defund @floor-%93-rev (mem loc pred)
  (@floor-succ91-rev mem (s '%93 (icmp-slt-i32 (g '%92 loc) 0) loc) pred))
(defund @floor-%92-rev (mem loc pred)
  (@floor-%93-rev mem (s '%92 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%91-rev (mem loc pred)
  (@floor-%92-rev mem loc pred))

(defund @floor-%91-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%92 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%93 (icmp-slt-i32 (g '%92 loc) 0) loc))
    (succ (case (g '%93 loc) (-1 '%94) (0 '%115))))
  (mv succ mem loc)))

(defruled @floor-%91-expand-bb
  (equal (@floor-%91-bb mem loc pred)
         (@floor-%91-rev mem loc pred))
  :enable (@floor-%91-bb @floor-%91-rev
    @floor-%92-rev
    @floor-%93-rev
    @floor-succ91-rev)
  :disable s-diff-s)

(defund @floor-%94-mem (s94)
  (car s94))
(defund @floor-%94-loc (s94)
  (cadr s94))
(defund @floor-%94-pred (s94)
  (caddr s94))
(defund @floor-%95-val (s94)
  (load-i32 (g '%j0 (@floor-%94-loc s94)) (@floor-%94-mem s94)))
(defund @floor-%95-loc (s94)
  (s '%95 (@floor-%95-val s94) (@floor-%94-loc s94)))
(defund @floor-%96-val (s94)
  (icmp-eq-i32 (g '%95 (@floor-%95-loc s94)) 20))
(defund @floor-%96-loc (s94)
  (s '%96 (@floor-%96-val s94) (@floor-%95-loc s94)))
(defund @floor-succ94-lab (s94)
  (case (g '%96 (@floor-%96-loc s94)) (-1 '%97) (0 '%100)))

(defund @floor-succ94-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%96 loc) (-1 '%97) (0 '%100)) mem loc))
(defund @floor-%96-rev (mem loc pred)
  (@floor-succ94-rev mem (s '%96 (icmp-eq-i32 (g '%95 loc) 20) loc) pred))
(defund @floor-%95-rev (mem loc pred)
  (@floor-%96-rev mem (s '%95 (load-i32 (g '%j0 loc) mem) loc) pred))

(defund @floor-%94-rev (mem loc pred)
  (@floor-%95-rev mem loc pred))

(defund @floor-%94-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%95 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%96 (icmp-eq-i32 (g '%95 loc) 20) loc))
    (succ (case (g '%96 loc) (-1 '%97) (0 '%100))))
  (mv succ mem loc)))

(defruled @floor-%94-expand-bb
  (equal (@floor-%94-bb mem loc pred)
         (@floor-%94-rev mem loc pred))
  :enable (@floor-%94-bb @floor-%94-rev
    @floor-%95-rev
    @floor-%96-rev
    @floor-succ94-rev)
  :disable s-diff-s)

(defund @floor-%97-mem (s97)
  (car s97))
(defund @floor-%97-loc (s97)
  (cadr s97))
(defund @floor-%97-pred (s97)
  (caddr s97))
(defund @floor-%98-val (s97)
  (load-i32 (g '%i0 (@floor-%97-loc s97)) (@floor-%97-mem s97)))
(defund @floor-%98-loc (s97)
  (s '%98 (@floor-%98-val s97) (@floor-%97-loc s97)))
(defund @floor-%99-val (s97)
  (add-i32 (g '%98 (@floor-%98-loc s97)) 1))
(defund @floor-%99-loc (s97)
  (s '%99 (@floor-%99-val s97) (@floor-%98-loc s97)))
(defund @floor-m97.1-mem (s97)
  (store-i32 (g '%99 (@floor-%99-loc s97)) (g '%i0 (@floor-%99-loc s97)) (@floor-%97-mem s97)))
(defund @floor-succ97-lab (s97)
  (declare (ignore s97))
  '%114)

(defund @floor-succ97-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%114 mem loc))
(defund @floor-m97.1-rev (mem loc pred)
  (@floor-succ97-rev (store-i32 (g '%99 loc) (g '%i0 loc) mem) loc pred))
(defund @floor-%99-rev (mem loc pred)
  (@floor-m97.1-rev mem (s '%99 (add-i32 (g '%98 loc) 1) loc) pred))
(defund @floor-%98-rev (mem loc pred)
  (@floor-%99-rev mem (s '%98 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%97-rev (mem loc pred)
  (@floor-%98-rev mem loc pred))

(defund @floor-%97-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%98 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%99 (add-i32 (g '%98 loc) 1) loc))
    (mem (store-i32 (g '%99 loc) (g '%i0 loc) mem))
    (succ '%114))
  (mv succ mem loc)))

(defruled @floor-%97-expand-bb
  (equal (@floor-%97-bb mem loc pred)
         (@floor-%97-rev mem loc pred))
  :enable (@floor-%97-bb @floor-%97-rev
    @floor-%98-rev
    @floor-%99-rev
    @floor-m97.1-rev
    @floor-succ97-rev)
  :disable s-diff-s)

(defund @floor-%100-mem (s100)
  (car s100))
(defund @floor-%100-loc (s100)
  (cadr s100))
(defund @floor-%100-pred (s100)
  (caddr s100))
(defund @floor-%101-val (s100)
  (load-i32 (g '%i1 (@floor-%100-loc s100)) (@floor-%100-mem s100)))
(defund @floor-%101-loc (s100)
  (s '%101 (@floor-%101-val s100) (@floor-%100-loc s100)))
(defund @floor-%102-val (s100)
  (load-i32 (g '%j0 (@floor-%101-loc s100)) (@floor-%100-mem s100)))
(defund @floor-%102-loc (s100)
  (s '%102 (@floor-%102-val s100) (@floor-%101-loc s100)))
(defund @floor-%103-val (s100)
  (sub-i32 52 (g '%102 (@floor-%102-loc s100))))
(defund @floor-%103-loc (s100)
  (s '%103 (@floor-%103-val s100) (@floor-%102-loc s100)))
(defund @floor-%104-val (s100)
  (shl-i32 1 (g '%103 (@floor-%103-loc s100))))
(defund @floor-%104-loc (s100)
  (s '%104 (@floor-%104-val s100) (@floor-%103-loc s100)))
(defund @floor-%105-val (s100)
  (add-i32 (g '%101 (@floor-%104-loc s100)) (g '%104 (@floor-%104-loc s100))))
(defund @floor-%105-loc (s100)
  (s '%105 (@floor-%105-val s100) (@floor-%104-loc s100)))
(defund @floor-m100.1-mem (s100)
  (store-i32 (g '%105 (@floor-%105-loc s100)) (g '%j (@floor-%105-loc s100)) (@floor-%100-mem s100)))
(defund @floor-%106-val (s100)
  (load-i32 (g '%j (@floor-%105-loc s100)) (@floor-m100.1-mem s100)))
(defund @floor-%106-loc (s100)
  (s '%106 (@floor-%106-val s100) (@floor-%105-loc s100)))
(defund @floor-%107-val (s100)
  (load-i32 (g '%i1 (@floor-%106-loc s100)) (@floor-m100.1-mem s100)))
(defund @floor-%107-loc (s100)
  (s '%107 (@floor-%107-val s100) (@floor-%106-loc s100)))
(defund @floor-%108-val (s100)
  (icmp-ult-i32 (g '%106 (@floor-%107-loc s100)) (g '%107 (@floor-%107-loc s100))))
(defund @floor-%108-loc (s100)
  (s '%108 (@floor-%108-val s100) (@floor-%107-loc s100)))
(defund @floor-succ100-lab (s100)
  (case (g '%108 (@floor-%108-loc s100)) (-1 '%109) (0 '%112)))

(defund @floor-succ100-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%108 loc) (-1 '%109) (0 '%112)) mem loc))
(defund @floor-%108-rev (mem loc pred)
  (@floor-succ100-rev mem (s '%108 (icmp-ult-i32 (g '%106 loc) (g '%107 loc)) loc) pred))
(defund @floor-%107-rev (mem loc pred)
  (@floor-%108-rev mem (s '%107 (load-i32 (g '%i1 loc) mem) loc) pred))
(defund @floor-%106-rev (mem loc pred)
  (@floor-%107-rev mem (s '%106 (load-i32 (g '%j loc) mem) loc) pred))
(defund @floor-m100.1-rev (mem loc pred)
  (@floor-%106-rev (store-i32 (g '%105 loc) (g '%j loc) mem) loc pred))
(defund @floor-%105-rev (mem loc pred)
  (@floor-m100.1-rev mem (s '%105 (add-i32 (g '%101 loc) (g '%104 loc)) loc) pred))
(defund @floor-%104-rev (mem loc pred)
  (@floor-%105-rev mem (s '%104 (shl-i32 1 (g '%103 loc)) loc) pred))
(defund @floor-%103-rev (mem loc pred)
  (@floor-%104-rev mem (s '%103 (sub-i32 52 (g '%102 loc)) loc) pred))
(defund @floor-%102-rev (mem loc pred)
  (@floor-%103-rev mem (s '%102 (load-i32 (g '%j0 loc) mem) loc) pred))
(defund @floor-%101-rev (mem loc pred)
  (@floor-%102-rev mem (s '%101 (load-i32 (g '%i1 loc) mem) loc) pred))

(defund @floor-%100-rev (mem loc pred)
  (@floor-%101-rev mem loc pred))

(defund @floor-%100-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%101 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%102 (load-i32 (g '%j0 loc) mem) loc))
    (loc (s '%103 (sub-i32 52 (g '%102 loc)) loc))
    (loc (s '%104 (shl-i32 1 (g '%103 loc)) loc))
    (loc (s '%105 (add-i32 (g '%101 loc) (g '%104 loc)) loc))
    (mem (store-i32 (g '%105 loc) (g '%j loc) mem))
    (loc (s '%106 (load-i32 (g '%j loc) mem) loc))
    (loc (s '%107 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%108 (icmp-ult-i32 (g '%106 loc) (g '%107 loc)) loc))
    (succ (case (g '%108 loc) (-1 '%109) (0 '%112))))
  (mv succ mem loc)))

(defruled @floor-%100-expand-bb
  (equal (@floor-%100-bb mem loc pred)
         (@floor-%100-rev mem loc pred))
  :enable (@floor-%100-bb @floor-%100-rev
    @floor-%101-rev
    @floor-%102-rev
    @floor-%103-rev
    @floor-%104-rev
    @floor-%105-rev
    @floor-m100.1-rev
    @floor-%106-rev
    @floor-%107-rev
    @floor-%108-rev
    @floor-succ100-rev)
  :disable s-diff-s)

(defund @floor-%109-mem (s109)
  (car s109))
(defund @floor-%109-loc (s109)
  (cadr s109))
(defund @floor-%109-pred (s109)
  (caddr s109))
(defund @floor-%110-val (s109)
  (load-i32 (g '%i0 (@floor-%109-loc s109)) (@floor-%109-mem s109)))
(defund @floor-%110-loc (s109)
  (s '%110 (@floor-%110-val s109) (@floor-%109-loc s109)))
(defund @floor-%111-val (s109)
  (add-i32 (g '%110 (@floor-%110-loc s109)) 1))
(defund @floor-%111-loc (s109)
  (s '%111 (@floor-%111-val s109) (@floor-%110-loc s109)))
(defund @floor-m109.1-mem (s109)
  (store-i32 (g '%111 (@floor-%111-loc s109)) (g '%i0 (@floor-%111-loc s109)) (@floor-%109-mem s109)))
(defund @floor-succ109-lab (s109)
  (declare (ignore s109))
  '%112)

(defund @floor-succ109-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%112 mem loc))
(defund @floor-m109.1-rev (mem loc pred)
  (@floor-succ109-rev (store-i32 (g '%111 loc) (g '%i0 loc) mem) loc pred))
(defund @floor-%111-rev (mem loc pred)
  (@floor-m109.1-rev mem (s '%111 (add-i32 (g '%110 loc) 1) loc) pred))
(defund @floor-%110-rev (mem loc pred)
  (@floor-%111-rev mem (s '%110 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%109-rev (mem loc pred)
  (@floor-%110-rev mem loc pred))

(defund @floor-%109-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%110 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%111 (add-i32 (g '%110 loc) 1) loc))
    (mem (store-i32 (g '%111 loc) (g '%i0 loc) mem))
    (succ '%112))
  (mv succ mem loc)))

(defruled @floor-%109-expand-bb
  (equal (@floor-%109-bb mem loc pred)
         (@floor-%109-rev mem loc pred))
  :enable (@floor-%109-bb @floor-%109-rev
    @floor-%110-rev
    @floor-%111-rev
    @floor-m109.1-rev
    @floor-succ109-rev)
  :disable s-diff-s)

(defund @floor-%112-mem (s112)
  (car s112))
(defund @floor-%112-loc (s112)
  (cadr s112))
(defund @floor-%112-pred (s112)
  (caddr s112))
(defund @floor-%113-val (s112)
  (load-i32 (g '%j (@floor-%112-loc s112)) (@floor-%112-mem s112)))
(defund @floor-%113-loc (s112)
  (s '%113 (@floor-%113-val s112) (@floor-%112-loc s112)))
(defund @floor-m112.1-mem (s112)
  (store-i32 (g '%113 (@floor-%113-loc s112)) (g '%i1 (@floor-%113-loc s112)) (@floor-%112-mem s112)))
(defund @floor-succ112-lab (s112)
  (declare (ignore s112))
  '%114)

(defund @floor-succ112-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%114 mem loc))
(defund @floor-m112.1-rev (mem loc pred)
  (@floor-succ112-rev (store-i32 (g '%113 loc) (g '%i1 loc) mem) loc pred))
(defund @floor-%113-rev (mem loc pred)
  (@floor-m112.1-rev mem (s '%113 (load-i32 (g '%j loc) mem) loc) pred))

(defund @floor-%112-rev (mem loc pred)
  (@floor-%113-rev mem loc pred))

(defund @floor-%112-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%113 (load-i32 (g '%j loc) mem) loc))
    (mem (store-i32 (g '%113 loc) (g '%i1 loc) mem))
    (succ '%114))
  (mv succ mem loc)))

(defruled @floor-%112-expand-bb
  (equal (@floor-%112-bb mem loc pred)
         (@floor-%112-rev mem loc pred))
  :enable (@floor-%112-bb @floor-%112-rev
    @floor-%113-rev
    @floor-m112.1-rev
    @floor-succ112-rev)
  :disable s-diff-s)

(defund @floor-%114-mem (s114)
  (car s114))
(defund @floor-%114-loc (s114)
  (cadr s114))
(defund @floor-%114-pred (s114)
  (caddr s114))
(defund @floor-succ114-lab (s114)
  (declare (ignore s114))
  '%115)

(defund @floor-succ114-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%115 mem loc))

(defund @floor-%114-rev (mem loc pred)
  (@floor-succ114-rev mem loc pred))

(defund @floor-%114-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%115))
  (mv succ mem loc)))

(defruled @floor-%114-expand-bb
  (equal (@floor-%114-bb mem loc pred)
         (@floor-%114-rev mem loc pred))
  :enable (@floor-%114-bb @floor-%114-rev
    @floor-succ114-rev)
  :disable s-diff-s)

(defund @floor-%115-mem (s115)
  (car s115))
(defund @floor-%115-loc (s115)
  (cadr s115))
(defund @floor-%115-pred (s115)
  (caddr s115))
(defund @floor-%116-val (s115)
  (load-i32 (g '%i (@floor-%115-loc s115)) (@floor-%115-mem s115)))
(defund @floor-%116-loc (s115)
  (s '%116 (@floor-%116-val s115) (@floor-%115-loc s115)))
(defund @floor-%117-val (s115)
  (xor-i32 (g '%116 (@floor-%116-loc s115)) -1))
(defund @floor-%117-loc (s115)
  (s '%117 (@floor-%117-val s115) (@floor-%116-loc s115)))
(defund @floor-%118-val (s115)
  (load-i32 (g '%i1 (@floor-%117-loc s115)) (@floor-%115-mem s115)))
(defund @floor-%118-loc (s115)
  (s '%118 (@floor-%118-val s115) (@floor-%117-loc s115)))
(defund @floor-%119-val (s115)
  (and-i32 (g '%118 (@floor-%118-loc s115)) (g '%117 (@floor-%118-loc s115))))
(defund @floor-%119-loc (s115)
  (s '%119 (@floor-%119-val s115) (@floor-%118-loc s115)))
(defund @floor-m115.1-mem (s115)
  (store-i32 (g '%119 (@floor-%119-loc s115)) (g '%i1 (@floor-%119-loc s115)) (@floor-%115-mem s115)))
(defund @floor-succ115-lab (s115)
  (declare (ignore s115))
  '%120)

(defund @floor-succ115-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%120 mem loc))
(defund @floor-m115.1-rev (mem loc pred)
  (@floor-succ115-rev (store-i32 (g '%119 loc) (g '%i1 loc) mem) loc pred))
(defund @floor-%119-rev (mem loc pred)
  (@floor-m115.1-rev mem (s '%119 (and-i32 (g '%118 loc) (g '%117 loc)) loc) pred))
(defund @floor-%118-rev (mem loc pred)
  (@floor-%119-rev mem (s '%118 (load-i32 (g '%i1 loc) mem) loc) pred))
(defund @floor-%117-rev (mem loc pred)
  (@floor-%118-rev mem (s '%117 (xor-i32 (g '%116 loc) -1) loc) pred))
(defund @floor-%116-rev (mem loc pred)
  (@floor-%117-rev mem (s '%116 (load-i32 (g '%i loc) mem) loc) pred))

(defund @floor-%115-rev (mem loc pred)
  (@floor-%116-rev mem loc pred))

(defund @floor-%115-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%116 (load-i32 (g '%i loc) mem) loc))
    (loc (s '%117 (xor-i32 (g '%116 loc) -1) loc))
    (loc (s '%118 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%119 (and-i32 (g '%118 loc) (g '%117 loc)) loc))
    (mem (store-i32 (g '%119 loc) (g '%i1 loc) mem))
    (succ '%120))
  (mv succ mem loc)))

(defruled @floor-%115-expand-bb
  (equal (@floor-%115-bb mem loc pred)
         (@floor-%115-rev mem loc pred))
  :enable (@floor-%115-bb @floor-%115-rev
    @floor-%116-rev
    @floor-%117-rev
    @floor-%118-rev
    @floor-%119-rev
    @floor-m115.1-rev
    @floor-succ115-rev)
  :disable s-diff-s)

(defund @floor-%120-mem (s120)
  (car s120))
(defund @floor-%120-loc (s120)
  (cadr s120))
(defund @floor-%120-pred (s120)
  (caddr s120))
(defund @floor-succ120-lab (s120)
  (declare (ignore s120))
  '%121)

(defund @floor-succ120-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%121 mem loc))

(defund @floor-%120-rev (mem loc pred)
  (@floor-succ120-rev mem loc pred))

(defund @floor-%120-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%121))
  (mv succ mem loc)))

(defruled @floor-%120-expand-bb
  (equal (@floor-%120-bb mem loc pred)
         (@floor-%120-rev mem loc pred))
  :enable (@floor-%120-bb @floor-%120-rev
    @floor-succ120-rev)
  :disable s-diff-s)

(defund @floor-%121-mem (s121)
  (car s121))
(defund @floor-%121-loc (s121)
  (cadr s121))
(defund @floor-%121-pred (s121)
  (caddr s121))
(defund @floor-succ121-lab (s121)
  (declare (ignore s121))
  '%122)

(defund @floor-succ121-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%122 mem loc))

(defund @floor-%121-rev (mem loc pred)
  (@floor-succ121-rev mem loc pred))

(defund @floor-%121-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%122))
  (mv succ mem loc)))

(defruled @floor-%121-expand-bb
  (equal (@floor-%121-bb mem loc pred)
         (@floor-%121-rev mem loc pred))
  :enable (@floor-%121-bb @floor-%121-rev
    @floor-succ121-rev)
  :disable s-diff-s)

(defund @floor-%122-mem (s122)
  (car s122))
(defund @floor-%122-loc (s122)
  (cadr s122))
(defund @floor-%122-pred (s122)
  (caddr s122))
(defund @floor-%123-val (s122)
  (load-i32 (g '%i0 (@floor-%122-loc s122)) (@floor-%122-mem s122)))
(defund @floor-%123-loc (s122)
  (s '%123 (@floor-%123-val s122) (@floor-%122-loc s122)))
(defund @floor-%124-val (s122)
  (bitcast-double*-to-i32* (g '%2 (@floor-%123-loc s122))))
(defund @floor-%124-loc (s122)
  (s '%124 (@floor-%124-val s122) (@floor-%123-loc s122)))
(defund @floor-%125-val (s122)
  (getelementptr-i32 (g '%124 (@floor-%124-loc s122)) 1))
(defund @floor-%125-loc (s122)
  (s '%125 (@floor-%125-val s122) (@floor-%124-loc s122)))
(defund @floor-m122.1-mem (s122)
  (store-i32 (g '%123 (@floor-%125-loc s122)) (g '%125 (@floor-%125-loc s122)) (@floor-%122-mem s122)))
(defund @floor-%126-val (s122)
  (load-i32 (g '%i1 (@floor-%125-loc s122)) (@floor-m122.1-mem s122)))
(defund @floor-%126-loc (s122)
  (s '%126 (@floor-%126-val s122) (@floor-%125-loc s122)))
(defund @floor-%127-val (s122)
  (bitcast-double*-to-i32* (g '%2 (@floor-%126-loc s122))))
(defund @floor-%127-loc (s122)
  (s '%127 (@floor-%127-val s122) (@floor-%126-loc s122)))
(defund @floor-m122.2-mem (s122)
  (store-i32 (g '%126 (@floor-%127-loc s122)) (g '%127 (@floor-%127-loc s122)) (@floor-m122.1-mem s122)))
(defund @floor-%128-val (s122)
  (load-double (g '%2 (@floor-%127-loc s122)) (@floor-m122.2-mem s122)))
(defund @floor-%128-loc (s122)
  (s '%128 (@floor-%128-val s122) (@floor-%127-loc s122)))
(defund @floor-m122.3-mem (s122)
  (store-double (g '%128 (@floor-%128-loc s122)) (g '%1 (@floor-%128-loc s122)) (@floor-m122.2-mem s122)))
(defund @floor-succ122-lab (s122)
  (declare (ignore s122))
  '%129)

(defund @floor-succ122-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%129 mem loc))
(defund @floor-m122.3-rev (mem loc pred)
  (@floor-succ122-rev (store-double (g '%128 loc) (g '%1 loc) mem) loc pred))
(defund @floor-%128-rev (mem loc pred)
  (@floor-m122.3-rev mem (s '%128 (load-double (g '%2 loc) mem) loc) pred))
(defund @floor-m122.2-rev (mem loc pred)
  (@floor-%128-rev (store-i32 (g '%126 loc) (g '%127 loc) mem) loc pred))
(defund @floor-%127-rev (mem loc pred)
  (@floor-m122.2-rev mem (s '%127 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @floor-%126-rev (mem loc pred)
  (@floor-%127-rev mem (s '%126 (load-i32 (g '%i1 loc) mem) loc) pred))
(defund @floor-m122.1-rev (mem loc pred)
  (@floor-%126-rev (store-i32 (g '%123 loc) (g '%125 loc) mem) loc pred))
(defund @floor-%125-rev (mem loc pred)
  (@floor-m122.1-rev mem (s '%125 (getelementptr-i32 (g '%124 loc) 1) loc) pred))
(defund @floor-%124-rev (mem loc pred)
  (@floor-%125-rev mem (s '%124 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @floor-%123-rev (mem loc pred)
  (@floor-%124-rev mem (s '%123 (load-i32 (g '%i0 loc) mem) loc) pred))

(defund @floor-%122-rev (mem loc pred)
  (@floor-%123-rev mem loc pred))

(defund @floor-%122-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%123 (load-i32 (g '%i0 loc) mem) loc))
    (loc (s '%124 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%125 (getelementptr-i32 (g '%124 loc) 1) loc))
    (mem (store-i32 (g '%123 loc) (g '%125 loc) mem))
    (loc (s '%126 (load-i32 (g '%i1 loc) mem) loc))
    (loc (s '%127 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (mem (store-i32 (g '%126 loc) (g '%127 loc) mem))
    (loc (s '%128 (load-double (g '%2 loc) mem) loc))
    (mem (store-double (g '%128 loc) (g '%1 loc) mem))
    (succ '%129))
  (mv succ mem loc)))

(defruled @floor-%122-expand-bb
  (equal (@floor-%122-bb mem loc pred)
         (@floor-%122-rev mem loc pred))
  :enable (@floor-%122-bb @floor-%122-rev
    @floor-%123-rev
    @floor-%124-rev
    @floor-%125-rev
    @floor-m122.1-rev
    @floor-%126-rev
    @floor-%127-rev
    @floor-m122.2-rev
    @floor-%128-rev
    @floor-m122.3-rev
    @floor-succ122-rev)
  :disable s-diff-s)

(defund @floor-%129-mem (s129)
  (car s129))
(defund @floor-%129-loc (s129)
  (cadr s129))
(defund @floor-%129-pred (s129)
  (caddr s129))
(defund @floor-%130-val (s129)
  (load-double (g '%1 (@floor-%129-loc s129)) (@floor-%129-mem s129)))
(defund @floor-%130-loc (s129)
  (s '%130 (@floor-%130-val s129) (@floor-%129-loc s129)))
(defund @floor-succ129-lab (s129)
  (declare (ignore s129))
  'ret)

(defund @floor-succ129-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @floor-%130-rev (mem loc pred)
  (@floor-succ129-rev mem (s '%130 (load-double (g '%1 loc) mem) loc) pred))

(defund @floor-%129-rev (mem loc pred)
  (@floor-%130-rev mem loc pred))

(defund @floor-%129-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%130 (load-double (g '%1 loc) mem) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @floor-%129-expand-bb
  (equal (@floor-%129-bb mem loc pred)
         (@floor-%129-rev mem loc pred))
  :enable (@floor-%129-bb @floor-%129-rev
    @floor-%130-rev
    @floor-succ129-rev)
  :disable s-diff-s)

(defund @floor-step (label mem loc pred)
  (case label
    (%0 (@floor-%0-bb mem loc pred))
    (%14 (@floor-%14-bb mem loc pred))
    (%17 (@floor-%17-bb mem loc pred))
    (%21 (@floor-%21-bb mem loc pred))
    (%24 (@floor-%24-bb mem loc pred))
    (%25 (@floor-%25-bb mem loc pred))
    (%31 (@floor-%31-bb mem loc pred))
    (%32 (@floor-%32-bb mem loc pred))
    (%33 (@floor-%33-bb mem loc pred))
    (%34 (@floor-%34-bb mem loc pred))
    (%35 (@floor-%35-bb mem loc pred))
    (%44 (@floor-%44-bb mem loc pred))
    (%46 (@floor-%46-bb mem loc pred))
    (%50 (@floor-%50-bb mem loc pred))
    (%53 (@floor-%53-bb mem loc pred))
    (%58 (@floor-%58-bb mem loc pred))
    (%63 (@floor-%63-bb mem loc pred))
    (%64 (@floor-%64-bb mem loc pred))
    (%65 (@floor-%65-bb mem loc pred))
    (%68 (@floor-%68-bb mem loc pred))
    (%71 (@floor-%71-bb mem loc pred))
    (%75 (@floor-%75-bb mem loc pred))
    (%77 (@floor-%77-bb mem loc pred))
    (%85 (@floor-%85-bb mem loc pred))
    (%87 (@floor-%87-bb mem loc pred))
    (%91 (@floor-%91-bb mem loc pred))
    (%94 (@floor-%94-bb mem loc pred))
    (%97 (@floor-%97-bb mem loc pred))
    (%100 (@floor-%100-bb mem loc pred))
    (%109 (@floor-%109-bb mem loc pred))
    (%112 (@floor-%112-bb mem loc pred))
    (%114 (@floor-%114-bb mem loc pred))
    (%115 (@floor-%115-bb mem loc pred))
    (%120 (@floor-%120-bb mem loc pred))
    (%121 (@floor-%121-bb mem loc pred))
    (%122 (@floor-%122-bb mem loc pred))
    (%129 (@floor-%129-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @floor-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%130 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@floor-step label mem loc pred)
        (@floor-steps new-label new-mem new-loc label (1- n))))))

(defund @floor (%x)
  (declare (ignore %x))
   nil)
