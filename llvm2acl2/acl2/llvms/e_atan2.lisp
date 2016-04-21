(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_atan")

(defconst *__ieee754_atan2-globals* '())

(defconst *__ieee754_atan2-labels* '(%0 %26 %35 %39 %45 %48 %60 %62 %64 %65 %66 %67 %72 %76 %79 %82 %84 %85 %86 %87 %88 %89 %91 %92 %93 %94 %95 %96 %97 %100 %104 %111 %112 %115 %118 %119 %125 %126 %128 %130 %136 %140 %144))

(defund @__ieee754_atan2-%0-mem (s0)
  (car s0))
(defund @__ieee754_atan2-%0-loc (s0)
  (cadr s0))
(defund @__ieee754_atan2-%0-pred (s0)
  (caddr s0))
(defund @__ieee754_atan2-%1-mem (s0)
  (alloca-double 'ret 1 (@__ieee754_atan2-%0-mem s0)))
(defund @__ieee754_atan2-%1-loc (s0)
  (s '%1 '(ret . 0) (@__ieee754_atan2-%0-loc s0)))
(defund @__ieee754_atan2-%2-mem (s0)
  (alloca-double 'y 1 (@__ieee754_atan2-%1-mem s0)))
(defund @__ieee754_atan2-%2-loc (s0)
  (s '%2 '(y . 0) (@__ieee754_atan2-%1-loc s0)))
(defund @__ieee754_atan2-%3-mem (s0)
  (alloca-double 'x 1 (@__ieee754_atan2-%2-mem s0)))
(defund @__ieee754_atan2-%3-loc (s0)
  (s '%3 '(x . 0) (@__ieee754_atan2-%2-loc s0)))
(defund @__ieee754_atan2-%z-mem (s0)
  (alloca-double 'z 1 (@__ieee754_atan2-%3-mem s0)))
(defund @__ieee754_atan2-%z-loc (s0)
  (s '%z '(z . 0) (@__ieee754_atan2-%3-loc s0)))
(defund @__ieee754_atan2-%k-mem (s0)
  (alloca-i32 'k 1 (@__ieee754_atan2-%z-mem s0)))
(defund @__ieee754_atan2-%k-loc (s0)
  (s '%k '(k . 0) (@__ieee754_atan2-%z-loc s0)))
(defund @__ieee754_atan2-%m-mem (s0)
  (alloca-i32 'm 1 (@__ieee754_atan2-%k-mem s0)))
(defund @__ieee754_atan2-%m-loc (s0)
  (s '%m '(m . 0) (@__ieee754_atan2-%k-loc s0)))
(defund @__ieee754_atan2-%hx-mem (s0)
  (alloca-i32 'hx 1 (@__ieee754_atan2-%m-mem s0)))
(defund @__ieee754_atan2-%hx-loc (s0)
  (s '%hx '(hx . 0) (@__ieee754_atan2-%m-loc s0)))
(defund @__ieee754_atan2-%hy-mem (s0)
  (alloca-i32 'hy 1 (@__ieee754_atan2-%hx-mem s0)))
(defund @__ieee754_atan2-%hy-loc (s0)
  (s '%hy '(hy . 0) (@__ieee754_atan2-%hx-loc s0)))
(defund @__ieee754_atan2-%ix-mem (s0)
  (alloca-i32 'ix 1 (@__ieee754_atan2-%hy-mem s0)))
(defund @__ieee754_atan2-%ix-loc (s0)
  (s '%ix '(ix . 0) (@__ieee754_atan2-%hy-loc s0)))
(defund @__ieee754_atan2-%iy-mem (s0)
  (alloca-i32 'iy 1 (@__ieee754_atan2-%ix-mem s0)))
(defund @__ieee754_atan2-%iy-loc (s0)
  (s '%iy '(iy . 0) (@__ieee754_atan2-%ix-loc s0)))
(defund @__ieee754_atan2-%lx-mem (s0)
  (alloca-i32 'lx 1 (@__ieee754_atan2-%iy-mem s0)))
(defund @__ieee754_atan2-%lx-loc (s0)
  (s '%lx '(lx . 0) (@__ieee754_atan2-%iy-loc s0)))
(defund @__ieee754_atan2-%ly-mem (s0)
  (alloca-i32 'ly 1 (@__ieee754_atan2-%lx-mem s0)))
(defund @__ieee754_atan2-%ly-loc (s0)
  (s '%ly '(ly . 0) (@__ieee754_atan2-%lx-loc s0)))
(defund @__ieee754_atan2-m0.1-mem (s0)
  (store-double (g '%y (@__ieee754_atan2-%ly-loc s0)) (g '%2 (@__ieee754_atan2-%ly-loc s0)) (@__ieee754_atan2-%ly-mem s0)))
(defund @__ieee754_atan2-m0.2-mem (s0)
  (store-double (g '%x (@__ieee754_atan2-%ly-loc s0)) (g '%3 (@__ieee754_atan2-%ly-loc s0)) (@__ieee754_atan2-m0.1-mem s0)))
(defund @__ieee754_atan2-%4-val (s0)
  (bitcast-double*-to-i32* (g '%3 (@__ieee754_atan2-%ly-loc s0))))
(defund @__ieee754_atan2-%4-loc (s0)
  (s '%4 (@__ieee754_atan2-%4-val s0) (@__ieee754_atan2-%ly-loc s0)))
(defund @__ieee754_atan2-%5-val (s0)
  (getelementptr-i32 (g '%4 (@__ieee754_atan2-%4-loc s0)) 1))
(defund @__ieee754_atan2-%5-loc (s0)
  (s '%5 (@__ieee754_atan2-%5-val s0) (@__ieee754_atan2-%4-loc s0)))
(defund @__ieee754_atan2-%6-val (s0)
  (load-i32 (g '%5 (@__ieee754_atan2-%5-loc s0)) (@__ieee754_atan2-m0.2-mem s0)))
(defund @__ieee754_atan2-%6-loc (s0)
  (s '%6 (@__ieee754_atan2-%6-val s0) (@__ieee754_atan2-%5-loc s0)))
(defund @__ieee754_atan2-m0.3-mem (s0)
  (store-i32 (g '%6 (@__ieee754_atan2-%6-loc s0)) (g '%hx (@__ieee754_atan2-%6-loc s0)) (@__ieee754_atan2-m0.2-mem s0)))
(defund @__ieee754_atan2-%7-val (s0)
  (load-i32 (g '%hx (@__ieee754_atan2-%6-loc s0)) (@__ieee754_atan2-m0.3-mem s0)))
(defund @__ieee754_atan2-%7-loc (s0)
  (s '%7 (@__ieee754_atan2-%7-val s0) (@__ieee754_atan2-%6-loc s0)))
(defund @__ieee754_atan2-%8-val (s0)
  (and-i32 (g '%7 (@__ieee754_atan2-%7-loc s0)) 2147483647))
(defund @__ieee754_atan2-%8-loc (s0)
  (s '%8 (@__ieee754_atan2-%8-val s0) (@__ieee754_atan2-%7-loc s0)))
(defund @__ieee754_atan2-m0.4-mem (s0)
  (store-i32 (g '%8 (@__ieee754_atan2-%8-loc s0)) (g '%ix (@__ieee754_atan2-%8-loc s0)) (@__ieee754_atan2-m0.3-mem s0)))
(defund @__ieee754_atan2-%9-val (s0)
  (bitcast-double*-to-i32* (g '%3 (@__ieee754_atan2-%8-loc s0))))
(defund @__ieee754_atan2-%9-loc (s0)
  (s '%9 (@__ieee754_atan2-%9-val s0) (@__ieee754_atan2-%8-loc s0)))
(defund @__ieee754_atan2-%10-val (s0)
  (load-i32 (g '%9 (@__ieee754_atan2-%9-loc s0)) (@__ieee754_atan2-m0.4-mem s0)))
(defund @__ieee754_atan2-%10-loc (s0)
  (s '%10 (@__ieee754_atan2-%10-val s0) (@__ieee754_atan2-%9-loc s0)))
(defund @__ieee754_atan2-m0.5-mem (s0)
  (store-i32 (g '%10 (@__ieee754_atan2-%10-loc s0)) (g '%lx (@__ieee754_atan2-%10-loc s0)) (@__ieee754_atan2-m0.4-mem s0)))
(defund @__ieee754_atan2-%11-val (s0)
  (bitcast-double*-to-i32* (g '%2 (@__ieee754_atan2-%10-loc s0))))
(defund @__ieee754_atan2-%11-loc (s0)
  (s '%11 (@__ieee754_atan2-%11-val s0) (@__ieee754_atan2-%10-loc s0)))
(defund @__ieee754_atan2-%12-val (s0)
  (getelementptr-i32 (g '%11 (@__ieee754_atan2-%11-loc s0)) 1))
(defund @__ieee754_atan2-%12-loc (s0)
  (s '%12 (@__ieee754_atan2-%12-val s0) (@__ieee754_atan2-%11-loc s0)))
(defund @__ieee754_atan2-%13-val (s0)
  (load-i32 (g '%12 (@__ieee754_atan2-%12-loc s0)) (@__ieee754_atan2-m0.5-mem s0)))
(defund @__ieee754_atan2-%13-loc (s0)
  (s '%13 (@__ieee754_atan2-%13-val s0) (@__ieee754_atan2-%12-loc s0)))
(defund @__ieee754_atan2-m0.6-mem (s0)
  (store-i32 (g '%13 (@__ieee754_atan2-%13-loc s0)) (g '%hy (@__ieee754_atan2-%13-loc s0)) (@__ieee754_atan2-m0.5-mem s0)))
(defund @__ieee754_atan2-%14-val (s0)
  (load-i32 (g '%hy (@__ieee754_atan2-%13-loc s0)) (@__ieee754_atan2-m0.6-mem s0)))
(defund @__ieee754_atan2-%14-loc (s0)
  (s '%14 (@__ieee754_atan2-%14-val s0) (@__ieee754_atan2-%13-loc s0)))
(defund @__ieee754_atan2-%15-val (s0)
  (and-i32 (g '%14 (@__ieee754_atan2-%14-loc s0)) 2147483647))
(defund @__ieee754_atan2-%15-loc (s0)
  (s '%15 (@__ieee754_atan2-%15-val s0) (@__ieee754_atan2-%14-loc s0)))
(defund @__ieee754_atan2-m0.7-mem (s0)
  (store-i32 (g '%15 (@__ieee754_atan2-%15-loc s0)) (g '%iy (@__ieee754_atan2-%15-loc s0)) (@__ieee754_atan2-m0.6-mem s0)))
(defund @__ieee754_atan2-%16-val (s0)
  (bitcast-double*-to-i32* (g '%2 (@__ieee754_atan2-%15-loc s0))))
(defund @__ieee754_atan2-%16-loc (s0)
  (s '%16 (@__ieee754_atan2-%16-val s0) (@__ieee754_atan2-%15-loc s0)))
(defund @__ieee754_atan2-%17-val (s0)
  (load-i32 (g '%16 (@__ieee754_atan2-%16-loc s0)) (@__ieee754_atan2-m0.7-mem s0)))
(defund @__ieee754_atan2-%17-loc (s0)
  (s '%17 (@__ieee754_atan2-%17-val s0) (@__ieee754_atan2-%16-loc s0)))
(defund @__ieee754_atan2-m0.8-mem (s0)
  (store-i32 (g '%17 (@__ieee754_atan2-%17-loc s0)) (g '%ly (@__ieee754_atan2-%17-loc s0)) (@__ieee754_atan2-m0.7-mem s0)))
(defund @__ieee754_atan2-%18-val (s0)
  (load-i32 (g '%ix (@__ieee754_atan2-%17-loc s0)) (@__ieee754_atan2-m0.8-mem s0)))
(defund @__ieee754_atan2-%18-loc (s0)
  (s '%18 (@__ieee754_atan2-%18-val s0) (@__ieee754_atan2-%17-loc s0)))
(defund @__ieee754_atan2-%19-val (s0)
  (load-i32 (g '%lx (@__ieee754_atan2-%18-loc s0)) (@__ieee754_atan2-m0.8-mem s0)))
(defund @__ieee754_atan2-%19-loc (s0)
  (s '%19 (@__ieee754_atan2-%19-val s0) (@__ieee754_atan2-%18-loc s0)))
(defund @__ieee754_atan2-%20-val (s0)
  (load-i32 (g '%lx (@__ieee754_atan2-%19-loc s0)) (@__ieee754_atan2-m0.8-mem s0)))
(defund @__ieee754_atan2-%20-loc (s0)
  (s '%20 (@__ieee754_atan2-%20-val s0) (@__ieee754_atan2-%19-loc s0)))
(defund @__ieee754_atan2-%21-val (s0)
  (sub-i32 0 (g '%20 (@__ieee754_atan2-%20-loc s0))))
(defund @__ieee754_atan2-%21-loc (s0)
  (s '%21 (@__ieee754_atan2-%21-val s0) (@__ieee754_atan2-%20-loc s0)))
(defund @__ieee754_atan2-%22-val (s0)
  (or-i32 (g '%19 (@__ieee754_atan2-%21-loc s0)) (g '%21 (@__ieee754_atan2-%21-loc s0))))
(defund @__ieee754_atan2-%22-loc (s0)
  (s '%22 (@__ieee754_atan2-%22-val s0) (@__ieee754_atan2-%21-loc s0)))
(defund @__ieee754_atan2-%23-val (s0)
  (lshr-i32 (g '%22 (@__ieee754_atan2-%22-loc s0)) 31))
(defund @__ieee754_atan2-%23-loc (s0)
  (s '%23 (@__ieee754_atan2-%23-val s0) (@__ieee754_atan2-%22-loc s0)))
(defund @__ieee754_atan2-%24-val (s0)
  (or-i32 (g '%18 (@__ieee754_atan2-%23-loc s0)) (g '%23 (@__ieee754_atan2-%23-loc s0))))
(defund @__ieee754_atan2-%24-loc (s0)
  (s '%24 (@__ieee754_atan2-%24-val s0) (@__ieee754_atan2-%23-loc s0)))
(defund @__ieee754_atan2-%25-val (s0)
  (icmp-ugt-i32 (g '%24 (@__ieee754_atan2-%24-loc s0)) 2146435072))
(defund @__ieee754_atan2-%25-loc (s0)
  (s '%25 (@__ieee754_atan2-%25-val s0) (@__ieee754_atan2-%24-loc s0)))
(defund @__ieee754_atan2-succ0-lab (s0)
  (case (g '%25 (@__ieee754_atan2-%25-loc s0)) (-1 '%35) (0 '%26)))

(defund @__ieee754_atan2-succ0-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%25 loc) (-1 '%35) (0 '%26)) mem loc))
(defund @__ieee754_atan2-%25-rev (mem loc pred)
  (@__ieee754_atan2-succ0-rev mem (s '%25 (icmp-ugt-i32 (g '%24 loc) 2146435072) loc) pred))
(defund @__ieee754_atan2-%24-rev (mem loc pred)
  (@__ieee754_atan2-%25-rev mem (s '%24 (or-i32 (g '%18 loc) (g '%23 loc)) loc) pred))
(defund @__ieee754_atan2-%23-rev (mem loc pred)
  (@__ieee754_atan2-%24-rev mem (s '%23 (lshr-i32 (g '%22 loc) 31) loc) pred))
(defund @__ieee754_atan2-%22-rev (mem loc pred)
  (@__ieee754_atan2-%23-rev mem (s '%22 (or-i32 (g '%19 loc) (g '%21 loc)) loc) pred))
(defund @__ieee754_atan2-%21-rev (mem loc pred)
  (@__ieee754_atan2-%22-rev mem (s '%21 (sub-i32 0 (g '%20 loc)) loc) pred))
(defund @__ieee754_atan2-%20-rev (mem loc pred)
  (@__ieee754_atan2-%21-rev mem (s '%20 (load-i32 (g '%lx loc) mem) loc) pred))
(defund @__ieee754_atan2-%19-rev (mem loc pred)
  (@__ieee754_atan2-%20-rev mem (s '%19 (load-i32 (g '%lx loc) mem) loc) pred))
(defund @__ieee754_atan2-%18-rev (mem loc pred)
  (@__ieee754_atan2-%19-rev mem (s '%18 (load-i32 (g '%ix loc) mem) loc) pred))
(defund @__ieee754_atan2-m0.8-rev (mem loc pred)
  (@__ieee754_atan2-%18-rev (store-i32 (g '%17 loc) (g '%ly loc) mem) loc pred))
(defund @__ieee754_atan2-%17-rev (mem loc pred)
  (@__ieee754_atan2-m0.8-rev mem (s '%17 (load-i32 (g '%16 loc) mem) loc) pred))
(defund @__ieee754_atan2-%16-rev (mem loc pred)
  (@__ieee754_atan2-%17-rev mem (s '%16 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @__ieee754_atan2-m0.7-rev (mem loc pred)
  (@__ieee754_atan2-%16-rev (store-i32 (g '%15 loc) (g '%iy loc) mem) loc pred))
(defund @__ieee754_atan2-%15-rev (mem loc pred)
  (@__ieee754_atan2-m0.7-rev mem (s '%15 (and-i32 (g '%14 loc) 2147483647) loc) pred))
(defund @__ieee754_atan2-%14-rev (mem loc pred)
  (@__ieee754_atan2-%15-rev mem (s '%14 (load-i32 (g '%hy loc) mem) loc) pred))
(defund @__ieee754_atan2-m0.6-rev (mem loc pred)
  (@__ieee754_atan2-%14-rev (store-i32 (g '%13 loc) (g '%hy loc) mem) loc pred))
(defund @__ieee754_atan2-%13-rev (mem loc pred)
  (@__ieee754_atan2-m0.6-rev mem (s '%13 (load-i32 (g '%12 loc) mem) loc) pred))
(defund @__ieee754_atan2-%12-rev (mem loc pred)
  (@__ieee754_atan2-%13-rev mem (s '%12 (getelementptr-i32 (g '%11 loc) 1) loc) pred))
(defund @__ieee754_atan2-%11-rev (mem loc pred)
  (@__ieee754_atan2-%12-rev mem (s '%11 (bitcast-double*-to-i32* (g '%2 loc)) loc) pred))
(defund @__ieee754_atan2-m0.5-rev (mem loc pred)
  (@__ieee754_atan2-%11-rev (store-i32 (g '%10 loc) (g '%lx loc) mem) loc pred))
(defund @__ieee754_atan2-%10-rev (mem loc pred)
  (@__ieee754_atan2-m0.5-rev mem (s '%10 (load-i32 (g '%9 loc) mem) loc) pred))
(defund @__ieee754_atan2-%9-rev (mem loc pred)
  (@__ieee754_atan2-%10-rev mem (s '%9 (bitcast-double*-to-i32* (g '%3 loc)) loc) pred))
(defund @__ieee754_atan2-m0.4-rev (mem loc pred)
  (@__ieee754_atan2-%9-rev (store-i32 (g '%8 loc) (g '%ix loc) mem) loc pred))
(defund @__ieee754_atan2-%8-rev (mem loc pred)
  (@__ieee754_atan2-m0.4-rev mem (s '%8 (and-i32 (g '%7 loc) 2147483647) loc) pred))
(defund @__ieee754_atan2-%7-rev (mem loc pred)
  (@__ieee754_atan2-%8-rev mem (s '%7 (load-i32 (g '%hx loc) mem) loc) pred))
(defund @__ieee754_atan2-m0.3-rev (mem loc pred)
  (@__ieee754_atan2-%7-rev (store-i32 (g '%6 loc) (g '%hx loc) mem) loc pred))
(defund @__ieee754_atan2-%6-rev (mem loc pred)
  (@__ieee754_atan2-m0.3-rev mem (s '%6 (load-i32 (g '%5 loc) mem) loc) pred))
(defund @__ieee754_atan2-%5-rev (mem loc pred)
  (@__ieee754_atan2-%6-rev mem (s '%5 (getelementptr-i32 (g '%4 loc) 1) loc) pred))
(defund @__ieee754_atan2-%4-rev (mem loc pred)
  (@__ieee754_atan2-%5-rev mem (s '%4 (bitcast-double*-to-i32* (g '%3 loc)) loc) pred))
(defund @__ieee754_atan2-m0.2-rev (mem loc pred)
  (@__ieee754_atan2-%4-rev (store-double (g '%x loc) (g '%3 loc) mem) loc pred))
(defund @__ieee754_atan2-m0.1-rev (mem loc pred)
  (@__ieee754_atan2-m0.2-rev (store-double (g '%y loc) (g '%2 loc) mem) loc pred))
(defund @__ieee754_atan2-%ly-rev (mem loc pred)
  (@__ieee754_atan2-m0.1-rev (alloca-i32 'ly 1 mem) (s '%ly '(ly . 0) loc) pred))
(defund @__ieee754_atan2-%lx-rev (mem loc pred)
  (@__ieee754_atan2-%ly-rev (alloca-i32 'lx 1 mem) (s '%lx '(lx . 0) loc) pred))
(defund @__ieee754_atan2-%iy-rev (mem loc pred)
  (@__ieee754_atan2-%lx-rev (alloca-i32 'iy 1 mem) (s '%iy '(iy . 0) loc) pred))
(defund @__ieee754_atan2-%ix-rev (mem loc pred)
  (@__ieee754_atan2-%iy-rev (alloca-i32 'ix 1 mem) (s '%ix '(ix . 0) loc) pred))
(defund @__ieee754_atan2-%hy-rev (mem loc pred)
  (@__ieee754_atan2-%ix-rev (alloca-i32 'hy 1 mem) (s '%hy '(hy . 0) loc) pred))
(defund @__ieee754_atan2-%hx-rev (mem loc pred)
  (@__ieee754_atan2-%hy-rev (alloca-i32 'hx 1 mem) (s '%hx '(hx . 0) loc) pred))
(defund @__ieee754_atan2-%m-rev (mem loc pred)
  (@__ieee754_atan2-%hx-rev (alloca-i32 'm 1 mem) (s '%m '(m . 0) loc) pred))
(defund @__ieee754_atan2-%k-rev (mem loc pred)
  (@__ieee754_atan2-%m-rev (alloca-i32 'k 1 mem) (s '%k '(k . 0) loc) pred))
(defund @__ieee754_atan2-%z-rev (mem loc pred)
  (@__ieee754_atan2-%k-rev (alloca-double 'z 1 mem) (s '%z '(z . 0) loc) pred))
(defund @__ieee754_atan2-%3-rev (mem loc pred)
  (@__ieee754_atan2-%z-rev (alloca-double 'x 1 mem) (s '%3 '(x . 0) loc) pred))
(defund @__ieee754_atan2-%2-rev (mem loc pred)
  (@__ieee754_atan2-%3-rev (alloca-double 'y 1 mem) (s '%2 '(y . 0) loc) pred))
(defund @__ieee754_atan2-%1-rev (mem loc pred)
  (@__ieee754_atan2-%2-rev (alloca-double 'ret 1 mem) (s '%1 '(ret . 0) loc) pred))

(defund @__ieee754_atan2-%0-rev (mem loc pred)
  (@__ieee754_atan2-%1-rev mem loc pred))

(defund @__ieee754_atan2-%0-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (loc (s '%1 '(ret . 0) loc))
    (mem (alloca-double 'y 1 mem))
    (loc (s '%2 '(y . 0) loc))
    (mem (alloca-double 'x 1 mem))
    (loc (s '%3 '(x . 0) loc))
    (mem (alloca-double 'z 1 mem))
    (loc (s '%z '(z . 0) loc))
    (mem (alloca-i32 'k 1 mem))
    (loc (s '%k '(k . 0) loc))
    (mem (alloca-i32 'm 1 mem))
    (loc (s '%m '(m . 0) loc))
    (mem (alloca-i32 'hx 1 mem))
    (loc (s '%hx '(hx . 0) loc))
    (mem (alloca-i32 'hy 1 mem))
    (loc (s '%hy '(hy . 0) loc))
    (mem (alloca-i32 'ix 1 mem))
    (loc (s '%ix '(ix . 0) loc))
    (mem (alloca-i32 'iy 1 mem))
    (loc (s '%iy '(iy . 0) loc))
    (mem (alloca-i32 'lx 1 mem))
    (loc (s '%lx '(lx . 0) loc))
    (mem (alloca-i32 'ly 1 mem))
    (loc (s '%ly '(ly . 0) loc))
    (mem (store-double (g '%y loc) (g '%2 loc) mem))
    (mem (store-double (g '%x loc) (g '%3 loc) mem))
    (loc (s '%4 (bitcast-double*-to-i32* (g '%3 loc)) loc))
    (loc (s '%5 (getelementptr-i32 (g '%4 loc) 1) loc))
    (loc (s '%6 (load-i32 (g '%5 loc) mem) loc))
    (mem (store-i32 (g '%6 loc) (g '%hx loc) mem))
    (loc (s '%7 (load-i32 (g '%hx loc) mem) loc))
    (loc (s '%8 (and-i32 (g '%7 loc) 2147483647) loc))
    (mem (store-i32 (g '%8 loc) (g '%ix loc) mem))
    (loc (s '%9 (bitcast-double*-to-i32* (g '%3 loc)) loc))
    (loc (s '%10 (load-i32 (g '%9 loc) mem) loc))
    (mem (store-i32 (g '%10 loc) (g '%lx loc) mem))
    (loc (s '%11 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%12 (getelementptr-i32 (g '%11 loc) 1) loc))
    (loc (s '%13 (load-i32 (g '%12 loc) mem) loc))
    (mem (store-i32 (g '%13 loc) (g '%hy loc) mem))
    (loc (s '%14 (load-i32 (g '%hy loc) mem) loc))
    (loc (s '%15 (and-i32 (g '%14 loc) 2147483647) loc))
    (mem (store-i32 (g '%15 loc) (g '%iy loc) mem))
    (loc (s '%16 (bitcast-double*-to-i32* (g '%2 loc)) loc))
    (loc (s '%17 (load-i32 (g '%16 loc) mem) loc))
    (mem (store-i32 (g '%17 loc) (g '%ly loc) mem))
    (loc (s '%18 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%19 (load-i32 (g '%lx loc) mem) loc))
    (loc (s '%20 (load-i32 (g '%lx loc) mem) loc))
    (loc (s '%21 (sub-i32 0 (g '%20 loc)) loc))
    (loc (s '%22 (or-i32 (g '%19 loc) (g '%21 loc)) loc))
    (loc (s '%23 (lshr-i32 (g '%22 loc) 31) loc))
    (loc (s '%24 (or-i32 (g '%18 loc) (g '%23 loc)) loc))
    (loc (s '%25 (icmp-ugt-i32 (g '%24 loc) 2146435072) loc))
    (succ (case (g '%25 loc) (-1 '%35) (0 '%26))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%0-expand-bb
  (equal (@__ieee754_atan2-%0-bb mem loc pred)
         (@__ieee754_atan2-%0-rev mem loc pred))
  :enable (@__ieee754_atan2-%0-bb @__ieee754_atan2-%0-rev
    @__ieee754_atan2-%1-rev
    @__ieee754_atan2-%2-rev
    @__ieee754_atan2-%3-rev
    @__ieee754_atan2-%z-rev
    @__ieee754_atan2-%k-rev
    @__ieee754_atan2-%m-rev
    @__ieee754_atan2-%hx-rev
    @__ieee754_atan2-%hy-rev
    @__ieee754_atan2-%ix-rev
    @__ieee754_atan2-%iy-rev
    @__ieee754_atan2-%lx-rev
    @__ieee754_atan2-%ly-rev
    @__ieee754_atan2-m0.1-rev
    @__ieee754_atan2-m0.2-rev
    @__ieee754_atan2-%4-rev
    @__ieee754_atan2-%5-rev
    @__ieee754_atan2-%6-rev
    @__ieee754_atan2-m0.3-rev
    @__ieee754_atan2-%7-rev
    @__ieee754_atan2-%8-rev
    @__ieee754_atan2-m0.4-rev
    @__ieee754_atan2-%9-rev
    @__ieee754_atan2-%10-rev
    @__ieee754_atan2-m0.5-rev
    @__ieee754_atan2-%11-rev
    @__ieee754_atan2-%12-rev
    @__ieee754_atan2-%13-rev
    @__ieee754_atan2-m0.6-rev
    @__ieee754_atan2-%14-rev
    @__ieee754_atan2-%15-rev
    @__ieee754_atan2-m0.7-rev
    @__ieee754_atan2-%16-rev
    @__ieee754_atan2-%17-rev
    @__ieee754_atan2-m0.8-rev
    @__ieee754_atan2-%18-rev
    @__ieee754_atan2-%19-rev
    @__ieee754_atan2-%20-rev
    @__ieee754_atan2-%21-rev
    @__ieee754_atan2-%22-rev
    @__ieee754_atan2-%23-rev
    @__ieee754_atan2-%24-rev
    @__ieee754_atan2-%25-rev
    @__ieee754_atan2-succ0-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%26-mem (s26)
  (car s26))
(defund @__ieee754_atan2-%26-loc (s26)
  (cadr s26))
(defund @__ieee754_atan2-%26-pred (s26)
  (caddr s26))
(defund @__ieee754_atan2-%27-val (s26)
  (load-i32 (g '%iy (@__ieee754_atan2-%26-loc s26)) (@__ieee754_atan2-%26-mem s26)))
(defund @__ieee754_atan2-%27-loc (s26)
  (s '%27 (@__ieee754_atan2-%27-val s26) (@__ieee754_atan2-%26-loc s26)))
(defund @__ieee754_atan2-%28-val (s26)
  (load-i32 (g '%ly (@__ieee754_atan2-%27-loc s26)) (@__ieee754_atan2-%26-mem s26)))
(defund @__ieee754_atan2-%28-loc (s26)
  (s '%28 (@__ieee754_atan2-%28-val s26) (@__ieee754_atan2-%27-loc s26)))
(defund @__ieee754_atan2-%29-val (s26)
  (load-i32 (g '%ly (@__ieee754_atan2-%28-loc s26)) (@__ieee754_atan2-%26-mem s26)))
(defund @__ieee754_atan2-%29-loc (s26)
  (s '%29 (@__ieee754_atan2-%29-val s26) (@__ieee754_atan2-%28-loc s26)))
(defund @__ieee754_atan2-%30-val (s26)
  (sub-i32 0 (g '%29 (@__ieee754_atan2-%29-loc s26))))
(defund @__ieee754_atan2-%30-loc (s26)
  (s '%30 (@__ieee754_atan2-%30-val s26) (@__ieee754_atan2-%29-loc s26)))
(defund @__ieee754_atan2-%31-val (s26)
  (or-i32 (g '%28 (@__ieee754_atan2-%30-loc s26)) (g '%30 (@__ieee754_atan2-%30-loc s26))))
(defund @__ieee754_atan2-%31-loc (s26)
  (s '%31 (@__ieee754_atan2-%31-val s26) (@__ieee754_atan2-%30-loc s26)))
(defund @__ieee754_atan2-%32-val (s26)
  (lshr-i32 (g '%31 (@__ieee754_atan2-%31-loc s26)) 31))
(defund @__ieee754_atan2-%32-loc (s26)
  (s '%32 (@__ieee754_atan2-%32-val s26) (@__ieee754_atan2-%31-loc s26)))
(defund @__ieee754_atan2-%33-val (s26)
  (or-i32 (g '%27 (@__ieee754_atan2-%32-loc s26)) (g '%32 (@__ieee754_atan2-%32-loc s26))))
(defund @__ieee754_atan2-%33-loc (s26)
  (s '%33 (@__ieee754_atan2-%33-val s26) (@__ieee754_atan2-%32-loc s26)))
(defund @__ieee754_atan2-%34-val (s26)
  (icmp-ugt-i32 (g '%33 (@__ieee754_atan2-%33-loc s26)) 2146435072))
(defund @__ieee754_atan2-%34-loc (s26)
  (s '%34 (@__ieee754_atan2-%34-val s26) (@__ieee754_atan2-%33-loc s26)))
(defund @__ieee754_atan2-succ26-lab (s26)
  (case (g '%34 (@__ieee754_atan2-%34-loc s26)) (-1 '%35) (0 '%39)))

(defund @__ieee754_atan2-succ26-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%34 loc) (-1 '%35) (0 '%39)) mem loc))
(defund @__ieee754_atan2-%34-rev (mem loc pred)
  (@__ieee754_atan2-succ26-rev mem (s '%34 (icmp-ugt-i32 (g '%33 loc) 2146435072) loc) pred))
(defund @__ieee754_atan2-%33-rev (mem loc pred)
  (@__ieee754_atan2-%34-rev mem (s '%33 (or-i32 (g '%27 loc) (g '%32 loc)) loc) pred))
(defund @__ieee754_atan2-%32-rev (mem loc pred)
  (@__ieee754_atan2-%33-rev mem (s '%32 (lshr-i32 (g '%31 loc) 31) loc) pred))
(defund @__ieee754_atan2-%31-rev (mem loc pred)
  (@__ieee754_atan2-%32-rev mem (s '%31 (or-i32 (g '%28 loc) (g '%30 loc)) loc) pred))
(defund @__ieee754_atan2-%30-rev (mem loc pred)
  (@__ieee754_atan2-%31-rev mem (s '%30 (sub-i32 0 (g '%29 loc)) loc) pred))
(defund @__ieee754_atan2-%29-rev (mem loc pred)
  (@__ieee754_atan2-%30-rev mem (s '%29 (load-i32 (g '%ly loc) mem) loc) pred))
(defund @__ieee754_atan2-%28-rev (mem loc pred)
  (@__ieee754_atan2-%29-rev mem (s '%28 (load-i32 (g '%ly loc) mem) loc) pred))
(defund @__ieee754_atan2-%27-rev (mem loc pred)
  (@__ieee754_atan2-%28-rev mem (s '%27 (load-i32 (g '%iy loc) mem) loc) pred))

(defund @__ieee754_atan2-%26-rev (mem loc pred)
  (@__ieee754_atan2-%27-rev mem loc pred))

(defund @__ieee754_atan2-%26-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%27 (load-i32 (g '%iy loc) mem) loc))
    (loc (s '%28 (load-i32 (g '%ly loc) mem) loc))
    (loc (s '%29 (load-i32 (g '%ly loc) mem) loc))
    (loc (s '%30 (sub-i32 0 (g '%29 loc)) loc))
    (loc (s '%31 (or-i32 (g '%28 loc) (g '%30 loc)) loc))
    (loc (s '%32 (lshr-i32 (g '%31 loc) 31) loc))
    (loc (s '%33 (or-i32 (g '%27 loc) (g '%32 loc)) loc))
    (loc (s '%34 (icmp-ugt-i32 (g '%33 loc) 2146435072) loc))
    (succ (case (g '%34 loc) (-1 '%35) (0 '%39))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%26-expand-bb
  (equal (@__ieee754_atan2-%26-bb mem loc pred)
         (@__ieee754_atan2-%26-rev mem loc pred))
  :enable (@__ieee754_atan2-%26-bb @__ieee754_atan2-%26-rev
    @__ieee754_atan2-%27-rev
    @__ieee754_atan2-%28-rev
    @__ieee754_atan2-%29-rev
    @__ieee754_atan2-%30-rev
    @__ieee754_atan2-%31-rev
    @__ieee754_atan2-%32-rev
    @__ieee754_atan2-%33-rev
    @__ieee754_atan2-%34-rev
    @__ieee754_atan2-succ26-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%35-mem (s35)
  (car s35))
(defund @__ieee754_atan2-%35-loc (s35)
  (cadr s35))
(defund @__ieee754_atan2-%35-pred (s35)
  (caddr s35))
(defund @__ieee754_atan2-%36-val (s35)
  (load-double (g '%3 (@__ieee754_atan2-%35-loc s35)) (@__ieee754_atan2-%35-mem s35)))
(defund @__ieee754_atan2-%36-loc (s35)
  (s '%36 (@__ieee754_atan2-%36-val s35) (@__ieee754_atan2-%35-loc s35)))
(defund @__ieee754_atan2-%37-val (s35)
  (load-double (g '%2 (@__ieee754_atan2-%36-loc s35)) (@__ieee754_atan2-%35-mem s35)))
(defund @__ieee754_atan2-%37-loc (s35)
  (s '%37 (@__ieee754_atan2-%37-val s35) (@__ieee754_atan2-%36-loc s35)))
(defund @__ieee754_atan2-%38-val (s35)
  (fadd-double (g '%36 (@__ieee754_atan2-%37-loc s35)) (g '%37 (@__ieee754_atan2-%37-loc s35))))
(defund @__ieee754_atan2-%38-loc (s35)
  (s '%38 (@__ieee754_atan2-%38-val s35) (@__ieee754_atan2-%37-loc s35)))
(defund @__ieee754_atan2-m35.1-mem (s35)
  (store-double (g '%38 (@__ieee754_atan2-%38-loc s35)) (g '%1 (@__ieee754_atan2-%38-loc s35)) (@__ieee754_atan2-%35-mem s35)))
(defund @__ieee754_atan2-succ35-lab (s35)
  (declare (ignore s35))
  '%144)

(defund @__ieee754_atan2-succ35-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m35.1-rev (mem loc pred)
  (@__ieee754_atan2-succ35-rev (store-double (g '%38 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%38-rev (mem loc pred)
  (@__ieee754_atan2-m35.1-rev mem (s '%38 (fadd-double (g '%36 loc) (g '%37 loc)) loc) pred))
(defund @__ieee754_atan2-%37-rev (mem loc pred)
  (@__ieee754_atan2-%38-rev mem (s '%37 (load-double (g '%2 loc) mem) loc) pred))
(defund @__ieee754_atan2-%36-rev (mem loc pred)
  (@__ieee754_atan2-%37-rev mem (s '%36 (load-double (g '%3 loc) mem) loc) pred))

(defund @__ieee754_atan2-%35-rev (mem loc pred)
  (@__ieee754_atan2-%36-rev mem loc pred))

(defund @__ieee754_atan2-%35-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%36 (load-double (g '%3 loc) mem) loc))
    (loc (s '%37 (load-double (g '%2 loc) mem) loc))
    (loc (s '%38 (fadd-double (g '%36 loc) (g '%37 loc)) loc))
    (mem (store-double (g '%38 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%35-expand-bb
  (equal (@__ieee754_atan2-%35-bb mem loc pred)
         (@__ieee754_atan2-%35-rev mem loc pred))
  :enable (@__ieee754_atan2-%35-bb @__ieee754_atan2-%35-rev
    @__ieee754_atan2-%36-rev
    @__ieee754_atan2-%37-rev
    @__ieee754_atan2-%38-rev
    @__ieee754_atan2-m35.1-rev
    @__ieee754_atan2-succ35-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%39-mem (s39)
  (car s39))
(defund @__ieee754_atan2-%39-loc (s39)
  (cadr s39))
(defund @__ieee754_atan2-%39-pred (s39)
  (caddr s39))
(defund @__ieee754_atan2-%40-val (s39)
  (load-i32 (g '%hx (@__ieee754_atan2-%39-loc s39)) (@__ieee754_atan2-%39-mem s39)))
(defund @__ieee754_atan2-%40-loc (s39)
  (s '%40 (@__ieee754_atan2-%40-val s39) (@__ieee754_atan2-%39-loc s39)))
(defund @__ieee754_atan2-%41-val (s39)
  (sub-i32 (g '%40 (@__ieee754_atan2-%40-loc s39)) 1072693248))
(defund @__ieee754_atan2-%41-loc (s39)
  (s '%41 (@__ieee754_atan2-%41-val s39) (@__ieee754_atan2-%40-loc s39)))
(defund @__ieee754_atan2-%42-val (s39)
  (load-i32 (g '%lx (@__ieee754_atan2-%41-loc s39)) (@__ieee754_atan2-%39-mem s39)))
(defund @__ieee754_atan2-%42-loc (s39)
  (s '%42 (@__ieee754_atan2-%42-val s39) (@__ieee754_atan2-%41-loc s39)))
(defund @__ieee754_atan2-%43-val (s39)
  (or-i32 (g '%41 (@__ieee754_atan2-%42-loc s39)) (g '%42 (@__ieee754_atan2-%42-loc s39))))
(defund @__ieee754_atan2-%43-loc (s39)
  (s '%43 (@__ieee754_atan2-%43-val s39) (@__ieee754_atan2-%42-loc s39)))
(defund @__ieee754_atan2-%44-val (s39)
  (icmp-eq-i32 (g '%43 (@__ieee754_atan2-%43-loc s39)) 0))
(defund @__ieee754_atan2-%44-loc (s39)
  (s '%44 (@__ieee754_atan2-%44-val s39) (@__ieee754_atan2-%43-loc s39)))
(defund @__ieee754_atan2-succ39-lab (s39)
  (case (g '%44 (@__ieee754_atan2-%44-loc s39)) (-1 '%45) (0 '%48)))

(defund @__ieee754_atan2-succ39-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%44 loc) (-1 '%45) (0 '%48)) mem loc))
(defund @__ieee754_atan2-%44-rev (mem loc pred)
  (@__ieee754_atan2-succ39-rev mem (s '%44 (icmp-eq-i32 (g '%43 loc) 0) loc) pred))
(defund @__ieee754_atan2-%43-rev (mem loc pred)
  (@__ieee754_atan2-%44-rev mem (s '%43 (or-i32 (g '%41 loc) (g '%42 loc)) loc) pred))
(defund @__ieee754_atan2-%42-rev (mem loc pred)
  (@__ieee754_atan2-%43-rev mem (s '%42 (load-i32 (g '%lx loc) mem) loc) pred))
(defund @__ieee754_atan2-%41-rev (mem loc pred)
  (@__ieee754_atan2-%42-rev mem (s '%41 (sub-i32 (g '%40 loc) 1072693248) loc) pred))
(defund @__ieee754_atan2-%40-rev (mem loc pred)
  (@__ieee754_atan2-%41-rev mem (s '%40 (load-i32 (g '%hx loc) mem) loc) pred))

(defund @__ieee754_atan2-%39-rev (mem loc pred)
  (@__ieee754_atan2-%40-rev mem loc pred))

(defund @__ieee754_atan2-%39-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%40 (load-i32 (g '%hx loc) mem) loc))
    (loc (s '%41 (sub-i32 (g '%40 loc) 1072693248) loc))
    (loc (s '%42 (load-i32 (g '%lx loc) mem) loc))
    (loc (s '%43 (or-i32 (g '%41 loc) (g '%42 loc)) loc))
    (loc (s '%44 (icmp-eq-i32 (g '%43 loc) 0) loc))
    (succ (case (g '%44 loc) (-1 '%45) (0 '%48))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%39-expand-bb
  (equal (@__ieee754_atan2-%39-bb mem loc pred)
         (@__ieee754_atan2-%39-rev mem loc pred))
  :enable (@__ieee754_atan2-%39-bb @__ieee754_atan2-%39-rev
    @__ieee754_atan2-%40-rev
    @__ieee754_atan2-%41-rev
    @__ieee754_atan2-%42-rev
    @__ieee754_atan2-%43-rev
    @__ieee754_atan2-%44-rev
    @__ieee754_atan2-succ39-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%45-mem (s45)
  (car s45))
(defund @__ieee754_atan2-%45-loc (s45)
  (cadr s45))
(defund @__ieee754_atan2-%45-pred (s45)
  (caddr s45))
(defund @__ieee754_atan2-%46-val (s45)
  (load-double (g '%2 (@__ieee754_atan2-%45-loc s45)) (@__ieee754_atan2-%45-mem s45)))
(defund @__ieee754_atan2-%46-loc (s45)
  (s '%46 (@__ieee754_atan2-%46-val s45) (@__ieee754_atan2-%45-loc s45)))
(defund @__ieee754_atan2-%47-val (s45)
  (@atan (g '%46 (@__ieee754_atan2-%46-loc s45))))
(defund @__ieee754_atan2-%47-loc (s45)
  (s '%47 (@__ieee754_atan2-%47-val s45) (@__ieee754_atan2-%46-loc s45)))
(defund @__ieee754_atan2-m45.1-mem (s45)
  (store-double (g '%47 (@__ieee754_atan2-%47-loc s45)) (g '%1 (@__ieee754_atan2-%47-loc s45)) (@__ieee754_atan2-%45-mem s45)))
(defund @__ieee754_atan2-succ45-lab (s45)
  (declare (ignore s45))
  '%144)

(defund @__ieee754_atan2-succ45-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m45.1-rev (mem loc pred)
  (@__ieee754_atan2-succ45-rev (store-double (g '%47 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%47-rev (mem loc pred)
  (@__ieee754_atan2-m45.1-rev mem (s '%47 (@atan (g '%46 loc)) loc) pred))
(defund @__ieee754_atan2-%46-rev (mem loc pred)
  (@__ieee754_atan2-%47-rev mem (s '%46 (load-double (g '%2 loc) mem) loc) pred))

(defund @__ieee754_atan2-%45-rev (mem loc pred)
  (@__ieee754_atan2-%46-rev mem loc pred))

(defund @__ieee754_atan2-%45-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%46 (load-double (g '%2 loc) mem) loc))
    (loc (s '%47 (@atan (g '%46 loc)) loc))
    (mem (store-double (g '%47 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%45-expand-bb
  (equal (@__ieee754_atan2-%45-bb mem loc pred)
         (@__ieee754_atan2-%45-rev mem loc pred))
  :enable (@__ieee754_atan2-%45-bb @__ieee754_atan2-%45-rev
    @__ieee754_atan2-%46-rev
    @__ieee754_atan2-%47-rev
    @__ieee754_atan2-m45.1-rev
    @__ieee754_atan2-succ45-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%48-mem (s48)
  (car s48))
(defund @__ieee754_atan2-%48-loc (s48)
  (cadr s48))
(defund @__ieee754_atan2-%48-pred (s48)
  (caddr s48))
(defund @__ieee754_atan2-%49-val (s48)
  (load-i32 (g '%hy (@__ieee754_atan2-%48-loc s48)) (@__ieee754_atan2-%48-mem s48)))
(defund @__ieee754_atan2-%49-loc (s48)
  (s '%49 (@__ieee754_atan2-%49-val s48) (@__ieee754_atan2-%48-loc s48)))
(defund @__ieee754_atan2-%50-val (s48)
  (ashr-i32 (g '%49 (@__ieee754_atan2-%49-loc s48)) 31))
(defund @__ieee754_atan2-%50-loc (s48)
  (s '%50 (@__ieee754_atan2-%50-val s48) (@__ieee754_atan2-%49-loc s48)))
(defund @__ieee754_atan2-%51-val (s48)
  (and-i32 (g '%50 (@__ieee754_atan2-%50-loc s48)) 1))
(defund @__ieee754_atan2-%51-loc (s48)
  (s '%51 (@__ieee754_atan2-%51-val s48) (@__ieee754_atan2-%50-loc s48)))
(defund @__ieee754_atan2-%52-val (s48)
  (load-i32 (g '%hx (@__ieee754_atan2-%51-loc s48)) (@__ieee754_atan2-%48-mem s48)))
(defund @__ieee754_atan2-%52-loc (s48)
  (s '%52 (@__ieee754_atan2-%52-val s48) (@__ieee754_atan2-%51-loc s48)))
(defund @__ieee754_atan2-%53-val (s48)
  (ashr-i32 (g '%52 (@__ieee754_atan2-%52-loc s48)) 30))
(defund @__ieee754_atan2-%53-loc (s48)
  (s '%53 (@__ieee754_atan2-%53-val s48) (@__ieee754_atan2-%52-loc s48)))
(defund @__ieee754_atan2-%54-val (s48)
  (and-i32 (g '%53 (@__ieee754_atan2-%53-loc s48)) 2))
(defund @__ieee754_atan2-%54-loc (s48)
  (s '%54 (@__ieee754_atan2-%54-val s48) (@__ieee754_atan2-%53-loc s48)))
(defund @__ieee754_atan2-%55-val (s48)
  (or-i32 (g '%51 (@__ieee754_atan2-%54-loc s48)) (g '%54 (@__ieee754_atan2-%54-loc s48))))
(defund @__ieee754_atan2-%55-loc (s48)
  (s '%55 (@__ieee754_atan2-%55-val s48) (@__ieee754_atan2-%54-loc s48)))
(defund @__ieee754_atan2-m48.1-mem (s48)
  (store-i32 (g '%55 (@__ieee754_atan2-%55-loc s48)) (g '%m (@__ieee754_atan2-%55-loc s48)) (@__ieee754_atan2-%48-mem s48)))
(defund @__ieee754_atan2-%56-val (s48)
  (load-i32 (g '%iy (@__ieee754_atan2-%55-loc s48)) (@__ieee754_atan2-m48.1-mem s48)))
(defund @__ieee754_atan2-%56-loc (s48)
  (s '%56 (@__ieee754_atan2-%56-val s48) (@__ieee754_atan2-%55-loc s48)))
(defund @__ieee754_atan2-%57-val (s48)
  (load-i32 (g '%ly (@__ieee754_atan2-%56-loc s48)) (@__ieee754_atan2-m48.1-mem s48)))
(defund @__ieee754_atan2-%57-loc (s48)
  (s '%57 (@__ieee754_atan2-%57-val s48) (@__ieee754_atan2-%56-loc s48)))
(defund @__ieee754_atan2-%58-val (s48)
  (or-i32 (g '%56 (@__ieee754_atan2-%57-loc s48)) (g '%57 (@__ieee754_atan2-%57-loc s48))))
(defund @__ieee754_atan2-%58-loc (s48)
  (s '%58 (@__ieee754_atan2-%58-val s48) (@__ieee754_atan2-%57-loc s48)))
(defund @__ieee754_atan2-%59-val (s48)
  (icmp-eq-i32 (g '%58 (@__ieee754_atan2-%58-loc s48)) 0))
(defund @__ieee754_atan2-%59-loc (s48)
  (s '%59 (@__ieee754_atan2-%59-val s48) (@__ieee754_atan2-%58-loc s48)))
(defund @__ieee754_atan2-succ48-lab (s48)
  (case (g '%59 (@__ieee754_atan2-%59-loc s48)) (-1 '%60) (0 '%67)))

(defund @__ieee754_atan2-succ48-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%59 loc) (-1 '%60) (0 '%67)) mem loc))
(defund @__ieee754_atan2-%59-rev (mem loc pred)
  (@__ieee754_atan2-succ48-rev mem (s '%59 (icmp-eq-i32 (g '%58 loc) 0) loc) pred))
(defund @__ieee754_atan2-%58-rev (mem loc pred)
  (@__ieee754_atan2-%59-rev mem (s '%58 (or-i32 (g '%56 loc) (g '%57 loc)) loc) pred))
(defund @__ieee754_atan2-%57-rev (mem loc pred)
  (@__ieee754_atan2-%58-rev mem (s '%57 (load-i32 (g '%ly loc) mem) loc) pred))
(defund @__ieee754_atan2-%56-rev (mem loc pred)
  (@__ieee754_atan2-%57-rev mem (s '%56 (load-i32 (g '%iy loc) mem) loc) pred))
(defund @__ieee754_atan2-m48.1-rev (mem loc pred)
  (@__ieee754_atan2-%56-rev (store-i32 (g '%55 loc) (g '%m loc) mem) loc pred))
(defund @__ieee754_atan2-%55-rev (mem loc pred)
  (@__ieee754_atan2-m48.1-rev mem (s '%55 (or-i32 (g '%51 loc) (g '%54 loc)) loc) pred))
(defund @__ieee754_atan2-%54-rev (mem loc pred)
  (@__ieee754_atan2-%55-rev mem (s '%54 (and-i32 (g '%53 loc) 2) loc) pred))
(defund @__ieee754_atan2-%53-rev (mem loc pred)
  (@__ieee754_atan2-%54-rev mem (s '%53 (ashr-i32 (g '%52 loc) 30) loc) pred))
(defund @__ieee754_atan2-%52-rev (mem loc pred)
  (@__ieee754_atan2-%53-rev mem (s '%52 (load-i32 (g '%hx loc) mem) loc) pred))
(defund @__ieee754_atan2-%51-rev (mem loc pred)
  (@__ieee754_atan2-%52-rev mem (s '%51 (and-i32 (g '%50 loc) 1) loc) pred))
(defund @__ieee754_atan2-%50-rev (mem loc pred)
  (@__ieee754_atan2-%51-rev mem (s '%50 (ashr-i32 (g '%49 loc) 31) loc) pred))
(defund @__ieee754_atan2-%49-rev (mem loc pred)
  (@__ieee754_atan2-%50-rev mem (s '%49 (load-i32 (g '%hy loc) mem) loc) pred))

(defund @__ieee754_atan2-%48-rev (mem loc pred)
  (@__ieee754_atan2-%49-rev mem loc pred))

(defund @__ieee754_atan2-%48-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%49 (load-i32 (g '%hy loc) mem) loc))
    (loc (s '%50 (ashr-i32 (g '%49 loc) 31) loc))
    (loc (s '%51 (and-i32 (g '%50 loc) 1) loc))
    (loc (s '%52 (load-i32 (g '%hx loc) mem) loc))
    (loc (s '%53 (ashr-i32 (g '%52 loc) 30) loc))
    (loc (s '%54 (and-i32 (g '%53 loc) 2) loc))
    (loc (s '%55 (or-i32 (g '%51 loc) (g '%54 loc)) loc))
    (mem (store-i32 (g '%55 loc) (g '%m loc) mem))
    (loc (s '%56 (load-i32 (g '%iy loc) mem) loc))
    (loc (s '%57 (load-i32 (g '%ly loc) mem) loc))
    (loc (s '%58 (or-i32 (g '%56 loc) (g '%57 loc)) loc))
    (loc (s '%59 (icmp-eq-i32 (g '%58 loc) 0) loc))
    (succ (case (g '%59 loc) (-1 '%60) (0 '%67))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%48-expand-bb
  (equal (@__ieee754_atan2-%48-bb mem loc pred)
         (@__ieee754_atan2-%48-rev mem loc pred))
  :enable (@__ieee754_atan2-%48-bb @__ieee754_atan2-%48-rev
    @__ieee754_atan2-%49-rev
    @__ieee754_atan2-%50-rev
    @__ieee754_atan2-%51-rev
    @__ieee754_atan2-%52-rev
    @__ieee754_atan2-%53-rev
    @__ieee754_atan2-%54-rev
    @__ieee754_atan2-%55-rev
    @__ieee754_atan2-m48.1-rev
    @__ieee754_atan2-%56-rev
    @__ieee754_atan2-%57-rev
    @__ieee754_atan2-%58-rev
    @__ieee754_atan2-%59-rev
    @__ieee754_atan2-succ48-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%60-mem (s60)
  (car s60))
(defund @__ieee754_atan2-%60-loc (s60)
  (cadr s60))
(defund @__ieee754_atan2-%60-pred (s60)
  (caddr s60))
(defund @__ieee754_atan2-%61-val (s60)
  (load-i32 (g '%m (@__ieee754_atan2-%60-loc s60)) (@__ieee754_atan2-%60-mem s60)))
(defund @__ieee754_atan2-%61-loc (s60)
  (s '%61 (@__ieee754_atan2-%61-val s60) (@__ieee754_atan2-%60-loc s60)))
(defund @__ieee754_atan2-succ60-lab (s60)
  (case (g '%61 (@__ieee754_atan2-%61-loc s60))(0 '%62)(1 '%62)(2 '%64)(3 '%65) (otherwise '%66)))

(defund @__ieee754_atan2-succ60-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%61 loc)(0 '%62)(1 '%62)(2 '%64)(3 '%65) (otherwise '%66)) mem loc))
(defund @__ieee754_atan2-%61-rev (mem loc pred)
  (@__ieee754_atan2-succ60-rev mem (s '%61 (load-i32 (g '%m loc) mem) loc) pred))

(defund @__ieee754_atan2-%60-rev (mem loc pred)
  (@__ieee754_atan2-%61-rev mem loc pred))

(defund @__ieee754_atan2-%60-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%61 (load-i32 (g '%m loc) mem) loc))
    (succ (case (g '%61 loc)(0 '%62)(1 '%62)(2 '%64)(3 '%65) (otherwise '%66))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%60-expand-bb
  (equal (@__ieee754_atan2-%60-bb mem loc pred)
         (@__ieee754_atan2-%60-rev mem loc pred))
  :enable (@__ieee754_atan2-%60-bb @__ieee754_atan2-%60-rev
    @__ieee754_atan2-%61-rev
    @__ieee754_atan2-succ60-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%62-mem (s62)
  (car s62))
(defund @__ieee754_atan2-%62-loc (s62)
  (cadr s62))
(defund @__ieee754_atan2-%62-pred (s62)
  (caddr s62))
(defund @__ieee754_atan2-%63-val (s62)
  (load-double (g '%2 (@__ieee754_atan2-%62-loc s62)) (@__ieee754_atan2-%62-mem s62)))
(defund @__ieee754_atan2-%63-loc (s62)
  (s '%63 (@__ieee754_atan2-%63-val s62) (@__ieee754_atan2-%62-loc s62)))
(defund @__ieee754_atan2-m62.1-mem (s62)
  (store-double (g '%63 (@__ieee754_atan2-%63-loc s62)) (g '%1 (@__ieee754_atan2-%63-loc s62)) (@__ieee754_atan2-%62-mem s62)))
(defund @__ieee754_atan2-succ62-lab (s62)
  (declare (ignore s62))
  '%144)

(defund @__ieee754_atan2-succ62-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m62.1-rev (mem loc pred)
  (@__ieee754_atan2-succ62-rev (store-double (g '%63 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%63-rev (mem loc pred)
  (@__ieee754_atan2-m62.1-rev mem (s '%63 (load-double (g '%2 loc) mem) loc) pred))

(defund @__ieee754_atan2-%62-rev (mem loc pred)
  (@__ieee754_atan2-%63-rev mem loc pred))

(defund @__ieee754_atan2-%62-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%63 (load-double (g '%2 loc) mem) loc))
    (mem (store-double (g '%63 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%62-expand-bb
  (equal (@__ieee754_atan2-%62-bb mem loc pred)
         (@__ieee754_atan2-%62-rev mem loc pred))
  :enable (@__ieee754_atan2-%62-bb @__ieee754_atan2-%62-rev
    @__ieee754_atan2-%63-rev
    @__ieee754_atan2-m62.1-rev
    @__ieee754_atan2-succ62-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%64-mem (s64)
  (car s64))
(defund @__ieee754_atan2-%64-loc (s64)
  (cadr s64))
(defund @__ieee754_atan2-%64-pred (s64)
  (caddr s64))
(defund @__ieee754_atan2-m64.1-mem (s64)
  (store-double #x400921FB54442D18 (g '%1 (@__ieee754_atan2-%64-loc s64)) (@__ieee754_atan2-%64-mem s64)))
(defund @__ieee754_atan2-succ64-lab (s64)
  (declare (ignore s64))
  '%144)

(defund @__ieee754_atan2-succ64-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m64.1-rev (mem loc pred)
  (@__ieee754_atan2-succ64-rev (store-double #x400921FB54442D18 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%64-rev (mem loc pred)
  (@__ieee754_atan2-m64.1-rev mem loc pred))

(defund @__ieee754_atan2-%64-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x400921FB54442D18 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%64-expand-bb
  (equal (@__ieee754_atan2-%64-bb mem loc pred)
         (@__ieee754_atan2-%64-rev mem loc pred))
  :enable (@__ieee754_atan2-%64-bb @__ieee754_atan2-%64-rev
    @__ieee754_atan2-m64.1-rev
    @__ieee754_atan2-succ64-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%65-mem (s65)
  (car s65))
(defund @__ieee754_atan2-%65-loc (s65)
  (cadr s65))
(defund @__ieee754_atan2-%65-pred (s65)
  (caddr s65))
(defund @__ieee754_atan2-m65.1-mem (s65)
  (store-double #xC00921FB54442D18 (g '%1 (@__ieee754_atan2-%65-loc s65)) (@__ieee754_atan2-%65-mem s65)))
(defund @__ieee754_atan2-succ65-lab (s65)
  (declare (ignore s65))
  '%144)

(defund @__ieee754_atan2-succ65-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m65.1-rev (mem loc pred)
  (@__ieee754_atan2-succ65-rev (store-double #xC00921FB54442D18 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%65-rev (mem loc pred)
  (@__ieee754_atan2-m65.1-rev mem loc pred))

(defund @__ieee754_atan2-%65-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #xC00921FB54442D18 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%65-expand-bb
  (equal (@__ieee754_atan2-%65-bb mem loc pred)
         (@__ieee754_atan2-%65-rev mem loc pred))
  :enable (@__ieee754_atan2-%65-bb @__ieee754_atan2-%65-rev
    @__ieee754_atan2-m65.1-rev
    @__ieee754_atan2-succ65-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%66-mem (s66)
  (car s66))
(defund @__ieee754_atan2-%66-loc (s66)
  (cadr s66))
(defund @__ieee754_atan2-%66-pred (s66)
  (caddr s66))
(defund @__ieee754_atan2-succ66-lab (s66)
  (declare (ignore s66))
  '%67)

(defund @__ieee754_atan2-succ66-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%67 mem loc))

(defund @__ieee754_atan2-%66-rev (mem loc pred)
  (@__ieee754_atan2-succ66-rev mem loc pred))

(defund @__ieee754_atan2-%66-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%67))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%66-expand-bb
  (equal (@__ieee754_atan2-%66-bb mem loc pred)
         (@__ieee754_atan2-%66-rev mem loc pred))
  :enable (@__ieee754_atan2-%66-bb @__ieee754_atan2-%66-rev
    @__ieee754_atan2-succ66-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%67-mem (s67)
  (car s67))
(defund @__ieee754_atan2-%67-loc (s67)
  (cadr s67))
(defund @__ieee754_atan2-%67-pred (s67)
  (caddr s67))
(defund @__ieee754_atan2-%68-val (s67)
  (load-i32 (g '%ix (@__ieee754_atan2-%67-loc s67)) (@__ieee754_atan2-%67-mem s67)))
(defund @__ieee754_atan2-%68-loc (s67)
  (s '%68 (@__ieee754_atan2-%68-val s67) (@__ieee754_atan2-%67-loc s67)))
(defund @__ieee754_atan2-%69-val (s67)
  (load-i32 (g '%lx (@__ieee754_atan2-%68-loc s67)) (@__ieee754_atan2-%67-mem s67)))
(defund @__ieee754_atan2-%69-loc (s67)
  (s '%69 (@__ieee754_atan2-%69-val s67) (@__ieee754_atan2-%68-loc s67)))
(defund @__ieee754_atan2-%70-val (s67)
  (or-i32 (g '%68 (@__ieee754_atan2-%69-loc s67)) (g '%69 (@__ieee754_atan2-%69-loc s67))))
(defund @__ieee754_atan2-%70-loc (s67)
  (s '%70 (@__ieee754_atan2-%70-val s67) (@__ieee754_atan2-%69-loc s67)))
(defund @__ieee754_atan2-%71-val (s67)
  (icmp-eq-i32 (g '%70 (@__ieee754_atan2-%70-loc s67)) 0))
(defund @__ieee754_atan2-%71-loc (s67)
  (s '%71 (@__ieee754_atan2-%71-val s67) (@__ieee754_atan2-%70-loc s67)))
(defund @__ieee754_atan2-succ67-lab (s67)
  (case (g '%71 (@__ieee754_atan2-%71-loc s67)) (-1 '%72) (0 '%76)))

(defund @__ieee754_atan2-succ67-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%71 loc) (-1 '%72) (0 '%76)) mem loc))
(defund @__ieee754_atan2-%71-rev (mem loc pred)
  (@__ieee754_atan2-succ67-rev mem (s '%71 (icmp-eq-i32 (g '%70 loc) 0) loc) pred))
(defund @__ieee754_atan2-%70-rev (mem loc pred)
  (@__ieee754_atan2-%71-rev mem (s '%70 (or-i32 (g '%68 loc) (g '%69 loc)) loc) pred))
(defund @__ieee754_atan2-%69-rev (mem loc pred)
  (@__ieee754_atan2-%70-rev mem (s '%69 (load-i32 (g '%lx loc) mem) loc) pred))
(defund @__ieee754_atan2-%68-rev (mem loc pred)
  (@__ieee754_atan2-%69-rev mem (s '%68 (load-i32 (g '%ix loc) mem) loc) pred))

(defund @__ieee754_atan2-%67-rev (mem loc pred)
  (@__ieee754_atan2-%68-rev mem loc pred))

(defund @__ieee754_atan2-%67-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%68 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%69 (load-i32 (g '%lx loc) mem) loc))
    (loc (s '%70 (or-i32 (g '%68 loc) (g '%69 loc)) loc))
    (loc (s '%71 (icmp-eq-i32 (g '%70 loc) 0) loc))
    (succ (case (g '%71 loc) (-1 '%72) (0 '%76))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%67-expand-bb
  (equal (@__ieee754_atan2-%67-bb mem loc pred)
         (@__ieee754_atan2-%67-rev mem loc pred))
  :enable (@__ieee754_atan2-%67-bb @__ieee754_atan2-%67-rev
    @__ieee754_atan2-%68-rev
    @__ieee754_atan2-%69-rev
    @__ieee754_atan2-%70-rev
    @__ieee754_atan2-%71-rev
    @__ieee754_atan2-succ67-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%72-mem (s72)
  (car s72))
(defund @__ieee754_atan2-%72-loc (s72)
  (cadr s72))
(defund @__ieee754_atan2-%72-pred (s72)
  (caddr s72))
(defund @__ieee754_atan2-%73-val (s72)
  (load-i32 (g '%hy (@__ieee754_atan2-%72-loc s72)) (@__ieee754_atan2-%72-mem s72)))
(defund @__ieee754_atan2-%73-loc (s72)
  (s '%73 (@__ieee754_atan2-%73-val s72) (@__ieee754_atan2-%72-loc s72)))
(defund @__ieee754_atan2-%74-val (s72)
  (icmp-slt-i32 (g '%73 (@__ieee754_atan2-%73-loc s72)) 0))
(defund @__ieee754_atan2-%74-loc (s72)
  (s '%74 (@__ieee754_atan2-%74-val s72) (@__ieee754_atan2-%73-loc s72)))
(defund @__ieee754_atan2-%75-val (s72)
  (select-double (g '%74 (@__ieee754_atan2-%74-loc s72)) #xBFF921FB54442D18 #x3FF921FB54442D18))
(defund @__ieee754_atan2-%75-loc (s72)
  (s '%75 (@__ieee754_atan2-%75-val s72) (@__ieee754_atan2-%74-loc s72)))
(defund @__ieee754_atan2-m72.1-mem (s72)
  (store-double (g '%75 (@__ieee754_atan2-%75-loc s72)) (g '%1 (@__ieee754_atan2-%75-loc s72)) (@__ieee754_atan2-%72-mem s72)))
(defund @__ieee754_atan2-succ72-lab (s72)
  (declare (ignore s72))
  '%144)

(defund @__ieee754_atan2-succ72-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m72.1-rev (mem loc pred)
  (@__ieee754_atan2-succ72-rev (store-double (g '%75 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%75-rev (mem loc pred)
  (@__ieee754_atan2-m72.1-rev mem (s '%75 (select-double (g '%74 loc) #xBFF921FB54442D18 #x3FF921FB54442D18) loc) pred))
(defund @__ieee754_atan2-%74-rev (mem loc pred)
  (@__ieee754_atan2-%75-rev mem (s '%74 (icmp-slt-i32 (g '%73 loc) 0) loc) pred))
(defund @__ieee754_atan2-%73-rev (mem loc pred)
  (@__ieee754_atan2-%74-rev mem (s '%73 (load-i32 (g '%hy loc) mem) loc) pred))

(defund @__ieee754_atan2-%72-rev (mem loc pred)
  (@__ieee754_atan2-%73-rev mem loc pred))

(defund @__ieee754_atan2-%72-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%73 (load-i32 (g '%hy loc) mem) loc))
    (loc (s '%74 (icmp-slt-i32 (g '%73 loc) 0) loc))
    (loc (s '%75 (select-double (g '%74 loc) #xBFF921FB54442D18 #x3FF921FB54442D18) loc))
    (mem (store-double (g '%75 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%72-expand-bb
  (equal (@__ieee754_atan2-%72-bb mem loc pred)
         (@__ieee754_atan2-%72-rev mem loc pred))
  :enable (@__ieee754_atan2-%72-bb @__ieee754_atan2-%72-rev
    @__ieee754_atan2-%73-rev
    @__ieee754_atan2-%74-rev
    @__ieee754_atan2-%75-rev
    @__ieee754_atan2-m72.1-rev
    @__ieee754_atan2-succ72-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%76-mem (s76)
  (car s76))
(defund @__ieee754_atan2-%76-loc (s76)
  (cadr s76))
(defund @__ieee754_atan2-%76-pred (s76)
  (caddr s76))
(defund @__ieee754_atan2-%77-val (s76)
  (load-i32 (g '%ix (@__ieee754_atan2-%76-loc s76)) (@__ieee754_atan2-%76-mem s76)))
(defund @__ieee754_atan2-%77-loc (s76)
  (s '%77 (@__ieee754_atan2-%77-val s76) (@__ieee754_atan2-%76-loc s76)))
(defund @__ieee754_atan2-%78-val (s76)
  (icmp-eq-i32 (g '%77 (@__ieee754_atan2-%77-loc s76)) 2146435072))
(defund @__ieee754_atan2-%78-loc (s76)
  (s '%78 (@__ieee754_atan2-%78-val s76) (@__ieee754_atan2-%77-loc s76)))
(defund @__ieee754_atan2-succ76-lab (s76)
  (case (g '%78 (@__ieee754_atan2-%78-loc s76)) (-1 '%79) (0 '%97)))

(defund @__ieee754_atan2-succ76-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%78 loc) (-1 '%79) (0 '%97)) mem loc))
(defund @__ieee754_atan2-%78-rev (mem loc pred)
  (@__ieee754_atan2-succ76-rev mem (s '%78 (icmp-eq-i32 (g '%77 loc) 2146435072) loc) pred))
(defund @__ieee754_atan2-%77-rev (mem loc pred)
  (@__ieee754_atan2-%78-rev mem (s '%77 (load-i32 (g '%ix loc) mem) loc) pred))

(defund @__ieee754_atan2-%76-rev (mem loc pred)
  (@__ieee754_atan2-%77-rev mem loc pred))

(defund @__ieee754_atan2-%76-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%77 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%78 (icmp-eq-i32 (g '%77 loc) 2146435072) loc))
    (succ (case (g '%78 loc) (-1 '%79) (0 '%97))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%76-expand-bb
  (equal (@__ieee754_atan2-%76-bb mem loc pred)
         (@__ieee754_atan2-%76-rev mem loc pred))
  :enable (@__ieee754_atan2-%76-bb @__ieee754_atan2-%76-rev
    @__ieee754_atan2-%77-rev
    @__ieee754_atan2-%78-rev
    @__ieee754_atan2-succ76-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%79-mem (s79)
  (car s79))
(defund @__ieee754_atan2-%79-loc (s79)
  (cadr s79))
(defund @__ieee754_atan2-%79-pred (s79)
  (caddr s79))
(defund @__ieee754_atan2-%80-val (s79)
  (load-i32 (g '%iy (@__ieee754_atan2-%79-loc s79)) (@__ieee754_atan2-%79-mem s79)))
(defund @__ieee754_atan2-%80-loc (s79)
  (s '%80 (@__ieee754_atan2-%80-val s79) (@__ieee754_atan2-%79-loc s79)))
(defund @__ieee754_atan2-%81-val (s79)
  (icmp-eq-i32 (g '%80 (@__ieee754_atan2-%80-loc s79)) 2146435072))
(defund @__ieee754_atan2-%81-loc (s79)
  (s '%81 (@__ieee754_atan2-%81-val s79) (@__ieee754_atan2-%80-loc s79)))
(defund @__ieee754_atan2-succ79-lab (s79)
  (case (g '%81 (@__ieee754_atan2-%81-loc s79)) (-1 '%82) (0 '%89)))

(defund @__ieee754_atan2-succ79-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%81 loc) (-1 '%82) (0 '%89)) mem loc))
(defund @__ieee754_atan2-%81-rev (mem loc pred)
  (@__ieee754_atan2-succ79-rev mem (s '%81 (icmp-eq-i32 (g '%80 loc) 2146435072) loc) pred))
(defund @__ieee754_atan2-%80-rev (mem loc pred)
  (@__ieee754_atan2-%81-rev mem (s '%80 (load-i32 (g '%iy loc) mem) loc) pred))

(defund @__ieee754_atan2-%79-rev (mem loc pred)
  (@__ieee754_atan2-%80-rev mem loc pred))

(defund @__ieee754_atan2-%79-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%80 (load-i32 (g '%iy loc) mem) loc))
    (loc (s '%81 (icmp-eq-i32 (g '%80 loc) 2146435072) loc))
    (succ (case (g '%81 loc) (-1 '%82) (0 '%89))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%79-expand-bb
  (equal (@__ieee754_atan2-%79-bb mem loc pred)
         (@__ieee754_atan2-%79-rev mem loc pred))
  :enable (@__ieee754_atan2-%79-bb @__ieee754_atan2-%79-rev
    @__ieee754_atan2-%80-rev
    @__ieee754_atan2-%81-rev
    @__ieee754_atan2-succ79-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%82-mem (s82)
  (car s82))
(defund @__ieee754_atan2-%82-loc (s82)
  (cadr s82))
(defund @__ieee754_atan2-%82-pred (s82)
  (caddr s82))
(defund @__ieee754_atan2-%83-val (s82)
  (load-i32 (g '%m (@__ieee754_atan2-%82-loc s82)) (@__ieee754_atan2-%82-mem s82)))
(defund @__ieee754_atan2-%83-loc (s82)
  (s '%83 (@__ieee754_atan2-%83-val s82) (@__ieee754_atan2-%82-loc s82)))
(defund @__ieee754_atan2-succ82-lab (s82)
  (case (g '%83 (@__ieee754_atan2-%83-loc s82))(0 '%84)(1 '%85)(2 '%86)(3 '%87) (otherwise '%88)))

(defund @__ieee754_atan2-succ82-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%83 loc)(0 '%84)(1 '%85)(2 '%86)(3 '%87) (otherwise '%88)) mem loc))
(defund @__ieee754_atan2-%83-rev (mem loc pred)
  (@__ieee754_atan2-succ82-rev mem (s '%83 (load-i32 (g '%m loc) mem) loc) pred))

(defund @__ieee754_atan2-%82-rev (mem loc pred)
  (@__ieee754_atan2-%83-rev mem loc pred))

(defund @__ieee754_atan2-%82-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%83 (load-i32 (g '%m loc) mem) loc))
    (succ (case (g '%83 loc)(0 '%84)(1 '%85)(2 '%86)(3 '%87) (otherwise '%88))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%82-expand-bb
  (equal (@__ieee754_atan2-%82-bb mem loc pred)
         (@__ieee754_atan2-%82-rev mem loc pred))
  :enable (@__ieee754_atan2-%82-bb @__ieee754_atan2-%82-rev
    @__ieee754_atan2-%83-rev
    @__ieee754_atan2-succ82-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%84-mem (s84)
  (car s84))
(defund @__ieee754_atan2-%84-loc (s84)
  (cadr s84))
(defund @__ieee754_atan2-%84-pred (s84)
  (caddr s84))
(defund @__ieee754_atan2-m84.1-mem (s84)
  (store-double #x3FE921FB54442D18 (g '%1 (@__ieee754_atan2-%84-loc s84)) (@__ieee754_atan2-%84-mem s84)))
(defund @__ieee754_atan2-succ84-lab (s84)
  (declare (ignore s84))
  '%144)

(defund @__ieee754_atan2-succ84-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m84.1-rev (mem loc pred)
  (@__ieee754_atan2-succ84-rev (store-double #x3FE921FB54442D18 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%84-rev (mem loc pred)
  (@__ieee754_atan2-m84.1-rev mem loc pred))

(defund @__ieee754_atan2-%84-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x3FE921FB54442D18 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%84-expand-bb
  (equal (@__ieee754_atan2-%84-bb mem loc pred)
         (@__ieee754_atan2-%84-rev mem loc pred))
  :enable (@__ieee754_atan2-%84-bb @__ieee754_atan2-%84-rev
    @__ieee754_atan2-m84.1-rev
    @__ieee754_atan2-succ84-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%85-mem (s85)
  (car s85))
(defund @__ieee754_atan2-%85-loc (s85)
  (cadr s85))
(defund @__ieee754_atan2-%85-pred (s85)
  (caddr s85))
(defund @__ieee754_atan2-m85.1-mem (s85)
  (store-double #xBFE921FB54442D18 (g '%1 (@__ieee754_atan2-%85-loc s85)) (@__ieee754_atan2-%85-mem s85)))
(defund @__ieee754_atan2-succ85-lab (s85)
  (declare (ignore s85))
  '%144)

(defund @__ieee754_atan2-succ85-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m85.1-rev (mem loc pred)
  (@__ieee754_atan2-succ85-rev (store-double #xBFE921FB54442D18 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%85-rev (mem loc pred)
  (@__ieee754_atan2-m85.1-rev mem loc pred))

(defund @__ieee754_atan2-%85-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #xBFE921FB54442D18 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%85-expand-bb
  (equal (@__ieee754_atan2-%85-bb mem loc pred)
         (@__ieee754_atan2-%85-rev mem loc pred))
  :enable (@__ieee754_atan2-%85-bb @__ieee754_atan2-%85-rev
    @__ieee754_atan2-m85.1-rev
    @__ieee754_atan2-succ85-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%86-mem (s86)
  (car s86))
(defund @__ieee754_atan2-%86-loc (s86)
  (cadr s86))
(defund @__ieee754_atan2-%86-pred (s86)
  (caddr s86))
(defund @__ieee754_atan2-m86.1-mem (s86)
  (store-double #x4002D97C7F3321D2 (g '%1 (@__ieee754_atan2-%86-loc s86)) (@__ieee754_atan2-%86-mem s86)))
(defund @__ieee754_atan2-succ86-lab (s86)
  (declare (ignore s86))
  '%144)

(defund @__ieee754_atan2-succ86-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m86.1-rev (mem loc pred)
  (@__ieee754_atan2-succ86-rev (store-double #x4002D97C7F3321D2 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%86-rev (mem loc pred)
  (@__ieee754_atan2-m86.1-rev mem loc pred))

(defund @__ieee754_atan2-%86-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x4002D97C7F3321D2 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%86-expand-bb
  (equal (@__ieee754_atan2-%86-bb mem loc pred)
         (@__ieee754_atan2-%86-rev mem loc pred))
  :enable (@__ieee754_atan2-%86-bb @__ieee754_atan2-%86-rev
    @__ieee754_atan2-m86.1-rev
    @__ieee754_atan2-succ86-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%87-mem (s87)
  (car s87))
(defund @__ieee754_atan2-%87-loc (s87)
  (cadr s87))
(defund @__ieee754_atan2-%87-pred (s87)
  (caddr s87))
(defund @__ieee754_atan2-m87.1-mem (s87)
  (store-double #xC002D97C7F3321D2 (g '%1 (@__ieee754_atan2-%87-loc s87)) (@__ieee754_atan2-%87-mem s87)))
(defund @__ieee754_atan2-succ87-lab (s87)
  (declare (ignore s87))
  '%144)

(defund @__ieee754_atan2-succ87-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m87.1-rev (mem loc pred)
  (@__ieee754_atan2-succ87-rev (store-double #xC002D97C7F3321D2 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%87-rev (mem loc pred)
  (@__ieee754_atan2-m87.1-rev mem loc pred))

(defund @__ieee754_atan2-%87-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #xC002D97C7F3321D2 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%87-expand-bb
  (equal (@__ieee754_atan2-%87-bb mem loc pred)
         (@__ieee754_atan2-%87-rev mem loc pred))
  :enable (@__ieee754_atan2-%87-bb @__ieee754_atan2-%87-rev
    @__ieee754_atan2-m87.1-rev
    @__ieee754_atan2-succ87-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%88-mem (s88)
  (car s88))
(defund @__ieee754_atan2-%88-loc (s88)
  (cadr s88))
(defund @__ieee754_atan2-%88-pred (s88)
  (caddr s88))
(defund @__ieee754_atan2-succ88-lab (s88)
  (declare (ignore s88))
  '%96)

(defund @__ieee754_atan2-succ88-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%96 mem loc))

(defund @__ieee754_atan2-%88-rev (mem loc pred)
  (@__ieee754_atan2-succ88-rev mem loc pred))

(defund @__ieee754_atan2-%88-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%96))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%88-expand-bb
  (equal (@__ieee754_atan2-%88-bb mem loc pred)
         (@__ieee754_atan2-%88-rev mem loc pred))
  :enable (@__ieee754_atan2-%88-bb @__ieee754_atan2-%88-rev
    @__ieee754_atan2-succ88-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%89-mem (s89)
  (car s89))
(defund @__ieee754_atan2-%89-loc (s89)
  (cadr s89))
(defund @__ieee754_atan2-%89-pred (s89)
  (caddr s89))
(defund @__ieee754_atan2-%90-val (s89)
  (load-i32 (g '%m (@__ieee754_atan2-%89-loc s89)) (@__ieee754_atan2-%89-mem s89)))
(defund @__ieee754_atan2-%90-loc (s89)
  (s '%90 (@__ieee754_atan2-%90-val s89) (@__ieee754_atan2-%89-loc s89)))
(defund @__ieee754_atan2-succ89-lab (s89)
  (case (g '%90 (@__ieee754_atan2-%90-loc s89))(0 '%91)(1 '%92)(2 '%93)(3 '%94) (otherwise '%95)))

(defund @__ieee754_atan2-succ89-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%90 loc)(0 '%91)(1 '%92)(2 '%93)(3 '%94) (otherwise '%95)) mem loc))
(defund @__ieee754_atan2-%90-rev (mem loc pred)
  (@__ieee754_atan2-succ89-rev mem (s '%90 (load-i32 (g '%m loc) mem) loc) pred))

(defund @__ieee754_atan2-%89-rev (mem loc pred)
  (@__ieee754_atan2-%90-rev mem loc pred))

(defund @__ieee754_atan2-%89-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%90 (load-i32 (g '%m loc) mem) loc))
    (succ (case (g '%90 loc)(0 '%91)(1 '%92)(2 '%93)(3 '%94) (otherwise '%95))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%89-expand-bb
  (equal (@__ieee754_atan2-%89-bb mem loc pred)
         (@__ieee754_atan2-%89-rev mem loc pred))
  :enable (@__ieee754_atan2-%89-bb @__ieee754_atan2-%89-rev
    @__ieee754_atan2-%90-rev
    @__ieee754_atan2-succ89-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%91-mem (s91)
  (car s91))
(defund @__ieee754_atan2-%91-loc (s91)
  (cadr s91))
(defund @__ieee754_atan2-%91-pred (s91)
  (caddr s91))
(defund @__ieee754_atan2-m91.1-mem (s91)
  (store-double #x0000000000000000 (g '%1 (@__ieee754_atan2-%91-loc s91)) (@__ieee754_atan2-%91-mem s91)))
(defund @__ieee754_atan2-succ91-lab (s91)
  (declare (ignore s91))
  '%144)

(defund @__ieee754_atan2-succ91-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m91.1-rev (mem loc pred)
  (@__ieee754_atan2-succ91-rev (store-double #x0000000000000000 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%91-rev (mem loc pred)
  (@__ieee754_atan2-m91.1-rev mem loc pred))

(defund @__ieee754_atan2-%91-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x0000000000000000 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%91-expand-bb
  (equal (@__ieee754_atan2-%91-bb mem loc pred)
         (@__ieee754_atan2-%91-rev mem loc pred))
  :enable (@__ieee754_atan2-%91-bb @__ieee754_atan2-%91-rev
    @__ieee754_atan2-m91.1-rev
    @__ieee754_atan2-succ91-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%92-mem (s92)
  (car s92))
(defund @__ieee754_atan2-%92-loc (s92)
  (cadr s92))
(defund @__ieee754_atan2-%92-pred (s92)
  (caddr s92))
(defund @__ieee754_atan2-m92.1-mem (s92)
  (store-double #x8000000000000000 (g '%1 (@__ieee754_atan2-%92-loc s92)) (@__ieee754_atan2-%92-mem s92)))
(defund @__ieee754_atan2-succ92-lab (s92)
  (declare (ignore s92))
  '%144)

(defund @__ieee754_atan2-succ92-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m92.1-rev (mem loc pred)
  (@__ieee754_atan2-succ92-rev (store-double #x8000000000000000 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%92-rev (mem loc pred)
  (@__ieee754_atan2-m92.1-rev mem loc pred))

(defund @__ieee754_atan2-%92-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x8000000000000000 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%92-expand-bb
  (equal (@__ieee754_atan2-%92-bb mem loc pred)
         (@__ieee754_atan2-%92-rev mem loc pred))
  :enable (@__ieee754_atan2-%92-bb @__ieee754_atan2-%92-rev
    @__ieee754_atan2-m92.1-rev
    @__ieee754_atan2-succ92-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%93-mem (s93)
  (car s93))
(defund @__ieee754_atan2-%93-loc (s93)
  (cadr s93))
(defund @__ieee754_atan2-%93-pred (s93)
  (caddr s93))
(defund @__ieee754_atan2-m93.1-mem (s93)
  (store-double #x400921FB54442D18 (g '%1 (@__ieee754_atan2-%93-loc s93)) (@__ieee754_atan2-%93-mem s93)))
(defund @__ieee754_atan2-succ93-lab (s93)
  (declare (ignore s93))
  '%144)

(defund @__ieee754_atan2-succ93-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m93.1-rev (mem loc pred)
  (@__ieee754_atan2-succ93-rev (store-double #x400921FB54442D18 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%93-rev (mem loc pred)
  (@__ieee754_atan2-m93.1-rev mem loc pred))

(defund @__ieee754_atan2-%93-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x400921FB54442D18 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%93-expand-bb
  (equal (@__ieee754_atan2-%93-bb mem loc pred)
         (@__ieee754_atan2-%93-rev mem loc pred))
  :enable (@__ieee754_atan2-%93-bb @__ieee754_atan2-%93-rev
    @__ieee754_atan2-m93.1-rev
    @__ieee754_atan2-succ93-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%94-mem (s94)
  (car s94))
(defund @__ieee754_atan2-%94-loc (s94)
  (cadr s94))
(defund @__ieee754_atan2-%94-pred (s94)
  (caddr s94))
(defund @__ieee754_atan2-m94.1-mem (s94)
  (store-double #xC00921FB54442D18 (g '%1 (@__ieee754_atan2-%94-loc s94)) (@__ieee754_atan2-%94-mem s94)))
(defund @__ieee754_atan2-succ94-lab (s94)
  (declare (ignore s94))
  '%144)

(defund @__ieee754_atan2-succ94-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m94.1-rev (mem loc pred)
  (@__ieee754_atan2-succ94-rev (store-double #xC00921FB54442D18 (g '%1 loc) mem) loc pred))

(defund @__ieee754_atan2-%94-rev (mem loc pred)
  (@__ieee754_atan2-m94.1-rev mem loc pred))

(defund @__ieee754_atan2-%94-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #xC00921FB54442D18 (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%94-expand-bb
  (equal (@__ieee754_atan2-%94-bb mem loc pred)
         (@__ieee754_atan2-%94-rev mem loc pred))
  :enable (@__ieee754_atan2-%94-bb @__ieee754_atan2-%94-rev
    @__ieee754_atan2-m94.1-rev
    @__ieee754_atan2-succ94-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%95-mem (s95)
  (car s95))
(defund @__ieee754_atan2-%95-loc (s95)
  (cadr s95))
(defund @__ieee754_atan2-%95-pred (s95)
  (caddr s95))
(defund @__ieee754_atan2-succ95-lab (s95)
  (declare (ignore s95))
  '%96)

(defund @__ieee754_atan2-succ95-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%96 mem loc))

(defund @__ieee754_atan2-%95-rev (mem loc pred)
  (@__ieee754_atan2-succ95-rev mem loc pred))

(defund @__ieee754_atan2-%95-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%96))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%95-expand-bb
  (equal (@__ieee754_atan2-%95-bb mem loc pred)
         (@__ieee754_atan2-%95-rev mem loc pred))
  :enable (@__ieee754_atan2-%95-bb @__ieee754_atan2-%95-rev
    @__ieee754_atan2-succ95-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%96-mem (s96)
  (car s96))
(defund @__ieee754_atan2-%96-loc (s96)
  (cadr s96))
(defund @__ieee754_atan2-%96-pred (s96)
  (caddr s96))
(defund @__ieee754_atan2-succ96-lab (s96)
  (declare (ignore s96))
  '%97)

(defund @__ieee754_atan2-succ96-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%97 mem loc))

(defund @__ieee754_atan2-%96-rev (mem loc pred)
  (@__ieee754_atan2-succ96-rev mem loc pred))

(defund @__ieee754_atan2-%96-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%97))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%96-expand-bb
  (equal (@__ieee754_atan2-%96-bb mem loc pred)
         (@__ieee754_atan2-%96-rev mem loc pred))
  :enable (@__ieee754_atan2-%96-bb @__ieee754_atan2-%96-rev
    @__ieee754_atan2-succ96-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%97-mem (s97)
  (car s97))
(defund @__ieee754_atan2-%97-loc (s97)
  (cadr s97))
(defund @__ieee754_atan2-%97-pred (s97)
  (caddr s97))
(defund @__ieee754_atan2-%98-val (s97)
  (load-i32 (g '%iy (@__ieee754_atan2-%97-loc s97)) (@__ieee754_atan2-%97-mem s97)))
(defund @__ieee754_atan2-%98-loc (s97)
  (s '%98 (@__ieee754_atan2-%98-val s97) (@__ieee754_atan2-%97-loc s97)))
(defund @__ieee754_atan2-%99-val (s97)
  (icmp-eq-i32 (g '%98 (@__ieee754_atan2-%98-loc s97)) 2146435072))
(defund @__ieee754_atan2-%99-loc (s97)
  (s '%99 (@__ieee754_atan2-%99-val s97) (@__ieee754_atan2-%98-loc s97)))
(defund @__ieee754_atan2-succ97-lab (s97)
  (case (g '%99 (@__ieee754_atan2-%99-loc s97)) (-1 '%100) (0 '%104)))

(defund @__ieee754_atan2-succ97-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%99 loc) (-1 '%100) (0 '%104)) mem loc))
(defund @__ieee754_atan2-%99-rev (mem loc pred)
  (@__ieee754_atan2-succ97-rev mem (s '%99 (icmp-eq-i32 (g '%98 loc) 2146435072) loc) pred))
(defund @__ieee754_atan2-%98-rev (mem loc pred)
  (@__ieee754_atan2-%99-rev mem (s '%98 (load-i32 (g '%iy loc) mem) loc) pred))

(defund @__ieee754_atan2-%97-rev (mem loc pred)
  (@__ieee754_atan2-%98-rev mem loc pred))

(defund @__ieee754_atan2-%97-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%98 (load-i32 (g '%iy loc) mem) loc))
    (loc (s '%99 (icmp-eq-i32 (g '%98 loc) 2146435072) loc))
    (succ (case (g '%99 loc) (-1 '%100) (0 '%104))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%97-expand-bb
  (equal (@__ieee754_atan2-%97-bb mem loc pred)
         (@__ieee754_atan2-%97-rev mem loc pred))
  :enable (@__ieee754_atan2-%97-bb @__ieee754_atan2-%97-rev
    @__ieee754_atan2-%98-rev
    @__ieee754_atan2-%99-rev
    @__ieee754_atan2-succ97-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%100-mem (s100)
  (car s100))
(defund @__ieee754_atan2-%100-loc (s100)
  (cadr s100))
(defund @__ieee754_atan2-%100-pred (s100)
  (caddr s100))
(defund @__ieee754_atan2-%101-val (s100)
  (load-i32 (g '%hy (@__ieee754_atan2-%100-loc s100)) (@__ieee754_atan2-%100-mem s100)))
(defund @__ieee754_atan2-%101-loc (s100)
  (s '%101 (@__ieee754_atan2-%101-val s100) (@__ieee754_atan2-%100-loc s100)))
(defund @__ieee754_atan2-%102-val (s100)
  (icmp-slt-i32 (g '%101 (@__ieee754_atan2-%101-loc s100)) 0))
(defund @__ieee754_atan2-%102-loc (s100)
  (s '%102 (@__ieee754_atan2-%102-val s100) (@__ieee754_atan2-%101-loc s100)))
(defund @__ieee754_atan2-%103-val (s100)
  (select-double (g '%102 (@__ieee754_atan2-%102-loc s100)) #xBFF921FB54442D18 #x3FF921FB54442D18))
(defund @__ieee754_atan2-%103-loc (s100)
  (s '%103 (@__ieee754_atan2-%103-val s100) (@__ieee754_atan2-%102-loc s100)))
(defund @__ieee754_atan2-m100.1-mem (s100)
  (store-double (g '%103 (@__ieee754_atan2-%103-loc s100)) (g '%1 (@__ieee754_atan2-%103-loc s100)) (@__ieee754_atan2-%100-mem s100)))
(defund @__ieee754_atan2-succ100-lab (s100)
  (declare (ignore s100))
  '%144)

(defund @__ieee754_atan2-succ100-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m100.1-rev (mem loc pred)
  (@__ieee754_atan2-succ100-rev (store-double (g '%103 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%103-rev (mem loc pred)
  (@__ieee754_atan2-m100.1-rev mem (s '%103 (select-double (g '%102 loc) #xBFF921FB54442D18 #x3FF921FB54442D18) loc) pred))
(defund @__ieee754_atan2-%102-rev (mem loc pred)
  (@__ieee754_atan2-%103-rev mem (s '%102 (icmp-slt-i32 (g '%101 loc) 0) loc) pred))
(defund @__ieee754_atan2-%101-rev (mem loc pred)
  (@__ieee754_atan2-%102-rev mem (s '%101 (load-i32 (g '%hy loc) mem) loc) pred))

(defund @__ieee754_atan2-%100-rev (mem loc pred)
  (@__ieee754_atan2-%101-rev mem loc pred))

(defund @__ieee754_atan2-%100-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%101 (load-i32 (g '%hy loc) mem) loc))
    (loc (s '%102 (icmp-slt-i32 (g '%101 loc) 0) loc))
    (loc (s '%103 (select-double (g '%102 loc) #xBFF921FB54442D18 #x3FF921FB54442D18) loc))
    (mem (store-double (g '%103 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%100-expand-bb
  (equal (@__ieee754_atan2-%100-bb mem loc pred)
         (@__ieee754_atan2-%100-rev mem loc pred))
  :enable (@__ieee754_atan2-%100-bb @__ieee754_atan2-%100-rev
    @__ieee754_atan2-%101-rev
    @__ieee754_atan2-%102-rev
    @__ieee754_atan2-%103-rev
    @__ieee754_atan2-m100.1-rev
    @__ieee754_atan2-succ100-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%104-mem (s104)
  (car s104))
(defund @__ieee754_atan2-%104-loc (s104)
  (cadr s104))
(defund @__ieee754_atan2-%104-pred (s104)
  (caddr s104))
(defund @__ieee754_atan2-%105-val (s104)
  (load-i32 (g '%iy (@__ieee754_atan2-%104-loc s104)) (@__ieee754_atan2-%104-mem s104)))
(defund @__ieee754_atan2-%105-loc (s104)
  (s '%105 (@__ieee754_atan2-%105-val s104) (@__ieee754_atan2-%104-loc s104)))
(defund @__ieee754_atan2-%106-val (s104)
  (load-i32 (g '%ix (@__ieee754_atan2-%105-loc s104)) (@__ieee754_atan2-%104-mem s104)))
(defund @__ieee754_atan2-%106-loc (s104)
  (s '%106 (@__ieee754_atan2-%106-val s104) (@__ieee754_atan2-%105-loc s104)))
(defund @__ieee754_atan2-%107-val (s104)
  (sub-i32 (g '%105 (@__ieee754_atan2-%106-loc s104)) (g '%106 (@__ieee754_atan2-%106-loc s104))))
(defund @__ieee754_atan2-%107-loc (s104)
  (s '%107 (@__ieee754_atan2-%107-val s104) (@__ieee754_atan2-%106-loc s104)))
(defund @__ieee754_atan2-%108-val (s104)
  (ashr-i32 (g '%107 (@__ieee754_atan2-%107-loc s104)) 20))
(defund @__ieee754_atan2-%108-loc (s104)
  (s '%108 (@__ieee754_atan2-%108-val s104) (@__ieee754_atan2-%107-loc s104)))
(defund @__ieee754_atan2-m104.1-mem (s104)
  (store-i32 (g '%108 (@__ieee754_atan2-%108-loc s104)) (g '%k (@__ieee754_atan2-%108-loc s104)) (@__ieee754_atan2-%104-mem s104)))
(defund @__ieee754_atan2-%109-val (s104)
  (load-i32 (g '%k (@__ieee754_atan2-%108-loc s104)) (@__ieee754_atan2-m104.1-mem s104)))
(defund @__ieee754_atan2-%109-loc (s104)
  (s '%109 (@__ieee754_atan2-%109-val s104) (@__ieee754_atan2-%108-loc s104)))
(defund @__ieee754_atan2-%110-val (s104)
  (icmp-sgt-i32 (g '%109 (@__ieee754_atan2-%109-loc s104)) 60))
(defund @__ieee754_atan2-%110-loc (s104)
  (s '%110 (@__ieee754_atan2-%110-val s104) (@__ieee754_atan2-%109-loc s104)))
(defund @__ieee754_atan2-succ104-lab (s104)
  (case (g '%110 (@__ieee754_atan2-%110-loc s104)) (-1 '%111) (0 '%112)))

(defund @__ieee754_atan2-succ104-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%110 loc) (-1 '%111) (0 '%112)) mem loc))
(defund @__ieee754_atan2-%110-rev (mem loc pred)
  (@__ieee754_atan2-succ104-rev mem (s '%110 (icmp-sgt-i32 (g '%109 loc) 60) loc) pred))
(defund @__ieee754_atan2-%109-rev (mem loc pred)
  (@__ieee754_atan2-%110-rev mem (s '%109 (load-i32 (g '%k loc) mem) loc) pred))
(defund @__ieee754_atan2-m104.1-rev (mem loc pred)
  (@__ieee754_atan2-%109-rev (store-i32 (g '%108 loc) (g '%k loc) mem) loc pred))
(defund @__ieee754_atan2-%108-rev (mem loc pred)
  (@__ieee754_atan2-m104.1-rev mem (s '%108 (ashr-i32 (g '%107 loc) 20) loc) pred))
(defund @__ieee754_atan2-%107-rev (mem loc pred)
  (@__ieee754_atan2-%108-rev mem (s '%107 (sub-i32 (g '%105 loc) (g '%106 loc)) loc) pred))
(defund @__ieee754_atan2-%106-rev (mem loc pred)
  (@__ieee754_atan2-%107-rev mem (s '%106 (load-i32 (g '%ix loc) mem) loc) pred))
(defund @__ieee754_atan2-%105-rev (mem loc pred)
  (@__ieee754_atan2-%106-rev mem (s '%105 (load-i32 (g '%iy loc) mem) loc) pred))

(defund @__ieee754_atan2-%104-rev (mem loc pred)
  (@__ieee754_atan2-%105-rev mem loc pred))

(defund @__ieee754_atan2-%104-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%105 (load-i32 (g '%iy loc) mem) loc))
    (loc (s '%106 (load-i32 (g '%ix loc) mem) loc))
    (loc (s '%107 (sub-i32 (g '%105 loc) (g '%106 loc)) loc))
    (loc (s '%108 (ashr-i32 (g '%107 loc) 20) loc))
    (mem (store-i32 (g '%108 loc) (g '%k loc) mem))
    (loc (s '%109 (load-i32 (g '%k loc) mem) loc))
    (loc (s '%110 (icmp-sgt-i32 (g '%109 loc) 60) loc))
    (succ (case (g '%110 loc) (-1 '%111) (0 '%112))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%104-expand-bb
  (equal (@__ieee754_atan2-%104-bb mem loc pred)
         (@__ieee754_atan2-%104-rev mem loc pred))
  :enable (@__ieee754_atan2-%104-bb @__ieee754_atan2-%104-rev
    @__ieee754_atan2-%105-rev
    @__ieee754_atan2-%106-rev
    @__ieee754_atan2-%107-rev
    @__ieee754_atan2-%108-rev
    @__ieee754_atan2-m104.1-rev
    @__ieee754_atan2-%109-rev
    @__ieee754_atan2-%110-rev
    @__ieee754_atan2-succ104-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%111-mem (s111)
  (car s111))
(defund @__ieee754_atan2-%111-loc (s111)
  (cadr s111))
(defund @__ieee754_atan2-%111-pred (s111)
  (caddr s111))
(defund @__ieee754_atan2-m111.1-mem (s111)
  (store-double #x3FF921FB54442D18 (g '%z (@__ieee754_atan2-%111-loc s111)) (@__ieee754_atan2-%111-mem s111)))
(defund @__ieee754_atan2-succ111-lab (s111)
  (declare (ignore s111))
  '%126)

(defund @__ieee754_atan2-succ111-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%126 mem loc))
(defund @__ieee754_atan2-m111.1-rev (mem loc pred)
  (@__ieee754_atan2-succ111-rev (store-double #x3FF921FB54442D18 (g '%z loc) mem) loc pred))

(defund @__ieee754_atan2-%111-rev (mem loc pred)
  (@__ieee754_atan2-m111.1-rev mem loc pred))

(defund @__ieee754_atan2-%111-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x3FF921FB54442D18 (g '%z loc) mem))
    (succ '%126))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%111-expand-bb
  (equal (@__ieee754_atan2-%111-bb mem loc pred)
         (@__ieee754_atan2-%111-rev mem loc pred))
  :enable (@__ieee754_atan2-%111-bb @__ieee754_atan2-%111-rev
    @__ieee754_atan2-m111.1-rev
    @__ieee754_atan2-succ111-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%112-mem (s112)
  (car s112))
(defund @__ieee754_atan2-%112-loc (s112)
  (cadr s112))
(defund @__ieee754_atan2-%112-pred (s112)
  (caddr s112))
(defund @__ieee754_atan2-%113-val (s112)
  (load-i32 (g '%hx (@__ieee754_atan2-%112-loc s112)) (@__ieee754_atan2-%112-mem s112)))
(defund @__ieee754_atan2-%113-loc (s112)
  (s '%113 (@__ieee754_atan2-%113-val s112) (@__ieee754_atan2-%112-loc s112)))
(defund @__ieee754_atan2-%114-val (s112)
  (icmp-slt-i32 (g '%113 (@__ieee754_atan2-%113-loc s112)) 0))
(defund @__ieee754_atan2-%114-loc (s112)
  (s '%114 (@__ieee754_atan2-%114-val s112) (@__ieee754_atan2-%113-loc s112)))
(defund @__ieee754_atan2-succ112-lab (s112)
  (case (g '%114 (@__ieee754_atan2-%114-loc s112)) (-1 '%115) (0 '%119)))

(defund @__ieee754_atan2-succ112-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%114 loc) (-1 '%115) (0 '%119)) mem loc))
(defund @__ieee754_atan2-%114-rev (mem loc pred)
  (@__ieee754_atan2-succ112-rev mem (s '%114 (icmp-slt-i32 (g '%113 loc) 0) loc) pred))
(defund @__ieee754_atan2-%113-rev (mem loc pred)
  (@__ieee754_atan2-%114-rev mem (s '%113 (load-i32 (g '%hx loc) mem) loc) pred))

(defund @__ieee754_atan2-%112-rev (mem loc pred)
  (@__ieee754_atan2-%113-rev mem loc pred))

(defund @__ieee754_atan2-%112-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%113 (load-i32 (g '%hx loc) mem) loc))
    (loc (s '%114 (icmp-slt-i32 (g '%113 loc) 0) loc))
    (succ (case (g '%114 loc) (-1 '%115) (0 '%119))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%112-expand-bb
  (equal (@__ieee754_atan2-%112-bb mem loc pred)
         (@__ieee754_atan2-%112-rev mem loc pred))
  :enable (@__ieee754_atan2-%112-bb @__ieee754_atan2-%112-rev
    @__ieee754_atan2-%113-rev
    @__ieee754_atan2-%114-rev
    @__ieee754_atan2-succ112-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%115-mem (s115)
  (car s115))
(defund @__ieee754_atan2-%115-loc (s115)
  (cadr s115))
(defund @__ieee754_atan2-%115-pred (s115)
  (caddr s115))
(defund @__ieee754_atan2-%116-val (s115)
  (load-i32 (g '%k (@__ieee754_atan2-%115-loc s115)) (@__ieee754_atan2-%115-mem s115)))
(defund @__ieee754_atan2-%116-loc (s115)
  (s '%116 (@__ieee754_atan2-%116-val s115) (@__ieee754_atan2-%115-loc s115)))
(defund @__ieee754_atan2-%117-val (s115)
  (icmp-slt-i32 (g '%116 (@__ieee754_atan2-%116-loc s115)) -60))
(defund @__ieee754_atan2-%117-loc (s115)
  (s '%117 (@__ieee754_atan2-%117-val s115) (@__ieee754_atan2-%116-loc s115)))
(defund @__ieee754_atan2-succ115-lab (s115)
  (case (g '%117 (@__ieee754_atan2-%117-loc s115)) (-1 '%118) (0 '%119)))

(defund @__ieee754_atan2-succ115-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%117 loc) (-1 '%118) (0 '%119)) mem loc))
(defund @__ieee754_atan2-%117-rev (mem loc pred)
  (@__ieee754_atan2-succ115-rev mem (s '%117 (icmp-slt-i32 (g '%116 loc) -60) loc) pred))
(defund @__ieee754_atan2-%116-rev (mem loc pred)
  (@__ieee754_atan2-%117-rev mem (s '%116 (load-i32 (g '%k loc) mem) loc) pred))

(defund @__ieee754_atan2-%115-rev (mem loc pred)
  (@__ieee754_atan2-%116-rev mem loc pred))

(defund @__ieee754_atan2-%115-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%116 (load-i32 (g '%k loc) mem) loc))
    (loc (s '%117 (icmp-slt-i32 (g '%116 loc) -60) loc))
    (succ (case (g '%117 loc) (-1 '%118) (0 '%119))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%115-expand-bb
  (equal (@__ieee754_atan2-%115-bb mem loc pred)
         (@__ieee754_atan2-%115-rev mem loc pred))
  :enable (@__ieee754_atan2-%115-bb @__ieee754_atan2-%115-rev
    @__ieee754_atan2-%116-rev
    @__ieee754_atan2-%117-rev
    @__ieee754_atan2-succ115-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%118-mem (s118)
  (car s118))
(defund @__ieee754_atan2-%118-loc (s118)
  (cadr s118))
(defund @__ieee754_atan2-%118-pred (s118)
  (caddr s118))
(defund @__ieee754_atan2-m118.1-mem (s118)
  (store-double #x0000000000000000 (g '%z (@__ieee754_atan2-%118-loc s118)) (@__ieee754_atan2-%118-mem s118)))
(defund @__ieee754_atan2-succ118-lab (s118)
  (declare (ignore s118))
  '%125)

(defund @__ieee754_atan2-succ118-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%125 mem loc))
(defund @__ieee754_atan2-m118.1-rev (mem loc pred)
  (@__ieee754_atan2-succ118-rev (store-double #x0000000000000000 (g '%z loc) mem) loc pred))

(defund @__ieee754_atan2-%118-rev (mem loc pred)
  (@__ieee754_atan2-m118.1-rev mem loc pred))

(defund @__ieee754_atan2-%118-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (mem (store-double #x0000000000000000 (g '%z loc) mem))
    (succ '%125))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%118-expand-bb
  (equal (@__ieee754_atan2-%118-bb mem loc pred)
         (@__ieee754_atan2-%118-rev mem loc pred))
  :enable (@__ieee754_atan2-%118-bb @__ieee754_atan2-%118-rev
    @__ieee754_atan2-m118.1-rev
    @__ieee754_atan2-succ118-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%119-mem (s119)
  (car s119))
(defund @__ieee754_atan2-%119-loc (s119)
  (cadr s119))
(defund @__ieee754_atan2-%119-pred (s119)
  (caddr s119))
(defund @__ieee754_atan2-%120-val (s119)
  (load-double (g '%2 (@__ieee754_atan2-%119-loc s119)) (@__ieee754_atan2-%119-mem s119)))
(defund @__ieee754_atan2-%120-loc (s119)
  (s '%120 (@__ieee754_atan2-%120-val s119) (@__ieee754_atan2-%119-loc s119)))
(defund @__ieee754_atan2-%121-val (s119)
  (load-double (g '%3 (@__ieee754_atan2-%120-loc s119)) (@__ieee754_atan2-%119-mem s119)))
(defund @__ieee754_atan2-%121-loc (s119)
  (s '%121 (@__ieee754_atan2-%121-val s119) (@__ieee754_atan2-%120-loc s119)))
(defund @__ieee754_atan2-%122-val (s119)
  (fdiv-double (g '%120 (@__ieee754_atan2-%121-loc s119)) (g '%121 (@__ieee754_atan2-%121-loc s119))))
(defund @__ieee754_atan2-%122-loc (s119)
  (s '%122 (@__ieee754_atan2-%122-val s119) (@__ieee754_atan2-%121-loc s119)))
(defund @__ieee754_atan2-%123-val (s119)
  (@fabs (g '%122 (@__ieee754_atan2-%122-loc s119))))
(defund @__ieee754_atan2-%123-loc (s119)
  (s '%123 (@__ieee754_atan2-%123-val s119) (@__ieee754_atan2-%122-loc s119)))
(defund @__ieee754_atan2-%124-val (s119)
  (@atan (g '%123 (@__ieee754_atan2-%123-loc s119))))
(defund @__ieee754_atan2-%124-loc (s119)
  (s '%124 (@__ieee754_atan2-%124-val s119) (@__ieee754_atan2-%123-loc s119)))
(defund @__ieee754_atan2-m119.1-mem (s119)
  (store-double (g '%124 (@__ieee754_atan2-%124-loc s119)) (g '%z (@__ieee754_atan2-%124-loc s119)) (@__ieee754_atan2-%119-mem s119)))
(defund @__ieee754_atan2-succ119-lab (s119)
  (declare (ignore s119))
  '%125)

(defund @__ieee754_atan2-succ119-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%125 mem loc))
(defund @__ieee754_atan2-m119.1-rev (mem loc pred)
  (@__ieee754_atan2-succ119-rev (store-double (g '%124 loc) (g '%z loc) mem) loc pred))
(defund @__ieee754_atan2-%124-rev (mem loc pred)
  (@__ieee754_atan2-m119.1-rev mem (s '%124 (@atan (g '%123 loc)) loc) pred))
(defund @__ieee754_atan2-%123-rev (mem loc pred)
  (@__ieee754_atan2-%124-rev mem (s '%123 (@fabs (g '%122 loc)) loc) pred))
(defund @__ieee754_atan2-%122-rev (mem loc pred)
  (@__ieee754_atan2-%123-rev mem (s '%122 (fdiv-double (g '%120 loc) (g '%121 loc)) loc) pred))
(defund @__ieee754_atan2-%121-rev (mem loc pred)
  (@__ieee754_atan2-%122-rev mem (s '%121 (load-double (g '%3 loc) mem) loc) pred))
(defund @__ieee754_atan2-%120-rev (mem loc pred)
  (@__ieee754_atan2-%121-rev mem (s '%120 (load-double (g '%2 loc) mem) loc) pred))

(defund @__ieee754_atan2-%119-rev (mem loc pred)
  (@__ieee754_atan2-%120-rev mem loc pred))

(defund @__ieee754_atan2-%119-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%120 (load-double (g '%2 loc) mem) loc))
    (loc (s '%121 (load-double (g '%3 loc) mem) loc))
    (loc (s '%122 (fdiv-double (g '%120 loc) (g '%121 loc)) loc))
    (loc (s '%123 (@fabs (g '%122 loc)) loc))
    (loc (s '%124 (@atan (g '%123 loc)) loc))
    (mem (store-double (g '%124 loc) (g '%z loc) mem))
    (succ '%125))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%119-expand-bb
  (equal (@__ieee754_atan2-%119-bb mem loc pred)
         (@__ieee754_atan2-%119-rev mem loc pred))
  :enable (@__ieee754_atan2-%119-bb @__ieee754_atan2-%119-rev
    @__ieee754_atan2-%120-rev
    @__ieee754_atan2-%121-rev
    @__ieee754_atan2-%122-rev
    @__ieee754_atan2-%123-rev
    @__ieee754_atan2-%124-rev
    @__ieee754_atan2-m119.1-rev
    @__ieee754_atan2-succ119-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%125-mem (s125)
  (car s125))
(defund @__ieee754_atan2-%125-loc (s125)
  (cadr s125))
(defund @__ieee754_atan2-%125-pred (s125)
  (caddr s125))
(defund @__ieee754_atan2-succ125-lab (s125)
  (declare (ignore s125))
  '%126)

(defund @__ieee754_atan2-succ125-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%126 mem loc))

(defund @__ieee754_atan2-%125-rev (mem loc pred)
  (@__ieee754_atan2-succ125-rev mem loc pred))

(defund @__ieee754_atan2-%125-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (succ '%126))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%125-expand-bb
  (equal (@__ieee754_atan2-%125-bb mem loc pred)
         (@__ieee754_atan2-%125-rev mem loc pred))
  :enable (@__ieee754_atan2-%125-bb @__ieee754_atan2-%125-rev
    @__ieee754_atan2-succ125-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%126-mem (s126)
  (car s126))
(defund @__ieee754_atan2-%126-loc (s126)
  (cadr s126))
(defund @__ieee754_atan2-%126-pred (s126)
  (caddr s126))
(defund @__ieee754_atan2-%127-val (s126)
  (load-i32 (g '%m (@__ieee754_atan2-%126-loc s126)) (@__ieee754_atan2-%126-mem s126)))
(defund @__ieee754_atan2-%127-loc (s126)
  (s '%127 (@__ieee754_atan2-%127-val s126) (@__ieee754_atan2-%126-loc s126)))
(defund @__ieee754_atan2-succ126-lab (s126)
  (case (g '%127 (@__ieee754_atan2-%127-loc s126))(0 '%128)(1 '%130)(2 '%136) (otherwise '%140)))

(defund @__ieee754_atan2-succ126-rev (mem loc pred)
  (declare (ignore pred))
  (mv (case (g '%127 loc)(0 '%128)(1 '%130)(2 '%136) (otherwise '%140)) mem loc))
(defund @__ieee754_atan2-%127-rev (mem loc pred)
  (@__ieee754_atan2-succ126-rev mem (s '%127 (load-i32 (g '%m loc) mem) loc) pred))

(defund @__ieee754_atan2-%126-rev (mem loc pred)
  (@__ieee754_atan2-%127-rev mem loc pred))

(defund @__ieee754_atan2-%126-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%127 (load-i32 (g '%m loc) mem) loc))
    (succ (case (g '%127 loc)(0 '%128)(1 '%130)(2 '%136) (otherwise '%140))))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%126-expand-bb
  (equal (@__ieee754_atan2-%126-bb mem loc pred)
         (@__ieee754_atan2-%126-rev mem loc pred))
  :enable (@__ieee754_atan2-%126-bb @__ieee754_atan2-%126-rev
    @__ieee754_atan2-%127-rev
    @__ieee754_atan2-succ126-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%128-mem (s128)
  (car s128))
(defund @__ieee754_atan2-%128-loc (s128)
  (cadr s128))
(defund @__ieee754_atan2-%128-pred (s128)
  (caddr s128))
(defund @__ieee754_atan2-%129-val (s128)
  (load-double (g '%z (@__ieee754_atan2-%128-loc s128)) (@__ieee754_atan2-%128-mem s128)))
(defund @__ieee754_atan2-%129-loc (s128)
  (s '%129 (@__ieee754_atan2-%129-val s128) (@__ieee754_atan2-%128-loc s128)))
(defund @__ieee754_atan2-m128.1-mem (s128)
  (store-double (g '%129 (@__ieee754_atan2-%129-loc s128)) (g '%1 (@__ieee754_atan2-%129-loc s128)) (@__ieee754_atan2-%128-mem s128)))
(defund @__ieee754_atan2-succ128-lab (s128)
  (declare (ignore s128))
  '%144)

(defund @__ieee754_atan2-succ128-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m128.1-rev (mem loc pred)
  (@__ieee754_atan2-succ128-rev (store-double (g '%129 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%129-rev (mem loc pred)
  (@__ieee754_atan2-m128.1-rev mem (s '%129 (load-double (g '%z loc) mem) loc) pred))

(defund @__ieee754_atan2-%128-rev (mem loc pred)
  (@__ieee754_atan2-%129-rev mem loc pred))

(defund @__ieee754_atan2-%128-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%129 (load-double (g '%z loc) mem) loc))
    (mem (store-double (g '%129 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%128-expand-bb
  (equal (@__ieee754_atan2-%128-bb mem loc pred)
         (@__ieee754_atan2-%128-rev mem loc pred))
  :enable (@__ieee754_atan2-%128-bb @__ieee754_atan2-%128-rev
    @__ieee754_atan2-%129-rev
    @__ieee754_atan2-m128.1-rev
    @__ieee754_atan2-succ128-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%130-mem (s130)
  (car s130))
(defund @__ieee754_atan2-%130-loc (s130)
  (cadr s130))
(defund @__ieee754_atan2-%130-pred (s130)
  (caddr s130))
(defund @__ieee754_atan2-%131-val (s130)
  (bitcast-double*-to-i32* (g '%z (@__ieee754_atan2-%130-loc s130))))
(defund @__ieee754_atan2-%131-loc (s130)
  (s '%131 (@__ieee754_atan2-%131-val s130) (@__ieee754_atan2-%130-loc s130)))
(defund @__ieee754_atan2-%132-val (s130)
  (getelementptr-i32 (g '%131 (@__ieee754_atan2-%131-loc s130)) 1))
(defund @__ieee754_atan2-%132-loc (s130)
  (s '%132 (@__ieee754_atan2-%132-val s130) (@__ieee754_atan2-%131-loc s130)))
(defund @__ieee754_atan2-%133-val (s130)
  (load-i32 (g '%132 (@__ieee754_atan2-%132-loc s130)) (@__ieee754_atan2-%130-mem s130)))
(defund @__ieee754_atan2-%133-loc (s130)
  (s '%133 (@__ieee754_atan2-%133-val s130) (@__ieee754_atan2-%132-loc s130)))
(defund @__ieee754_atan2-%134-val (s130)
  (xor-i32 (g '%133 (@__ieee754_atan2-%133-loc s130)) -2147483648))
(defund @__ieee754_atan2-%134-loc (s130)
  (s '%134 (@__ieee754_atan2-%134-val s130) (@__ieee754_atan2-%133-loc s130)))
(defund @__ieee754_atan2-m130.1-mem (s130)
  (store-i32 (g '%134 (@__ieee754_atan2-%134-loc s130)) (g '%132 (@__ieee754_atan2-%134-loc s130)) (@__ieee754_atan2-%130-mem s130)))
(defund @__ieee754_atan2-%135-val (s130)
  (load-double (g '%z (@__ieee754_atan2-%134-loc s130)) (@__ieee754_atan2-m130.1-mem s130)))
(defund @__ieee754_atan2-%135-loc (s130)
  (s '%135 (@__ieee754_atan2-%135-val s130) (@__ieee754_atan2-%134-loc s130)))
(defund @__ieee754_atan2-m130.2-mem (s130)
  (store-double (g '%135 (@__ieee754_atan2-%135-loc s130)) (g '%1 (@__ieee754_atan2-%135-loc s130)) (@__ieee754_atan2-m130.1-mem s130)))
(defund @__ieee754_atan2-succ130-lab (s130)
  (declare (ignore s130))
  '%144)

(defund @__ieee754_atan2-succ130-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m130.2-rev (mem loc pred)
  (@__ieee754_atan2-succ130-rev (store-double (g '%135 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%135-rev (mem loc pred)
  (@__ieee754_atan2-m130.2-rev mem (s '%135 (load-double (g '%z loc) mem) loc) pred))
(defund @__ieee754_atan2-m130.1-rev (mem loc pred)
  (@__ieee754_atan2-%135-rev (store-i32 (g '%134 loc) (g '%132 loc) mem) loc pred))
(defund @__ieee754_atan2-%134-rev (mem loc pred)
  (@__ieee754_atan2-m130.1-rev mem (s '%134 (xor-i32 (g '%133 loc) -2147483648) loc) pred))
(defund @__ieee754_atan2-%133-rev (mem loc pred)
  (@__ieee754_atan2-%134-rev mem (s '%133 (load-i32 (g '%132 loc) mem) loc) pred))
(defund @__ieee754_atan2-%132-rev (mem loc pred)
  (@__ieee754_atan2-%133-rev mem (s '%132 (getelementptr-i32 (g '%131 loc) 1) loc) pred))
(defund @__ieee754_atan2-%131-rev (mem loc pred)
  (@__ieee754_atan2-%132-rev mem (s '%131 (bitcast-double*-to-i32* (g '%z loc)) loc) pred))

(defund @__ieee754_atan2-%130-rev (mem loc pred)
  (@__ieee754_atan2-%131-rev mem loc pred))

(defund @__ieee754_atan2-%130-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%131 (bitcast-double*-to-i32* (g '%z loc)) loc))
    (loc (s '%132 (getelementptr-i32 (g '%131 loc) 1) loc))
    (loc (s '%133 (load-i32 (g '%132 loc) mem) loc))
    (loc (s '%134 (xor-i32 (g '%133 loc) -2147483648) loc))
    (mem (store-i32 (g '%134 loc) (g '%132 loc) mem))
    (loc (s '%135 (load-double (g '%z loc) mem) loc))
    (mem (store-double (g '%135 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%130-expand-bb
  (equal (@__ieee754_atan2-%130-bb mem loc pred)
         (@__ieee754_atan2-%130-rev mem loc pred))
  :enable (@__ieee754_atan2-%130-bb @__ieee754_atan2-%130-rev
    @__ieee754_atan2-%131-rev
    @__ieee754_atan2-%132-rev
    @__ieee754_atan2-%133-rev
    @__ieee754_atan2-%134-rev
    @__ieee754_atan2-m130.1-rev
    @__ieee754_atan2-%135-rev
    @__ieee754_atan2-m130.2-rev
    @__ieee754_atan2-succ130-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%136-mem (s136)
  (car s136))
(defund @__ieee754_atan2-%136-loc (s136)
  (cadr s136))
(defund @__ieee754_atan2-%136-pred (s136)
  (caddr s136))
(defund @__ieee754_atan2-%137-val (s136)
  (load-double (g '%z (@__ieee754_atan2-%136-loc s136)) (@__ieee754_atan2-%136-mem s136)))
(defund @__ieee754_atan2-%137-loc (s136)
  (s '%137 (@__ieee754_atan2-%137-val s136) (@__ieee754_atan2-%136-loc s136)))
(defund @__ieee754_atan2-%138-val (s136)
  (fsub-double (g '%137 (@__ieee754_atan2-%137-loc s136)) #x3CA1A62633145C07))
(defund @__ieee754_atan2-%138-loc (s136)
  (s '%138 (@__ieee754_atan2-%138-val s136) (@__ieee754_atan2-%137-loc s136)))
(defund @__ieee754_atan2-%139-val (s136)
  (fsub-double #x400921FB54442D18 (g '%138 (@__ieee754_atan2-%138-loc s136))))
(defund @__ieee754_atan2-%139-loc (s136)
  (s '%139 (@__ieee754_atan2-%139-val s136) (@__ieee754_atan2-%138-loc s136)))
(defund @__ieee754_atan2-m136.1-mem (s136)
  (store-double (g '%139 (@__ieee754_atan2-%139-loc s136)) (g '%1 (@__ieee754_atan2-%139-loc s136)) (@__ieee754_atan2-%136-mem s136)))
(defund @__ieee754_atan2-succ136-lab (s136)
  (declare (ignore s136))
  '%144)

(defund @__ieee754_atan2-succ136-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m136.1-rev (mem loc pred)
  (@__ieee754_atan2-succ136-rev (store-double (g '%139 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%139-rev (mem loc pred)
  (@__ieee754_atan2-m136.1-rev mem (s '%139 (fsub-double #x400921FB54442D18 (g '%138 loc)) loc) pred))
(defund @__ieee754_atan2-%138-rev (mem loc pred)
  (@__ieee754_atan2-%139-rev mem (s '%138 (fsub-double (g '%137 loc) #x3CA1A62633145C07) loc) pred))
(defund @__ieee754_atan2-%137-rev (mem loc pred)
  (@__ieee754_atan2-%138-rev mem (s '%137 (load-double (g '%z loc) mem) loc) pred))

(defund @__ieee754_atan2-%136-rev (mem loc pred)
  (@__ieee754_atan2-%137-rev mem loc pred))

(defund @__ieee754_atan2-%136-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%137 (load-double (g '%z loc) mem) loc))
    (loc (s '%138 (fsub-double (g '%137 loc) #x3CA1A62633145C07) loc))
    (loc (s '%139 (fsub-double #x400921FB54442D18 (g '%138 loc)) loc))
    (mem (store-double (g '%139 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%136-expand-bb
  (equal (@__ieee754_atan2-%136-bb mem loc pred)
         (@__ieee754_atan2-%136-rev mem loc pred))
  :enable (@__ieee754_atan2-%136-bb @__ieee754_atan2-%136-rev
    @__ieee754_atan2-%137-rev
    @__ieee754_atan2-%138-rev
    @__ieee754_atan2-%139-rev
    @__ieee754_atan2-m136.1-rev
    @__ieee754_atan2-succ136-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%140-mem (s140)
  (car s140))
(defund @__ieee754_atan2-%140-loc (s140)
  (cadr s140))
(defund @__ieee754_atan2-%140-pred (s140)
  (caddr s140))
(defund @__ieee754_atan2-%141-val (s140)
  (load-double (g '%z (@__ieee754_atan2-%140-loc s140)) (@__ieee754_atan2-%140-mem s140)))
(defund @__ieee754_atan2-%141-loc (s140)
  (s '%141 (@__ieee754_atan2-%141-val s140) (@__ieee754_atan2-%140-loc s140)))
(defund @__ieee754_atan2-%142-val (s140)
  (fsub-double (g '%141 (@__ieee754_atan2-%141-loc s140)) #x3CA1A62633145C07))
(defund @__ieee754_atan2-%142-loc (s140)
  (s '%142 (@__ieee754_atan2-%142-val s140) (@__ieee754_atan2-%141-loc s140)))
(defund @__ieee754_atan2-%143-val (s140)
  (fsub-double (g '%142 (@__ieee754_atan2-%142-loc s140)) #x400921FB54442D18))
(defund @__ieee754_atan2-%143-loc (s140)
  (s '%143 (@__ieee754_atan2-%143-val s140) (@__ieee754_atan2-%142-loc s140)))
(defund @__ieee754_atan2-m140.1-mem (s140)
  (store-double (g '%143 (@__ieee754_atan2-%143-loc s140)) (g '%1 (@__ieee754_atan2-%143-loc s140)) (@__ieee754_atan2-%140-mem s140)))
(defund @__ieee754_atan2-succ140-lab (s140)
  (declare (ignore s140))
  '%144)

(defund @__ieee754_atan2-succ140-rev (mem loc pred)
  (declare (ignore pred))
  (mv '%144 mem loc))
(defund @__ieee754_atan2-m140.1-rev (mem loc pred)
  (@__ieee754_atan2-succ140-rev (store-double (g '%143 loc) (g '%1 loc) mem) loc pred))
(defund @__ieee754_atan2-%143-rev (mem loc pred)
  (@__ieee754_atan2-m140.1-rev mem (s '%143 (fsub-double (g '%142 loc) #x400921FB54442D18) loc) pred))
(defund @__ieee754_atan2-%142-rev (mem loc pred)
  (@__ieee754_atan2-%143-rev mem (s '%142 (fsub-double (g '%141 loc) #x3CA1A62633145C07) loc) pred))
(defund @__ieee754_atan2-%141-rev (mem loc pred)
  (@__ieee754_atan2-%142-rev mem (s '%141 (load-double (g '%z loc) mem) loc) pred))

(defund @__ieee754_atan2-%140-rev (mem loc pred)
  (@__ieee754_atan2-%141-rev mem loc pred))

(defund @__ieee754_atan2-%140-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%141 (load-double (g '%z loc) mem) loc))
    (loc (s '%142 (fsub-double (g '%141 loc) #x3CA1A62633145C07) loc))
    (loc (s '%143 (fsub-double (g '%142 loc) #x400921FB54442D18) loc))
    (mem (store-double (g '%143 loc) (g '%1 loc) mem))
    (succ '%144))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%140-expand-bb
  (equal (@__ieee754_atan2-%140-bb mem loc pred)
         (@__ieee754_atan2-%140-rev mem loc pred))
  :enable (@__ieee754_atan2-%140-bb @__ieee754_atan2-%140-rev
    @__ieee754_atan2-%141-rev
    @__ieee754_atan2-%142-rev
    @__ieee754_atan2-%143-rev
    @__ieee754_atan2-m140.1-rev
    @__ieee754_atan2-succ140-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-%144-mem (s144)
  (car s144))
(defund @__ieee754_atan2-%144-loc (s144)
  (cadr s144))
(defund @__ieee754_atan2-%144-pred (s144)
  (caddr s144))
(defund @__ieee754_atan2-%145-val (s144)
  (load-double (g '%1 (@__ieee754_atan2-%144-loc s144)) (@__ieee754_atan2-%144-mem s144)))
(defund @__ieee754_atan2-%145-loc (s144)
  (s '%145 (@__ieee754_atan2-%145-val s144) (@__ieee754_atan2-%144-loc s144)))
(defund @__ieee754_atan2-succ144-lab (s144)
  (declare (ignore s144))
  'ret)

(defund @__ieee754_atan2-succ144-rev (mem loc pred)
  (declare (ignore pred))
  (mv 'ret mem loc))
(defund @__ieee754_atan2-%145-rev (mem loc pred)
  (@__ieee754_atan2-succ144-rev mem (s '%145 (load-double (g '%1 loc) mem) loc) pred))

(defund @__ieee754_atan2-%144-rev (mem loc pred)
  (@__ieee754_atan2-%145-rev mem loc pred))

(defund @__ieee754_atan2-%144-bb (mem loc pred)
  (declare (ignore pred))
  (b* (
    (loc (s '%145 (load-double (g '%1 loc) mem) loc))
    (succ 'ret))
  (mv succ mem loc)))

(defruled @__ieee754_atan2-%144-expand-bb
  (equal (@__ieee754_atan2-%144-bb mem loc pred)
         (@__ieee754_atan2-%144-rev mem loc pred))
  :enable (@__ieee754_atan2-%144-bb @__ieee754_atan2-%144-rev
    @__ieee754_atan2-%145-rev
    @__ieee754_atan2-succ144-rev)
  :disable s-diff-s)

(defund @__ieee754_atan2-step (label mem loc pred)
  (case label
    (%0 (@__ieee754_atan2-%0-bb mem loc pred))
    (%26 (@__ieee754_atan2-%26-bb mem loc pred))
    (%35 (@__ieee754_atan2-%35-bb mem loc pred))
    (%39 (@__ieee754_atan2-%39-bb mem loc pred))
    (%45 (@__ieee754_atan2-%45-bb mem loc pred))
    (%48 (@__ieee754_atan2-%48-bb mem loc pred))
    (%60 (@__ieee754_atan2-%60-bb mem loc pred))
    (%62 (@__ieee754_atan2-%62-bb mem loc pred))
    (%64 (@__ieee754_atan2-%64-bb mem loc pred))
    (%65 (@__ieee754_atan2-%65-bb mem loc pred))
    (%66 (@__ieee754_atan2-%66-bb mem loc pred))
    (%67 (@__ieee754_atan2-%67-bb mem loc pred))
    (%72 (@__ieee754_atan2-%72-bb mem loc pred))
    (%76 (@__ieee754_atan2-%76-bb mem loc pred))
    (%79 (@__ieee754_atan2-%79-bb mem loc pred))
    (%82 (@__ieee754_atan2-%82-bb mem loc pred))
    (%84 (@__ieee754_atan2-%84-bb mem loc pred))
    (%85 (@__ieee754_atan2-%85-bb mem loc pred))
    (%86 (@__ieee754_atan2-%86-bb mem loc pred))
    (%87 (@__ieee754_atan2-%87-bb mem loc pred))
    (%88 (@__ieee754_atan2-%88-bb mem loc pred))
    (%89 (@__ieee754_atan2-%89-bb mem loc pred))
    (%91 (@__ieee754_atan2-%91-bb mem loc pred))
    (%92 (@__ieee754_atan2-%92-bb mem loc pred))
    (%93 (@__ieee754_atan2-%93-bb mem loc pred))
    (%94 (@__ieee754_atan2-%94-bb mem loc pred))
    (%95 (@__ieee754_atan2-%95-bb mem loc pred))
    (%96 (@__ieee754_atan2-%96-bb mem loc pred))
    (%97 (@__ieee754_atan2-%97-bb mem loc pred))
    (%100 (@__ieee754_atan2-%100-bb mem loc pred))
    (%104 (@__ieee754_atan2-%104-bb mem loc pred))
    (%111 (@__ieee754_atan2-%111-bb mem loc pred))
    (%112 (@__ieee754_atan2-%112-bb mem loc pred))
    (%115 (@__ieee754_atan2-%115-bb mem loc pred))
    (%118 (@__ieee754_atan2-%118-bb mem loc pred))
    (%119 (@__ieee754_atan2-%119-bb mem loc pred))
    (%125 (@__ieee754_atan2-%125-bb mem loc pred))
    (%126 (@__ieee754_atan2-%126-bb mem loc pred))
    (%128 (@__ieee754_atan2-%128-bb mem loc pred))
    (%130 (@__ieee754_atan2-%130-bb mem loc pred))
    (%136 (@__ieee754_atan2-%136-bb mem loc pred))
    (%140 (@__ieee754_atan2-%140-bb mem loc pred))
    (%144 (@__ieee754_atan2-%144-bb mem loc pred))
    (otherwise (mv nil mem loc))))

(defund @__ieee754_atan2-steps (label mem loc pred n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%145 loc)
    (if (zp n) nil
      (mv-let
        (new-label new-mem new-loc)
        (@__ieee754_atan2-step label mem loc pred)
        (@__ieee754_atan2-steps new-label new-mem new-loc label (1- n))))))

(defund @__ieee754_atan2 (%y %x)
  (declare (ignore %y %x))
   nil)
