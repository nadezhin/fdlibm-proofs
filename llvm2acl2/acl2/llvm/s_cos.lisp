(in-package "ACL2")
(include-book "../llvm")
(include-book "k_cos")
(include-book "k_sin")
(include-book "e_rem_pio2")

(defconst *cos-globals* '())

(defund @cos-%53 (mem %1)
  (b* (
    (%54 (load-double %1 mem)))
  %54))

(defund @cos-%47 (mem %y %1)
  (b* (
    (%48 (getelementptr-double %y 0))
    (%49 (load-double %48 mem))
    (%50 (getelementptr-double %y 1))
    (%51 (load-double %50 mem))
    (%52 (@__kernel_sin %49 %51 1))
    (mem (store-double %52 %1 mem)))
  (@cos-%53 mem %1)))

(defund @cos-%40 (mem %y %1)
  (b* (
    (%41 (getelementptr-double %y 0))
    (%42 (load-double %41 mem))
    (%43 (getelementptr-double %y 1))
    (%44 (load-double %43 mem))
    (%45 (@__kernel_cos %42 %44))
    (%46 (fsub-double #x8000000000000000 %45))
    (mem (store-double %46 %1 mem)))
  (@cos-%53 mem %1)))

(defund @cos-%33 (mem %y %1)
  (b* (
    (%34 (getelementptr-double %y 0))
    (%35 (load-double %34 mem))
    (%36 (getelementptr-double %y 1))
    (%37 (load-double %36 mem))
    (%38 (@__kernel_sin %35 %37 1))
    (%39 (fsub-double #x8000000000000000 %38))
    (mem (store-double %39 %1 mem)))
  (@cos-%53 mem %1)))

(defund @cos-%27 (mem %y %1)
  (b* (
    (%28 (getelementptr-double %y 0))
    (%29 (load-double %28 mem))
    (%30 (getelementptr-double %y 1))
    (%31 (load-double %30 mem))
    (%32 (@__kernel_cos %29 %31))
    (mem (store-double %32 %1 mem)))
  (@cos-%53 mem %1)))

(defund @cos-%21 (mem %n %y %1 %2)
  (b* (
    (%22 (load-double %2 mem))
    (%23 (getelementptr-double %y 0))
    (%24 (@__ieee754_rem_pio2 %22 %23))
    (mem (store-i32 %24 %n mem))
    (%25 (load-i32 %n mem))
    (%26 (and-i32 %25 3)))
  (case %26
    (0 (@cos-%27 mem %y %1))
    (1 (@cos-%33 mem %y %1))
    (2 (@cos-%40 mem %y %1))
    (otherwise  (@cos-%47 mem %y %1)))))

(defund @cos-%17 (mem %1 %2)
  (b* (
    (%18 (load-double %2 mem))
    (%19 (load-double %2 mem))
    (%20 (fsub-double %18 %19))
    (mem (store-double %20 %1 mem)))
  (@cos-%53 mem %1)))

(defund @cos-%14 (mem %ix %n %y %1 %2)
  (b* (
    (%15 (load-i32 %ix mem))
    (%16 (icmp-sge-i32 %15 2146435072)))
  (case %16
    (-1 (@cos-%17 mem %1 %2))
    (0 (@cos-%21 mem %n %y %1 %2)))))

(defund @cos-%10 (mem %z %1 %2)
  (b* (
    (%11 (load-double %2 mem))
    (%12 (load-double %z mem))
    (%13 (@__kernel_cos %11 %12))
    (mem (store-double %13 %1 mem)))
  (@cos-%53 mem %1)))

(defund @cos-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %y mem) (alloca-double 'y 2 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %n mem) (alloca-i32 'n 1 mem))
    ((mv %ix mem) (alloca-i32 'ix 1 mem))
    (mem (store-double %x %2 mem))
    (mem (store-double #x0000000000000000 %z mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %ix mem))
    (%6 (load-i32 %ix mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 %ix mem))
    (%8 (load-i32 %ix mem))
    (%9 (icmp-sle-i32 %8 1072243195)))
  (case %9
    (-1 (@cos-%10 mem %z %1 %2))
    (0 (@cos-%14 mem %ix %n %y %1 %2)))))

(defund @cos (%x)
  (@cos-%0 *cos-globals* %x))
