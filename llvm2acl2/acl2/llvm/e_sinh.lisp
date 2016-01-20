(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")
(include-book "e_exp")

(defconst *__ieee754_sinh-globals* '(
  (one #x00000000 #x3ff00000)))

(defund @__ieee754_sinh-%98 (mem %1)
  (b* (
    (%99 (load-double %1 mem)))
  %99))

(defund @__ieee754_sinh-%95 (mem %1 %2)
  (b* (
    (%96 (load-double %2 mem))
    (%97 (fmul-double %96 #x7fac7b1f3cac7433))
    (mem (store-double %97 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%84 (mem %h %t %w %1 %2)
  (b* (
    (%85 (load-double %2 mem))
    (%86 (@fabs %85))
    (%87 (fmul-double #x3fe0000000000000 %86))
    (%88 (@__ieee754_exp %87))
    (mem (store-double %88 %w mem))
    (%89 (load-double %h mem))
    (%90 (load-double %w mem))
    (%91 (fmul-double %89 %90))
    (mem (store-double %91 %t mem))
    (%92 (load-double %t mem))
    (%93 (load-double %w mem))
    (%94 (fmul-double %92 %93))
    (mem (store-double %94 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%81 (mem %h %lx %t %w %1 %2)
  (b* (
    (%82 (load-i32 %lx mem))
    (%83 (icmp-ule-i32 %82 -1883637635)))
  (case %83
    (-1 (@__ieee754_sinh-%84 mem %h %t %w %1 %2))
    (0 (@__ieee754_sinh-%95 mem %1 %2)))))

(defund @__ieee754_sinh-%78 (mem %h %ix %lx %t %w %1 %2)
  (b* (
    (%79 (load-i32 %ix mem))
    (%80 (icmp-eq-i32 %79 1082536910)))
  (case %80
    (-1 (@__ieee754_sinh-%81 mem %h %lx %t %w %1 %2))
    (0 (@__ieee754_sinh-%95 mem %1 %2)))))

(defund @__ieee754_sinh-%69 (mem %h %ix %lx %t %w %1 %2)
  (b* (
    (%70 (load-i32 '(one . 0) mem))
    (%71 (lshr-i32 %70 29))
    (%72 (bitcast-double*-to-i32* %2))
    (%73 (zext-i32-to-i64 %71))
    (%74 (getelementptr-i32 %72 %73))
    (%75 (load-i32 %74 mem))
    (mem (store-i32 %75 %lx mem))
    (%76 (load-i32 %ix mem))
    (%77 (icmp-slt-i32 %76 1082536910)))
  (case %77
    (-1 (@__ieee754_sinh-%84 mem %h %t %w %1 %2))
    (0 (@__ieee754_sinh-%78 mem %h %ix %lx %t %w %1 %2)))))

(defund @__ieee754_sinh-%63 (mem %h %1 %2)
  (b* (
    (%64 (load-double %h mem))
    (%65 (load-double %2 mem))
    (%66 (@fabs %65))
    (%67 (@__ieee754_exp %66))
    (%68 (fmul-double %64 %67))
    (mem (store-double %68 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%60 (mem %h %ix %lx %t %w %1 %2)
  (b* (
    (%61 (load-i32 %ix mem))
    (%62 (icmp-slt-i32 %61 1082535490)))
  (case %62
    (-1 (@__ieee754_sinh-%63 mem %h %1 %2))
    (0 (@__ieee754_sinh-%69 mem %h %ix %lx %t %w %1 %2)))))

(defund @__ieee754_sinh-%51 (mem %h %t %1)
  (b* (
    (%52 (load-double %h mem))
    (%53 (load-double %t mem))
    (%54 (load-double %t mem))
    (%55 (load-double %t mem))
    (%56 (fadd-double %55 #x3ff0000000000000))
    (%57 (fdiv-double %54 %56))
    (%58 (fadd-double %53 %57))
    (%59 (fmul-double %52 %58))
    (mem (store-double %59 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%39 (mem %h %t %1)
  (b* (
    (%40 (load-double %h mem))
    (%41 (load-double %t mem))
    (%42 (fmul-double #x4000000000000000 %41))
    (%43 (load-double %t mem))
    (%44 (load-double %t mem))
    (%45 (fmul-double %43 %44))
    (%46 (load-double %t mem))
    (%47 (fadd-double %46 #x3ff0000000000000))
    (%48 (fdiv-double %45 %47))
    (%49 (fsub-double %42 %48))
    (%50 (fmul-double %40 %49))
    (mem (store-double %50 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%33 (mem %h %ix %t %1 %2)
  (b* (
    (%34 (load-double %2 mem))
    (%35 (@fabs %34))
    (%36 (@expm1 %35))
    (mem (store-double %36 %t mem))
    (%37 (load-i32 %ix mem))
    (%38 (icmp-slt-i32 %37 1072693248)))
  (case %38
    (-1 (@__ieee754_sinh-%39 mem %h %t %1))
    (0 (@__ieee754_sinh-%51 mem %h %t %1)))))

(defund @__ieee754_sinh-%32 (mem %h %ix %t %1 %2)
  (b* ()
  (@__ieee754_sinh-%33 mem %h %ix %t %1 %2)))

(defund @__ieee754_sinh-%30 (mem %1 %2)
  (b* (
    (%31 (load-double %2 mem))
    (mem (store-double %31 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%26 (mem %h %ix %t %1 %2)
  (b* (
    (%27 (load-double %2 mem))
    (%28 (fadd-double #x7fac7b1f3cac7433 %27))
    (%29 (fcmp-ogt-double %28 #x3ff0000000000000)))
  (case %29
    (-1 (@__ieee754_sinh-%30 mem %1 %2))
    (0 (@__ieee754_sinh-%32 mem %h %ix %t %1 %2)))))

(defund @__ieee754_sinh-%23 (mem %h %ix %t %1 %2)
  (b* (
    (%24 (load-i32 %ix mem))
    (%25 (icmp-slt-i32 %24 1043333120)))
  (case %25
    (-1 (@__ieee754_sinh-%26 mem %h %ix %t %1 %2))
    (0 (@__ieee754_sinh-%33 mem %h %ix %t %1 %2)))))

(defund @__ieee754_sinh-%20 (mem %h %ix %lx %t %w %1 %2)
  (b* (
    (%21 (load-i32 %ix mem))
    (%22 (icmp-slt-i32 %21 1077280768)))
  (case %22
    (-1 (@__ieee754_sinh-%23 mem %h %ix %t %1 %2))
    (0 (@__ieee754_sinh-%60 mem %h %ix %lx %t %w %1 %2)))))

(defund @__ieee754_sinh-%17 (mem %h %ix %lx %t %w %1 %2)
  (b* (
    (%18 (load-double %h mem))
    (%19 (fsub-double #x8000000000000000 %18))
    (mem (store-double %19 %h mem)))
  (@__ieee754_sinh-%20 mem %h %ix %lx %t %w %1 %2)))

(defund @__ieee754_sinh-%14 (mem %h %ix %jx %lx %t %w %1 %2)
  (b* (
    (mem (store-double #x3fe0000000000000 %h mem))
    (%15 (load-i32 %jx mem))
    (%16 (icmp-slt-i32 %15 0)))
  (case %16
    (-1 (@__ieee754_sinh-%17 mem %h %ix %lx %t %w %1 %2))
    (0 (@__ieee754_sinh-%20 mem %h %ix %lx %t %w %1 %2)))))

(defund @__ieee754_sinh-%10 (mem %1 %2)
  (b* (
    (%11 (load-double %2 mem))
    (%12 (load-double %2 mem))
    (%13 (fadd-double %11 %12))
    (mem (store-double %13 %1 mem)))
  (@__ieee754_sinh-%98 mem %1)))

(defund @__ieee754_sinh-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %t mem) (alloca-double 't 1 mem))
    ((mv %w mem) (alloca-double 'w 1 mem))
    ((mv %h mem) (alloca-double 'h 1 mem))
    ((mv %ix mem) (alloca-i32 'ix 1 mem))
    ((mv %jx mem) (alloca-i32 'jx 1 mem))
    ((mv %lx mem) (alloca-i32 'lx 1 mem))
    (mem (store-double %x %2 mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %jx mem))
    (%6 (load-i32 %jx mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 %ix mem))
    (%8 (load-i32 %ix mem))
    (%9 (icmp-sge-i32 %8 2146435072)))
  (case %9
    (-1 (@__ieee754_sinh-%10 mem %1 %2))
    (0 (@__ieee754_sinh-%14 mem %h %ix %jx %lx %t %w %1 %2)))))

(defund @__ieee754_sinh (%x)
  (@__ieee754_sinh-%0 *__ieee754_sinh-globals* %x))
