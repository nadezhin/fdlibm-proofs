(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")
(include-book "s_atan")

(defconst *__ieee754_atan2-globals* '())

(defund @__ieee754_atan2-%144 (mem %1)
  (b* (
    (%145 (load-double %1 mem)))
  %145))

(defund @__ieee754_atan2-%140 (mem %z %1)
  (b* (
    (%141 (load-double %z mem))
    (%142 (fsub-double %141 #x3CA1A62633145C07))
    (%143 (fsub-double %142 #x400921FB54442D18))
    (mem (store-double %143 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%136 (mem %z %1)
  (b* (
    (%137 (load-double %z mem))
    (%138 (fsub-double %137 #x3CA1A62633145C07))
    (%139 (fsub-double #x400921FB54442D18 %138))
    (mem (store-double %139 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%130 (mem %z %1)
  (b* (
    (%131 (bitcast-double*-to-i32* %z))
    (%132 (getelementptr-i32 %131 1))
    (%133 (load-i32 %132 mem))
    (%134 (xor-i32 %133 -2147483648))
    (mem (store-i32 %134 %132 mem))
    (%135 (load-double %z mem))
    (mem (store-double %135 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%128 (mem %z %1)
  (b* (
    (%129 (load-double %z mem))
    (mem (store-double %129 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%126 (mem %m %z %1)
  (b* (
    (%127 (load-i32 %m mem)))
  (case %127
    (0 (@__ieee754_atan2-%128 mem %z %1))
    (1 (@__ieee754_atan2-%130 mem %z %1))
    (2 (@__ieee754_atan2-%136 mem %z %1))
    (otherwise  (@__ieee754_atan2-%140 mem %z %1)))))

(defund @__ieee754_atan2-%125 (mem %m %z %1)
  (b* ()
  (@__ieee754_atan2-%126 mem %m %z %1)))

(defund @__ieee754_atan2-%119 (mem %m %z %1 %2 %3)
  (b* (
    (%120 (load-double %2 mem))
    (%121 (load-double %3 mem))
    (%122 (fdiv-double %120 %121))
    (%123 (@fabs %122))
    (%124 (@atan %123))
    (mem (store-double %124 %z mem)))
  (@__ieee754_atan2-%125 mem %m %z %1)))

(defund @__ieee754_atan2-%118 (mem %m %z %1)
  (b* (
    (mem (store-double #x0000000000000000 %z mem)))
  (@__ieee754_atan2-%125 mem %m %z %1)))

(defund @__ieee754_atan2-%115 (mem %k %m %z %1 %2 %3)
  (b* (
    (%116 (load-i32 %k mem))
    (%117 (icmp-slt-i32 %116 -60)))
  (case %117
    (-1  (@__ieee754_atan2-%118 mem %m %z %1))
    (0 (@__ieee754_atan2-%119 mem %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%112 (mem %hx %k %m %z %1 %2 %3)
  (b* (
    (%113 (load-i32 %hx mem))
    (%114 (icmp-slt-i32 %113 0)))
  (case %114
    (-1  (@__ieee754_atan2-%115 mem %k %m %z %1 %2 %3))
    (0 (@__ieee754_atan2-%119 mem %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%111 (mem %m %z %1)
  (b* (
    (mem (store-double #x3FF921FB54442D18 %z mem)))
  (@__ieee754_atan2-%126 mem %m %z %1)))

(defund @__ieee754_atan2-%104 (mem %hx %ix %iy %k %m %z %1 %2 %3)
  (b* (
    (%105 (load-i32 %iy mem))
    (%106 (load-i32 %ix mem))
    (%107 (sub-i32 %105 %106))
    (%108 (ashr-i32 %107 20))
    (mem (store-i32 %108 %k mem))
    (%109 (load-i32 %k mem))
    (%110 (icmp-sgt-i32 %109 60)))
  (case %110
    (-1  (@__ieee754_atan2-%111 mem %m %z %1))
    (0 (@__ieee754_atan2-%112 mem %hx %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%100 (mem %hy %1)
  (b* (
    (%101 (load-i32 %hy mem))
    (%102 (icmp-slt-i32 %101 0))
    (%103 (select-double %102 #xBFF921FB54442D18 #x3FF921FB54442D18))
    (mem (store-double %103 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%97 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* (
    (%98 (load-i32 %iy mem))
    (%99 (icmp-eq-i32 %98 2146435072)))
  (case %99
    (-1  (@__ieee754_atan2-%100 mem %hy %1))
    (0 (@__ieee754_atan2-%104 mem %hx %ix %iy %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%96 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* ()
  (@__ieee754_atan2-%97 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))

(defund @__ieee754_atan2-%95 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* ()
  (@__ieee754_atan2-%96 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))

(defund @__ieee754_atan2-%94 (mem %1)
  (b* (
    (mem (store-double #xC00921FB54442D18 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%93 (mem %1)
  (b* (
    (mem (store-double #x400921FB54442D18 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%92 (mem %1)
  (b* (
    (mem (store-double #x8000000000000000 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%91 (mem %1)
  (b* (
    (mem (store-double #x0000000000000000 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%89 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* (
    (%90 (load-i32 %m mem)))
  (case %90
    (0 (@__ieee754_atan2-%91 mem %1))
    (1 (@__ieee754_atan2-%92 mem %1))
    (2 (@__ieee754_atan2-%93 mem %1))
    (3 (@__ieee754_atan2-%94 mem %1))
    (otherwise  (@__ieee754_atan2-%95 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%88 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* ()
  (@__ieee754_atan2-%96 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))

(defund @__ieee754_atan2-%87 (mem %1)
  (b* (
    (mem (store-double #xC002D97C7F3321D2 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%86 (mem %1)
  (b* (
    (mem (store-double #x4002D97C7F3321D2 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%85 (mem %1)
  (b* (
    (mem (store-double #xBFE921FB54442D18 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%84 (mem %1)
  (b* (
    (mem (store-double #x3FE921FB54442D18 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%82 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* (
    (%83 (load-i32 %m mem)))
  (case %83
    (0 (@__ieee754_atan2-%84 mem %1))
    (1 (@__ieee754_atan2-%85 mem %1))
    (2 (@__ieee754_atan2-%86 mem %1))
    (3 (@__ieee754_atan2-%87 mem %1))
    (otherwise  (@__ieee754_atan2-%88 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%79 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* (
    (%80 (load-i32 %iy mem))
    (%81 (icmp-eq-i32 %80 2146435072)))
  (case %81
    (-1  (@__ieee754_atan2-%82 mem %hx %hy %ix %iy %k %m %z %1 %2 %3))
    (0 (@__ieee754_atan2-%89 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%76 (mem %hx %hy %ix %iy %k %m %z %1 %2 %3)
  (b* (
    (%77 (load-i32 %ix mem))
    (%78 (icmp-eq-i32 %77 2146435072)))
  (case %78
    (-1  (@__ieee754_atan2-%79 mem %hx %hy %ix %iy %k %m %z %1 %2 %3))
    (0 (@__ieee754_atan2-%97 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%72 (mem %hy %1)
  (b* (
    (%73 (load-i32 %hy mem))
    (%74 (icmp-slt-i32 %73 0))
    (%75 (select-double %74 #xBFF921FB54442D18 #x3FF921FB54442D18))
    (mem (store-double %75 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%67 (mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3)
  (b* (
    (%68 (load-i32 %ix mem))
    (%69 (load-i32 %lx mem))
    (%70 (or-i32 %68 %69))
    (%71 (icmp-eq-i32 %70 0)))
  (case %71
    (-1  (@__ieee754_atan2-%72 mem %hy %1))
    (0 (@__ieee754_atan2-%76 mem %hx %hy %ix %iy %k %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%66 (mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3)
  (b* ()
  (@__ieee754_atan2-%67 mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3)))

(defund @__ieee754_atan2-%65 (mem %1)
  (b* (
    (mem (store-double #xC00921FB54442D18 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%64 (mem %1)
  (b* (
    (mem (store-double #x400921FB54442D18 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%62 (mem %1 %2)
  (b* (
    (%63 (load-double %2 mem))
    (mem (store-double %63 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%60 (mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3)
  (b* (
    (%61 (load-i32 %m mem)))
  (case %61
    (0 (@__ieee754_atan2-%62 mem %1 %2))
    (1 (@__ieee754_atan2-%62 mem %1 %2))
    (2 (@__ieee754_atan2-%64 mem %1))
    (3 (@__ieee754_atan2-%65 mem %1))
    (otherwise  (@__ieee754_atan2-%66 mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%48 (mem %hx %hy %ix %iy %k %lx %ly %m %z %1 %2 %3)
  (b* (
    (%49 (load-i32 %hy mem))
    (%50 (ashr-i32 %49 31))
    (%51 (and-i32 %50 1))
    (%52 (load-i32 %hx mem))
    (%53 (ashr-i32 %52 30))
    (%54 (and-i32 %53 2))
    (%55 (or-i32 %51 %54))
    (mem (store-i32 %55 %m mem))
    (%56 (load-i32 %iy mem))
    (%57 (load-i32 %ly mem))
    (%58 (or-i32 %56 %57))
    (%59 (icmp-eq-i32 %58 0)))
  (case %59
    (-1  (@__ieee754_atan2-%60 mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3))
    (0 (@__ieee754_atan2-%67 mem %hx %hy %ix %iy %k %lx %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%45 (mem %1 %2)
  (b* (
    (%46 (load-double %2 mem))
    (%47 (@atan %46))
    (mem (store-double %47 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%39 (mem %hx %hy %ix %iy %k %lx %ly %m %z %1 %2 %3)
  (b* (
    (%40 (load-i32 %hx mem))
    (%41 (sub-i32 %40 1072693248))
    (%42 (load-i32 %lx mem))
    (%43 (or-i32 %41 %42))
    (%44 (icmp-eq-i32 %43 0)))
  (case %44
    (-1  (@__ieee754_atan2-%45 mem %1 %2))
    (0 (@__ieee754_atan2-%48 mem %hx %hy %ix %iy %k %lx %ly %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%35 (mem %1 %2 %3)
  (b* (
    (%36 (load-double %3 mem))
    (%37 (load-double %2 mem))
    (%38 (fadd-double %36 %37))
    (mem (store-double %38 %1 mem)))
  (@__ieee754_atan2-%144 mem %1)))

(defund @__ieee754_atan2-%26 (mem %hx %hy %ix %iy %k %lx %ly %m %z %1 %2 %3)
  (b* (
    (%27 (load-i32 %iy mem))
    (%28 (load-i32 %ly mem))
    (%29 (load-i32 %ly mem))
    (%30 (sub-i32 0 %29))
    (%31 (or-i32 %28 %30))
    (%32 (lshr-i32 %31 31))
    (%33 (or-i32 %27 %32))
    (%34 (icmp-ugt-i32 %33 2146435072)))
  (case %34
    (-1  (@__ieee754_atan2-%35 mem %1 %2 %3))
    (0 (@__ieee754_atan2-%39 mem %hx %hy %ix %iy %k %lx %ly %m %z %1 %2 %3)))))

(defund @__ieee754_atan2-%0 (mem %y %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'y 1 mem))
    ((mv %3 mem) (alloca-double 'x 1 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %m mem) (alloca-i32 'm 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    ((mv %hy mem) (alloca-i32 'hy 1 mem))
    ((mv %ix mem) (alloca-i32 'ix 1 mem))
    ((mv %iy mem) (alloca-i32 'iy 1 mem))
    ((mv %lx mem) (alloca-i32 'lx 1 mem))
    ((mv %ly mem) (alloca-i32 'ly 1 mem))
    (mem (store-double %y %2 mem))
    (mem (store-double %x %3 mem))
    (%4 (bitcast-double*-to-i32* %3))
    (%5 (getelementptr-i32 %4 1))
    (%6 (load-i32 %5 mem))
    (mem (store-i32 %6 %hx mem))
    (%7 (load-i32 %hx mem))
    (%8 (and-i32 %7 2147483647))
    (mem (store-i32 %8 %ix mem))
    (%9 (bitcast-double*-to-i32* %3))
    (%10 (load-i32 %9 mem))
    (mem (store-i32 %10 %lx mem))
    (%11 (bitcast-double*-to-i32* %2))
    (%12 (getelementptr-i32 %11 1))
    (%13 (load-i32 %12 mem))
    (mem (store-i32 %13 %hy mem))
    (%14 (load-i32 %hy mem))
    (%15 (and-i32 %14 2147483647))
    (mem (store-i32 %15 %iy mem))
    (%16 (bitcast-double*-to-i32* %2))
    (%17 (load-i32 %16 mem))
    (mem (store-i32 %17 %ly mem))
    (%18 (load-i32 %ix mem))
    (%19 (load-i32 %lx mem))
    (%20 (load-i32 %lx mem))
    (%21 (sub-i32 0 %20))
    (%22 (or-i32 %19 %21))
    (%23 (lshr-i32 %22 31))
    (%24 (or-i32 %18 %23))
    (%25 (icmp-ugt-i32 %24 2146435072)))
  (case %25
    (-1  (@__ieee754_atan2-%35 mem %1 %2 %3))
    (0 (@__ieee754_atan2-%26 mem %hx %hy %ix %iy %k %lx %ly %m %z %1 %2 %3)))))

(defund @__ieee754_atan2 (%y %x)
  (@__ieee754_atan2-%0 *__ieee754_atan2-globals* %y %x))
