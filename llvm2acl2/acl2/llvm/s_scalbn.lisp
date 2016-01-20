(in-package "ACL2")
(include-book "../llvm")
(include-book "s_copysign")

(defconst *scalbn-globals* '())

(defund @scalbn-%93 (mem)
  (b* (
    (%94 (load-double '(ret . 0) mem)))
  %94))

(defund @scalbn-%81 (mem)
  (b* (
    (%82 (load-i32 '(k . 0) mem))
    (%83 (add-i32 %82 54))
    (mem (store-i32 %83 '(k . 0) mem))
    (%84 (load-i32 '(hx . 0) mem))
    (%85 (and-i32 %84 -2146435073))
    (%86 (load-i32 '(k . 0) mem))
    (%87 (shl-i32 %86 20))
    (%88 (or-i32 %85 %87))
    (%89 (bitcast-double*-to-i32* '(x . 0)))
    (%90 (getelementptr-i32 %89 1))
    (mem (store-i32 %88 %90 mem))
    (%91 (load-double '(x . 0) mem))
    (%92 (fmul-double %91 #x3C90000000000000))
    (mem (store-double %92 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%77 (mem)
  (b* (
    (%78 (load-double '(x . 0) mem))
    (%79 (@copysign #x01a56e1fc2f8f359 %78))
    (%80 (fmul-double #x01a56e1fc2f8f359 %79))
    (mem (store-double %80 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%73 (mem)
  (b* (
    (%74 (load-double '(x . 0) mem))
    (%75 (@copysign #x7e37e43c8800759c %74))
    (%76 (fmul-double #x7e37e43c8800759c %75))
    (mem (store-double %76 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%70 (mem)
  (b* (
    (%71 (load-i32 '(n . 0) mem))
    (%72 (icmp-sgt-i32 %71 50000)))
  (case %72
    (-1 (@scalbn-%73 mem))
    (0 (@scalbn-%77 mem)))))

(defund @scalbn-%67 (mem)
  (b* (
    (%68 (load-i32 '(k . 0) mem))
    (%69 (icmp-sle-i32 %68 -54)))
  (case %69
    (-1 (@scalbn-%70 mem))
    (0 (@scalbn-%81 mem)))))

(defund @scalbn-%58 (mem)
  (b* (
    (%59 (load-i32 '(hx . 0) mem))
    (%60 (and-i32 %59 -2146435073))
    (%61 (load-i32 '(k . 0) mem))
    (%62 (shl-i32 %61 20))
    (%63 (or-i32 %60 %62))
    (%64 (bitcast-double*-to-i32* '(x . 0)))
    (%65 (getelementptr-i32 %64 1))
    (mem (store-i32 %63 %65 mem))
    (%66 (load-double '(x . 0) mem))
    (mem (store-double %66 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%55 (mem)
  (b* (
    (%56 (load-i32 '(k . 0) mem))
    (%57 (icmp-sgt-i32 %56 0)))
  (case %57
    (-1 (@scalbn-%58 mem))
    (0 (@scalbn-%67 mem)))))

(defund @scalbn-%51 (mem)
  (b* (
    (%52 (load-double '(x . 0) mem))
    (%53 (@copysign #x7e37e43c8800759c %52))
    (%54 (fmul-double #x7e37e43c8800759c %53))
    (mem (store-double %54 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%45 (mem)
  (b* (
    (%46 (load-i32 '(k . 0) mem))
    (%47 (load-i32 '(n . 0) mem))
    (%48 (add-i32 %46 %47))
    (mem (store-i32 %48 '(k . 0) mem))
    (%49 (load-i32 '(k . 0) mem))
    (%50 (icmp-sgt-i32 %49 2046)))
  (case %50
    (-1 (@scalbn-%51 mem))
    (0 (@scalbn-%55 mem)))))

(defund @scalbn-%41 (mem)
  (b* (
    (%42 (load-double '(x . 0) mem))
    (%43 (load-double '(x . 0) mem))
    (%44 (fadd-double %42 %43))
    (mem (store-double %44 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%38 (mem)
  (b* (
    (%39 (load-i32 '(k . 0) mem))
    (%40 (icmp-eq-i32 %39 2047)))
  (case %40
    (-1 (@scalbn-%41 mem))
    (0 (@scalbn-%45 mem)))))

(defund @scalbn-%37 (mem)
  (b* ()
  (@scalbn-%38 mem)))

(defund @scalbn-%34 (mem)
  (b* (
    (%35 (load-double '(x . 0) mem))
    (%36 (fmul-double #x01a56e1fc2f8f359 %35))
    (mem (store-double %36 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%22 (mem)
  (b* (
    (%23 (load-double '(x . 0) mem))
    (%24 (fmul-double %23 #x4350000000000000))
    (mem (store-double %24 '(x . 0) mem))
    (%25 (bitcast-double*-to-i32* '(x . 0)))
    (%26 (getelementptr-i32 %25 1))
    (%27 (load-i32 %26 mem))
    (mem (store-i32 %27 '(hx . 0) mem))
    (%28 (load-i32 '(hx . 0) mem))
    (%29 (and-i32 %28 2146435072))
    (%30 (ashr-i32 %29 20))
    (%31 (sub-i32 %30 54))
    (mem (store-i32 %31 '(k . 0) mem))
    (%32 (load-i32 '(n . 0) mem))
    (%33 (icmp-slt-i32 %32 -50000)))
  (case %33
    (-1 (@scalbn-%34 mem))
    (0 (@scalbn-%37 mem)))))

(defund @scalbn-%20 (mem)
  (b* (
    (%21 (load-double '(x . 0) mem))
    (mem (store-double %21 '(ret . 0) mem)))
  (@scalbn-%93 mem)))

(defund @scalbn-%14 (mem)
  (b* (
    (%15 (load-i32 '(lx . 0) mem))
    (%16 (load-i32 '(hx . 0) mem))
    (%17 (and-i32 %16 2147483647))
    (%18 (or-i32 %15 %17))
    (%19 (icmp-eq-i32 %18 0)))
  (case %19
    (-1 (@scalbn-%20 mem))
    (0 (@scalbn-%22 mem)))))

(defund @scalbn-%0 (mem %x %n)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-i32 'n 1 mem))
    (mem (alloca-i32 'k 1 mem))
    (mem (alloca-i32 'hx 1 mem))
    (mem (alloca-i32 'lx 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (mem (store-i32 %n '(n . 0) mem))
    (%4 (bitcast-double*-to-i32* '(x . 0)))
    (%5 (getelementptr-i32 %4 1))
    (%6 (load-i32 %5 mem))
    (mem (store-i32 %6 '(hx . 0) mem))
    (%7 (bitcast-double*-to-i32* '(x . 0)))
    (%8 (load-i32 %7 mem))
    (mem (store-i32 %8 '(lx . 0) mem))
    (%9 (load-i32 '(hx . 0) mem))
    (%10 (and-i32 %9 2146435072))
    (%11 (ashr-i32 %10 20))
    (mem (store-i32 %11 '(k . 0) mem))
    (%12 (load-i32 '(k . 0) mem))
    (%13 (icmp-eq-i32 %12 0)))
  (case %13
    (-1 (@scalbn-%14 mem))
    (0 (@scalbn-%38 mem)))))

(defund @scalbn (%x %n)
  (@scalbn-%0 *scalbn-globals*  %x %n))
