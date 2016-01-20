(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")
(include-book "e_exp")

(defconst *__ieee754_cosh-globals* '(
  (one #x00000000 #x3ff00000)))

(defund @__ieee754_cosh-%82 (mem)
  (b* (
    (%83 (load-double '(ret . 0) mem)))
  %83))

(defund @__ieee754_cosh-%81 (mem)
  (b* (
    (mem (store-double #x7FF0000000000000 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%71 (mem)
  (b* (
    (%72 (load-double '(x . 0) mem))
    (%73 (@fabs %72))
    (%74 (fmul-double #x3fe0000000000000 %73))
    (%75 (@__ieee754_exp %74))
    (mem (store-double %75 '(w . 0) mem))
    (%76 (load-double '(w . 0) mem))
    (%77 (fmul-double #x3fe0000000000000 %76))
    (mem (store-double %77 '(t . 0) mem))
    (%78 (load-double '(t . 0) mem))
    (%79 (load-double '(w . 0) mem))
    (%80 (fmul-double %78 %79))
    (mem (store-double %80 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%68 (mem)
  (b* (
    (%69 (load-i32 '(lx . 0) mem))
    (%70 (icmp-ule-i32 %69 -1883637635)))
  (case %70
    (-1 (@__ieee754_cosh-%71 mem))
    (0 (@__ieee754_cosh-%81 mem)))))

(defund @__ieee754_cosh-%65 (mem)
  (b* (
    (%66 (load-i32 '(ix . 0) mem))
    (%67 (icmp-eq-i32 %66 1082536910)))
  (case %67
    (-1 (@__ieee754_cosh-%68 mem))
    (0 (@__ieee754_cosh-%81 mem)))))

(defund @__ieee754_cosh-%56 (mem)
  (b* (
    (%57 (load-i32 '(one . 0) mem))
    (%58 (lshr-i32 %57 29))
    (%59 (bitcast-double*-to-i32* '(x . 0)))
    (%60 (zext-i32-to-i64 %58))
    (%61 (getelementptr-i32 %59 %60))
    (%62 (load-i32 %61 mem))
    (mem (store-i32 %62 '(lx . 0) mem))
    (%63 (load-i32 '(ix . 0) mem))
    (%64 (icmp-slt-i32 %63 1082536910)))
  (case %64
    (-1 (@__ieee754_cosh-%71 mem))
    (0 (@__ieee754_cosh-%65 mem)))))

(defund @__ieee754_cosh-%51 (mem)
  (b* (
    (%52 (load-double '(x . 0) mem))
    (%53 (@fabs %52))
    (%54 (@__ieee754_exp %53))
    (%55 (fmul-double #x3fe0000000000000 %54))
    (mem (store-double %55 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%48 (mem)
  (b* (
    (%49 (load-i32 '(ix . 0) mem))
    (%50 (icmp-slt-i32 %49 1082535490)))
  (case %50
    (-1 (@__ieee754_cosh-%51 mem))
    (0 (@__ieee754_cosh-%56 mem)))))

(defund @__ieee754_cosh-%39 (mem)
  (b* (
    (%40 (load-double '(x . 0) mem))
    (%41 (@fabs %40))
    (%42 (@__ieee754_exp %41))
    (mem (store-double %42 '(t . 0) mem))
    (%43 (load-double '(t . 0) mem))
    (%44 (fmul-double #x3fe0000000000000 %43))
    (%45 (load-double '(t . 0) mem))
    (%46 (fdiv-double #x3fe0000000000000 %45))
    (%47 (fadd-double %44 %46))
    (mem (store-double %47 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%36 (mem)
  (b* (
    (%37 (load-i32 '(ix . 0) mem))
    (%38 (icmp-slt-i32 %37 1077280768)))
  (case %38
    (-1 (@__ieee754_cosh-%39 mem))
    (0 (@__ieee754_cosh-%48 mem)))))

(defund @__ieee754_cosh-%27 (mem)
  (b* (
    (%28 (load-double '(t . 0) mem))
    (%29 (load-double '(t . 0) mem))
    (%30 (fmul-double %28 %29))
    (%31 (load-double '(w . 0) mem))
    (%32 (load-double '(w . 0) mem))
    (%33 (fadd-double %31 %32))
    (%34 (fdiv-double %30 %33))
    (%35 (fadd-double #x3ff0000000000000 %34))
    (mem (store-double %35 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%25 (mem)
  (b* (
    (%26 (load-double '(w . 0) mem))
    (mem (store-double %26 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%17 (mem)
  (b* (
    (%18 (load-double '(x . 0) mem))
    (%19 (@fabs %18))
    (%20 (@expm1 %19))
    (mem (store-double %20 '(t . 0) mem))
    (%21 (load-double '(t . 0) mem))
    (%22 (fadd-double #x3ff0000000000000 %21))
    (mem (store-double %22 '(w . 0) mem))
    (%23 (load-i32 '(ix . 0) mem))
    (%24 (icmp-slt-i32 %23 1015021568)))
  (case %24
    (-1 (@__ieee754_cosh-%25 mem))
    (0 (@__ieee754_cosh-%27 mem)))))

(defund @__ieee754_cosh-%14 (mem)
  (b* (
    (%15 (load-i32 '(ix . 0) mem))
    (%16 (icmp-slt-i32 %15 1071001155)))
  (case %16
    (-1 (@__ieee754_cosh-%17 mem))
    (0 (@__ieee754_cosh-%36 mem)))))

(defund @__ieee754_cosh-%10 (mem)
  (b* (
    (%11 (load-double '(x . 0) mem))
    (%12 (load-double '(x . 0) mem))
    (%13 (fmul-double %11 %12))
    (mem (store-double %13 '(ret . 0) mem)))
  (@__ieee754_cosh-%82 mem)))

(defund @__ieee754_cosh-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'w 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (alloca-i32 'lx 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (%3 (bitcast-double*-to-i32* '(x . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 '(ix . 0) mem))
    (%6 (load-i32 '(ix . 0) mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 '(ix . 0) mem))
    (%8 (load-i32 '(ix . 0) mem))
    (%9 (icmp-sge-i32 %8 2146435072)))
  (case %9
    (-1 (@__ieee754_cosh-%10 mem))
    (0 (@__ieee754_cosh-%14 mem)))))

(defund @__ieee754_cosh (%x)
  (@__ieee754_cosh-%0 *__ieee754_cosh-globals*  %x))
