(in-package "ACL2")
(include-book "../llvm")

(defconst *__ieee754_exp-globals* '(
  (ln2HI #xfee00000 #x3fe62e42 #xfee00000 #xbfe62e42)
  (ln2LO #x35793c76 #x3dea39ef #x35793c76 #xbdea39ef)
  (halF #x00000000 #x3fe00000 #x00000000 #xbfe00000)))

(defund @__ieee754_exp-%166 (mem %1)
  (b* (
    (%167 (load-double %1 mem)))
  %167))

(defund @__ieee754_exp-%156 (mem %k %y %1)
  (b* (
    (%157 (load-i32 %k mem))
    (%158 (add-i32 %157 1000))
    (%159 (shl-i32 %158 20))
    (%160 (bitcast-double*-to-i32* %y))
    (%161 (getelementptr-i32 %160 1))
    (%162 (load-i32 %161 mem))
    (%163 (add-i32 %162 %159))
    (mem (store-i32 %163 %161 mem))
    (%164 (load-double %y mem))
    (%165 (fmul-double %164 #x170000000000000))
    (mem (store-double %165 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%148 (mem %k %y %1)
  (b* (
    (%149 (load-i32 %k mem))
    (%150 (shl-i32 %149 20))
    (%151 (bitcast-double*-to-i32* %y))
    (%152 (getelementptr-i32 %151 1))
    (%153 (load-i32 %152 mem))
    (%154 (add-i32 %153 %150))
    (mem (store-i32 %154 %152 mem))
    (%155 (load-double %y mem))
    (mem (store-double %155 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%145 (mem %k %y %1)
  (b* (
    (%146 (load-i32 %k mem))
    (%147 (icmp-sge-i32 %146 -1021)))
  (case %147
    (-1 (@__ieee754_exp-%148 mem %k %y %1))
    (0 (@__ieee754_exp-%156 mem %k %y %1)))))

(defund @__ieee754_exp-%133 (mem %c %hi %k %lo %y %1 %2)
  (b* (
    (%134 (load-double %lo mem))
    (%135 (load-double %2 mem))
    (%136 (load-double %c mem))
    (%137 (fmul-double %135 %136))
    (%138 (load-double %c mem))
    (%139 (fsub-double #x4000000000000000 %138))
    (%140 (fdiv-double %137 %139))
    (%141 (fsub-double %134 %140))
    (%142 (load-double %hi mem))
    (%143 (fsub-double %141 %142))
    (%144 (fsub-double #x3ff0000000000000 %143))
    (mem (store-double %144 %y mem)))
  (@__ieee754_exp-%145 mem %k %y %1)))

(defund @__ieee754_exp-%123 (mem %c %1 %2)
  (b* (
    (%124 (load-double %2 mem))
    (%125 (load-double %c mem))
    (%126 (fmul-double %124 %125))
    (%127 (load-double %c mem))
    (%128 (fsub-double %127 #x4000000000000000))
    (%129 (fdiv-double %126 %128))
    (%130 (load-double %2 mem))
    (%131 (fsub-double %129 %130))
    (%132 (fsub-double #x3ff0000000000000 %131))
    (mem (store-double %132 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%101 (mem %c %hi %k %lo %t %y %1 %2)
  (b* (
    (%102 (load-double %2 mem))
    (%103 (load-double %2 mem))
    (%104 (fmul-double %102 %103))
    (mem (store-double %104 %t mem))
    (%105 (load-double %2 mem))
    (%106 (load-double %t mem))
    (%107 (load-double %t mem))
    (%108 (load-double %t mem))
    (%109 (load-double %t mem))
    (%110 (load-double %t mem))
    (%111 (fmul-double %110 #x3E66376972BEA4D0))
    (%112 (fadd-double #xBEBBBD41C5D26BF1 %111))
    (%113 (fmul-double %109 %112))
    (%114 (fadd-double #x3F11566AAF25DE2C %113))
    (%115 (fmul-double %108 %114))
    (%116 (fadd-double #xBF66C16C16BEBD93 %115))
    (%117 (fmul-double %107 %116))
    (%118 (fadd-double #x3FC555555555553E %117))
    (%119 (fmul-double %106 %118))
    (%120 (fsub-double %105 %119))
    (mem (store-double %120 %c mem))
    (%121 (load-i32 %k mem))
    (%122 (icmp-eq-i32 %121 0)))
  (case %122
    (-1 (@__ieee754_exp-%123 mem %c %1 %2))
    (0 (@__ieee754_exp-%133 mem %c %hi %k %lo %y %1 %2)))))

(defund @__ieee754_exp-%100 (mem %c %hi %k %lo %t %y %1 %2)
  (b* ()
  (@__ieee754_exp-%101 mem %c %hi %k %lo %t %y %1 %2)))

(defund @__ieee754_exp-%99 (mem %c %hi %k %lo %t %y %1 %2)
  (b* (
    (mem (store-i32 0 %k mem)))
  (@__ieee754_exp-%100 mem %c %hi %k %lo %t %y %1 %2)))

(defund @__ieee754_exp-%98 (mem %c %hi %k %lo %t %y %1 %2)
  (b* ()
  (@__ieee754_exp-%100 mem %c %hi %k %lo %t %y %1 %2)))

(defund @__ieee754_exp-%95 (mem %1 %2)
  (b* (
    (%96 (load-double %2 mem))
    (%97 (fadd-double #x3ff0000000000000 %96))
    (mem (store-double %97 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%91 (mem %c %hi %k %lo %t %y %1 %2)
  (b* (
    (%92 (load-double %2 mem))
    (%93 (fadd-double #x7e37e43c8800759c %92))
    (%94 (fcmp-ogt-double %93 #x3ff0000000000000)))
  (case %94
    (-1 (@__ieee754_exp-%95 mem %1 %2))
    (0 (@__ieee754_exp-%98 mem %c %hi %k %lo %t %y %1 %2)))))

(defund @__ieee754_exp-%88 (mem %c %hi %hx %k %lo %t %y %1 %2)
  (b* (
    (%89 (load-i32 %hx mem))
    (%90 (icmp-ult-i32 %89 1043333120)))
  (case %90
    (-1 (@__ieee754_exp-%91 mem %c %hi %k %lo %t %y %1 %2))
    (0 (@__ieee754_exp-%99 mem %c %hi %k %lo %t %y %1 %2)))))

(defund @__ieee754_exp-%84 (mem %c %hi %k %lo %t %y %1 %2)
  (b* (
    (%85 (load-double %hi mem))
    (%86 (load-double %lo mem))
    (%87 (fsub-double %85 %86))
    (mem (store-double %87 %2 mem)))
  (@__ieee754_exp-%101 mem %c %hi %k %lo %t %y %1 %2)))

(defund @__ieee754_exp-%65 (mem %c %hi %k %lo %t %xsb %y %1 %2)
  (b* (
    (%66 (load-double %2 mem))
    (%67 (fmul-double #x3FF71547652B82FE %66))
    (%68 (load-i32 %xsb mem))
    (%69 (sext-i32-to-i64 %68))
    (%70 (getelementptr-double '(halF . 0) %69))
    (%71 (load-double %70 mem))
    (%72 (fadd-double %67 %71))
    (%73 (fptosi-double-to-i32 %72))
    (mem (store-i32 %73 %k mem))
    (%74 (load-i32 %k mem))
    (%75 (sitofp-i32-to-double %74))
    (mem (store-double %75 %t mem))
    (%76 (load-double %2 mem))
    (%77 (load-double %t mem))
    (%78 (load-double (getelementptr-double '(ln2HI . 0) 0) mem))
    (%79 (fmul-double %77 %78))
    (%80 (fsub-double %76 %79))
    (mem (store-double %80 %hi mem))
    (%81 (load-double %t mem))
    (%82 (load-double (getelementptr-double '(ln2LO . 0) 0) mem))
    (%83 (fmul-double %81 %82))
    (mem (store-double %83 %lo mem)))
  (@__ieee754_exp-%84 mem %c %hi %k %lo %t %y %1 %2)))

(defund @__ieee754_exp-%50 (mem %c %hi %k %lo %t %xsb %y %1 %2)
  (b* (
    (%51 (load-double %2 mem))
    (%52 (load-i32 %xsb mem))
    (%53 (sext-i32-to-i64 %52))
    (%54 (getelementptr-double '(ln2HI . 0) %53))
    (%55 (load-double %54 mem))
    (%56 (fsub-double %51 %55))
    (mem (store-double %56 %hi mem))
    (%57 (load-i32 %xsb mem))
    (%58 (sext-i32-to-i64 %57))
    (%59 (getelementptr-double '(ln2LO . 0) %58))
    (%60 (load-double %59 mem))
    (mem (store-double %60 %lo mem))
    (%61 (load-i32 %xsb mem))
    (%62 (sub-i32 1 %61))
    (%63 (load-i32 %xsb mem))
    (%64 (sub-i32 %62 %63))
    (mem (store-i32 %64 %k mem)))
  (@__ieee754_exp-%84 mem %c %hi %k %lo %t %y %1 %2)))

(defund @__ieee754_exp-%47 (mem %c %hi %hx %k %lo %t %xsb %y %1 %2)
  (b* (
    (%48 (load-i32 %hx mem))
    (%49 (icmp-ult-i32 %48 1072734898)))
  (case %49
    (-1 (@__ieee754_exp-%50 mem %c %hi %k %lo %t %xsb %y %1 %2))
    (0 (@__ieee754_exp-%65 mem %c %hi %k %lo %t %xsb %y %1 %2)))))

(defund @__ieee754_exp-%44 (mem %c %hi %hx %k %lo %t %xsb %y %1 %2)
  (b* (
    (%45 (load-i32 %hx mem))
    (%46 (icmp-ugt-i32 %45 1071001154)))
  (case %46
    (-1 (@__ieee754_exp-%47 mem %c %hi %hx %k %lo %t %xsb %y %1 %2))
    (0 (@__ieee754_exp-%88 mem %c %hi %hx %k %lo %t %y %1 %2)))))

(defund @__ieee754_exp-%43 (mem %c %hi %hx %k %lo %t %xsb %y %1 %2)
  (b* ()
  (@__ieee754_exp-%44 mem %c %hi %hx %k %lo %t %xsb %y %1 %2)))

(defund @__ieee754_exp-%42 (mem %1)
  (b* (
    (mem (store-double #x0000000000000000 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%39 (mem %c %hi %hx %k %lo %t %xsb %y %1 %2)
  (b* (
    (%40 (load-double %2 mem))
    (%41 (fcmp-olt-double %40 #xC0874910D52D3051)))
  (case %41
    (-1 (@__ieee754_exp-%42 mem %1))
    (0 (@__ieee754_exp-%43 mem %c %hi %hx %k %lo %t %xsb %y %1 %2)))))

(defund @__ieee754_exp-%38 (mem %1)
  (b* (
    (mem (store-double #x7FF0000000000000 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%35 (mem %c %hi %hx %k %lo %t %xsb %y %1 %2)
  (b* (
    (%36 (load-double %2 mem))
    (%37 (fcmp-ogt-double %36 #x40862E42FEFA39EF)))
  (case %37
    (-1 (@__ieee754_exp-%38 mem %1))
    (0 (@__ieee754_exp-%39 mem %c %hi %hx %k %lo %t %xsb %y %1 %2)))))

(defund @__ieee754_exp-%33 (mem %1 %34)
  (b* (
    ; %34 = phi double [ %31, %30 ], [ #x0000000000000000, %32 ]
    (mem (store-double %34 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%32 (mem %1)
  (b* ()
  (@__ieee754_exp-%33 mem %1 #x0000000000000000)))

(defund @__ieee754_exp-%30 (mem %1 %2)
  (b* (
    (%31 (load-double %2 mem)))
  (@__ieee754_exp-%33 mem %1 %31)))

(defund @__ieee754_exp-%27 (mem %xsb %1 %2)
  (b* (
    (%28 (load-i32 %xsb mem))
    (%29 (icmp-eq-i32 %28 0)))
  (case %29
    (-1 (@__ieee754_exp-%30 mem %1 %2))
    (0 (@__ieee754_exp-%32 mem %1)))))

(defund @__ieee754_exp-%23 (mem %1 %2)
  (b* (
    (%24 (load-double %2 mem))
    (%25 (load-double %2 mem))
    (%26 (fadd-double %24 %25))
    (mem (store-double %26 %1 mem)))
  (@__ieee754_exp-%166 mem %1)))

(defund @__ieee754_exp-%16 (mem %hx %xsb %1 %2)
  (b* (
    (%17 (load-i32 %hx mem))
    (%18 (and-i32 %17 1048575))
    (%19 (bitcast-double*-to-i32* %2))
    (%20 (load-i32 %19 mem))
    (%21 (or-i32 %18 %20))
    (%22 (icmp-ne-i32 %21 0)))
  (case %22
    (-1 (@__ieee754_exp-%23 mem %1 %2))
    (0 (@__ieee754_exp-%27 mem %xsb %1 %2)))))

(defund @__ieee754_exp-%13 (mem %c %hi %hx %k %lo %t %xsb %y %1 %2)
  (b* (
    (%14 (load-i32 %hx mem))
    (%15 (icmp-uge-i32 %14 2146435072)))
  (case %15
    (-1 (@__ieee754_exp-%16 mem %hx %xsb %1 %2))
    (0 (@__ieee754_exp-%35 mem %c %hi %hx %k %lo %t %xsb %y %1 %2)))))

(defund @__ieee754_exp-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %y mem) (alloca-double 'y 1 mem))
    ((mv %hi mem) (alloca-double 'hi 1 mem))
    ((mv %lo mem) (alloca-double 'lo 1 mem))
    ((mv %c mem) (alloca-double 'c 1 mem))
    ((mv %t mem) (alloca-double 't 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %xsb mem) (alloca-i32 'xsb 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    (mem (store-double %x %2 mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %hx mem))
    (%6 (load-i32 %hx mem))
    (%7 (lshr-i32 %6 31))
    (%8 (and-i32 %7 1))
    (mem (store-i32 %8 %xsb mem))
    (%9 (load-i32 %hx mem))
    (%10 (and-i32 %9 2147483647))
    (mem (store-i32 %10 %hx mem))
    (%11 (load-i32 %hx mem))
    (%12 (icmp-uge-i32 %11 1082535490)))
  (case %12
    (-1 (@__ieee754_exp-%13 mem %c %hi %hx %k %lo %t %xsb %y %1 %2))
    (0 (@__ieee754_exp-%44 mem %c %hi %hx %k %lo %t %xsb %y %1 %2)))))

(defund @__ieee754_exp (%x)
  (@__ieee754_exp-%0 *__ieee754_exp-globals* %x))
