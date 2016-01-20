(in-package "ACL2")
(include-book "../llvm")

(defconst *__ieee754_exp-globals* '(
  (ln2HI #xfee00000 #x3fe62e42 #xfee00000 #xbfe62e42)
  (ln2LO #x35793c76 #x3dea39ef #x35793c76 #xbdea39ef)
  (halF #x00000000 #x3fe00000 #x00000000 #xbfe00000)))

(defund @__ieee754_exp-%166 (mem)
  (b* (
    (%167 (load-double '(ret . 0) mem)))
  %167))

(defund @__ieee754_exp-%156 (mem)
  (b* (
    (%157 (load-i32 '(k . 0) mem))
    (%158 (add-i32 %157 1000))
    (%159 (shl-i32 %158 20))
    (%160 (bitcast-double*-to-i32* '(y . 0)))
    (%161 (getelementptr-i32 %160 1))
    (%162 (load-i32 %161 mem))
    (%163 (add-i32 %162 %159))
    (mem (store-i32 %163 %161 mem))
    (%164 (load-double '(y . 0) mem))
    (%165 (fmul-double %164 #x170000000000000))
    (mem (store-double %165 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%148 (mem)
  (b* (
    (%149 (load-i32 '(k . 0) mem))
    (%150 (shl-i32 %149 20))
    (%151 (bitcast-double*-to-i32* '(y . 0)))
    (%152 (getelementptr-i32 %151 1))
    (%153 (load-i32 %152 mem))
    (%154 (add-i32 %153 %150))
    (mem (store-i32 %154 %152 mem))
    (%155 (load-double '(y . 0) mem))
    (mem (store-double %155 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%145 (mem)
  (b* (
    (%146 (load-i32 '(k . 0) mem))
    (%147 (icmp-sge-i32 %146 -1021)))
  (case %147
    (-1 (@__ieee754_exp-%148 mem))
    (0 (@__ieee754_exp-%156 mem)))))

(defund @__ieee754_exp-%133 (mem)
  (b* (
    (%134 (load-double '(lo . 0) mem))
    (%135 (load-double '(x . 0) mem))
    (%136 (load-double '(c . 0) mem))
    (%137 (fmul-double %135 %136))
    (%138 (load-double '(c . 0) mem))
    (%139 (fsub-double #x4000000000000000 %138))
    (%140 (fdiv-double %137 %139))
    (%141 (fsub-double %134 %140))
    (%142 (load-double '(hi . 0) mem))
    (%143 (fsub-double %141 %142))
    (%144 (fsub-double #x3ff0000000000000 %143))
    (mem (store-double %144 '(y . 0) mem)))
  (@__ieee754_exp-%145 mem)))

(defund @__ieee754_exp-%123 (mem)
  (b* (
    (%124 (load-double '(x . 0) mem))
    (%125 (load-double '(c . 0) mem))
    (%126 (fmul-double %124 %125))
    (%127 (load-double '(c . 0) mem))
    (%128 (fsub-double %127 #x4000000000000000))
    (%129 (fdiv-double %126 %128))
    (%130 (load-double '(x . 0) mem))
    (%131 (fsub-double %129 %130))
    (%132 (fsub-double #x3ff0000000000000 %131))
    (mem (store-double %132 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%101 (mem)
  (b* (
    (%102 (load-double '(x . 0) mem))
    (%103 (load-double '(x . 0) mem))
    (%104 (fmul-double %102 %103))
    (mem (store-double %104 '(t . 0) mem))
    (%105 (load-double '(x . 0) mem))
    (%106 (load-double '(t . 0) mem))
    (%107 (load-double '(t . 0) mem))
    (%108 (load-double '(t . 0) mem))
    (%109 (load-double '(t . 0) mem))
    (%110 (load-double '(t . 0) mem))
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
    (mem (store-double %120 '(c . 0) mem))
    (%121 (load-i32 '(k . 0) mem))
    (%122 (icmp-eq-i32 %121 0)))
  (case %122
    (-1 (@__ieee754_exp-%123 mem))
    (0 (@__ieee754_exp-%133 mem)))))

(defund @__ieee754_exp-%100 (mem)
  (b* ()
  (@__ieee754_exp-%101 mem)))

(defund @__ieee754_exp-%99 (mem)
  (b* (
    (mem (store-i32 0 '(k . 0) mem)))
  (@__ieee754_exp-%100 mem)))

(defund @__ieee754_exp-%98 (mem)
  (b* ()
  (@__ieee754_exp-%100 mem)))

(defund @__ieee754_exp-%95 (mem)
  (b* (
    (%96 (load-double '(x . 0) mem))
    (%97 (fadd-double #x3ff0000000000000 %96))
    (mem (store-double %97 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%91 (mem)
  (b* (
    (%92 (load-double '(x . 0) mem))
    (%93 (fadd-double #x7e37e43c8800759c %92))
    (%94 (fcmp-ogt-double %93 #x3ff0000000000000)))
  (case %94
    (-1 (@__ieee754_exp-%95 mem))
    (0 (@__ieee754_exp-%98 mem)))))

(defund @__ieee754_exp-%88 (mem)
  (b* (
    (%89 (load-i32 '(hx . 0) mem))
    (%90 (icmp-ult-i32 %89 1043333120)))
  (case %90
    (-1 (@__ieee754_exp-%91 mem))
    (0 (@__ieee754_exp-%99 mem)))))

(defund @__ieee754_exp-%84 (mem)
  (b* (
    (%85 (load-double '(hi . 0) mem))
    (%86 (load-double '(lo . 0) mem))
    (%87 (fsub-double %85 %86))
    (mem (store-double %87 '(x . 0) mem)))
  (@__ieee754_exp-%101 mem)))

(defund @__ieee754_exp-%65 (mem)
  (b* (
    (%66 (load-double '(x . 0) mem))
    (%67 (fmul-double #x3FF71547652B82FE %66))
    (%68 (load-i32 '(xsb . 0) mem))
    (%69 (sext-i32-to-i64 %68))
    (%70 (getelementptr-double '(halF . 0) %69))
    (%71 (load-double %70 mem))
    (%72 (fadd-double %67 %71))
    (%73 (fptosi-double-to-i32 %72))
    (mem (store-i32 %73 '(k . 0) mem))
    (%74 (load-i32 '(k . 0) mem))
    (%75 (sitofp-i32-to-double %74))
    (mem (store-double %75 '(t . 0) mem))
    (%76 (load-double '(x . 0) mem))
    (%77 (load-double '(t . 0) mem))
    (%78 (load-double (getelementptr-double '(ln2HI . 0) 0) mem))
    (%79 (fmul-double %77 %78))
    (%80 (fsub-double %76 %79))
    (mem (store-double %80 '(hi . 0) mem))
    (%81 (load-double '(t . 0) mem))
    (%82 (load-double (getelementptr-double '(ln2LO . 0) 0) mem))
    (%83 (fmul-double %81 %82))
    (mem (store-double %83 '(lo . 0) mem)))
  (@__ieee754_exp-%84 mem)))

(defund @__ieee754_exp-%50 (mem)
  (b* (
    (%51 (load-double '(x . 0) mem))
    (%52 (load-i32 '(xsb . 0) mem))
    (%53 (sext-i32-to-i64 %52))
    (%54 (getelementptr-double '(ln2HI . 0) %53))
    (%55 (load-double %54 mem))
    (%56 (fsub-double %51 %55))
    (mem (store-double %56 '(hi . 0) mem))
    (%57 (load-i32 '(xsb . 0) mem))
    (%58 (sext-i32-to-i64 %57))
    (%59 (getelementptr-double '(ln2LO . 0) %58))
    (%60 (load-double %59 mem))
    (mem (store-double %60 '(lo . 0) mem))
    (%61 (load-i32 '(xsb . 0) mem))
    (%62 (sub-i32 1 %61))
    (%63 (load-i32 '(xsb . 0) mem))
    (%64 (sub-i32 %62 %63))
    (mem (store-i32 %64 '(k . 0) mem)))
  (@__ieee754_exp-%84 mem)))

(defund @__ieee754_exp-%47 (mem)
  (b* (
    (%48 (load-i32 '(hx . 0) mem))
    (%49 (icmp-ult-i32 %48 1072734898)))
  (case %49
    (-1 (@__ieee754_exp-%50 mem))
    (0 (@__ieee754_exp-%65 mem)))))

(defund @__ieee754_exp-%44 (mem)
  (b* (
    (%45 (load-i32 '(hx . 0) mem))
    (%46 (icmp-ugt-i32 %45 1071001154)))
  (case %46
    (-1 (@__ieee754_exp-%47 mem))
    (0 (@__ieee754_exp-%88 mem)))))

(defund @__ieee754_exp-%43 (mem)
  (b* ()
  (@__ieee754_exp-%44 mem)))

(defund @__ieee754_exp-%42 (mem)
  (b* (
    (mem (store-double #x0000000000000000 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%39 (mem)
  (b* (
    (%40 (load-double '(x . 0) mem))
    (%41 (fcmp-olt-double %40 #xC0874910D52D3051)))
  (case %41
    (-1 (@__ieee754_exp-%42 mem))
    (0 (@__ieee754_exp-%43 mem)))))

(defund @__ieee754_exp-%38 (mem)
  (b* (
    (mem (store-double #x7FF0000000000000 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%35 (mem)
  (b* (
    (%36 (load-double '(x . 0) mem))
    (%37 (fcmp-ogt-double %36 #x40862E42FEFA39EF)))
  (case %37
    (-1 (@__ieee754_exp-%38 mem))
    (0 (@__ieee754_exp-%39 mem)))))

(defund @__ieee754_exp-%33 (mem %34)
  (b* (
    ; %34 = phi double [ %31, %30 ], [ #x0000000000000000, %32 ]
    (mem (store-double %34 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%32 (mem)
  (b* ()
  (@__ieee754_exp-%33 mem #x0000000000000000)))

(defund @__ieee754_exp-%30 (mem)
  (b* (
    (%31 (load-double '(x . 0) mem)))
  (@__ieee754_exp-%33 mem %31)))

(defund @__ieee754_exp-%27 (mem)
  (b* (
    (%28 (load-i32 '(xsb . 0) mem))
    (%29 (icmp-eq-i32 %28 0)))
  (case %29
    (-1 (@__ieee754_exp-%30 mem))
    (0 (@__ieee754_exp-%32 mem)))))

(defund @__ieee754_exp-%23 (mem)
  (b* (
    (%24 (load-double '(x . 0) mem))
    (%25 (load-double '(x . 0) mem))
    (%26 (fadd-double %24 %25))
    (mem (store-double %26 '(ret . 0) mem)))
  (@__ieee754_exp-%166 mem)))

(defund @__ieee754_exp-%16 (mem)
  (b* (
    (%17 (load-i32 '(hx . 0) mem))
    (%18 (and-i32 %17 1048575))
    (%19 (bitcast-double*-to-i32* '(x . 0)))
    (%20 (load-i32 %19 mem))
    (%21 (or-i32 %18 %20))
    (%22 (icmp-ne-i32 %21 0)))
  (case %22
    (-1 (@__ieee754_exp-%23 mem))
    (0 (@__ieee754_exp-%27 mem)))))

(defund @__ieee754_exp-%13 (mem)
  (b* (
    (%14 (load-i32 '(hx . 0) mem))
    (%15 (icmp-uge-i32 %14 2146435072)))
  (case %15
    (-1 (@__ieee754_exp-%16 mem))
    (0 (@__ieee754_exp-%35 mem)))))

(defund @__ieee754_exp-%0 (mem %x)
  (b* (
    (mem (alloca-double 'ret 1 mem))
    (mem (alloca-double 'x 1 mem))
    (mem (alloca-double 'y 1 mem))
    (mem (alloca-double 'hi 1 mem))
    (mem (alloca-double 'lo 1 mem))
    (mem (alloca-double 'c 1 mem))
    (mem (alloca-double 't 1 mem))
    (mem (alloca-i32 'k 1 mem))
    (mem (alloca-i32 'xsb 1 mem))
    (mem (alloca-i32 'hx 1 mem))
    (mem (store-double %x '(x . 0) mem))
    (%3 (bitcast-double*-to-i32* '(x . 0)))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 '(hx . 0) mem))
    (%6 (load-i32 '(hx . 0) mem))
    (%7 (lshr-i32 %6 31))
    (%8 (and-i32 %7 1))
    (mem (store-i32 %8 '(xsb . 0) mem))
    (%9 (load-i32 '(hx . 0) mem))
    (%10 (and-i32 %9 2147483647))
    (mem (store-i32 %10 '(hx . 0) mem))
    (%11 (load-i32 '(hx . 0) mem))
    (%12 (icmp-uge-i32 %11 1082535490)))
  (case %12
    (-1 (@__ieee754_exp-%13 mem))
    (0 (@__ieee754_exp-%44 mem)))))

(defund @__ieee754_exp (%x)
  (@__ieee754_exp-%0 *__ieee754_exp-globals*  %x))
