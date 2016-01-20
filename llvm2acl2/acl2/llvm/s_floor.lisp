(in-package "ACL2")
(include-book "../llvm")

(defconst *floor-globals* '())

(defund @floor-%129 (mem)
  (b* (
    (%130 (load-double '(ret . 0) mem)))
  %130))

(defund @floor-%122 (mem)
  (b* (
    (%123 (load-i32 '(i0 . 0) mem))
    (%124 (bitcast-double*-to-i32* '(x . 0)))
    (%125 (getelementptr-i32 %124 1))
    (mem (store-i32 %123 %125 mem))
    (%126 (load-i32 '(i1 . 0) mem))
    (%127 (bitcast-double*-to-i32* '(x . 0)))
    (mem (store-i32 %126 %127 mem))
    (%128 (load-double '(x . 0) mem))
    (mem (store-double %128 '(ret . 0) mem)))
  (@floor-%129 mem)))

(defund @floor-%121 (mem)
  (b* ()
  (@floor-%122 mem)))

(defund @floor-%120 (mem)
  (b* ()
  (@floor-%121 mem)))

(defund @floor-%115 (mem)
  (b* (
    (%116 (load-i32 '(i . 0) mem))
    (%117 (xor-i32 %116 -1))
    (%118 (load-i32 '(i1 . 0) mem))
    (%119 (and-i32 %118 %117))
    (mem (store-i32 %119 '(i1 . 0) mem)))
  (@floor-%120 mem)))

(defund @floor-%114 (mem)
  (b* ()
  (@floor-%115 mem)))

(defund @floor-%112 (mem)
  (b* (
    (%113 (load-i32 '(j . 0) mem))
    (mem (store-i32 %113 '(i1 . 0) mem)))
  (@floor-%114 mem)))

(defund @floor-%109 (mem)
  (b* (
    (%110 (load-i32 '(i0 . 0) mem))
    (%111 (add-i32 %110 1))
    (mem (store-i32 %111 '(i0 . 0) mem)))
  (@floor-%112 mem)))

(defund @floor-%100 (mem)
  (b* (
    (%101 (load-i32 '(i1 . 0) mem))
    (%102 (load-i32 '(j0 . 0) mem))
    (%103 (sub-i32 52 %102))
    (%104 (shl-i32 1 %103))
    (%105 (add-i32 %101 %104))
    (mem (store-i32 %105 '(j . 0) mem))
    (%106 (load-i32 '(j . 0) mem))
    (%107 (load-i32 '(i1 . 0) mem))
    (%108 (icmp-ult-i32 %106 %107)))
  (case %108
    (-1 (@floor-%109 mem))
    (0 (@floor-%112 mem)))))

(defund @floor-%97 (mem)
  (b* (
    (%98 (load-i32 '(i0 . 0) mem))
    (%99 (add-i32 %98 1))
    (mem (store-i32 %99 '(i0 . 0) mem)))
  (@floor-%114 mem)))

(defund @floor-%94 (mem)
  (b* (
    (%95 (load-i32 '(j0 . 0) mem))
    (%96 (icmp-eq-i32 %95 20)))
  (case %96
    (-1 (@floor-%97 mem))
    (0 (@floor-%100 mem)))))

(defund @floor-%91 (mem)
  (b* (
    (%92 (load-i32 '(i0 . 0) mem))
    (%93 (icmp-slt-i32 %92 0)))
  (case %93
    (-1 (@floor-%94 mem))
    (0 (@floor-%115 mem)))))

(defund @floor-%87 (mem)
  (b* (
    (%88 (load-double '(x . 0) mem))
    (%89 (fadd-double #x7e37e43c8800759c %88))
    (%90 (fcmp-ogt-double %89 #x0000000000000000)))
  (case %90
    (-1 (@floor-%91 mem))
    (0 (@floor-%120 mem)))))

(defund @floor-%85 (mem)
  (b* (
    (%86 (load-double '(x . 0) mem))
    (mem (store-double %86 '(ret . 0) mem)))
  (@floor-%129 mem)))

(defund @floor-%77 (mem)
  (b* (
    (%78 (load-i32 '(j0 . 0) mem))
    (%79 (sub-i32 %78 20))
    (%80 (lshr-i32 -1 %79))
    (mem (store-i32 %80 '(i . 0) mem))
    (%81 (load-i32 '(i1 . 0) mem))
    (%82 (load-i32 '(i . 0) mem))
    (%83 (and-i32 %81 %82))
    (%84 (icmp-eq-i32 %83 0)))
  (case %84
    (-1 (@floor-%85 mem))
    (0 (@floor-%87 mem)))))

(defund @floor-%75 (mem)
  (b* (
    (%76 (load-double '(x . 0) mem))
    (mem (store-double %76 '(ret . 0) mem)))
  (@floor-%129 mem)))

(defund @floor-%71 (mem)
  (b* (
    (%72 (load-double '(x . 0) mem))
    (%73 (load-double '(x . 0) mem))
    (%74 (fadd-double %72 %73))
    (mem (store-double %74 '(ret . 0) mem)))
  (@floor-%129 mem)))

(defund @floor-%68 (mem)
  (b* (
    (%69 (load-i32 '(j0 . 0) mem))
    (%70 (icmp-eq-i32 %69 1024)))
  (case %70
    (-1 (@floor-%71 mem))
    (0 (@floor-%75 mem)))))

(defund @floor-%65 (mem)
  (b* (
    (%66 (load-i32 '(j0 . 0) mem))
    (%67 (icmp-sgt-i32 %66 51)))
  (case %67
    (-1 (@floor-%68 mem))
    (0 (@floor-%77 mem)))))

(defund @floor-%64 (mem)
  (b* ()
  (@floor-%122 mem)))

(defund @floor-%63 (mem)
  (b* ()
  (@floor-%64 mem)))

(defund @floor-%58 (mem)
  (b* (
    (%59 (load-i32 '(i . 0) mem))
    (%60 (xor-i32 %59 -1))
    (%61 (load-i32 '(i0 . 0) mem))
    (%62 (and-i32 %61 %60))
    (mem (store-i32 %62 '(i0 . 0) mem))
    (mem (store-i32 0 '(i1 . 0) mem)))
  (@floor-%63 mem)))

(defund @floor-%53 (mem)
  (b* (
    (%54 (load-i32 '(j0 . 0) mem))
    (%55 (ashr-i32 1048576 %54))
    (%56 (load-i32 '(i0 . 0) mem))
    (%57 (add-i32 %56 %55))
    (mem (store-i32 %57 '(i0 . 0) mem)))
  (@floor-%58 mem)))

(defund @floor-%50 (mem)
  (b* (
    (%51 (load-i32 '(i0 . 0) mem))
    (%52 (icmp-slt-i32 %51 0)))
  (case %52
    (-1 (@floor-%53 mem))
    (0 (@floor-%58 mem)))))

(defund @floor-%46 (mem)
  (b* (
    (%47 (load-double '(x . 0) mem))
    (%48 (fadd-double #x7e37e43c8800759c %47))
    (%49 (fcmp-ogt-double %48 #x0000000000000000)))
  (case %49
    (-1 (@floor-%50 mem))
    (0 (@floor-%63 mem)))))

(defund @floor-%44 (mem)
  (b* (
    (%45 (load-double '(x . 0) mem))
    (mem (store-double %45 '(ret . 0) mem)))
  (@floor-%129 mem)))

(defund @floor-%35 (mem)
  (b* (
    (%36 (load-i32 '(j0 . 0) mem))
    (%37 (ashr-i32 1048575 %36))
    (mem (store-i32 %37 '(i . 0) mem))
    (%38 (load-i32 '(i0 . 0) mem))
    (%39 (load-i32 '(i . 0) mem))
    (%40 (and-i32 %38 %39))
    (%41 (load-i32 '(i1 . 0) mem))
    (%42 (or-i32 %40 %41))
    (%43 (icmp-eq-i32 %42 0)))
  (case %43
    (-1 (@floor-%44 mem))
    (0 (@floor-%46 mem)))))

(defund @floor-%34 (mem)
  (b* ()
  (@floor-%64 mem)))

(defund @floor-%33 (mem)
  (b* ()
  (@floor-%34 mem)))

(defund @floor-%32 (mem)
  (b* ()
  (@floor-%33 mem)))

(defund @floor-%31 (mem)
  (b* (
    (mem (store-i32 -1074790400 '(i0 . 0) mem))
    (mem (store-i32 0 '(i1 . 0) mem)))
  (@floor-%32 mem)))

(defund @floor-%25 (mem)
  (b* (
    (%26 (load-i32 '(i0 . 0) mem))
    (%27 (and-i32 %26 2147483647))
    (%28 (load-i32 '(i1 . 0) mem))
    (%29 (or-i32 %27 %28))
    (%30 (icmp-ne-i32 %29 0)))
  (case %30
    (-1 (@floor-%31 mem))
    (0 (@floor-%32 mem)))))

(defund @floor-%24 (mem)
  (b* (
    (mem (store-i32 0 '(i1 . 0) mem))
    (mem (store-i32 0 '(i0 . 0) mem)))
  (@floor-%33 mem)))

(defund @floor-%21 (mem)
  (b* (
    (%22 (load-i32 '(i0 . 0) mem))
    (%23 (icmp-sge-i32 %22 0)))
  (case %23
    (-1 (@floor-%24 mem))
    (0 (@floor-%25 mem)))))

(defund @floor-%17 (mem)
  (b* (
    (%18 (load-double '(x . 0) mem))
    (%19 (fadd-double #x7e37e43c8800759c %18))
    (%20 (fcmp-ogt-double %19 #x0000000000000000)))
  (case %20
    (-1 (@floor-%21 mem))
    (0 (@floor-%34 mem)))))

(defund @floor-%14 (mem)
  (b* (
    (%15 (load-i32 '(j0 . 0) mem))
    (%16 (icmp-slt-i32 %15 0)))
  (case %16
    (-1 (@floor-%17 mem))
    (0 (@floor-%35 mem)))))

(defund @floor-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-i32 'i0 1 mem))
    (mem (alloca-i32 'i1 1 mem))
    (mem (alloca-i32 'j0 1 mem))
    (mem (alloca-i32 'i 1 mem))
    (mem (alloca-i32 'j 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (%3 (bitcast-double*-to-i32* '(x . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 '(i0 . 0) mem))
    (%6 (bitcast-double*-to-i32* '(x . 0)))
    (%7 (load-i32 %6 mem))
    (mem (store-i32 %7 '(i1 . 0) mem))
    (%8 (load-i32 '(i0 . 0) mem))
    (%9 (ashr-i32 %8 20))
    (%10 (and-i32 %9 2047))
    (%11 (sub-i32 %10 1023))
    (mem (store-i32 %11 '(j0 . 0) mem))
    (%12 (load-i32 '(j0 . 0) mem))
    (%13 (icmp-slt-i32 %12 20)))
  (case %13
    (-1 (@floor-%14 mem))
    (0 (@floor-%65 mem)))))

(defund @floor (%x)
  (@floor-%0 *floor-globals*  %x))
