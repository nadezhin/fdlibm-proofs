(in-package "ACL2")
(include-book "../llvm")
(include-book "k_cos")
(include-book "k_sin")
(include-book "e_rem_pio2")

(defconst *cos-globals* '())

(defund @cos-%53 (mem)
  (b* (
    (%54 (load-double '(ret . 0) mem)))
  %54))

(defund @cos-%47 (mem)
  (b* (
    (%48 (getelementptr-double '(y . 0) 0))
    (%49 (load-double %48 mem))
    (%50 (getelementptr-double '(y . 0) 1))
    (%51 (load-double %50 mem))
    (%52 (@__kernel_sin %49 %51 1))
    (mem (store-double %52 '(ret . 0) mem)))
  (@cos-%53 mem)))

(defund @cos-%40 (mem)
  (b* (
    (%41 (getelementptr-double '(y . 0) 0))
    (%42 (load-double %41 mem))
    (%43 (getelementptr-double '(y . 0) 1))
    (%44 (load-double %43 mem))
    (%45 (@__kernel_cos %42 %44))
    (%46 (fsub-double #x8000000000000000 %45))
    (mem (store-double %46 '(ret . 0) mem)))
  (@cos-%53 mem)))

(defund @cos-%33 (mem)
  (b* (
    (%34 (getelementptr-double '(y . 0) 0))
    (%35 (load-double %34 mem))
    (%36 (getelementptr-double '(y . 0) 1))
    (%37 (load-double %36 mem))
    (%38 (@__kernel_sin %35 %37 1))
    (%39 (fsub-double #x8000000000000000 %38))
    (mem (store-double %39 '(ret . 0) mem)))
  (@cos-%53 mem)))

(defund @cos-%27 (mem)
  (b* (
    (%28 (getelementptr-double '(y . 0) 0))
    (%29 (load-double %28 mem))
    (%30 (getelementptr-double '(y . 0) 1))
    (%31 (load-double %30 mem))
    (%32 (@__kernel_cos %29 %31))
    (mem (store-double %32 '(ret . 0) mem)))
  (@cos-%53 mem)))

(defund @cos-%21 (mem)
  (b* (
    (%22 (load-double '(x . 0) mem))
    (%23 (getelementptr-double '(y . 0) 0))
    (%24 (@__ieee754_rem_pio2 %22 %23))
    (mem (store-i32 %24 '(n . 0) mem))
    (%25 (load-i32 '(n . 0) mem))
    (%26 (and-i32 %25 3)))
  (case %26
    (0 (@cos-%27 mem ))
    (1 (@cos-%33 mem ))
    (2 (@cos-%40 mem ))
    (otherwise  (@cos-%47 mem )))))

(defund @cos-%17 (mem)
  (b* (
    (%18 (load-double '(x . 0) mem))
    (%19 (load-double '(x . 0) mem))
    (%20 (fsub-double %18 %19))
    (mem (store-double %20 '(ret . 0) mem)))
  (@cos-%53 mem)))

(defund @cos-%14 (mem)
  (b* (
    (%15 (load-i32 '(ix . 0) mem))
    (%16 (icmp-sge-i32 %15 2146435072)))
  (case %16
    (-1 (@cos-%17 mem))
    (0 (@cos-%21 mem)))))

(defund @cos-%10 (mem)
  (b* (
    (%11 (load-double '(x . 0) mem))
    (%12 (load-double '(z . 0) mem))
    (%13 (@__kernel_cos %11 %12))
    (mem (store-double %13 '(ret . 0) mem)))
  (@cos-%53 mem)))

(defund @cos-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 'y 2 mem))
    (mem (alloca-double 'z 1 mem))
    (mem (alloca-i32 'n 1 mem))
    (mem (alloca-i32 'ix 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (mem (store-double #x0000000000000000 '(z . 0) mem))
    (%3 (bitcast-double*-to-i32* '(x . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 '(ix . 0) mem))
    (%6 (load-i32 '(ix . 0) mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 '(ix . 0) mem))
    (%8 (load-i32 '(ix . 0) mem))
    (%9 (icmp-sle-i32 %8 1072243195)))
  (case %9
    (-1 (@cos-%10 mem))
    (0 (@cos-%14 mem)))))

(defund @cos (%x)
  (@cos-%0 *cos-globals*  %x))
