(in-package "ACL2")
(include-book "../llvm")
(include-book "s_copysign")

(defconst *scalbn-globals* '())

(defund @scalbn-%93 (mem %1)
  (b* (
    (%94 (load-double %1 mem)))
  %94))

(defund @scalbn-%81 (mem %hx %k %1 %2)
  (b* (
    (%82 (load-i32 %k mem))
    (%83 (add-i32 %82 54))
    (mem (store-i32 %83 %k mem))
    (%84 (load-i32 %hx mem))
    (%85 (and-i32 %84 -2146435073))
    (%86 (load-i32 %k mem))
    (%87 (shl-i32 %86 20))
    (%88 (or-i32 %85 %87))
    (%89 (bitcast-double*-to-i32* %2))
    (%90 (getelementptr-i32 %89 1))
    (mem (store-i32 %88 %90 mem))
    (%91 (load-double %2 mem))
    (%92 (fmul-double %91 #x3C90000000000000))
    (mem (store-double %92 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%77 (mem %1 %2)
  (b* (
    (%78 (load-double %2 mem))
    (%79 (@copysign #x01a56e1fc2f8f359 %78))
    (%80 (fmul-double #x01a56e1fc2f8f359 %79))
    (mem (store-double %80 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%73 (mem %1 %2)
  (b* (
    (%74 (load-double %2 mem))
    (%75 (@copysign #x7e37e43c8800759c %74))
    (%76 (fmul-double #x7e37e43c8800759c %75))
    (mem (store-double %76 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%70 (mem %1 %2 %3)
  (b* (
    (%71 (load-i32 %3 mem))
    (%72 (icmp-sgt-i32 %71 50000)))
  (case %72
    (-1  (@scalbn-%73 mem %1 %2))
    (0 (@scalbn-%77 mem %1 %2)))))

(defund @scalbn-%67 (mem %hx %k %1 %2 %3)
  (b* (
    (%68 (load-i32 %k mem))
    (%69 (icmp-sle-i32 %68 -54)))
  (case %69
    (-1  (@scalbn-%70 mem %1 %2 %3))
    (0 (@scalbn-%81 mem %hx %k %1 %2)))))

(defund @scalbn-%58 (mem %hx %k %1 %2)
  (b* (
    (%59 (load-i32 %hx mem))
    (%60 (and-i32 %59 -2146435073))
    (%61 (load-i32 %k mem))
    (%62 (shl-i32 %61 20))
    (%63 (or-i32 %60 %62))
    (%64 (bitcast-double*-to-i32* %2))
    (%65 (getelementptr-i32 %64 1))
    (mem (store-i32 %63 %65 mem))
    (%66 (load-double %2 mem))
    (mem (store-double %66 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%55 (mem %hx %k %1 %2 %3)
  (b* (
    (%56 (load-i32 %k mem))
    (%57 (icmp-sgt-i32 %56 0)))
  (case %57
    (-1  (@scalbn-%58 mem %hx %k %1 %2))
    (0 (@scalbn-%67 mem %hx %k %1 %2 %3)))))

(defund @scalbn-%51 (mem %1 %2)
  (b* (
    (%52 (load-double %2 mem))
    (%53 (@copysign #x7e37e43c8800759c %52))
    (%54 (fmul-double #x7e37e43c8800759c %53))
    (mem (store-double %54 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%45 (mem %hx %k %1 %2 %3)
  (b* (
    (%46 (load-i32 %k mem))
    (%47 (load-i32 %3 mem))
    (%48 (add-i32 %46 %47))
    (mem (store-i32 %48 %k mem))
    (%49 (load-i32 %k mem))
    (%50 (icmp-sgt-i32 %49 2046)))
  (case %50
    (-1  (@scalbn-%51 mem %1 %2))
    (0 (@scalbn-%55 mem %hx %k %1 %2 %3)))))

(defund @scalbn-%41 (mem %1 %2)
  (b* (
    (%42 (load-double %2 mem))
    (%43 (load-double %2 mem))
    (%44 (fadd-double %42 %43))
    (mem (store-double %44 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%38 (mem %hx %k %1 %2 %3)
  (b* (
    (%39 (load-i32 %k mem))
    (%40 (icmp-eq-i32 %39 2047)))
  (case %40
    (-1  (@scalbn-%41 mem %1 %2))
    (0 (@scalbn-%45 mem %hx %k %1 %2 %3)))))

(defund @scalbn-%37 (mem %hx %k %1 %2 %3)
  (b* ()
  (@scalbn-%38 mem %hx %k %1 %2 %3)))

(defund @scalbn-%34 (mem %1 %2)
  (b* (
    (%35 (load-double %2 mem))
    (%36 (fmul-double #x01a56e1fc2f8f359 %35))
    (mem (store-double %36 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%22 (mem %hx %k %1 %2 %3)
  (b* (
    (%23 (load-double %2 mem))
    (%24 (fmul-double %23 #x4350000000000000))
    (mem (store-double %24 %2 mem))
    (%25 (bitcast-double*-to-i32* %2))
    (%26 (getelementptr-i32 %25 1))
    (%27 (load-i32 %26 mem))
    (mem (store-i32 %27 %hx mem))
    (%28 (load-i32 %hx mem))
    (%29 (and-i32 %28 2146435072))
    (%30 (ashr-i32 %29 20))
    (%31 (sub-i32 %30 54))
    (mem (store-i32 %31 %k mem))
    (%32 (load-i32 %3 mem))
    (%33 (icmp-slt-i32 %32 -50000)))
  (case %33
    (-1  (@scalbn-%34 mem %1 %2))
    (0 (@scalbn-%37 mem %hx %k %1 %2 %3)))))

(defund @scalbn-%20 (mem %1 %2)
  (b* (
    (%21 (load-double %2 mem))
    (mem (store-double %21 %1 mem)))
  (@scalbn-%93 mem %1)))

(defund @scalbn-%14 (mem %hx %k %lx %1 %2 %3)
  (b* (
    (%15 (load-i32 %lx mem))
    (%16 (load-i32 %hx mem))
    (%17 (and-i32 %16 2147483647))
    (%18 (or-i32 %15 %17))
    (%19 (icmp-eq-i32 %18 0)))
  (case %19
    (-1  (@scalbn-%20 mem %1 %2))
    (0 (@scalbn-%22 mem %hx %k %1 %2 %3)))))

(defund @scalbn-%0 (mem %x %n)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %3 mem) (alloca-i32 'n 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    ((mv %lx mem) (alloca-i32 'lx 1 mem))
    (mem (store-double %x %2 mem))
    (mem (store-i32 %n %3 mem))
    (%4 (bitcast-double*-to-i32* %2))
    (%5 (getelementptr-i32 %4 1))
    (%6 (load-i32 %5 mem))
    (mem (store-i32 %6 %hx mem))
    (%7 (bitcast-double*-to-i32* %2))
    (%8 (load-i32 %7 mem))
    (mem (store-i32 %8 %lx mem))
    (%9 (load-i32 %hx mem))
    (%10 (and-i32 %9 2146435072))
    (%11 (ashr-i32 %10 20))
    (mem (store-i32 %11 %k mem))
    (%12 (load-i32 %k mem))
    (%13 (icmp-eq-i32 %12 0)))
  (case %13
    (-1  (@scalbn-%14 mem %hx %k %lx %1 %2 %3))
    (0 (@scalbn-%38 mem %hx %k %1 %2 %3)))))

(defund @scalbn (%x %n)
  (@scalbn-%0 *scalbn-globals* %x %n))
