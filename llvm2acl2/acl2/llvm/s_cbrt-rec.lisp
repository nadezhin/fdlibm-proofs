(in-package "ACL2")
(include-book "../llvm-rec")

(defund @cbrt-%101 (mem %1)
  (b* (
    (%102 (load-double %1 mem)))
  %102))

(defund @cbrt-%50 (mem %r %s %sign %t %w %1 %2)
  (b* (
    (%51 (load-double %t mem))
    (%52 (load-double %t mem))
    (%53 (fmul-double %51 %52))
    (%54 (load-double %2 mem))
    (%55 (fdiv-double %53 %54))
    (mem (store-double %55 %r mem))
    (%56 (load-double %r mem))
    (%57 (load-double %t mem))
    (%58 (fmul-double %56 %57))
    (%59 (fadd-double #x3FE15F15F15F15F1 %58))
    (mem (store-double %59 %s mem))
    (%60 (load-double %s mem))
    (%61 (fadd-double %60 #x3FF6A0EA0EA0EA0F))
    (%62 (load-double %s mem))
    (%63 (fdiv-double #xBFE691DE2532C834 %62))
    (%64 (fadd-double %61 %63))
    (%65 (fdiv-double #x3FF9B6DB6DB6DB6E %64))
    (%66 (fadd-double #x3FD6DB6DB6DB6DB7 %65))
    (%67 (load-double %t mem))
    (%68 (fmul-double %67 %66))
    (mem (store-double %68 %t mem))
    (%69 (bitcast-double*-to-i32* %t))
    (mem (store-i32 0 %69 mem))
    (%70 (bitcast-double*-to-i32* %t))
    (%71 (getelementptr-i32 %70 1))
    (%72 (load-i32 %71 mem))
    (%73 (add-i32 %72 1))
    (mem (store-i32 %73 %71 mem))
    (%74 (load-double %t mem))
    (%75 (load-double %t mem))
    (%76 (fmul-double %74 %75))
    (mem (store-double %76 %s mem))
    (%77 (load-double %2 mem))
    (%78 (load-double %s mem))
    (%79 (fdiv-double %77 %78))
    (mem (store-double %79 %r mem))
    (%80 (load-double %t mem))
    (%81 (load-double %t mem))
    (%82 (fadd-double %80 %81))
    (mem (store-double %82 %w mem))
    (%83 (load-double %r mem))
    (%84 (load-double %t mem))
    (%85 (fsub-double %83 %84))
    (%86 (load-double %w mem))
    (%87 (load-double %r mem))
    (%88 (fadd-double %86 %87))
    (%89 (fdiv-double %85 %88))
    (mem (store-double %89 %r mem))
    (%90 (load-double %t mem))
    (%91 (load-double %t mem))
    (%92 (load-double %r mem))
    (%93 (fmul-double %91 %92))
    (%94 (fadd-double %90 %93))
    (mem (store-double %94 %t mem))
    (%95 (load-i32 %sign mem))
    (%96 (bitcast-double*-to-i32* %t))
    (%97 (getelementptr-i32 %96 1))
    (%98 (load-i32 %97 mem))
    (%99 (or-i32 %98 %95))
    (mem (store-i32 %99 %97 mem))
    (%100 (load-double %t mem))
    (mem (store-double %100 %1 mem)))
  (@cbrt-%101 mem %1)))

(defund @cbrt-%44 (mem %hx %r %s %sign %t %w %1 %2)
  (b* (
    (%45 (load-i32 %hx mem))
    (%46 (sdiv-i32 %45 3))
    (%47 (add-i32 %46 715094163))
    (%48 (bitcast-double*-to-i32* %t))
    (%49 (getelementptr-i32 %48 1))
    (mem (store-i32 %47 %49 mem)))
  (@cbrt-%50 mem %r %s %sign %t %w %1 %2)))

(defund @cbrt-%31 (mem %r %s %sign %t %w %1 %2)
  (b* (
    (%32 (bitcast-double*-to-i32* %t))
    (%33 (getelementptr-i32 %32 1))
    (mem (store-i32 1129316352 %33 mem))
    (%34 (load-double %2 mem))
    (%35 (load-double %t mem))
    (%36 (fmul-double %35 %34))
    (mem (store-double %36 %t mem))
    (%37 (bitcast-double*-to-i32* %t))
    (%38 (getelementptr-i32 %37 1))
    (%39 (load-i32 %38 mem))
    (%40 (sdiv-i32 %39 3))
    (%41 (add-i32 %40 696219795))
    (%42 (bitcast-double*-to-i32* %t))
    (%43 (getelementptr-i32 %42 1))
    (mem (store-i32 %41 %43 mem)))
  (@cbrt-%50 mem %r %s %sign %t %w %1 %2)))

(defund @cbrt-%25 (mem %hx %r %s %sign %t %w %1 %2)
  (b* (
    (%26 (load-i32 %hx mem))
    (%27 (bitcast-double*-to-i32* %2))
    (%28 (getelementptr-i32 %27 1))
    (mem (store-i32 %26 %28 mem))
    (%29 (load-i32 %hx mem))
    (%30 (icmp-slt-i32 %29 1048576)))
  (case %30
    (0  (@cbrt-%31 mem %r %s %sign %t %w %1 %2))
    (-1 (@cbrt-%44 mem %hx %r %s %sign %t %w %1 %2)))))

(defund @cbrt-%23 (mem %1 %2)
  (b* (
    (%24 (load-double %2 mem))
    (mem (store-double %24 %1 mem)))
  (@cbrt-%101 mem %1)))

(defund @cbrt-%17 (mem %hx %r %s %sign %t %w %1 %2)
  (b* (
    (%18 (load-i32 %hx mem))
    (%19 (bitcast-double*-to-i32* %2))
    (%20 (load-i32 %19 mem))
    (%21 (or-i32 %18 %20))
    (%22 (icmp-eq-i32 %21 0)))
  (case %22
    (0  (@cbrt-%23 mem %1 %2))
    (-1 (@cbrt-%25 mem %hx %r %s %sign %t %w %1 %2)))))

(defund @cbrt-%13 (mem %1 %2)
  (b* (
    (%14 (load-double %2 mem))
    (%15 (load-double %2 mem))
    (%16 (fadd-double %14 %15))
    (mem (store-double %16 %1 mem)))
  (@cbrt-%101 mem %1)))

(defund @cbrt-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (%1 '(ret . 0))
    (mem (alloca-double 'x 1 mem))
    (%2 '(x . 0))
    (mem (alloca-i32 'hx 1 mem))
    (%hx '(hx . 0))
    (mem (alloca-double 'r 1 mem))
    (%r '(r . 0))
    (mem (alloca-double 's 1 mem))
    (%s '(s . 0))
    (mem (alloca-double 't 1 mem))
    (%t '(t . 0))
    (mem (alloca-double 'w 1 mem))
    (%w '(w . 0))
    (mem (alloca-i32 'sign 1 mem))
    (%sign '(sign . 0))
    (mem (store-double %x %2 mem))
    (mem (store-double #x0000000000000000 %t mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %hx mem))
    (%6 (load-i32 %hx mem))
    (%7 (and-i32 %6 -2147483648))
    (mem (store-i32 %7 %sign mem))
    (%8 (load-i32 %sign mem))
    (%9 (load-i32 %hx mem))
    (%10 (xor-i32 %9 %8))
    (mem (store-i32 %10 %hx mem))
    (%11 (load-i32 %hx mem))
    (%12 (icmp-sge-i32 %11 2146435072)))
  (case %12
    (0  (@cbrt-%13 mem %1 %2))
    (-1 (@cbrt-%17 mem %hx %r %s %sign %t %w %1 %2)))))

(defund @cbrt (%x)
  (@cbrt-%0 () %x))
