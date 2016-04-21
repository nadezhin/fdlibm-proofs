(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")

(defconst *__kernel_sin-globals* '())

(defconst *__kernel_sin-labels* '(%0 %11 %15 %17 %18 %39 %48 %64))

(defund @__kernel_sin-%0-mem (s0)
  (car s0))
(defund @__kernel_sin-%0-loc (s0)
  (cadr s0))
(defund @__kernel_sin-%0-pred (s0)
  (caddr s0))
(defund @__kernel_sin-%1-mem (s0)
  (alloca-double 'ret 1 (@__kernel_sin-%0-mem s0)))
(defund @__kernel_sin-%1-loc (s0)
  (s '%1 '(ret . 0) (@__kernel_sin-%0-loc s0)))
(defund @__kernel_sin-%2-mem (s0)
  (alloca-double 'x 1 (@__kernel_sin-%1-mem s0)))
(defund @__kernel_sin-%2-loc (s0)
  (s '%2 '(x . 0) (@__kernel_sin-%1-loc s0)))
(defund @__kernel_sin-%3-mem (s0)
  (alloca-double 'y 1 (@__kernel_sin-%2-mem s0)))
(defund @__kernel_sin-%3-loc (s0)
  (s '%3 '(y . 0) (@__kernel_sin-%2-loc s0)))
(defund @__kernel_sin-%4-mem (s0)
  (alloca-i32 'iy 1 (@__kernel_sin-%3-mem s0)))
(defund @__kernel_sin-%4-loc (s0)
  (s '%4 '(iy . 0) (@__kernel_sin-%3-loc s0)))
(defund @__kernel_sin-%z-mem (s0)
  (alloca-double 'z 1 (@__kernel_sin-%4-mem s0)))
(defund @__kernel_sin-%z-loc (s0)
  (s '%z '(z . 0) (@__kernel_sin-%4-loc s0)))
(defund @__kernel_sin-%r-mem (s0)
  (alloca-double 'r 1 (@__kernel_sin-%z-mem s0)))
(defund @__kernel_sin-%r-loc (s0)
  (s '%r '(r . 0) (@__kernel_sin-%z-loc s0)))
(defund @__kernel_sin-%v-mem (s0)
  (alloca-double 'v 1 (@__kernel_sin-%r-mem s0)))
(defund @__kernel_sin-%v-loc (s0)
  (s '%v '(v . 0) (@__kernel_sin-%r-loc s0)))
(defund @__kernel_sin-%ix-mem (s0)
  (alloca-i32 'ix 1 (@__kernel_sin-%v-mem s0)))
(defund @__kernel_sin-%ix-loc (s0)
  (s '%ix '(ix . 0) (@__kernel_sin-%v-loc s0)))
(defund @__kernel_sin-m0.1-mem (s0)
  (store-double (g '%x (@__kernel_sin-%ix-loc s0)) (g '%2 (@__kernel_sin-%ix-loc s0)) (@__kernel_sin-%ix-mem s0)))
(defund @__kernel_sin-m0.2-mem (s0)
  (store-double (g '%y (@__kernel_sin-%ix-loc s0)) (g '%3 (@__kernel_sin-%ix-loc s0)) (@__kernel_sin-m0.1-mem s0)))
(defund @__kernel_sin-m0.3-mem (s0)
  (store-i32 (g '%iy (@__kernel_sin-%ix-loc s0)) (g '%4 (@__kernel_sin-%ix-loc s0)) (@__kernel_sin-m0.2-mem s0)))
(defund @__kernel_sin-%5-val (s0)
  (bitcast-double*-to-i32* (g '%2 (@__kernel_sin-%ix-loc s0))))
(defund @__kernel_sin-%5-loc (s0)
  (s '%5 (@__kernel_sin-%5-val s0) (@__kernel_sin-%ix-loc s0)))
(defund @__kernel_sin-%6-val (s0)
  (getelementptr-i32 (g '%5 (@__kernel_sin-%5-loc s0)) 1))
(defund @__kernel_sin-%6-loc (s0)
  (s '%6 (@__kernel_sin-%6-val s0) (@__kernel_sin-%5-loc s0)))
(defund @__kernel_sin-%7-val (s0)
  (load-i32 (g '%6 (@__kernel_sin-%6-loc s0)) (@__kernel_sin-m0.3-mem s0)))
(defund @__kernel_sin-%7-loc (s0)
  (s '%7 (@__kernel_sin-%7-val s0) (@__kernel_sin-%6-loc s0)))
(defund @__kernel_sin-%8-val (s0)
  (and-i32 (g '%7 (@__kernel_sin-%7-loc s0)) 2147483647))
(defund @__kernel_sin-%8-loc (s0)
  (s '%8 (@__kernel_sin-%8-val s0) (@__kernel_sin-%7-loc s0)))
(defund @__kernel_sin-m0.4-mem (s0)
  (store-i32 (g '%8 (@__kernel_sin-%8-loc s0)) (g '%ix (@__kernel_sin-%8-loc s0)) (@__kernel_sin-m0.3-mem s0)))
(defund @__kernel_sin-%9-val (s0)
  (load-i32 (g '%ix (@__kernel_sin-%8-loc s0)) (@__kernel_sin-m0.4-mem s0)))
(defund @__kernel_sin-%9-loc (s0)
  (s '%9 (@__kernel_sin-%9-val s0) (@__kernel_sin-%8-loc s0)))
(defund @__kernel_sin-%10-val (s0)
  (icmp-slt-i32 (g '%9 (@__kernel_sin-%9-loc s0)) 1044381696))
(defund @__kernel_sin-%10-loc (s0)
  (s '%10 (@__kernel_sin-%10-val s0) (@__kernel_sin-%9-loc s0)))
(defund @__kernel_sin-succ0-lab (s0)
  (case (g '%10 (@__kernel_sin-%10-loc s0)) (-1 '%11) (0 '%18)))

(defund @__kernel_sin-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%10 loc) (-1 '%11) (0 '%18)) mem loc))
(defund @__kernel_sin-%10-rev (mem loc pred)
  (@__kernel_sin-succ0-rev mem (s '%10 (icmp-slt-i32 (g '%9 loc) 1044381696) loc) pred))
(defund @__kernel_sin-%9-rev (mem loc pred)
  (@__kernel_sin-%10-rev mem (s '%9 (load-i32 (g '%ix loc) mem) loc) pred))
(defund @__kernel_sin-m0.4-rev (mem loc pred)
  (@__kernel_sin-%9-rev (store-i32 (g '%8 loc) (g '%ix loc) mem) loc pred))
(defund @__kernel_sin-%8-rev (mem loc pred)
  (@__kernel_sin-m0.4-rev mem (s '%8 (and-i32 (g '%7 loc) 2147483647) loc) pred))
(defund @__kernel_sin-%7-rev (mem loc pred)
  (@__kernel_sin-%8-rev mem (s '%7 (load-i32 (g '%6 loc) mem) loc) pred))
(defund @__kernel_sin-%6-rev (mem loc pred)
  (@__kernel_sin-%7-rev mem (s '%6 (getelementptr-i32 (g '%5 loc) 1) loc) pred))
(defund @__kernel_sin-%5-rev (mem loc pred)
  (@__kernel_sin-%6-rev mem (s '%5 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @__kernel_sin-m0.3-rev (mem loc pred)
  (@__kernel_sin-%5-rev (store-i32 (g '%iy loc) (g '%4 loc) mem) loc pred))
(defund @__kernel_sin-m0.2-rev (mem loc pred)
  (@__kernel_sin-m0.3-rev (store-double (g '%y loc) (g '%3 loc) mem) loc pred))
(defund @__kernel_sin-m0.1-rev (mem loc pred)
  (@__kernel_sin-m0.2-rev (store-double (g '%x loc) (g '%2 loc) mem) loc pred))
(defund @__kernel_sin-%ix-rev (mem loc pred)
  (@__kernel_sin-m0.1-rev (alloca-i32 'ix 1 mem) (s '%ix '(ix . 0) loc) pred))
(defund @__kernel_sin-%v-rev (mem loc pred)
  (@__kernel_sin-%ix-rev (alloca-double 'v 1 mem) (s '%v '(v . 0) loc) pred))
(defund @__kernel_sin-%r-rev (mem loc pred)
  (@__kernel_sin-%v-rev (alloca-double 'r 1 mem) (s '%r '(r . 0) loc) pred))
(defund @__kernel_sin-%z-rev (mem loc pred)
  (@__kernel_sin-%r-rev (alloca-double 'z 1 mem) (s '%z '(z . 0) loc) pred))
(defund @__kernel_sin-%4-rev (mem loc pred)
  (@__kernel_sin-%z-rev (alloca-i32 'iy 1 mem) (s '%4 '(iy . 0) loc) pred))
(defund @__kernel_sin-%3-rev (mem loc pred)
  (@__kernel_sin-%4-rev (alloca-double 'y 1 mem) (s '%3 '(y . 0) loc) pred))
(defund @__kernel_sin-%2-rev (mem loc pred)
  (@__kernel_sin-%3-rev (alloca-double 'x 1 mem) (s '%2 '(x . 0) loc) pred))
(defund @__kernel_sin-%1-rev (mem loc pred)
  (@__kernel_sin-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @__kernel_sin-%0-rev (mem loc pred)
  (@__kernel_sin-%1-rev mem loc pred))

(defund @__kernel_sin-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (alloca-double 'x 1 mem))
    (loc (s '%2 '(x . 0) loc))
    (mem (alloca-double 'y 1 mem))
    (loc (s '%3 '(y . 0) loc))
    (mem (alloca-i32 'iy 1 mem))
    (loc (s '%4 '(iy . 0) loc))
    (mem (alloca-double 'z 1 mem))
    (loc (s '%z '(z . 0) loc))
    (mem (alloca-double 'r 1 mem))
    (loc (s '%r '(r . 0) loc))
    (mem (alloca-double 'v 1 mem))
    (loc (s '%v '(v . 0) loc))
    (mem (alloca-i32 'ix 1 mem))
    (loc (s '%ix '(ix . 0) loc))
    (mem (store-double (g '%x loc) (g '%2 loc) mem))
    (mem (store-double (g '%y loc) (g '%3 loc) mem))
    (mem (store-i32 (g '%iy loc) (g '%4 loc) mem))
    (loc (s '%5 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%6 (getelementptr-i32 (g '%5 loc) 1) loc))
    (loc (s '%7 (load-i32 (g '%6 loc) mem) loc))
    (loc (s '%8 (and-i32 (g '%7 loc) 2147483647) loc))
    (mem (store-i32 (g '%8 loc) (g '%ix loc) mem))
    (loc (s '%9 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%10 (icmp-slt-i32 (g '%9 loc) 1044381696) loc))
    (succ (case (g '%10 loc) (-1 '%11) (0 '%18))))
  (mv succ mem loc)))

(defruled @__kernel_sin-%0-expand-bb
  (equal (@__kernel_sin-%0-bb mem loc pred)
         (@__kernel_sin-%0-rev mem loc pred))
  :enable (@__kernel_sin-%0-bb @__kernel_sin-%0-rev
    @__kernel_sin-%1-rev
    @__kernel_sin-%2-rev
    @__kernel_sin-%3-rev
    @__kernel_sin-%4-rev
    @__kernel_sin-%z-rev
    @__kernel_sin-%r-rev
    @__kernel_sin-%v-rev
    @__kernel_sin-%ix-rev
    @__kernel_sin-m0.1-rev
    @__kernel_sin-m0.2-rev
    @__kernel_sin-m0.3-rev
    @__kernel_sin-%5-rev
    @__kernel_sin-%6-rev
    @__kernel_sin-%7-rev
    @__kernel_sin-%8-rev
    @__kernel_sin-m0.4-rev
    @__kernel_sin-%9-rev
    @__kernel_sin-%10-rev
    @__kernel_sin-succ0-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%11-mem (s11)
  (car s11))
(defund @__kernel_sin-%11-loc (s11)
  (cadr s11))
(defund @__kernel_sin-%11-pred (s11)
  (caddr s11))
(defund @__kernel_sin-%12-val (s11)
  (load-double (g '%2 (@__kernel_sin-%11-loc s11)) (@__kernel_sin-%11-mem s11)))
(defund @__kernel_sin-%12-loc (s11)
  (s '%12 (@__kernel_sin-%12-val s11) (@__kernel_sin-%11-loc s11)))
(defund @__kernel_sin-%13-val (s11)
  (fptosi-double-to-i32 (g '%12 (@__kernel_sin-%12-loc s11))))
(defund @__kernel_sin-%13-loc (s11)
  (s '%13 (@__kernel_sin-%13-val s11) (@__kernel_sin-%12-loc s11)))
(defund @__kernel_sin-%14-val (s11)
  (icmp-eq-i32 (g '%13 (@__kernel_sin-%13-loc s11)) 0))
(defund @__kernel_sin-%14-loc (s11)
  (s '%14 (@__kernel_sin-%14-val s11) (@__kernel_sin-%13-loc s11)))
(defund @__kernel_sin-succ11-lab (s11)
  (case (g '%14 (@__kernel_sin-%14-loc s11)) (-1 '%15) (0 '%17)))

(defund @__kernel_sin-succ11-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%14 loc) (-1 '%15) (0 '%17)) mem loc))
(defund @__kernel_sin-%14-rev (mem loc pred)
  (@__kernel_sin-succ11-rev mem (s '%14 (icmp-eq-i32 (g '%13 loc) 0) loc) pred))
(defund @__kernel_sin-%13-rev (mem loc pred)
  (@__kernel_sin-%14-rev mem (s '%13 (fptosi-double-to-i32 (g '%12 loc)) loc) pred))
(defund @__kernel_sin-%12-rev (mem loc pred)
  (@__kernel_sin-%13-rev mem (s '%12 (load-double (g '%2 loc) mem) loc) pred))

(defund @__kernel_sin-%11-rev (mem loc pred)
  (@__kernel_sin-%12-rev mem loc pred))

(defund @__kernel_sin-%11-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%12 (load-double (g '%2 loc) mem) loc))
    (loc (s '%13 (fptosi-double-to-i32 (g '%12 loc)) loc))
    (loc (s '%14 (icmp-eq-i32 (g '%13 loc) 0) loc))
    (succ (case (g '%14 loc) (-1 '%15) (0 '%17))))
  (mv succ mem loc)))

(defruled @__kernel_sin-%11-expand-bb
  (equal (@__kernel_sin-%11-bb mem loc pred)
         (@__kernel_sin-%11-rev mem loc pred))
  :enable (@__kernel_sin-%11-bb @__kernel_sin-%11-rev
    @__kernel_sin-%12-rev
    @__kernel_sin-%13-rev
    @__kernel_sin-%14-rev
    @__kernel_sin-succ11-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%15-mem (s15)
  (car s15))
(defund @__kernel_sin-%15-loc (s15)
  (cadr s15))
(defund @__kernel_sin-%15-pred (s15)
  (caddr s15))
(defund @__kernel_sin-%16-val (s15)
  (load-double (g '%2 (@__kernel_sin-%15-loc s15)) (@__kernel_sin-%15-mem s15)))
(defund @__kernel_sin-%16-loc (s15)
  (s '%16 (@__kernel_sin-%16-val s15) (@__kernel_sin-%15-loc s15)))
(defund @__kernel_sin-m15.1-mem (s15)
  (store-double (g '%16 (@__kernel_sin-%16-loc s15)) (g '%1 (@__kernel_sin-%16-loc s15)) (@__kernel_sin-%15-mem s15)))
(defund @__kernel_sin-succ15-lab (s15)
  (declare (ignore s15))
  '%64)

(defund @__kernel_sin-succ15-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))
(defund @__kernel_sin-m15.1-rev (mem loc pred)
  (@__kernel_sin-succ15-rev (store-double (g '%16 loc) (g '%1 loc) mem) loc pred))
(defund @__kernel_sin-%16-rev (mem loc pred)
  (@__kernel_sin-m15.1-rev mem (s '%16 (load-double (g '%2 loc) mem) loc) pred))

(defund @__kernel_sin-%15-rev (mem loc pred)
  (@__kernel_sin-%16-rev mem loc pred))

(defund @__kernel_sin-%15-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%16 (load-double (g '%2 loc) mem) loc))
    (mem (store-double (g '%16 loc) (g '%1 loc) mem))
    (succ '%64))
  (mv succ mem loc)))

(defruled @__kernel_sin-%15-expand-bb
  (equal (@__kernel_sin-%15-bb mem loc pred)
         (@__kernel_sin-%15-rev mem loc pred))
  :enable (@__kernel_sin-%15-bb @__kernel_sin-%15-rev
    @__kernel_sin-%16-rev
    @__kernel_sin-m15.1-rev
    @__kernel_sin-succ15-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%17-mem (s17)
  (car s17))
(defund @__kernel_sin-%17-loc (s17)
  (cadr s17))
(defund @__kernel_sin-%17-pred (s17)
  (caddr s17))
(defund @__kernel_sin-succ17-lab (s17)
  (declare (ignore s17))
  '%18)

(defund @__kernel_sin-succ17-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%18 mem loc))

(defund @__kernel_sin-%17-rev (mem loc pred)
  (@__kernel_sin-succ17-rev mem loc pred))

(defund @__kernel_sin-%17-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%18))
  (mv succ mem loc)))

(defruled @__kernel_sin-%17-expand-bb
  (equal (@__kernel_sin-%17-bb mem loc pred)
         (@__kernel_sin-%17-rev mem loc pred))
  :enable (@__kernel_sin-%17-bb @__kernel_sin-%17-rev
    @__kernel_sin-succ17-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%18-mem (s18)
  (car s18))
(defund @__kernel_sin-%18-loc (s18)
  (cadr s18))
(defund @__kernel_sin-%18-pred (s18)
  (caddr s18))
(defund @__kernel_sin-%19-val (s18)
  (load-double (g '%2 (@__kernel_sin-%18-loc s18)) (@__kernel_sin-%18-mem s18)))
(defund @__kernel_sin-%19-loc (s18)
  (s '%19 (@__kernel_sin-%19-val s18) (@__kernel_sin-%18-loc s18)))
(defund @__kernel_sin-%20-val (s18)
  (load-double (g '%2 (@__kernel_sin-%19-loc s18)) (@__kernel_sin-%18-mem s18)))
(defund @__kernel_sin-%20-loc (s18)
  (s '%20 (@__kernel_sin-%20-val s18) (@__kernel_sin-%19-loc s18)))
(defund @__kernel_sin-%21-val (s18)
  (fmul-double (g '%19 (@__kernel_sin-%20-loc s18)) (g '%20 (@__kernel_sin-%20-loc s18))))
(defund @__kernel_sin-%21-loc (s18)
  (s '%21 (@__kernel_sin-%21-val s18) (@__kernel_sin-%20-loc s18)))
(defund @__kernel_sin-m18.1-mem (s18)
  (store-double (g '%21 (@__kernel_sin-%21-loc s18)) (g '%z (@__kernel_sin-%21-loc s18)) (@__kernel_sin-%18-mem s18)))
(defund @__kernel_sin-%22-val (s18)
  (load-double (g '%z (@__kernel_sin-%21-loc s18)) (@__kernel_sin-m18.1-mem s18)))
(defund @__kernel_sin-%22-loc (s18)
  (s '%22 (@__kernel_sin-%22-val s18) (@__kernel_sin-%21-loc s18)))
(defund @__kernel_sin-%23-val (s18)
  (load-double (g '%2 (@__kernel_sin-%22-loc s18)) (@__kernel_sin-m18.1-mem s18)))
(defund @__kernel_sin-%23-loc (s18)
  (s '%23 (@__kernel_sin-%23-val s18) (@__kernel_sin-%22-loc s18)))
(defund @__kernel_sin-%24-val (s18)
  (fmul-double (g '%22 (@__kernel_sin-%23-loc s18)) (g '%23 (@__kernel_sin-%23-loc s18))))
(defund @__kernel_sin-%24-loc (s18)
  (s '%24 (@__kernel_sin-%24-val s18) (@__kernel_sin-%23-loc s18)))
(defund @__kernel_sin-m18.2-mem (s18)
  (store-double (g '%24 (@__kernel_sin-%24-loc s18)) (g '%v (@__kernel_sin-%24-loc s18)) (@__kernel_sin-m18.1-mem s18)))
(defund @__kernel_sin-%25-val (s18)
  (load-double (g '%z (@__kernel_sin-%24-loc s18)) (@__kernel_sin-m18.2-mem s18)))
(defund @__kernel_sin-%25-loc (s18)
  (s '%25 (@__kernel_sin-%25-val s18) (@__kernel_sin-%24-loc s18)))
(defund @__kernel_sin-%26-val (s18)
  (load-double (g '%z (@__kernel_sin-%25-loc s18)) (@__kernel_sin-m18.2-mem s18)))
(defund @__kernel_sin-%26-loc (s18)
  (s '%26 (@__kernel_sin-%26-val s18) (@__kernel_sin-%25-loc s18)))
(defund @__kernel_sin-%27-val (s18)
  (load-double (g '%z (@__kernel_sin-%26-loc s18)) (@__kernel_sin-m18.2-mem s18)))
(defund @__kernel_sin-%27-loc (s18)
  (s '%27 (@__kernel_sin-%27-val s18) (@__kernel_sin-%26-loc s18)))
(defund @__kernel_sin-%28-val (s18)
  (load-double (g '%z (@__kernel_sin-%27-loc s18)) (@__kernel_sin-m18.2-mem s18)))
(defund @__kernel_sin-%28-loc (s18)
  (s '%28 (@__kernel_sin-%28-val s18) (@__kernel_sin-%27-loc s18)))
(defund @__kernel_sin-%29-val (s18)
  (fmul-double (g '%28 (@__kernel_sin-%28-loc s18)) #x3DE5D93A5ACFD57C))
(defund @__kernel_sin-%29-loc (s18)
  (s '%29 (@__kernel_sin-%29-val s18) (@__kernel_sin-%28-loc s18)))
(defund @__kernel_sin-%30-val (s18)
  (fadd-double #xBE5AE5E68A2B9CEB (g '%29 (@__kernel_sin-%29-loc s18))))
(defund @__kernel_sin-%30-loc (s18)
  (s '%30 (@__kernel_sin-%30-val s18) (@__kernel_sin-%29-loc s18)))
(defund @__kernel_sin-%31-val (s18)
  (fmul-double (g '%27 (@__kernel_sin-%30-loc s18)) (g '%30 (@__kernel_sin-%30-loc s18))))
(defund @__kernel_sin-%31-loc (s18)
  (s '%31 (@__kernel_sin-%31-val s18) (@__kernel_sin-%30-loc s18)))
(defund @__kernel_sin-%32-val (s18)
  (fadd-double #x3EC71DE357B1FE7D (g '%31 (@__kernel_sin-%31-loc s18))))
(defund @__kernel_sin-%32-loc (s18)
  (s '%32 (@__kernel_sin-%32-val s18) (@__kernel_sin-%31-loc s18)))
(defund @__kernel_sin-%33-val (s18)
  (fmul-double (g '%26 (@__kernel_sin-%32-loc s18)) (g '%32 (@__kernel_sin-%32-loc s18))))
(defund @__kernel_sin-%33-loc (s18)
  (s '%33 (@__kernel_sin-%33-val s18) (@__kernel_sin-%32-loc s18)))
(defund @__kernel_sin-%34-val (s18)
  (fadd-double #xBF2A01A019C161D5 (g '%33 (@__kernel_sin-%33-loc s18))))
(defund @__kernel_sin-%34-loc (s18)
  (s '%34 (@__kernel_sin-%34-val s18) (@__kernel_sin-%33-loc s18)))
(defund @__kernel_sin-%35-val (s18)
  (fmul-double (g '%25 (@__kernel_sin-%34-loc s18)) (g '%34 (@__kernel_sin-%34-loc s18))))
(defund @__kernel_sin-%35-loc (s18)
  (s '%35 (@__kernel_sin-%35-val s18) (@__kernel_sin-%34-loc s18)))
(defund @__kernel_sin-%36-val (s18)
  (fadd-double #x3F8111111110F8A6 (g '%35 (@__kernel_sin-%35-loc s18))))
(defund @__kernel_sin-%36-loc (s18)
  (s '%36 (@__kernel_sin-%36-val s18) (@__kernel_sin-%35-loc s18)))
(defund @__kernel_sin-m18.3-mem (s18)
  (store-double (g '%36 (@__kernel_sin-%36-loc s18)) (g '%r (@__kernel_sin-%36-loc s18)) (@__kernel_sin-m18.2-mem s18)))
(defund @__kernel_sin-%37-val (s18)
  (load-i32 (g '%4 (@__kernel_sin-%36-loc s18)) (@__kernel_sin-m18.3-mem s18)))
(defund @__kernel_sin-%37-loc (s18)
  (s '%37 (@__kernel_sin-%37-val s18) (@__kernel_sin-%36-loc s18)))
(defund @__kernel_sin-%38-val (s18)
  (icmp-eq-i32 (g '%37 (@__kernel_sin-%37-loc s18)) 0))
(defund @__kernel_sin-%38-loc (s18)
  (s '%38 (@__kernel_sin-%38-val s18) (@__kernel_sin-%37-loc s18)))
(defund @__kernel_sin-succ18-lab (s18)
  (case (g '%38 (@__kernel_sin-%38-loc s18)) (-1 '%39) (0 '%48)))

(defund @__kernel_sin-succ18-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%38 loc) (-1 '%39) (0 '%48)) mem loc))
(defund @__kernel_sin-%38-rev (mem loc pred)
  (@__kernel_sin-succ18-rev mem (s '%38 (icmp-eq-i32 (g '%37 loc) 0) loc) pred))
(defund @__kernel_sin-%37-rev (mem loc pred)
  (@__kernel_sin-%38-rev mem (s '%37 (load-i32 (g '%4 loc) mem) loc) pred))
(defund @__kernel_sin-m18.3-rev (mem loc pred)
  (@__kernel_sin-%37-rev (store-double (g '%36 loc) (g '%r loc) mem) loc pred))
(defund @__kernel_sin-%36-rev (mem loc pred)
  (@__kernel_sin-m18.3-rev mem (s '%36 (fadd-double #x3F8111111110F8A6 (g '%35 loc)) loc) pred))
(defund @__kernel_sin-%35-rev (mem loc pred)
  (@__kernel_sin-%36-rev mem (s '%35 (fmul-double (g '%25 loc) (g '%34 loc)) loc) pred))
(defund @__kernel_sin-%34-rev (mem loc pred)
  (@__kernel_sin-%35-rev mem (s '%34 (fadd-double #xBF2A01A019C161D5 (g '%33 loc)) loc) pred))
(defund @__kernel_sin-%33-rev (mem loc pred)
  (@__kernel_sin-%34-rev mem (s '%33 (fmul-double (g '%26 loc) (g '%32 loc)) loc) pred))
(defund @__kernel_sin-%32-rev (mem loc pred)
  (@__kernel_sin-%33-rev mem (s '%32 (fadd-double #x3EC71DE357B1FE7D (g '%31 loc)) loc) pred))
(defund @__kernel_sin-%31-rev (mem loc pred)
  (@__kernel_sin-%32-rev mem (s '%31 (fmul-double (g '%27 loc) (g '%30 loc)) loc) pred))
(defund @__kernel_sin-%30-rev (mem loc pred)
  (@__kernel_sin-%31-rev mem (s '%30 (fadd-double #xBE5AE5E68A2B9CEB (g '%29 loc)) loc) pred))
(defund @__kernel_sin-%29-rev (mem loc pred)
  (@__kernel_sin-%30-rev mem (s '%29 (fmul-double (g '%28 loc) #x3DE5D93A5ACFD57C) loc) pred))
(defund @__kernel_sin-%28-rev (mem loc pred)
  (@__kernel_sin-%29-rev mem (s '%28 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-%27-rev (mem loc pred)
  (@__kernel_sin-%28-rev mem (s '%27 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-%26-rev (mem loc pred)
  (@__kernel_sin-%27-rev mem (s '%26 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-%25-rev (mem loc pred)
  (@__kernel_sin-%26-rev mem (s '%25 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-m18.2-rev (mem loc pred)
  (@__kernel_sin-%25-rev (store-double (g '%24 loc) (g '%v loc) mem) loc pred))
(defund @__kernel_sin-%24-rev (mem loc pred)
  (@__kernel_sin-m18.2-rev mem (s '%24 (fmul-double (g '%22 loc) (g '%23 loc)) loc) pred))
(defund @__kernel_sin-%23-rev (mem loc pred)
  (@__kernel_sin-%24-rev mem (s '%23 (load-double (g '%2 loc) mem) loc) pred))
(defund @__kernel_sin-%22-rev (mem loc pred)
  (@__kernel_sin-%23-rev mem (s '%22 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-m18.1-rev (mem loc pred)
  (@__kernel_sin-%22-rev (store-double (g '%21 loc) (g '%z loc) mem) loc pred))
(defund @__kernel_sin-%21-rev (mem loc pred)
  (@__kernel_sin-m18.1-rev mem (s '%21 (fmul-double (g '%19 loc) (g '%20 loc)) loc) pred))
(defund @__kernel_sin-%20-rev (mem loc pred)
  (@__kernel_sin-%21-rev mem (s '%20 (load-double (g '%2 loc) mem) loc) pred))
(defund @__kernel_sin-%19-rev (mem loc pred)
  (@__kernel_sin-%20-rev mem (s '%19 (load-double (g '%2 loc) mem) loc) pred))

(defund @__kernel_sin-%18-rev (mem loc pred)
  (@__kernel_sin-%19-rev mem loc pred))

(defund @__kernel_sin-%18-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%19 (load-double (g '%2 loc) mem) loc))
    (loc (s '%20 (load-double (g '%2 loc) mem) loc))
    (loc (s '%21 (fmul-double (g '%19 loc) (g '%20 loc)) loc))
    (mem (store-double (g '%21 loc) (g '%z loc) mem))
    (loc (s '%22 (load-double (g '%z loc) mem) loc))
    (loc (s '%23 (load-double (g '%2 loc) mem) loc))
    (loc (s '%24 (fmul-double (g '%22 loc) (g '%23 loc)) loc))
    (mem (store-double (g '%24 loc) (g '%v loc) mem))
    (loc (s '%25 (load-double (g '%z loc) mem) loc))
    (loc (s '%26 (load-double (g '%z loc) mem) loc))
    (loc (s '%27 (load-double (g '%z loc) mem) loc))
    (loc (s '%28 (load-double (g '%z loc) mem) loc))
    (loc (s '%29 (fmul-double (g '%28 loc) #x3DE5D93A5ACFD57C) loc))
    (loc (s '%30 (fadd-double #xBE5AE5E68A2B9CEB (g '%29 loc)) loc))
    (loc (s '%31 (fmul-double (g '%27 loc) (g '%30 loc)) loc))
    (loc (s '%32 (fadd-double #x3EC71DE357B1FE7D (g '%31 loc)) loc))
    (loc (s '%33 (fmul-double (g '%26 loc) (g '%32 loc)) loc))
    (loc (s '%34 (fadd-double #xBF2A01A019C161D5 (g '%33 loc)) loc))
    (loc (s '%35 (fmul-double (g '%25 loc) (g '%34 loc)) loc))
    (loc (s '%36 (fadd-double #x3F8111111110F8A6 (g '%35 loc)) loc))
    (mem (store-double (g '%36 loc) (g '%r loc) mem))
    (loc (s '%37 (load-i32 (g '%4 loc) mem) loc))
    (loc (s '%38 (icmp-eq-i32 (g '%37 loc) 0) loc))
    (succ (case (g '%38 loc) (-1 '%39) (0 '%48))))
  (mv succ mem loc)))

(defruled @__kernel_sin-%18-expand-bb
  (equal (@__kernel_sin-%18-bb mem loc pred)
         (@__kernel_sin-%18-rev mem loc pred))
  :enable (@__kernel_sin-%18-bb @__kernel_sin-%18-rev
    @__kernel_sin-%19-rev
    @__kernel_sin-%20-rev
    @__kernel_sin-%21-rev
    @__kernel_sin-m18.1-rev
    @__kernel_sin-%22-rev
    @__kernel_sin-%23-rev
    @__kernel_sin-%24-rev
    @__kernel_sin-m18.2-rev
    @__kernel_sin-%25-rev
    @__kernel_sin-%26-rev
    @__kernel_sin-%27-rev
    @__kernel_sin-%28-rev
    @__kernel_sin-%29-rev
    @__kernel_sin-%30-rev
    @__kernel_sin-%31-rev
    @__kernel_sin-%32-rev
    @__kernel_sin-%33-rev
    @__kernel_sin-%34-rev
    @__kernel_sin-%35-rev
    @__kernel_sin-%36-rev
    @__kernel_sin-m18.3-rev
    @__kernel_sin-%37-rev
    @__kernel_sin-%38-rev
    @__kernel_sin-succ18-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%39-mem (s39)
  (car s39))
(defund @__kernel_sin-%39-loc (s39)
  (cadr s39))
(defund @__kernel_sin-%39-pred (s39)
  (caddr s39))
(defund @__kernel_sin-%40-val (s39)
  (load-double (g '%2 (@__kernel_sin-%39-loc s39)) (@__kernel_sin-%39-mem s39)))
(defund @__kernel_sin-%40-loc (s39)
  (s '%40 (@__kernel_sin-%40-val s39) (@__kernel_sin-%39-loc s39)))
(defund @__kernel_sin-%41-val (s39)
  (load-double (g '%v (@__kernel_sin-%40-loc s39)) (@__kernel_sin-%39-mem s39)))
(defund @__kernel_sin-%41-loc (s39)
  (s '%41 (@__kernel_sin-%41-val s39) (@__kernel_sin-%40-loc s39)))
(defund @__kernel_sin-%42-val (s39)
  (load-double (g '%z (@__kernel_sin-%41-loc s39)) (@__kernel_sin-%39-mem s39)))
(defund @__kernel_sin-%42-loc (s39)
  (s '%42 (@__kernel_sin-%42-val s39) (@__kernel_sin-%41-loc s39)))
(defund @__kernel_sin-%43-val (s39)
  (load-double (g '%r (@__kernel_sin-%42-loc s39)) (@__kernel_sin-%39-mem s39)))
(defund @__kernel_sin-%43-loc (s39)
  (s '%43 (@__kernel_sin-%43-val s39) (@__kernel_sin-%42-loc s39)))
(defund @__kernel_sin-%44-val (s39)
  (fmul-double (g '%42 (@__kernel_sin-%43-loc s39)) (g '%43 (@__kernel_sin-%43-loc s39))))
(defund @__kernel_sin-%44-loc (s39)
  (s '%44 (@__kernel_sin-%44-val s39) (@__kernel_sin-%43-loc s39)))
(defund @__kernel_sin-%45-val (s39)
  (fadd-double #xBFC5555555555549 (g '%44 (@__kernel_sin-%44-loc s39))))
(defund @__kernel_sin-%45-loc (s39)
  (s '%45 (@__kernel_sin-%45-val s39) (@__kernel_sin-%44-loc s39)))
(defund @__kernel_sin-%46-val (s39)
  (fmul-double (g '%41 (@__kernel_sin-%45-loc s39)) (g '%45 (@__kernel_sin-%45-loc s39))))
(defund @__kernel_sin-%46-loc (s39)
  (s '%46 (@__kernel_sin-%46-val s39) (@__kernel_sin-%45-loc s39)))
(defund @__kernel_sin-%47-val (s39)
  (fadd-double (g '%40 (@__kernel_sin-%46-loc s39)) (g '%46 (@__kernel_sin-%46-loc s39))))
(defund @__kernel_sin-%47-loc (s39)
  (s '%47 (@__kernel_sin-%47-val s39) (@__kernel_sin-%46-loc s39)))
(defund @__kernel_sin-m39.1-mem (s39)
  (store-double (g '%47 (@__kernel_sin-%47-loc s39)) (g '%1 (@__kernel_sin-%47-loc s39)) (@__kernel_sin-%39-mem s39)))
(defund @__kernel_sin-succ39-lab (s39)
  (declare (ignore s39))
  '%64)

(defund @__kernel_sin-succ39-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))
(defund @__kernel_sin-m39.1-rev (mem loc pred)
  (@__kernel_sin-succ39-rev (store-double (g '%47 loc) (g '%1 loc) mem) loc pred))
(defund @__kernel_sin-%47-rev (mem loc pred)
  (@__kernel_sin-m39.1-rev mem (s '%47 (fadd-double (g '%40 loc) (g '%46 loc)) loc) pred))
(defund @__kernel_sin-%46-rev (mem loc pred)
  (@__kernel_sin-%47-rev mem (s '%46 (fmul-double (g '%41 loc) (g '%45 loc)) loc) pred))
(defund @__kernel_sin-%45-rev (mem loc pred)
  (@__kernel_sin-%46-rev mem (s '%45 (fadd-double #xBFC5555555555549 (g '%44 loc)) loc) pred))
(defund @__kernel_sin-%44-rev (mem loc pred)
  (@__kernel_sin-%45-rev mem (s '%44 (fmul-double (g '%42 loc) (g '%43 loc)) loc) pred))
(defund @__kernel_sin-%43-rev (mem loc pred)
  (@__kernel_sin-%44-rev mem (s '%43 (load-double (g '%r loc) mem) loc) pred))
(defund @__kernel_sin-%42-rev (mem loc pred)
  (@__kernel_sin-%43-rev mem (s '%42 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-%41-rev (mem loc pred)
  (@__kernel_sin-%42-rev mem (s '%41 (load-double (g '%v loc) mem) loc) pred))
(defund @__kernel_sin-%40-rev (mem loc pred)
  (@__kernel_sin-%41-rev mem (s '%40 (load-double (g '%2 loc) mem) loc) pred))

(defund @__kernel_sin-%39-rev (mem loc pred)
  (@__kernel_sin-%40-rev mem loc pred))

(defund @__kernel_sin-%39-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%40 (load-double (g '%2 loc) mem) loc))
    (loc (s '%41 (load-double (g '%v loc) mem) loc))
    (loc (s '%42 (load-double (g '%z loc) mem) loc))
    (loc (s '%43 (load-double (g '%r loc) mem) loc))
    (loc (s '%44 (fmul-double (g '%42 loc) (g '%43 loc)) loc))
    (loc (s '%45 (fadd-double #xBFC5555555555549 (g '%44 loc)) loc))
    (loc (s '%46 (fmul-double (g '%41 loc) (g '%45 loc)) loc))
    (loc (s '%47 (fadd-double (g '%40 loc) (g '%46 loc)) loc))
    (mem (store-double (g '%47 loc) (g '%1 loc) mem))
    (succ '%64))
  (mv succ mem loc)))

(defruled @__kernel_sin-%39-expand-bb
  (equal (@__kernel_sin-%39-bb mem loc pred)
         (@__kernel_sin-%39-rev mem loc pred))
  :enable (@__kernel_sin-%39-bb @__kernel_sin-%39-rev
    @__kernel_sin-%40-rev
    @__kernel_sin-%41-rev
    @__kernel_sin-%42-rev
    @__kernel_sin-%43-rev
    @__kernel_sin-%44-rev
    @__kernel_sin-%45-rev
    @__kernel_sin-%46-rev
    @__kernel_sin-%47-rev
    @__kernel_sin-m39.1-rev
    @__kernel_sin-succ39-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%48-mem (s48)
  (car s48))
(defund @__kernel_sin-%48-loc (s48)
  (cadr s48))
(defund @__kernel_sin-%48-pred (s48)
  (caddr s48))
(defund @__kernel_sin-%49-val (s48)
  (load-double (g '%2 (@__kernel_sin-%48-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%49-loc (s48)
  (s '%49 (@__kernel_sin-%49-val s48) (@__kernel_sin-%48-loc s48)))
(defund @__kernel_sin-%50-val (s48)
  (load-double (g '%z (@__kernel_sin-%49-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%50-loc (s48)
  (s '%50 (@__kernel_sin-%50-val s48) (@__kernel_sin-%49-loc s48)))
(defund @__kernel_sin-%51-val (s48)
  (load-double (g '%3 (@__kernel_sin-%50-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%51-loc (s48)
  (s '%51 (@__kernel_sin-%51-val s48) (@__kernel_sin-%50-loc s48)))
(defund @__kernel_sin-%52-val (s48)
  (fmul-double #x3fe0000000000000 (g '%51 (@__kernel_sin-%51-loc s48))))
(defund @__kernel_sin-%52-loc (s48)
  (s '%52 (@__kernel_sin-%52-val s48) (@__kernel_sin-%51-loc s48)))
(defund @__kernel_sin-%53-val (s48)
  (load-double (g '%v (@__kernel_sin-%52-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%53-loc (s48)
  (s '%53 (@__kernel_sin-%53-val s48) (@__kernel_sin-%52-loc s48)))
(defund @__kernel_sin-%54-val (s48)
  (load-double (g '%r (@__kernel_sin-%53-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%54-loc (s48)
  (s '%54 (@__kernel_sin-%54-val s48) (@__kernel_sin-%53-loc s48)))
(defund @__kernel_sin-%55-val (s48)
  (fmul-double (g '%53 (@__kernel_sin-%54-loc s48)) (g '%54 (@__kernel_sin-%54-loc s48))))
(defund @__kernel_sin-%55-loc (s48)
  (s '%55 (@__kernel_sin-%55-val s48) (@__kernel_sin-%54-loc s48)))
(defund @__kernel_sin-%56-val (s48)
  (fsub-double (g '%52 (@__kernel_sin-%55-loc s48)) (g '%55 (@__kernel_sin-%55-loc s48))))
(defund @__kernel_sin-%56-loc (s48)
  (s '%56 (@__kernel_sin-%56-val s48) (@__kernel_sin-%55-loc s48)))
(defund @__kernel_sin-%57-val (s48)
  (fmul-double (g '%50 (@__kernel_sin-%56-loc s48)) (g '%56 (@__kernel_sin-%56-loc s48))))
(defund @__kernel_sin-%57-loc (s48)
  (s '%57 (@__kernel_sin-%57-val s48) (@__kernel_sin-%56-loc s48)))
(defund @__kernel_sin-%58-val (s48)
  (load-double (g '%3 (@__kernel_sin-%57-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%58-loc (s48)
  (s '%58 (@__kernel_sin-%58-val s48) (@__kernel_sin-%57-loc s48)))
(defund @__kernel_sin-%59-val (s48)
  (fsub-double (g '%57 (@__kernel_sin-%58-loc s48)) (g '%58 (@__kernel_sin-%58-loc s48))))
(defund @__kernel_sin-%59-loc (s48)
  (s '%59 (@__kernel_sin-%59-val s48) (@__kernel_sin-%58-loc s48)))
(defund @__kernel_sin-%60-val (s48)
  (load-double (g '%v (@__kernel_sin-%59-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-%60-loc (s48)
  (s '%60 (@__kernel_sin-%60-val s48) (@__kernel_sin-%59-loc s48)))
(defund @__kernel_sin-%61-val (s48)
  (fmul-double (g '%60 (@__kernel_sin-%60-loc s48)) #xBFC5555555555549))
(defund @__kernel_sin-%61-loc (s48)
  (s '%61 (@__kernel_sin-%61-val s48) (@__kernel_sin-%60-loc s48)))
(defund @__kernel_sin-%62-val (s48)
  (fsub-double (g '%59 (@__kernel_sin-%61-loc s48)) (g '%61 (@__kernel_sin-%61-loc s48))))
(defund @__kernel_sin-%62-loc (s48)
  (s '%62 (@__kernel_sin-%62-val s48) (@__kernel_sin-%61-loc s48)))
(defund @__kernel_sin-%63-val (s48)
  (fsub-double (g '%49 (@__kernel_sin-%62-loc s48)) (g '%62 (@__kernel_sin-%62-loc s48))))
(defund @__kernel_sin-%63-loc (s48)
  (s '%63 (@__kernel_sin-%63-val s48) (@__kernel_sin-%62-loc s48)))
(defund @__kernel_sin-m48.1-mem (s48)
  (store-double (g '%63 (@__kernel_sin-%63-loc s48)) (g '%1 (@__kernel_sin-%63-loc s48)) (@__kernel_sin-%48-mem s48)))
(defund @__kernel_sin-succ48-lab (s48)
  (declare (ignore s48))
  '%64)

(defund @__kernel_sin-succ48-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%64 mem loc))
(defund @__kernel_sin-m48.1-rev (mem loc pred)
  (@__kernel_sin-succ48-rev (store-double (g '%63 loc) (g '%1 loc) mem) loc pred))
(defund @__kernel_sin-%63-rev (mem loc pred)
  (@__kernel_sin-m48.1-rev mem (s '%63 (fsub-double (g '%49 loc) (g '%62 loc)) loc) pred))
(defund @__kernel_sin-%62-rev (mem loc pred)
  (@__kernel_sin-%63-rev mem (s '%62 (fsub-double (g '%59 loc) (g '%61 loc)) loc) pred))
(defund @__kernel_sin-%61-rev (mem loc pred)
  (@__kernel_sin-%62-rev mem (s '%61 (fmul-double (g '%60 loc) #xBFC5555555555549) loc) pred))
(defund @__kernel_sin-%60-rev (mem loc pred)
  (@__kernel_sin-%61-rev mem (s '%60 (load-double (g '%v loc) mem) loc) pred))
(defund @__kernel_sin-%59-rev (mem loc pred)
  (@__kernel_sin-%60-rev mem (s '%59 (fsub-double (g '%57 loc) (g '%58 loc)) loc) pred))
(defund @__kernel_sin-%58-rev (mem loc pred)
  (@__kernel_sin-%59-rev mem (s '%58 (load-double (g '%3 loc) mem) loc) pred))
(defund @__kernel_sin-%57-rev (mem loc pred)
  (@__kernel_sin-%58-rev mem (s '%57 (fmul-double (g '%50 loc) (g '%56 loc)) loc) pred))
(defund @__kernel_sin-%56-rev (mem loc pred)
  (@__kernel_sin-%57-rev mem (s '%56 (fsub-double (g '%52 loc) (g '%55 loc)) loc) pred))
(defund @__kernel_sin-%55-rev (mem loc pred)
  (@__kernel_sin-%56-rev mem (s '%55 (fmul-double (g '%53 loc) (g '%54 loc)) loc) pred))
(defund @__kernel_sin-%54-rev (mem loc pred)
  (@__kernel_sin-%55-rev mem (s '%54 (load-double (g '%r loc) mem) loc) pred))
(defund @__kernel_sin-%53-rev (mem loc pred)
  (@__kernel_sin-%54-rev mem (s '%53 (load-double (g '%v loc) mem) loc) pred))
(defund @__kernel_sin-%52-rev (mem loc pred)
  (@__kernel_sin-%53-rev mem (s '%52 (fmul-double #x3fe0000000000000 (g '%51 loc)) loc) pred))
(defund @__kernel_sin-%51-rev (mem loc pred)
  (@__kernel_sin-%52-rev mem (s '%51 (load-double (g '%3 loc) mem) loc) pred))
(defund @__kernel_sin-%50-rev (mem loc pred)
  (@__kernel_sin-%51-rev mem (s '%50 (load-double (g '%z loc) mem) loc) pred))
(defund @__kernel_sin-%49-rev (mem loc pred)
  (@__kernel_sin-%50-rev mem (s '%49 (load-double (g '%2 loc) mem) loc) pred))

(defund @__kernel_sin-%48-rev (mem loc pred)
  (@__kernel_sin-%49-rev mem loc pred))

(defund @__kernel_sin-%48-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%49 (load-double (g '%2 loc) mem) loc))
    (loc (s '%50 (load-double (g '%z loc) mem) loc))
    (loc (s '%51 (load-double (g '%3 loc) mem) loc))
    (loc (s '%52 (fmul-double #x3fe0000000000000 (g '%51 loc)) loc))
    (loc (s '%53 (load-double (g '%v loc) mem) loc))
    (loc (s '%54 (load-double (g '%r loc) mem) loc))
    (loc (s '%55 (fmul-double (g '%53 loc) (g '%54 loc)) loc))
    (loc (s '%56 (fsub-double (g '%52 loc) (g '%55 loc)) loc))
    (loc (s '%57 (fmul-double (g '%50 loc) (g '%56 loc)) loc))
    (loc (s '%58 (load-double (g '%3 loc) mem) loc))
    (loc (s '%59 (fsub-double (g '%57 loc) (g '%58 loc)) loc))
    (loc (s '%60 (load-double (g '%v loc) mem) loc))
    (loc (s '%61 (fmul-double (g '%60 loc) #xBFC5555555555549) loc))
    (loc (s '%62 (fsub-double (g '%59 loc) (g '%61 loc)) loc))
    (loc (s '%63 (fsub-double (g '%49 loc) (g '%62 loc)) loc))
    (mem (store-double (g '%63 loc) (g '%1 loc) mem))
    (succ '%64))
  (mv succ mem loc)))

(defruled @__kernel_sin-%48-expand-bb
  (equal (@__kernel_sin-%48-bb mem loc pred)
         (@__kernel_sin-%48-rev mem loc pred))
  :enable (@__kernel_sin-%48-bb @__kernel_sin-%48-rev
    @__kernel_sin-%49-rev
    @__kernel_sin-%50-rev
    @__kernel_sin-%51-rev
    @__kernel_sin-%52-rev
    @__kernel_sin-%53-rev
    @__kernel_sin-%54-rev
    @__kernel_sin-%55-rev
    @__kernel_sin-%56-rev
    @__kernel_sin-%57-rev
    @__kernel_sin-%58-rev
    @__kernel_sin-%59-rev
    @__kernel_sin-%60-rev
    @__kernel_sin-%61-rev
    @__kernel_sin-%62-rev
    @__kernel_sin-%63-rev
    @__kernel_sin-m48.1-rev
    @__kernel_sin-succ48-rev)
  :disable s-diff-s)

(defund @__kernel_sin-%64-mem (s64)
  (car s64))
(defund @__kernel_sin-%64-loc (s64)
  (cadr s64))
(defund @__kernel_sin-%64-pred (s64)
  (caddr s64))
(defund @__kernel_sin-%65-val (s64)
  (load-double (g '%1 (@__kernel_sin-%64-loc s64)) (@__kernel_sin-%64-mem s64)))
(defund @__kernel_sin-%65-loc (s64)
  (s '%65 (@__kernel_sin-%65-val s64) (@__kernel_sin-%64-loc s64)))
(defund @__kernel_sin-succ64-lab (s64)
  (declare (ignore s64))
  'ret)

(defund @__kernel_sin-succ64-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @__kernel_sin-%65-rev (mem loc pred)
  (@__kernel_sin-succ64-rev mem (s '%65 (load-double (g '%1 loc) mem) loc) pred))

(defund @__kernel_sin-%64-rev (mem loc pred)
  (@__kernel_sin-%65-rev mem loc pred))

(defund @__kernel_sin-%64-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%65 (load-double (g '%1 loc) mem) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @__kernel_sin-%64-expand-bb
  (equal (@__kernel_sin-%64-bb mem loc pred)
         (@__kernel_sin-%64-rev mem loc pred))
  :enable (@__kernel_sin-%64-bb @__kernel_sin-%64-rev
    @__kernel_sin-%65-rev
    @__kernel_sin-succ64-rev)
  :disable s-diff-s)

(defund @__kernel_sin-step (label mem loc pred)
  (case label
    (%0 (@__kernel_sin-%0-bb mem loc pred))
    (%11 (@__kernel_sin-%11-bb mem loc pred))
    (%15 (@__kernel_sin-%15-bb mem loc pred))
    (%17 (@__kernel_sin-%17-bb mem loc pred))
    (%18 (@__kernel_sin-%18-bb mem loc pred))
    (%39 (@__kernel_sin-%39-bb mem loc pred))
    (%48 (@__kernel_sin-%48-bb mem loc pred))
    (%64 (@__kernel_sin-%64-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @__kernel_sin-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%65 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@__kernel_sin-step label mem loc pred)
        (@__kernel_sin-steps new-label new-mem new-loc label (1- n))))))

(defund @__kernel_sin (%x %y %iy)
  (declare (ignore %x %y %iy))
   nil)
