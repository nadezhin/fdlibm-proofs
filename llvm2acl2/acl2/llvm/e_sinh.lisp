(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")
(include-book "e_exp")

(defconst *__ieee754_sinh-globals* '(
  (one #x00000000 #x3ff00000)))

(defund @__ieee754_sinh-%98 (mem)
  (b* (
    (%99 (load-double '(ret . 0) mem)))
  %99))

(defund @__ieee754_sinh-%95 (mem)
  (b* (
    (%96 (load-double '(x . 0) mem))
    (%97 (fmul-double %96 #x7fac7b1f3cac7433))
    (mem (store-double %97 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%84 (mem)
  (b* (
    (%85 (load-double '(x . 0) mem))
    (%86 (@fabs %85))
    (%87 (fmul-double #x3fe0000000000000 %86))
    (%88 (@__ieee754_exp %87))
    (mem (store-double %88 '(w . 0) mem))
    (%89 (load-double '(h . 0) mem))
    (%90 (load-double '(w . 0) mem))
    (%91 (fmul-double %89 %90))
    (mem (store-double %91 '(t . 0) mem))
    (%92 (load-double '(t . 0) mem))
    (%93 (load-double '(w . 0) mem))
    (%94 (fmul-double %92 %93))
    (mem (store-double %94 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%81 (mem)
  (b* (
    (%82 (load-i32 '(lx . 0) mem))
    (%83 (icmp-ule-i32 %82 -1883637635)))
  (case %83
    (-1 (@__ieee754_sinh-%84 mem))
    (0 (@__ieee754_sinh-%95 mem)))))

(defund @__ieee754_sinh-%78 (mem)
  (b* (
    (%79 (load-i32 '(ix . 0) mem))
    (%80 (icmp-eq-i32 %79 1082536910)))
  (case %80
    (-1 (@__ieee754_sinh-%81 mem))
    (0 (@__ieee754_sinh-%95 mem)))))

(defund @__ieee754_sinh-%69 (mem)
  (b* (
    (%70 (load-i32 '(one . 0) mem))
    (%71 (lshr-i32 %70 29))
    (%72 (bitcast-double*-to-i32* '(x . 0)))
    (%73 (zext-i32-to-i64 %71))
    (%74 (getelementptr-i32 %72 %73))
    (%75 (load-i32 %74 mem))
    (mem (store-i32 %75 '(lx . 0) mem))
    (%76 (load-i32 '(ix . 0) mem))
    (%77 (icmp-slt-i32 %76 1082536910)))
  (case %77
    (-1 (@__ieee754_sinh-%84 mem))
    (0 (@__ieee754_sinh-%78 mem)))))

(defund @__ieee754_sinh-%63 (mem)
  (b* (
    (%64 (load-double '(h . 0) mem))
    (%65 (load-double '(x . 0) mem))
    (%66 (@fabs %65))
    (%67 (@__ieee754_exp %66))
    (%68 (fmul-double %64 %67))
    (mem (store-double %68 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%60 (mem)
  (b* (
    (%61 (load-i32 '(ix . 0) mem))
    (%62 (icmp-slt-i32 %61 1082535490)))
  (case %62
    (-1 (@__ieee754_sinh-%63 mem))
    (0 (@__ieee754_sinh-%69 mem)))))

(defund @__ieee754_sinh-%51 (mem)
  (b* (
    (%52 (load-double '(h . 0) mem))
    (%53 (load-double '(t . 0) mem))
    (%54 (load-double '(t . 0) mem))
    (%55 (load-double '(t . 0) mem))
    (%56 (fadd-double %55 #x3ff0000000000000))
    (%57 (fdiv-double %54 %56))
    (%58 (fadd-double %53 %57))
    (%59 (fmul-double %52 %58))
    (mem (store-double %59 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%39 (mem)
  (b* (
    (%40 (load-double '(h . 0) mem))
    (%41 (load-double '(t . 0) mem))
    (%42 (fmul-double #x4000000000000000 %41))
    (%43 (load-double '(t . 0) mem))
    (%44 (load-double '(t . 0) mem))
    (%45 (fmul-double %43 %44))
    (%46 (load-double '(t . 0) mem))
    (%47 (fadd-double %46 #x3ff0000000000000))
    (%48 (fdiv-double %45 %47))
    (%49 (fsub-double %42 %48))
    (%50 (fmul-double %40 %49))
    (mem (store-double %50 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%33 (mem)
  (b* (
    (%34 (load-double '(x . 0) mem))
    (%35 (@fabs %34))
    (%36 (@expm1 %35))
    (mem (store-double %36 '(t . 0) mem))
    (%37 (load-i32 '(ix . 0) mem))
    (%38 (icmp-slt-i32 %37 1072693248)))
  (case %38
    (-1 (@__ieee754_sinh-%39 mem))
    (0 (@__ieee754_sinh-%51 mem)))))

(defund @__ieee754_sinh-%32 (mem)
  (b* ()
  (@__ieee754_sinh-%33 mem)))

(defund @__ieee754_sinh-%30 (mem)
  (b* (
    (%31 (load-double '(x . 0) mem))
    (mem (store-double %31 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%26 (mem)
  (b* (
    (%27 (load-double '(x . 0) mem))
    (%28 (fadd-double #x7fac7b1f3cac7433 %27))
    (%29 (fcmp-ogt-double %28 #x3ff0000000000000)))
  (case %29
    (-1 (@__ieee754_sinh-%30 mem))
    (0 (@__ieee754_sinh-%32 mem)))))

(defund @__ieee754_sinh-%23 (mem)
  (b* (
    (%24 (load-i32 '(ix . 0) mem))
    (%25 (icmp-slt-i32 %24 1043333120)))
  (case %25
    (-1 (@__ieee754_sinh-%26 mem))
    (0 (@__ieee754_sinh-%33 mem)))))

(defund @__ieee754_sinh-%20 (mem)
  (b* (
    (%21 (load-i32 '(ix . 0) mem))
    (%22 (icmp-slt-i32 %21 1077280768)))
  (case %22
    (-1 (@__ieee754_sinh-%23 mem))
    (0 (@__ieee754_sinh-%60 mem)))))

(defund @__ieee754_sinh-%17 (mem)
  (b* (
    (%18 (load-double '(h . 0) mem))
    (%19 (fsub-double #x8000000000000000 %18))
    (mem (store-double %19 '(h . 0) mem)))
  (@__ieee754_sinh-%20 mem)))

(defund @__ieee754_sinh-%14 (mem)
  (b* (
    (mem (store-double #x3fe0000000000000 '(h . 0) mem))
    (%15 (load-i32 '(jx . 0) mem))
    (%16 (icmp-slt-i32 %15 0)))
  (case %16
    (-1 (@__ieee754_sinh-%17 mem))
    (0 (@__ieee754_sinh-%20 mem)))))

(defund @__ieee754_sinh-%10 (mem)
  (b* (
    (%11 (load-double '(x . 0) mem))
    (%12 (load-double '(x . 0) mem))
    (%13 (fadd-double %11 %12))
    (mem (store-double %13 '(ret . 0) mem)))
  (@__ieee754_sinh-%98 mem)))

(defund @__ieee754_sinh-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'w 1 mem))
    (mem (alloca-double 'h 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (alloca-i32 'jx 1 mem))
    (mem (alloca-i32 'lx 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (%3 (bitcast-double*-to-i32* '(x . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 '(jx . 0) mem))
    (%6 (load-i32 '(jx . 0) mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 '(ix . 0) mem))
    (%8 (load-i32 '(ix . 0) mem))
    (%9 (icmp-sge-i32 %8 2146435072)))
  (case %9
    (-1 (@__ieee754_sinh-%10 mem))
    (0 (@__ieee754_sinh-%14 mem)))))

(defund @__ieee754_sinh (%x)
  (@__ieee754_sinh-%0 *__ieee754_sinh-globals*  %x))
