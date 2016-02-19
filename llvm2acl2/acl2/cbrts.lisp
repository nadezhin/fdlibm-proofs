(in-package "ACL2")
(include-book "./llvm")

(defconst *cbrts-globals* '())

(defund @cbrts-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-i32 'hx 1 mem))
    (mem (alloca-double 'r 1 mem))
    (mem (alloca-double 's 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-double 'w 1 mem))
    (mem (alloca-i32 'sign 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (mem (store-double #x0000000000000000 '(t . 0) mem))
    (%3 (bitcast-double*-to-i32* '(x . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 '(hx . 0) mem))
    (%6 (load-i32 '(hx . 0) mem))
    (%7 (and-i32 %6 -2147483648))
    (mem (store-i32 %7 '(sign . 0) mem))
    (%8 (load-i32 '(sign . 0) mem))
    (%9 (load-i32 '(hx . 0) mem))
    (%10 (xor-i32 %9 %8))
    (mem (store-i32 %10 '(hx . 0) mem))
    (%11 (load-i32 '(hx . 0) mem))
    (%12 (icmp-sge-i32 %11 2146435072)))
  (case %12
    (-1 (list '@cbrts-%13 mem))
    (0 (list '@cbrts-%17 mem)))))

(defund @cbrts-%13 (mem)
  (b* (
    (%14 (load-double '(x . 0) mem))
    (%15 (load-double '(x . 0) mem))
    (%16 (fadd-double %14 %15))
    (mem (store-double %16 '(ret . 0) mem)))
  (list '@cbrts-%101 mem)))

(defund @cbrts-%17 (mem)
  (b* (
    (%18 (load-i32 '(hx . 0) mem))
    (%19 (bitcast-double*-to-i32* '(x . 0)))
    (%20 (load-i32 %19 mem))
    (%21 (or-i32 %18 %20))
    (%22 (icmp-eq-i32 %21 0)))
  (case %22
    (-1 (list '@cbrts-%23 mem))
    (0 (list '@cbrts-%25 mem)))))

(defund @cbrts-%23 (mem)
  (b* (
    (%24 (load-double '(x . 0) mem))
    (mem (store-double %24 '(ret . 0) mem)))
  (list '@cbrts-%101 mem)))

(defund @cbrts-%25 (mem)
  (b* (
    (%26 (load-i32 '(hx . 0) mem))
    (%27 (bitcast-double*-to-i32* '(x . 0)))
    (%28 (getelementptr-i32 %27 1))
    (mem (store-i32 %26 %28 mem))
    (%29 (load-i32 '(hx . 0) mem))
    (%30 (icmp-slt-i32 %29 1048576)))
  (case %30
    (-1 (list '@cbrts-%31 mem))
    (0 (list '@cbrts-%44 mem)))))

(defund @cbrts-%31 (mem)
  (b* (
    (%32 (bitcast-double*-to-i32* '(t . 0)))
    (%33 (getelementptr-i32 %32 1))
    (mem (store-i32 1129316352 %33 mem))
    (%34 (load-double '(x . 0) mem))
    (%35 (load-double '(t . 0) mem))
    (%36 (fmul-double %35 %34))
    (mem (store-double %36 '(t . 0) mem))
    (%37 (bitcast-double*-to-i32* '(t . 0)))
    (%38 (getelementptr-i32 %37 1))
    (%39 (load-i32 %38 mem))
    (%40 (sdiv-i32 %39 3))
    (%41 (add-i32 %40 696219795))
    (%42 (bitcast-double*-to-i32* '(t . 0)))
    (%43 (getelementptr-i32 %42 1))
    (mem (store-i32 %41 %43 mem)))
  (list '@cbrts-%50 mem)))

(defund @cbrts-%44 (mem)
  (b* (
    (%45 (load-i32 '(hx . 0) mem))
    (%46 (sdiv-i32 %45 3))
    (%47 (add-i32 %46 715094163))
    (%48 (bitcast-double*-to-i32* '(t . 0)))
    (%49 (getelementptr-i32 %48 1))
    (mem (store-i32 %47 %49 mem)))
  (list '@cbrts-%50 mem)))

(defund @cbrts-%50 (mem)
  (b* (
    (%51 (load-double '(t . 0) mem))
    (%52 (load-double '(t . 0) mem))
    (%53 (fmul-double %51 %52))
    (%54 (load-double '(x . 0) mem))
    (%55 (fdiv-double %53 %54))
    (mem (store-double %55 '(r . 0) mem))
    (%56 (load-double '(r . 0) mem))
    (%57 (load-double '(t . 0) mem))
    (%58 (fmul-double %56 %57))
    (%59 (fadd-double #x3FE15F15F15F15F1 %58))
    (mem (store-double %59 '(s . 0) mem))
    (%60 (load-double '(s . 0) mem))
    (%61 (fadd-double %60 #x3FF6A0EA0EA0EA0F))
    (%62 (load-double '(s . 0) mem))
    (%63 (fdiv-double #xBFE691DE2532C834 %62))
    (%64 (fadd-double %61 %63))
    (%65 (fdiv-double #x3FF9B6DB6DB6DB6E %64))
    (%66 (fadd-double #x3FD6DB6DB6DB6DB7 %65))
    (%67 (load-double '(t . 0) mem))
    (%68 (fmul-double %67 %66))
    (mem (store-double %68 '(t . 0) mem))
    (%69 (bitcast-double*-to-i32* '(t . 0)))
    (mem (store-i32 0 %69 mem))
    (%70 (bitcast-double*-to-i32* '(t . 0)))
    (%71 (getelementptr-i32 %70 1))
    (%72 (load-i32 %71 mem))
    (%73 (add-i32 %72 1))
    (mem (store-i32 %73 %71 mem))
    (%74 (load-double '(t . 0) mem))
    (%75 (load-double '(t . 0) mem))
    (%76 (fmul-double %74 %75))
    (mem (store-double %76 '(s . 0) mem))
    (%77 (load-double '(x . 0) mem))
    (%78 (load-double '(s . 0) mem))
    (%79 (fdiv-double %77 %78))
    (mem (store-double %79 '(r . 0) mem))
    (%80 (load-double '(t . 0) mem))
    (%81 (load-double '(t . 0) mem))
    (%82 (fadd-double %80 %81))
    (mem (store-double %82 '(w . 0) mem))
    (%83 (load-double '(r . 0) mem))
    (%84 (load-double '(t . 0) mem))
    (%85 (fsub-double %83 %84))
    (%86 (load-double '(w . 0) mem))
    (%87 (load-double '(r . 0) mem))
    (%88 (fadd-double %86 %87))
    (%89 (fdiv-double %85 %88))
    (mem (store-double %89 '(r . 0) mem))
    (%90 (load-double '(t . 0) mem))
    (%91 (load-double '(t . 0) mem))
    (%92 (load-double '(r . 0) mem))
    (%93 (fmul-double %91 %92))
    (%94 (fadd-double %90 %93))
    (mem (store-double %94 '(t . 0) mem))
    (%95 (load-i32 '(sign . 0) mem))
    (%96 (bitcast-double*-to-i32* '(t . 0)))
    (%97 (getelementptr-i32 %96 1))
    (%98 (load-i32 %97 mem))
    (%99 (or-i32 %98 %95))
    (mem (store-i32 %99 %97 mem))
    (%100 (load-double '(t . 0) mem))
    (mem (store-double %100 '(ret . 0) mem)))
  (list '@cbrts-%101 mem)))

(defund @cbrts-%101 (mem)
  (b* (
    (%102 (load-double '(ret . 0) mem)))
  (list '@cbrts-ret %102)))

(defund @cbrts-step (s)
  (let ((label (car s))
        (mem (cadr s))
        (arg1 (caddr s)))
    (case label
      (@cbrts-%0 (@cbrts-%0 mem arg1))
      (@cbrts-%13 (@cbrts-%13 mem))
      (@cbrts-%17 (@cbrts-%17 mem))
      (@cbrts-%23 (@cbrts-%23 mem))
      (@cbrts-%25 (@cbrts-%25 mem))
      (@cbrts-%31 (@cbrts-%31 mem))
      (@cbrts-%44 (@cbrts-%44 mem))
      (@cbrts-%50 (@cbrts-%50 mem))
      (@cbrts-%101 (@cbrts-%101 mem)))))

(defund @cbrts-steps (s n)
  (declare (xargs :measure (nfix n)))
  (if (zp n) s (@cbrts-steps (@cbrts-step s) (1- n))))

(defchoose @cbrts-clock-aux n (s)
  (equal (car (@cbrts-steps s n)) '@cbrts-ret))

(defund @cbrts-clock (s)
  (let ((n (nfix (@cbrts-clock-aux s))))
    (and (equal (car (@cbrts-steps s n)) '@cbrts-ret) n)))

(defund @cbrts (%x)
  (let* ((s0 (list '@cbrts-0 *cbrts-globals* %x))
         (s (@cbrts-steps s0 (@cbrts-clock s0))))
    (and (equal (car s) '@cbrts-ret) (cadr s))))