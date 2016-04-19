(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_atan")

(defconst *__ieee754_atan2-globals* '())

(defund @__ieee754_atan2-%0-bb (mem loc)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'y 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 'z 1 mem))
    (mem (alloca-i32 'k 1 mem))
    (mem (alloca-i32 'm 1 mem))
    (mem (alloca-i32 'hx 1 mem))
    (mem (alloca-i32 'hy 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (alloca-i32 'iy 1 mem))
    (mem (alloca-i32 'lx 1 mem))
    (mem (alloca-i32 'ly 1 mem))
    (mem (store-double (g '%y loc) '(y . 0) mem))
    (mem (store-double (g '%x loc) '(x . 0) mem))
    (loc (s '%4 (bitcast-double*-to-i32* '(x . 0)) loc))
    (loc (s '%5 (getelementptr-i32 (g '%4 loc) 1) loc))
    (loc (s '%6 (load-i32 (g '%5 loc) mem) loc))
    (mem (store-i32 (g '%6 loc) '(hx . 0) mem))
    (loc (s '%7 (load-i32 '(hx . 0) mem) loc))
    (loc (s '%8 (and-i32 (g '%7 loc) 2147483647) loc))
    (mem (store-i32 (g '%8 loc) '(ix . 0) mem))
    (loc (s '%9 (bitcast-double*-to-i32* '(x . 0)) loc))
    (loc (s '%10 (load-i32 (g '%9 loc) mem) loc))
    (mem (store-i32 (g '%10 loc) '(lx . 0) mem))
    (loc (s '%11 (bitcast-double*-to-i32* '(y . 0)) loc))
    (loc (s '%12 (getelementptr-i32 (g '%11 loc) 1) loc))
    (loc (s '%13 (load-i32 (g '%12 loc) mem) loc))
    (mem (store-i32 (g '%13 loc) '(hy . 0) mem))
    (loc (s '%14 (load-i32 '(hy . 0) mem) loc))
    (loc (s '%15 (and-i32 (g '%14 loc) 2147483647) loc))
    (mem (store-i32 (g '%15 loc) '(iy . 0) mem))
    (loc (s '%16 (bitcast-double*-to-i32* '(y . 0)) loc))
    (loc (s '%17 (load-i32 (g '%16 loc) mem) loc))
    (mem (store-i32 (g '%17 loc) '(ly . 0) mem))
    (loc (s '%18 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%19 (load-i32 '(lx . 0) mem) loc))
    (loc (s '%20 (load-i32 '(lx . 0) mem) loc))
    (loc (s '%21 (sub-i32 0 (g '%20 loc)) loc))
    (loc (s '%22 (or-i32 (g '%19 loc) (g '%21 loc)) loc))
    (loc (s '%23 (lshr-i32 (g '%22 loc) 31) loc))
    (loc (s '%24 (or-i32 (g '%18 loc) (g '%23 loc)) loc))
    (loc (s '%25 (icmp-ugt-i32 (g '%24 loc) 2146435072) loc)))
  (case (g '%25 loc)
    (-1 (mv '@__ieee754_atan2-%35-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%26-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%26-bb (mem loc)
  (b* (
    (loc (s '%27 (load-i32 '(iy . 0) mem) loc))
    (loc (s '%28 (load-i32 '(ly . 0) mem) loc))
    (loc (s '%29 (load-i32 '(ly . 0) mem) loc))
    (loc (s '%30 (sub-i32 0 (g '%29 loc)) loc))
    (loc (s '%31 (or-i32 (g '%28 loc) (g '%30 loc)) loc))
    (loc (s '%32 (lshr-i32 (g '%31 loc) 31) loc))
    (loc (s '%33 (or-i32 (g '%27 loc) (g '%32 loc)) loc))
    (loc (s '%34 (icmp-ugt-i32 (g '%33 loc) 2146435072) loc)))
  (case (g '%34 loc)
    (-1 (mv '@__ieee754_atan2-%35-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%39-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%35-bb (mem loc)
  (b* (
    (loc (s '%36 (load-double '(x . 0) mem) loc))
    (loc (s '%37 (load-double '(y . 0) mem) loc))
    (loc (s '%38 (fadd-double (g '%36 loc) (g '%37 loc)) loc))
    (mem (store-double (g '%38 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%39-bb (mem loc)
  (b* (
    (loc (s '%40 (load-i32 '(hx . 0) mem) loc))
    (loc (s '%41 (sub-i32 (g '%40 loc) 1072693248) loc))
    (loc (s '%42 (load-i32 '(lx . 0) mem) loc))
    (loc (s '%43 (or-i32 (g '%41 loc) (g '%42 loc)) loc))
    (loc (s '%44 (icmp-eq-i32 (g '%43 loc) 0) loc)))
  (case (g '%44 loc)
    (-1 (mv '@__ieee754_atan2-%45-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%48-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%45-bb (mem loc)
  (b* (
    (loc (s '%46 (load-double '(y . 0) mem) loc))
    (loc (s '%47 (@atan (g '%46 loc)) loc))
    (mem (store-double (g '%47 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%48-bb (mem loc)
  (b* (
    (loc (s '%49 (load-i32 '(hy . 0) mem) loc))
    (loc (s '%50 (ashr-i32 (g '%49 loc) 31) loc))
    (loc (s '%51 (and-i32 (g '%50 loc) 1) loc))
    (loc (s '%52 (load-i32 '(hx . 0) mem) loc))
    (loc (s '%53 (ashr-i32 (g '%52 loc) 30) loc))
    (loc (s '%54 (and-i32 (g '%53 loc) 2) loc))
    (loc (s '%55 (or-i32 (g '%51 loc) (g '%54 loc)) loc))
    (mem (store-i32 (g '%55 loc) '(m . 0) mem))
    (loc (s '%56 (load-i32 '(iy . 0) mem) loc))
    (loc (s '%57 (load-i32 '(ly . 0) mem) loc))
    (loc (s '%58 (or-i32 (g '%56 loc) (g '%57 loc)) loc))
    (loc (s '%59 (icmp-eq-i32 (g '%58 loc) 0) loc)))
  (case (g '%59 loc)
    (-1 (mv '@__ieee754_atan2-%60-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%67-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%60-bb (mem loc)
  (b* (
    (loc (s '%61 (load-i32 '(m . 0) mem) loc)))
  (case (g '%61 loc)
    (0 (mv '@__ieee754_atan2-%62-bb mem loc))
    (1 (mv '@__ieee754_atan2-%62-bb mem loc))
    (2 (mv '@__ieee754_atan2-%64-bb mem loc))
    (3 (mv '@__ieee754_atan2-%65-bb mem loc))
    (otherwise (mv '@__ieee754_atan2-%66-bb mem loc)))))

(defund @__ieee754_atan2-%62-bb (mem loc)
  (b* (
    (loc (s '%63 (load-double '(y . 0) mem) loc))
    (mem (store-double (g '%63 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%64-bb (mem loc)
  (b* (
    (mem (store-double #x400921FB54442D18 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%65-bb (mem loc)
  (b* (
    (mem (store-double #xC00921FB54442D18 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%66-bb (mem loc)
  (b* ()
  (mv '@__ieee754_atan2-%67-bb mem loc)))

(defund @__ieee754_atan2-%67-bb (mem loc)
  (b* (
    (loc (s '%68 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%69 (load-i32 '(lx . 0) mem) loc))
    (loc (s '%70 (or-i32 (g '%68 loc) (g '%69 loc)) loc))
    (loc (s '%71 (icmp-eq-i32 (g '%70 loc) 0) loc)))
  (case (g '%71 loc)
    (-1 (mv '@__ieee754_atan2-%72-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%76-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%72-bb (mem loc)
  (b* (
    (loc (s '%73 (load-i32 '(hy . 0) mem) loc))
    (loc (s '%74 (icmp-slt-i32 (g '%73 loc) 0) loc))
    (loc (s '%75 (select-double (g '%74 loc) #xBFF921FB54442D18 #x3FF921FB54442D18) loc))
    (mem (store-double (g '%75 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%76-bb (mem loc)
  (b* (
    (loc (s '%77 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%78 (icmp-eq-i32 (g '%77 loc) 2146435072) loc)))
  (case (g '%78 loc)
    (-1 (mv '@__ieee754_atan2-%79-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%97-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%79-bb (mem loc)
  (b* (
    (loc (s '%80 (load-i32 '(iy . 0) mem) loc))
    (loc (s '%81 (icmp-eq-i32 (g '%80 loc) 2146435072) loc)))
  (case (g '%81 loc)
    (-1 (mv '@__ieee754_atan2-%82-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%89-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%82-bb (mem loc)
  (b* (
    (loc (s '%83 (load-i32 '(m . 0) mem) loc)))
  (case (g '%83 loc)
    (0 (mv '@__ieee754_atan2-%84-bb mem loc))
    (1 (mv '@__ieee754_atan2-%85-bb mem loc))
    (2 (mv '@__ieee754_atan2-%86-bb mem loc))
    (3 (mv '@__ieee754_atan2-%87-bb mem loc))
    (otherwise (mv '@__ieee754_atan2-%88-bb mem loc)))))

(defund @__ieee754_atan2-%84-bb (mem loc)
  (b* (
    (mem (store-double #x3FE921FB54442D18 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%85-bb (mem loc)
  (b* (
    (mem (store-double #xBFE921FB54442D18 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%86-bb (mem loc)
  (b* (
    (mem (store-double #x4002D97C7F3321D2 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%87-bb (mem loc)
  (b* (
    (mem (store-double #xC002D97C7F3321D2 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%88-bb (mem loc)
  (b* ()
  (mv '@__ieee754_atan2-%96-bb mem loc)))

(defund @__ieee754_atan2-%89-bb (mem loc)
  (b* (
    (loc (s '%90 (load-i32 '(m . 0) mem) loc)))
  (case (g '%90 loc)
    (0 (mv '@__ieee754_atan2-%91-bb mem loc))
    (1 (mv '@__ieee754_atan2-%92-bb mem loc))
    (2 (mv '@__ieee754_atan2-%93-bb mem loc))
    (3 (mv '@__ieee754_atan2-%94-bb mem loc))
    (otherwise (mv '@__ieee754_atan2-%95-bb mem loc)))))

(defund @__ieee754_atan2-%91-bb (mem loc)
  (b* (
    (mem (store-double #x0000000000000000 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%92-bb (mem loc)
  (b* (
    (mem (store-double #x8000000000000000 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%93-bb (mem loc)
  (b* (
    (mem (store-double #x400921FB54442D18 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%94-bb (mem loc)
  (b* (
    (mem (store-double #xC00921FB54442D18 '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%95-bb (mem loc)
  (b* ()
  (mv '@__ieee754_atan2-%96-bb mem loc)))

(defund @__ieee754_atan2-%96-bb (mem loc)
  (b* ()
  (mv '@__ieee754_atan2-%97-bb mem loc)))

(defund @__ieee754_atan2-%97-bb (mem loc)
  (b* (
    (loc (s '%98 (load-i32 '(iy . 0) mem) loc))
    (loc (s '%99 (icmp-eq-i32 (g '%98 loc) 2146435072) loc)))
  (case (g '%99 loc)
    (-1 (mv '@__ieee754_atan2-%100-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%104-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%100-bb (mem loc)
  (b* (
    (loc (s '%101 (load-i32 '(hy . 0) mem) loc))
    (loc (s '%102 (icmp-slt-i32 (g '%101 loc) 0) loc))
    (loc (s '%103 (select-double (g '%102 loc) #xBFF921FB54442D18 #x3FF921FB54442D18) loc))
    (mem (store-double (g '%103 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%104-bb (mem loc)
  (b* (
    (loc (s '%105 (load-i32 '(iy . 0) mem) loc))
    (loc (s '%106 (load-i32 '(ix . 0) mem) loc))
    (loc (s '%107 (sub-i32 (g '%105 loc) (g '%106 loc)) loc))
    (loc (s '%108 (ashr-i32 (g '%107 loc) 20) loc))
    (mem (store-i32 (g '%108 loc) '(k . 0) mem))
    (loc (s '%109 (load-i32 '(k . 0) mem) loc))
    (loc (s '%110 (icmp-sgt-i32 (g '%109 loc) 60) loc)))
  (case (g '%110 loc)
    (-1 (mv '@__ieee754_atan2-%111-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%112-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%111-bb (mem loc)
  (b* (
    (mem (store-double #x3FF921FB54442D18 '(z . 0) mem)))
  (mv '@__ieee754_atan2-%126-bb mem loc)))

(defund @__ieee754_atan2-%112-bb (mem loc)
  (b* (
    (loc (s '%113 (load-i32 '(hx . 0) mem) loc))
    (loc (s '%114 (icmp-slt-i32 (g '%113 loc) 0) loc)))
  (case (g '%114 loc)
    (-1 (mv '@__ieee754_atan2-%115-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%119-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%115-bb (mem loc)
  (b* (
    (loc (s '%116 (load-i32 '(k . 0) mem) loc))
    (loc (s '%117 (icmp-slt-i32 (g '%116 loc) -60) loc)))
  (case (g '%117 loc)
    (-1 (mv '@__ieee754_atan2-%118-bb mem loc))
    ( 0 (mv '@__ieee754_atan2-%119-bb mem loc))
    (otherwise (mv nil mem loc)))))

(defund @__ieee754_atan2-%118-bb (mem loc)
  (b* (
    (mem (store-double #x0000000000000000 '(z . 0) mem)))
  (mv '@__ieee754_atan2-%125-bb mem loc)))

(defund @__ieee754_atan2-%119-bb (mem loc)
  (b* (
    (loc (s '%120 (load-double '(y . 0) mem) loc))
    (loc (s '%121 (load-double '(x . 0) mem) loc))
    (loc (s '%122 (fdiv-double (g '%120 loc) (g '%121 loc)) loc))
    (loc (s '%123 (@fabs (g '%122 loc)) loc))
    (loc (s '%124 (@atan (g '%123 loc)) loc))
    (mem (store-double (g '%124 loc) '(z . 0) mem)))
  (mv '@__ieee754_atan2-%125-bb mem loc)))

(defund @__ieee754_atan2-%125-bb (mem loc)
  (b* ()
  (mv '@__ieee754_atan2-%126-bb mem loc)))

(defund @__ieee754_atan2-%126-bb (mem loc)
  (b* (
    (loc (s '%127 (load-i32 '(m . 0) mem) loc)))
  (case (g '%127 loc)
    (0 (mv '@__ieee754_atan2-%128-bb mem loc))
    (1 (mv '@__ieee754_atan2-%130-bb mem loc))
    (2 (mv '@__ieee754_atan2-%136-bb mem loc))
    (otherwise (mv '@__ieee754_atan2-%140-bb mem loc)))))

(defund @__ieee754_atan2-%128-bb (mem loc)
  (b* (
    (loc (s '%129 (load-double '(z . 0) mem) loc))
    (mem (store-double (g '%129 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%130-bb (mem loc)
  (b* (
    (loc (s '%131 (bitcast-double*-to-i32* '(z . 0)) loc))
    (loc (s '%132 (getelementptr-i32 (g '%131 loc) 1) loc))
    (loc (s '%133 (load-i32 (g '%132 loc) mem) loc))
    (loc (s '%134 (xor-i32 (g '%133 loc) -2147483648) loc))
    (mem (store-i32 (g '%134 loc) (g '%132 loc) mem))
    (loc (s '%135 (load-double '(z . 0) mem) loc))
    (mem (store-double (g '%135 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%136-bb (mem loc)
  (b* (
    (loc (s '%137 (load-double '(z . 0) mem) loc))
    (loc (s '%138 (fsub-double (g '%137 loc) #x3CA1A62633145C07) loc))
    (loc (s '%139 (fsub-double #x400921FB54442D18 (g '%138 loc)) loc))
    (mem (store-double (g '%139 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%140-bb (mem loc)
  (b* (
    (loc (s '%141 (load-double '(z . 0) mem) loc))
    (loc (s '%142 (fsub-double (g '%141 loc) #x3CA1A62633145C07) loc))
    (loc (s '%143 (fsub-double (g '%142 loc) #x400921FB54442D18) loc))
    (mem (store-double (g '%143 loc) '(ret . 0) mem)))
  (mv '@__ieee754_atan2-%144-bb mem loc)))

(defund @__ieee754_atan2-%144-bb (mem loc)
  (b* (
    (loc (s '%145 (load-double '(ret . 0) mem) loc)))
  (mv 'ret mem loc)))

(defund @__ieee754_atan2-step (label mem loc)
  (case label
    (%-0 (@__ieee754_atan2-%0-bb mem loc))
    (%-26 (@__ieee754_atan2-%26-bb mem loc))
    (%-35 (@__ieee754_atan2-%35-bb mem loc))
    (%-39 (@__ieee754_atan2-%39-bb mem loc))
    (%-45 (@__ieee754_atan2-%45-bb mem loc))
    (%-48 (@__ieee754_atan2-%48-bb mem loc))
    (%-60 (@__ieee754_atan2-%60-bb mem loc))
    (%-62 (@__ieee754_atan2-%62-bb mem loc))
    (%-64 (@__ieee754_atan2-%64-bb mem loc))
    (%-65 (@__ieee754_atan2-%65-bb mem loc))
    (%-66 (@__ieee754_atan2-%66-bb mem loc))
    (%-67 (@__ieee754_atan2-%67-bb mem loc))
    (%-72 (@__ieee754_atan2-%72-bb mem loc))
    (%-76 (@__ieee754_atan2-%76-bb mem loc))
    (%-79 (@__ieee754_atan2-%79-bb mem loc))
    (%-82 (@__ieee754_atan2-%82-bb mem loc))
    (%-84 (@__ieee754_atan2-%84-bb mem loc))
    (%-85 (@__ieee754_atan2-%85-bb mem loc))
    (%-86 (@__ieee754_atan2-%86-bb mem loc))
    (%-87 (@__ieee754_atan2-%87-bb mem loc))
    (%-88 (@__ieee754_atan2-%88-bb mem loc))
    (%-89 (@__ieee754_atan2-%89-bb mem loc))
    (%-91 (@__ieee754_atan2-%91-bb mem loc))
    (%-92 (@__ieee754_atan2-%92-bb mem loc))
    (%-93 (@__ieee754_atan2-%93-bb mem loc))
    (%-94 (@__ieee754_atan2-%94-bb mem loc))
    (%-95 (@__ieee754_atan2-%95-bb mem loc))
    (%-96 (@__ieee754_atan2-%96-bb mem loc))
    (%-97 (@__ieee754_atan2-%97-bb mem loc))
    (%-100 (@__ieee754_atan2-%100-bb mem loc))
    (%-104 (@__ieee754_atan2-%104-bb mem loc))
    (%-111 (@__ieee754_atan2-%111-bb mem loc))
    (%-112 (@__ieee754_atan2-%112-bb mem loc))
    (%-115 (@__ieee754_atan2-%115-bb mem loc))
    (%-118 (@__ieee754_atan2-%118-bb mem loc))
    (%-119 (@__ieee754_atan2-%119-bb mem loc))
    (%-125 (@__ieee754_atan2-%125-bb mem loc))
    (%-126 (@__ieee754_atan2-%126-bb mem loc))
    (%-128 (@__ieee754_atan2-%128-bb mem loc))
    (%-130 (@__ieee754_atan2-%130-bb mem loc))
    (%-136 (@__ieee754_atan2-%136-bb mem loc))
    (%-140 (@__ieee754_atan2-%140-bb mem loc))
    (%-144 (@__ieee754_atan2-%144-bb mem loc))
    (otherwise (mv nil mem loc))))

(defund @__ieee754_atan2-steps (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (equal label 'ret)
      (g '%145 loc)
    (if (zp n) nil
      (mv-let
        (label mem loc)
        (@__ieee754_atan2-step label mem loc)
        (@__ieee754_atan2-steps label mem loc (1- n))))))

(defund @__ieee754_atan2 (%y %x)
  (declare (ignore %y %x))
   nil)
