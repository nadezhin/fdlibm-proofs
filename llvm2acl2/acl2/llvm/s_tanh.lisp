(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_expm1")

(defconst *tanh-globals* '())

(defund @tanh-%66 (mem)
  (b* (
    (%67 (load-double '(ret . 0) mem)))
  %67))

(defund @tanh-%64 (mem %65)
  (b* (
    ; %65 = phi double [ %60, %59 ], [ %63, %61 ]
    (mem (store-double %65 '(ret . 0) mem)))
  (@tanh-%66 mem)))

(defund @tanh-%61 (mem)
  (b* (
    (%62 (load-double '(z . 0) mem))
    (%63 (fsub-double #x8000000000000000 %62)))
  (@tanh-%64 mem %63)))

(defund @tanh-%59 (mem)
  (b* (
    (%60 (load-double '(z . 0) mem)))
  (@tanh-%64 mem %60)))

(defund @tanh-%56 (mem)
  (b* (
    (%57 (load-i32 '(jx . 0) mem))
    (%58 (icmp-sge-i32 %57 0)))
  (case %58
    (-1 (@tanh-%59 mem))
    (0 (@tanh-%61 mem)))))

(defund @tanh-%55 (mem)
  (b* (
    (mem (store-double #x3ff0000000000000 '(z . 0) mem)))
  (@tanh-%56 mem)))

(defund @tanh-%54 (mem)
  (b* ()
  (@tanh-%56 mem)))

(defund @tanh-%44 (mem)
  (b* (
    (%45 (load-double '(x . 0) mem))
    (%46 (@fabs %45))
    (%47 (fmul-double #xc000000000000000 %46))
    (%48 (@expm1 %47))
    (mem (store-double %48 '(t . 0) mem))
    (%49 (load-double '(t . 0) mem))
    (%50 (fsub-double #x8000000000000000 %49))
    (%51 (load-double '(t . 0) mem))
    (%52 (fadd-double %51 #x4000000000000000))
    (%53 (fdiv-double %50 %52))
    (mem (store-double %53 '(z . 0) mem)))
  (@tanh-%54 mem)))

(defund @tanh-%35 (mem)
  (b* (
    (%36 (load-double '(x . 0) mem))
    (%37 (@fabs %36))
    (%38 (fmul-double #x4000000000000000 %37))
    (%39 (@expm1 %38))
    (mem (store-double %39 '(t . 0) mem))
    (%40 (load-double '(t . 0) mem))
    (%41 (fadd-double %40 #x4000000000000000))
    (%42 (fdiv-double #x4000000000000000 %41))
    (%43 (fsub-double #x3ff0000000000000 %42))
    (mem (store-double %43 '(z . 0) mem)))
  (@tanh-%54 mem)))

(defund @tanh-%32 (mem)
  (b* (
    (%33 (load-i32 '(ix . 0) mem))
    (%34 (icmp-sge-i32 %33 1072693248)))
  (case %34
    (-1 (@tanh-%35 mem))
    (0 (@tanh-%44 mem)))))

(defund @tanh-%27 (mem)
  (b* (
    (%28 (load-double '(x . 0) mem))
    (%29 (load-double '(x . 0) mem))
    (%30 (fadd-double #x3ff0000000000000 %29))
    (%31 (fmul-double %28 %30))
    (mem (store-double %31 '(ret . 0) mem)))
  (@tanh-%66 mem)))

(defund @tanh-%24 (mem)
  (b* (
    (%25 (load-i32 '(ix . 0) mem))
    (%26 (icmp-slt-i32 %25 1015021568)))
  (case %26
    (-1 (@tanh-%27 mem))
    (0 (@tanh-%32 mem)))))

(defund @tanh-%21 (mem)
  (b* (
    (%22 (load-i32 '(ix . 0) mem))
    (%23 (icmp-slt-i32 %22 1077280768)))
  (case %23
    (-1 (@tanh-%24 mem))
    (0 (@tanh-%55 mem)))))

(defund @tanh-%17 (mem)
  (b* (
    (%18 (load-double '(x . 0) mem))
    (%19 (fdiv-double #x3ff0000000000000 %18))
    (%20 (fsub-double %19 #x3ff0000000000000))
    (mem (store-double %20 '(ret . 0) mem)))
  (@tanh-%66 mem)))

(defund @tanh-%13 (mem)
  (b* (
    (%14 (load-double '(x . 0) mem))
    (%15 (fdiv-double #x3ff0000000000000 %14))
    (%16 (fadd-double %15 #x3ff0000000000000))
    (mem (store-double %16 '(ret . 0) mem)))
  (@tanh-%66 mem)))

(defund @tanh-%10 (mem)
  (b* (
    (%11 (load-i32 '(jx . 0) mem))
    (%12 (icmp-sge-i32 %11 0)))
  (case %12
    (-1 (@tanh-%13 mem))
    (0 (@tanh-%17 mem)))))

(defund @tanh-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'z 1 mem))
    (mem (alloca-i32 'jx 1 mem))
    (mem (alloca-i32 'ix 1 mem))
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
    (-1 (@tanh-%10 mem))
    (0 (@tanh-%21 mem)))))

(defund @tanh (%x)
  (@tanh-%0 *tanh-globals*  %x))
