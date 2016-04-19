(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")

(defconst *tanh-globals* '())

(defund @tanh-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'z 1 mem))
    (mem (alloca-i32 'jx 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (store-double (g '%x loc) '(x . 0) mem))
    (loc (s '%3 (bitcast-double*-to-i32* '(x . 0)) loc))
    (loc (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc))
    (loc (s '%5 (load-i32 (g '%4 loc) mem) loc))
    (mem (store-i32 (g '%5 loc) '(jx . 0) mem))
    (loc (s '%6 (load-i32 '(jx . 0) mem) loc))
    (loc (s '%7 (and-i32 (g '%6 loc) 2147483647) loc))
    (mem (store-i32 (g '%7 loc) '(ix . 0) mem))
    (loc (s '%8 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%9 (icmp-sge-i32 (g '%8 loc) 2146435072) loc)))
  (case (g '%9 loc)
    (-1 (mv '@tanh-%10-bb mem loc))
    ( 0 (mv '@tanh-%21-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @tanh-%10-bb (mem loc)
  (b* (
    (loc (s '%11 (load-i32 '(jx . 0) mem) loc))
    (loc (s '%12 (icmp-sge-i32 (g '%11 loc) 0) loc)))
  (case (g '%12 loc)
    (-1 (mv '@tanh-%13-bb mem loc))
    ( 0 (mv '@tanh-%17-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @tanh-%13-bb (mem loc)
  (b* (
    (loc (s '%14 (load-double '(x . 0) mem) loc))
    (loc (s '%15 (fdiv-double #x3ff0000000000000 (g '%14 loc)) loc))
    (loc (s '%16 (fadd-double (g '%15 loc) #x3ff0000000000000) loc))
    (mem (store-double (g '%16 loc) '(ret . 0) mem)))
  (mv '@tanh-%66-bb mem loc)))

(defund @tanh-%17-bb (mem loc)
  (b* (
    (loc (s '%18 (load-double '(x . 0) mem) loc))
    (loc (s '%19 (fdiv-double #x3ff0000000000000 (g '%18 loc)) loc))
    (loc (s '%20 (fsub-double (g '%19 loc) #x3ff0000000000000) loc))
    (mem (store-double (g '%20 loc) '(ret . 0) mem)))
  (mv '@tanh-%66-bb mem loc)))

(defund @tanh-%21-bb (mem loc)
  (b* (
    (loc (s '%22 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%23 (icmp-slt-i32 (g '%22 loc) 1077280768) loc)))
  (case (g '%23 loc)
    (-1 (mv '@tanh-%24-bb mem loc))
    ( 0 (mv '@tanh-%55-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @tanh-%24-bb (mem loc)
  (b* (
    (loc (s '%25 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%26 (icmp-slt-i32 (g '%25 loc) 1015021568) loc)))
  (case (g '%26 loc)
    (-1 (mv '@tanh-%27-bb mem loc))
    ( 0 (mv '@tanh-%32-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @tanh-%27-bb (mem loc)
  (b* (
    (loc (s '%28 (load-double '(x . 0) mem) loc))
    (loc (s '%29 (load-double '(x . 0) mem) loc))
    (loc (s '%30 (fadd-double #x3ff0000000000000 (g '%29 loc)) loc))
    (loc (s '%31 (fmul-double (g '%28 loc) (g '%30 loc)) loc))
    (mem (store-double (g '%31 loc) '(ret . 0) mem)))
  (mv '@tanh-%66-bb mem loc)))

(defund @tanh-%32-bb (mem loc)
  (b* (
    (loc (s '%33 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%34 (icmp-sge-i32 (g '%33 loc) 1072693248) loc)))
  (case (g '%34 loc)
    (-1 (mv '@tanh-%35-bb mem loc))
    ( 0 (mv '@tanh-%44-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @tanh-%35-bb (mem loc)
  (b* (
    (loc (s '%36 (load-double '(x . 0) mem) loc))
    (loc (s '%37 (@fabs (g '%36 loc)) loc))
    (loc (s '%38 (fmul-double #x4000000000000000 (g '%37 loc)) loc))
    (loc (s '%39 (@expm1 (g '%38 loc)) loc))
    (mem (store-double (g '%39 loc) '(t . 0) mem))
    (loc (s '%40 (load-double '(t . 0) mem) loc))
    (loc (s '%41 (fadd-double (g '%40 loc) #x4000000000000000) loc))
    (loc (s '%42 (fdiv-double #x4000000000000000 (g '%41 loc)) loc))
    (loc (s '%43 (fsub-double #x3ff0000000000000 (g '%42 loc)) loc))
    (mem (store-double (g '%43 loc) '(z . 0) mem)))
  (mv '@tanh-%54-bb mem loc)))

(defund @tanh-%44-bb (mem loc)
  (b* (
    (loc (s '%45 (load-double '(x . 0) mem) loc))
    (loc (s '%46 (@fabs (g '%45 loc)) loc))
    (loc (s '%47 (fmul-double #xc000000000000000 (g '%46 loc)) loc))
    (loc (s '%48 (@expm1 (g '%47 loc)) loc))
    (mem (store-double (g '%48 loc) '(t . 0) mem))
    (loc (s '%49 (load-double '(t . 0) mem) loc))
    (loc (s '%50 (fsub-double #x8000000000000000 (g '%49 loc)) loc))
    (loc (s '%51 (load-double '(t . 0) mem) loc))
    (loc (s '%52 (fadd-double (g '%51 loc) #x4000000000000000) loc))
    (loc (s '%53 (fdiv-double (g '%50 loc) (g '%52 loc)) loc))
    (mem (store-double (g '%53 loc) '(z . 0) mem)))
  (mv '@tanh-%54-bb mem loc)))

(defund @tanh-%54-bb (mem loc)
  (b* ()
  (mv '@tanh-%56-bb mem loc)))

(defund @tanh-%55-bb (mem loc)
  (b* (
    (mem (store-double #x3ff0000000000000 '(z . 0) mem)))
  (mv '@tanh-%56-bb mem loc)))

(defund @tanh-%56-bb (mem loc)
  (b* (
    (loc (s '%57 (load-i32 '(jx . 0) mem) loc))
    (loc (s '%58 (icmp-sge-i32 (g '%57 loc) 0) loc)))
  (case (g '%58 loc)
    (-1 (mv '@tanh-%59-bb mem loc))
    ( 0 (mv '@tanh-%61-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @tanh-%59-bb (mem loc)
  (b* (
    (loc (s '%60 (load-double '(z . 0) mem) loc)))
  (let* ((loc (s '%65 (g '%60 loc) loc))) (mv '@tanh-%64-bb mem loc))))

(defund @tanh-%61-bb (mem loc)
  (b* (
    (loc (s '%62 (load-double '(z . 0) mem) loc))
    (loc (s '%63 (fsub-double #x8000000000000000 (g '%62 loc)) loc)))
  (let* ((loc (s '%65 (g '%63 loc) loc))) (mv '@tanh-%64-bb mem loc))))

(defund @tanh-%64-bb (mem loc)
  ; %65 = phi double [ (g '%60 loc), %59 ], [ (g '%63 loc), %61 ]
  (b* (
    (mem (store-double (g '%65 loc) '(ret . 0) mem)))
  (mv '@tanh-%66-bb mem loc)))

(defund @tanh-%66-bb (mem loc)
  (b* (
    (loc (s '%67 (load-double '(ret . 0) mem) loc)))
  (mv 'ret mem loc)))

(defund @tanh-step (label mem loc)
  (case label
    (%-0 (@tanh-%0-bb mem loc))
    (%-10 (@tanh-%10-bb mem loc))
    (%-13 (@tanh-%13-bb mem loc))
    (%-17 (@tanh-%17-bb mem loc))
    (%-21 (@tanh-%21-bb mem loc))
    (%-24 (@tanh-%24-bb mem loc))
    (%-27 (@tanh-%27-bb mem loc))
    (%-32 (@tanh-%32-bb mem loc))
    (%-35 (@tanh-%35-bb mem loc))
    (%-44 (@tanh-%44-bb mem loc))
    (%-54 (@tanh-%54-bb mem loc))
    (%-55 (@tanh-%55-bb mem loc))
    (%-56 (@tanh-%56-bb mem loc))
    (%-59 (@tanh-%59-bb mem loc))
    (%-61 (@tanh-%61-bb mem loc))
    (%-64 (@tanh-%64-bb mem loc))
    (%-66 (@tanh-%66-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @tanh-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%67 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@tanh-step label mem loc)
        (@tanh-steps label mem loc (1- n))))))

(defund @tanh (%x)
  (declare (ignore %x))
   nil)
