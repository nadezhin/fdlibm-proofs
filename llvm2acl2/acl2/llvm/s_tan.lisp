(in-package "ACL2")
(include-book "../llvm")
(include-book "k_tan")
(include-book "e_rem_pio2")

(defconst *tan-globals* '())

(defund @tan-%34 (mem)
  (b* (
    (%35 (load-double '(ret . 0) mem)))
  %35))

(defund @tan-%21 (mem)
  (b* (
    (%22 (load-double '(x . 0) mem))
    (%23 (getelementptr-double '(y . 0) 0))
    (%24 (@__ieee754_rem_pio2 %22 %23))
    (mem (store-i32 %24 '(n . 0) mem))
    (%25 (getelementptr-double '(y . 0) 0))
    (%26 (load-double %25 mem))
    (%27 (getelementptr-double '(y . 0) 1))
    (%28 (load-double %27 mem))
    (%29 (load-i32 '(n . 0) mem))
    (%30 (and-i32 %29 1))
    (%31 (shl-i32 %30 1))
    (%32 (sub-i32 1 %31))
    (%33 (@__kernel_tan %26 %28 %32))
    (mem (store-double %33 '(ret . 0) mem)))
  (@tan-%34 mem)))

(defund @tan-%17 (mem)
  (b* (
    (%18 (load-double '(x . 0) mem))
    (%19 (load-double '(x . 0) mem))
    (%20 (fsub-double %18 %19))
    (mem (store-double %20 '(ret . 0) mem)))
  (@tan-%34 mem)))

(defund @tan-%14 (mem)
  (b* (
    (%15 (load-i32 '(ix . 0) mem))
    (%16 (icmp-sge-i32 %15 2146435072)))
  (case %16
    (-1 (@tan-%17 mem))
    (0 (@tan-%21 mem)))))

(defund @tan-%10 (mem)
  (b* (
    (%11 (load-double '(x . 0) mem))
    (%12 (load-double '(z . 0) mem))
    (%13 (@__kernel_tan %11 %12 1))
    (mem (store-double %13 '(ret . 0) mem)))
  (@tan-%34 mem)))

(defund @tan-%0 (mem %x)
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
    (-1 (@tan-%10 mem))
    (0 (@tan-%14 mem)))))

(defund @tan (%x)
  (@tan-%0 *tan-globals*  %x))
