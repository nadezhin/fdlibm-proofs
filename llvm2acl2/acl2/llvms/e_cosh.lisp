(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")
(include-book "e_exp")

(defconst *__ieee754_cosh-globals* '(
  (one #x00000000 #x3ff00000)))

(defund @__ieee754_cosh-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'w 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (alloca-i32 'lx 1 mem))
    (mem (store-double (g '%x loc) '(x . 0) mem))
    (loc (s '%3 (bitcast-double*-to-i32* '(x . 0)) loc))
    (loc (s '%4 (getelementptr-i32 (g '%3 loc) 1) loc))
    (loc (s '%5 (load-i32 (g '%4 loc) mem) loc))
    (mem (store-i32 (g '%5 loc) '(ix . 0) mem))
    (loc (s '%6 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%7 (and-i32 (g '%6 loc) 2147483647) loc))
    (mem (store-i32 (g '%7 loc) '(ix . 0) mem))
    (loc (s '%8 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%9 (icmp-sge-i32 (g '%8 loc) 2146435072) loc)))
  (case (g '%9 loc)
    (-1 (mv '@__ieee754_cosh-%10-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%14-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%10-bb (mem loc)
  (b* (
    (loc (s '%11 (load-double '(x . 0) mem) loc))
    (loc (s '%12 (load-double '(x . 0) mem) loc))
    (loc (s '%13 (fmul-double (g '%11 loc) (g '%12 loc)) loc))
    (mem (store-double (g '%13 loc) '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%14-bb (mem loc)
  (b* (
    (loc (s '%15 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%16 (icmp-slt-i32 (g '%15 loc) 1071001155) loc)))
  (case (g '%16 loc)
    (-1 (mv '@__ieee754_cosh-%17-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%36-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%17-bb (mem loc)
  (b* (
    (loc (s '%18 (load-double '(x . 0) mem) loc))
    (loc (s '%19 (@fabs (g '%18 loc)) loc))
    (loc (s '%20 (@expm1 (g '%19 loc)) loc))
    (mem (store-double (g '%20 loc) '(t . 0) mem))
    (loc (s '%21 (load-double '(t . 0) mem) loc))
    (loc (s '%22 (fadd-double #x3ff0000000000000 (g '%21 loc)) loc))
    (mem (store-double (g '%22 loc) '(w . 0) mem))
    (loc (s '%23 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%24 (icmp-slt-i32 (g '%23 loc) 1015021568) loc)))
  (case (g '%24 loc)
    (-1 (mv '@__ieee754_cosh-%25-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%27-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%25-bb (mem loc)
  (b* (
    (loc (s '%26 (load-double '(w . 0) mem) loc))
    (mem (store-double (g '%26 loc) '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%27-bb (mem loc)
  (b* (
    (loc (s '%28 (load-double '(t . 0) mem) loc))
    (loc (s '%29 (load-double '(t . 0) mem) loc))
    (loc (s '%30 (fmul-double (g '%28 loc) (g '%29 loc)) loc))
    (loc (s '%31 (load-double '(w . 0) mem) loc))
    (loc (s '%32 (load-double '(w . 0) mem) loc))
    (loc (s '%33 (fadd-double (g '%31 loc) (g '%32 loc)) loc))
    (loc (s '%34 (fdiv-double (g '%30 loc) (g '%33 loc)) loc))
    (loc (s '%35 (fadd-double #x3ff0000000000000 (g '%34 loc)) loc))
    (mem (store-double (g '%35 loc) '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%36-bb (mem loc)
  (b* (
    (loc (s '%37 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%38 (icmp-slt-i32 (g '%37 loc) 1077280768) loc)))
  (case (g '%38 loc)
    (-1 (mv '@__ieee754_cosh-%39-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%48-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%39-bb (mem loc)
  (b* (
    (loc (s '%40 (load-double '(x . 0) mem) loc))
    (loc (s '%41 (@fabs (g '%40 loc)) loc))
    (loc (s '%42 (@__ieee754_exp (g '%41 loc)) loc))
    (mem (store-double (g '%42 loc) '(t . 0) mem))
    (loc (s '%43 (load-double '(t . 0) mem) loc))
    (loc (s '%44 (fmul-double #x3fe0000000000000 (g '%43 loc)) loc))
    (loc (s '%45 (load-double '(t . 0) mem) loc))
    (loc (s '%46 (fdiv-double #x3fe0000000000000 (g '%45 loc)) loc))
    (loc (s '%47 (fadd-double (g '%44 loc) (g '%46 loc)) loc))
    (mem (store-double (g '%47 loc) '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%48-bb (mem loc)
  (b* (
    (loc (s '%49 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%50 (icmp-slt-i32 (g '%49 loc) 1082535490) loc)))
  (case (g '%50 loc)
    (-1 (mv '@__ieee754_cosh-%51-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%56-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%51-bb (mem loc)
  (b* (
    (loc (s '%52 (load-double '(x . 0) mem) loc))
    (loc (s '%53 (@fabs (g '%52 loc)) loc))
    (loc (s '%54 (@__ieee754_exp (g '%53 loc)) loc))
    (loc (s '%55 (fmul-double #x3fe0000000000000 (g '%54 loc)) loc))
    (mem (store-double (g '%55 loc) '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%56-bb (mem loc)
  (b* (
    (loc (s '%57 (load-i32 '(one . 0) mem) loc))
    (loc (s '%58 (lshr-i32 (g '%57 loc) 29) loc))
    (loc (s '%59 (bitcast-double*-to-i32* '(x . 0)) loc))
    (loc (s '%60 (zext-i32-to-i64 (g '%58 loc)) loc))
    (loc (s '%61 (getelementptr-i32 (g '%59 loc) (g '%60 loc)) loc))
    (loc (s '%62 (load-i32 (g '%61 loc) mem) loc))
    (mem (store-i32 (g '%62 loc) '(lx . 0) mem))
    (loc (s '%63 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%64 (icmp-slt-i32 (g '%63 loc) 1082536910) loc)))
  (case (g '%64 loc)
    (-1 (mv '@__ieee754_cosh-%71-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%65-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%65-bb (mem loc)
  (b* (
    (loc (s '%66 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%67 (icmp-eq-i32 (g '%66 loc) 1082536910) loc)))
  (case (g '%67 loc)
    (-1 (mv '@__ieee754_cosh-%68-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%81-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%68-bb (mem loc)
  (b* (
    (loc (s '%69 (load-i32 '(lx . 0) mem) loc))
    (loc (s '%70 (icmp-ule-i32 (g '%69 loc) -1883637635) loc)))
  (case (g '%70 loc)
    (-1 (mv '@__ieee754_cosh-%71-bb mem loc))
    ( 0 (mv '@__ieee754_cosh-%81-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_cosh-%71-bb (mem loc)
  (b* (
    (loc (s '%72 (load-double '(x . 0) mem) loc))
    (loc (s '%73 (@fabs (g '%72 loc)) loc))
    (loc (s '%74 (fmul-double #x3fe0000000000000 (g '%73 loc)) loc))
    (loc (s '%75 (@__ieee754_exp (g '%74 loc)) loc))
    (mem (store-double (g '%75 loc) '(w . 0) mem))
    (loc (s '%76 (load-double '(w . 0) mem) loc))
    (loc (s '%77 (fmul-double #x3fe0000000000000 (g '%76 loc)) loc))
    (mem (store-double (g '%77 loc) '(t . 0) mem))
    (loc (s '%78 (load-double '(t . 0) mem) loc))
    (loc (s '%79 (load-double '(w . 0) mem) loc))
    (loc (s '%80 (fmul-double (g '%78 loc) (g '%79 loc)) loc))
    (mem (store-double (g '%80 loc) '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%81-bb (mem loc)
  (b* (
    (mem (store-double #x7FF0000000000000 '(ret . 0) mem)))
  (mv '@__ieee754_cosh-%82-bb mem loc)))

(defund @__ieee754_cosh-%82-bb (mem loc)
  (b* (
    (loc (s '%83 (load-double '(ret . 0) mem) loc)))
  (mv 'ret mem loc)))

(defund @__ieee754_cosh-step (label mem loc)
  (case label
    (%-0 (@__ieee754_cosh-%0-bb mem loc))
    (%-10 (@__ieee754_cosh-%10-bb mem loc))
    (%-14 (@__ieee754_cosh-%14-bb mem loc))
    (%-17 (@__ieee754_cosh-%17-bb mem loc))
    (%-25 (@__ieee754_cosh-%25-bb mem loc))
    (%-27 (@__ieee754_cosh-%27-bb mem loc))
    (%-36 (@__ieee754_cosh-%36-bb mem loc))
    (%-39 (@__ieee754_cosh-%39-bb mem loc))
    (%-48 (@__ieee754_cosh-%48-bb mem loc))
    (%-51 (@__ieee754_cosh-%51-bb mem loc))
    (%-56 (@__ieee754_cosh-%56-bb mem loc))
    (%-65 (@__ieee754_cosh-%65-bb mem loc))
    (%-68 (@__ieee754_cosh-%68-bb mem loc))
    (%-71 (@__ieee754_cosh-%71-bb mem loc))
    (%-81 (@__ieee754_cosh-%81-bb mem loc))
    (%-82 (@__ieee754_cosh-%82-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @__ieee754_cosh-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%83 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@__ieee754_cosh-step label mem loc)
        (@__ieee754_cosh-steps label mem loc (1- n))))))

(defund @__ieee754_cosh (%x)
  (declare (ignore %x))
   nil)
