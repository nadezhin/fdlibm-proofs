(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")

(defconst *tanh-globals* '())

(defund @tanh-%66 (mem %1)
  (b* (
    (%67 (load-double %1 mem)))
  %67))

(defund @tanh-%64 (mem %1 %65)
  (b* (
    ; %65 = phi double [ %60, %59 ], [ %63, %61 ]
    (mem (store-double %65 %1 mem)))
  (@tanh-%66 mem %1)))

(defund @tanh-%61 (mem %z %1)
  (b* (
    (%62 (load-double %z mem))
    (%63 (fsub-double #x8000000000000000 %62)))
  (@tanh-%64 mem %1 %63)))

(defund @tanh-%59 (mem %z %1)
  (b* (
    (%60 (load-double %z mem)))
  (@tanh-%64 mem %1 %60)))

(defund @tanh-%56 (mem %jx %z %1)
  (b* (
    (%57 (load-i32 %jx mem))
    (%58 (icmp-sge-i32 %57 0)))
  (case %58
    (-1 (@tanh-%59 mem %z %1))
    (0 (@tanh-%61 mem %z %1)))))

(defund @tanh-%55 (mem %jx %z %1)
  (b* (
    (mem (store-double #x3ff0000000000000 %z mem)))
  (@tanh-%56 mem %jx %z %1)))

(defund @tanh-%54 (mem %jx %z %1)
  (b* ()
  (@tanh-%56 mem %jx %z %1)))

(defund @tanh-%44 (mem %jx %t %z %1 %2)
  (b* (
    (%45 (load-double %2 mem))
    (%46 (@fabs %45))
    (%47 (fmul-double #xc000000000000000 %46))
    (%48 (@expm1 %47))
    (mem (store-double %48 %t mem))
    (%49 (load-double %t mem))
    (%50 (fsub-double #x8000000000000000 %49))
    (%51 (load-double %t mem))
    (%52 (fadd-double %51 #x4000000000000000))
    (%53 (fdiv-double %50 %52))
    (mem (store-double %53 %z mem)))
  (@tanh-%54 mem %jx %z %1)))

(defund @tanh-%35 (mem %jx %t %z %1 %2)
  (b* (
    (%36 (load-double %2 mem))
    (%37 (@fabs %36))
    (%38 (fmul-double #x4000000000000000 %37))
    (%39 (@expm1 %38))
    (mem (store-double %39 %t mem))
    (%40 (load-double %t mem))
    (%41 (fadd-double %40 #x4000000000000000))
    (%42 (fdiv-double #x4000000000000000 %41))
    (%43 (fsub-double #x3ff0000000000000 %42))
    (mem (store-double %43 %z mem)))
  (@tanh-%54 mem %jx %z %1)))

(defund @tanh-%32 (mem %ix %jx %t %z %1 %2)
  (b* (
    (%33 (load-i32 %ix mem))
    (%34 (icmp-sge-i32 %33 1072693248)))
  (case %34
    (-1 (@tanh-%35 mem %jx %t %z %1 %2))
    (0 (@tanh-%44 mem %jx %t %z %1 %2)))))

(defund @tanh-%27 (mem %1 %2)
  (b* (
    (%28 (load-double %2 mem))
    (%29 (load-double %2 mem))
    (%30 (fadd-double #x3ff0000000000000 %29))
    (%31 (fmul-double %28 %30))
    (mem (store-double %31 %1 mem)))
  (@tanh-%66 mem %1)))

(defund @tanh-%24 (mem %ix %jx %t %z %1 %2)
  (b* (
    (%25 (load-i32 %ix mem))
    (%26 (icmp-slt-i32 %25 1015021568)))
  (case %26
    (-1 (@tanh-%27 mem %1 %2))
    (0 (@tanh-%32 mem %ix %jx %t %z %1 %2)))))

(defund @tanh-%21 (mem %ix %jx %t %z %1 %2)
  (b* (
    (%22 (load-i32 %ix mem))
    (%23 (icmp-slt-i32 %22 1077280768)))
  (case %23
    (-1 (@tanh-%24 mem %ix %jx %t %z %1 %2))
    (0 (@tanh-%55 mem %jx %z %1)))))

(defund @tanh-%17 (mem %1 %2)
  (b* (
    (%18 (load-double %2 mem))
    (%19 (fdiv-double #x3ff0000000000000 %18))
    (%20 (fsub-double %19 #x3ff0000000000000))
    (mem (store-double %20 %1 mem)))
  (@tanh-%66 mem %1)))

(defund @tanh-%13 (mem %1 %2)
  (b* (
    (%14 (load-double %2 mem))
    (%15 (fdiv-double #x3ff0000000000000 %14))
    (%16 (fadd-double %15 #x3ff0000000000000))
    (mem (store-double %16 %1 mem)))
  (@tanh-%66 mem %1)))

(defund @tanh-%10 (mem %jx %1 %2)
  (b* (
    (%11 (load-i32 %jx mem))
    (%12 (icmp-sge-i32 %11 0)))
  (case %12
    (-1 (@tanh-%13 mem %1 %2))
    (0 (@tanh-%17 mem %1 %2)))))

(defund @tanh-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %t mem) (alloca-double 't 1 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %jx mem) (alloca-i32 'jx 1 mem))
    ((mv %ix mem) (alloca-i32 'ix 1 mem))
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
    (-1 (@tanh-%10 mem %jx %1 %2))
    (0 (@tanh-%21 mem %ix %jx %t %z %1 %2)))))

(defund @tanh (%x)
  (@tanh-%0 *tanh-globals* %x))
