(in-package "ACL2")
(include-book "../llvm")

(defconst *__ieee754_log-globals* '(
  (zero #x00000000 #x00000000)))

(defund @__ieee754_log-%215 (mem %1)
  (b* (
    (%216 (load-double %1 mem)))
  %216))

(defund @__ieee754_log-%201 (mem %R %dk %f %s %1)
  (b* (
    (%202 (load-double %dk mem))
    (%203 (fmul-double %202 #x3FE62E42FEE00000))
    (%204 (load-double %s mem))
    (%205 (load-double %f mem))
    (%206 (load-double %R mem))
    (%207 (fsub-double %205 %206))
    (%208 (fmul-double %204 %207))
    (%209 (load-double %dk mem))
    (%210 (fmul-double %209 #x3DEA39EF35793C76))
    (%211 (fsub-double %208 %210))
    (%212 (load-double %f mem))
    (%213 (fsub-double %211 %212))
    (%214 (fsub-double %203 %213))
    (mem (store-double %214 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%193 (mem %R %f %s %1)
  (b* (
    (%194 (load-double %f mem))
    (%195 (load-double %s mem))
    (%196 (load-double %f mem))
    (%197 (load-double %R mem))
    (%198 (fsub-double %196 %197))
    (%199 (fmul-double %195 %198))
    (%200 (fsub-double %194 %199))
    (mem (store-double %200 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%190 (mem %R %dk %f %k %s %1)
  (b* (
    (%191 (load-i32 %k mem))
    (%192 (icmp-eq-i32 %191 0)))
  (case %192
    (-1  (@__ieee754_log-%193 mem %R %f %s %1))
    (0 (@__ieee754_log-%201 mem %R %dk %f %s %1)))))

(defund @__ieee754_log-%174 (mem %R %dk %f %hfsq %s %1)
  (b* (
    (%175 (load-double %dk mem))
    (%176 (fmul-double %175 #x3FE62E42FEE00000))
    (%177 (load-double %hfsq mem))
    (%178 (load-double %s mem))
    (%179 (load-double %hfsq mem))
    (%180 (load-double %R mem))
    (%181 (fadd-double %179 %180))
    (%182 (fmul-double %178 %181))
    (%183 (load-double %dk mem))
    (%184 (fmul-double %183 #x3DEA39EF35793C76))
    (%185 (fadd-double %182 %184))
    (%186 (fsub-double %177 %185))
    (%187 (load-double %f mem))
    (%188 (fsub-double %186 %187))
    (%189 (fsub-double %176 %188))
    (mem (store-double %189 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%164 (mem %R %f %hfsq %s %1)
  (b* (
    (%165 (load-double %f mem))
    (%166 (load-double %hfsq mem))
    (%167 (load-double %s mem))
    (%168 (load-double %hfsq mem))
    (%169 (load-double %R mem))
    (%170 (fadd-double %168 %169))
    (%171 (fmul-double %167 %170))
    (%172 (fsub-double %166 %171))
    (%173 (fsub-double %165 %172))
    (mem (store-double %173 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%157 (mem %R %dk %f %hfsq %k %s %1)
  (b* (
    (%158 (load-double %f mem))
    (%159 (fmul-double #x3fe0000000000000 %158))
    (%160 (load-double %f mem))
    (%161 (fmul-double %159 %160))
    (mem (store-double %161 %hfsq mem))
    (%162 (load-i32 %k mem))
    (%163 (icmp-eq-i32 %162 0)))
  (case %163
    (-1  (@__ieee754_log-%164 mem %R %f %hfsq %s %1))
    (0 (@__ieee754_log-%174 mem %R %dk %f %hfsq %s %1)))))

(defund @__ieee754_log-%113 (mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1)
  (b* (
    (%114 (load-double %f mem))
    (%115 (load-double %f mem))
    (%116 (fadd-double #x4000000000000000 %115))
    (%117 (fdiv-double %114 %116))
    (mem (store-double %117 %s mem))
    (%118 (load-i32 %k mem))
    (%119 (sitofp-i32-to-double %118))
    (mem (store-double %119 %dk mem))
    (%120 (load-double %s mem))
    (%121 (load-double %s mem))
    (%122 (fmul-double %120 %121))
    (mem (store-double %122 %z mem))
    (%123 (load-i32 %hx mem))
    (%124 (sub-i32 %123 398458))
    (mem (store-i32 %124 %i mem))
    (%125 (load-double %z mem))
    (%126 (load-double %z mem))
    (%127 (fmul-double %125 %126))
    (mem (store-double %127 %w mem))
    (%128 (load-i32 %hx mem))
    (%129 (sub-i32 440401 %128))
    (mem (store-i32 %129 %j mem))
    (%130 (load-double %w mem))
    (%131 (load-double %w mem))
    (%132 (load-double %w mem))
    (%133 (fmul-double %132 #x3FC39A09D078C69F))
    (%134 (fadd-double #x3FCC71C51D8E78AF %133))
    (%135 (fmul-double %131 %134))
    (%136 (fadd-double #x3FD999999997FA04 %135))
    (%137 (fmul-double %130 %136))
    (mem (store-double %137 %t1 mem))
    (%138 (load-double %z mem))
    (%139 (load-double %w mem))
    (%140 (load-double %w mem))
    (%141 (load-double %w mem))
    (%142 (fmul-double %141 #x3FC2F112DF3E5244))
    (%143 (fadd-double #x3FC7466496CB03DE %142))
    (%144 (fmul-double %140 %143))
    (%145 (fadd-double #x3FD2492494229359 %144))
    (%146 (fmul-double %139 %145))
    (%147 (fadd-double #x3FE5555555555593 %146))
    (%148 (fmul-double %138 %147))
    (mem (store-double %148 %t2 mem))
    (%149 (load-i32 %j mem))
    (%150 (load-i32 %i mem))
    (%151 (or-i32 %150 %149))
    (mem (store-i32 %151 %i mem))
    (%152 (load-double %t2 mem))
    (%153 (load-double %t1 mem))
    (%154 (fadd-double %152 %153))
    (mem (store-double %154 %R mem))
    (%155 (load-i32 %i mem))
    (%156 (icmp-sgt-i32 %155 0)))
  (case %156
    (-1  (@__ieee754_log-%157 mem %R %dk %f %hfsq %k %s %1))
    (0 (@__ieee754_log-%190 mem %R %dk %f %k %s %1)))))

(defund @__ieee754_log-%101 (mem %R %dk %f %k %1)
  (b* (
    (%102 (load-i32 %k mem))
    (%103 (sitofp-i32-to-double %102))
    (mem (store-double %103 %dk mem))
    (%104 (load-double %dk mem))
    (%105 (fmul-double %104 #x3FE62E42FEE00000))
    (%106 (load-double %R mem))
    (%107 (load-double %dk mem))
    (%108 (fmul-double %107 #x3DEA39EF35793C76))
    (%109 (fsub-double %106 %108))
    (%110 (load-double %f mem))
    (%111 (fsub-double %109 %110))
    (%112 (fsub-double %105 %111))
    (mem (store-double %112 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%97 (mem %R %f %1)
  (b* (
    (%98 (load-double %f mem))
    (%99 (load-double %R mem))
    (%100 (fsub-double %98 %99))
    (mem (store-double %100 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%87 (mem %R %dk %f %k %1)
  (b* (
    (%88 (load-double %f mem))
    (%89 (load-double %f mem))
    (%90 (fmul-double %88 %89))
    (%91 (load-double %f mem))
    (%92 (fmul-double #x3FD5555555555555 %91))
    (%93 (fsub-double #x3fe0000000000000 %92))
    (%94 (fmul-double %90 %93))
    (mem (store-double %94 %R mem))
    (%95 (load-i32 %k mem))
    (%96 (icmp-eq-i32 %95 0)))
  (case %96
    (-1  (@__ieee754_log-%97 mem %R %f %1))
    (0 (@__ieee754_log-%101 mem %R %dk %f %k %1)))))

(defund @__ieee754_log-%79 (mem %dk %k %1)
  (b* (
    (%80 (load-i32 %k mem))
    (%81 (sitofp-i32-to-double %80))
    (mem (store-double %81 %dk mem))
    (%82 (load-double %dk mem))
    (%83 (fmul-double %82 #x3FE62E42FEE00000))
    (%84 (load-double %dk mem))
    (%85 (fmul-double %84 #x3DEA39EF35793C76))
    (%86 (fadd-double %83 %85))
    (mem (store-double %86 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%77 (mem %1)
  (b* (
    (%78 (load-double '(zero . 0) mem))
    (mem (store-double %78 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%74 (mem %dk %k %1)
  (b* (
    (%75 (load-i32 %k mem))
    (%76 (icmp-eq-i32 %75 0)))
  (case %76
    (-1  (@__ieee754_log-%77 mem %1))
    (0 (@__ieee754_log-%79 mem %dk %k %1)))))

(defund @__ieee754_log-%70 (mem %R %dk %f %k %1)
  (b* (
    (%71 (load-double %f mem))
    (%72 (load-double '(zero . 0) mem))
    (%73 (fcmp-oeq-double %71 %72)))
  (case %73
    (-1  (@__ieee754_log-%74 mem %dk %k %1))
    (0 (@__ieee754_log-%87 mem %R %dk %f %k %1)))))

(defund @__ieee754_log-%43 (mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)
  (b* (
    (%44 (load-i32 %hx mem))
    (%45 (ashr-i32 %44 20))
    (%46 (sub-i32 %45 1023))
    (%47 (load-i32 %k mem))
    (%48 (add-i32 %47 %46))
    (mem (store-i32 %48 %k mem))
    (%49 (load-i32 %hx mem))
    (%50 (and-i32 %49 1048575))
    (mem (store-i32 %50 %hx mem))
    (%51 (load-i32 %hx mem))
    (%52 (add-i32 %51 614244))
    (%53 (and-i32 %52 1048576))
    (mem (store-i32 %53 %i mem))
    (%54 (load-i32 %hx mem))
    (%55 (load-i32 %i mem))
    (%56 (xor-i32 %55 1072693248))
    (%57 (or-i32 %54 %56))
    (%58 (bitcast-double*-to-i32* %2))
    (%59 (getelementptr-i32 %58 1))
    (mem (store-i32 %57 %59 mem))
    (%60 (load-i32 %i mem))
    (%61 (ashr-i32 %60 20))
    (%62 (load-i32 %k mem))
    (%63 (add-i32 %62 %61))
    (mem (store-i32 %63 %k mem))
    (%64 (load-double %2 mem))
    (%65 (fsub-double %64 #x3ff0000000000000))
    (mem (store-double %65 %f mem))
    (%66 (load-i32 %hx mem))
    (%67 (add-i32 2 %66))
    (%68 (and-i32 1048575 %67))
    (%69 (icmp-slt-i32 %68 3)))
  (case %69
    (-1  (@__ieee754_log-%70 mem %R %dk %f %k %1))
    (0 (@__ieee754_log-%113 mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1)))))

(defund @__ieee754_log-%39 (mem %1 %2)
  (b* (
    (%40 (load-double %2 mem))
    (%41 (load-double %2 mem))
    (%42 (fadd-double %40 %41))
    (mem (store-double %42 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%36 (mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)
  (b* (
    (%37 (load-i32 %hx mem))
    (%38 (icmp-sge-i32 %37 2146435072)))
  (case %38
    (-1  (@__ieee754_log-%39 mem %1 %2))
    (0 (@__ieee754_log-%43 mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)))))

(defund @__ieee754_log-%28 (mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)
  (b* (
    (%29 (load-i32 %k mem))
    (%30 (sub-i32 %29 54))
    (mem (store-i32 %30 %k mem))
    (%31 (load-double %2 mem))
    (%32 (fmul-double %31 #x4350000000000000))
    (mem (store-double %32 %2 mem))
    (%33 (bitcast-double*-to-i32* %2))
    (%34 (getelementptr-i32 %33 1))
    (%35 (load-i32 %34 mem))
    (mem (store-i32 %35 %hx mem)))
  (@__ieee754_log-%36 mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)))

(defund @__ieee754_log-%22 (mem %1 %2)
  (b* (
    (%23 (load-double %2 mem))
    (%24 (load-double %2 mem))
    (%25 (fsub-double %23 %24))
    (%26 (load-double '(zero . 0) mem))
    (%27 (fdiv-double %25 %26))
    (mem (store-double %27 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%19 (mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)
  (b* (
    (%20 (load-i32 %hx mem))
    (%21 (icmp-slt-i32 %20 0)))
  (case %21
    (-1  (@__ieee754_log-%22 mem %1 %2))
    (0 (@__ieee754_log-%28 mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)))))

(defund @__ieee754_log-%16 (mem %1)
  (b* (
    (%17 (load-double '(zero . 0) mem))
    (%18 (fdiv-double #xC350000000000000 %17))
    (mem (store-double %18 %1 mem)))
  (@__ieee754_log-%215 mem %1)))

(defund @__ieee754_log-%10 (mem %R %dk %f %hfsq %hx %i %j %k %lx %s %t1 %t2 %w %z %1 %2)
  (b* (
    (%11 (load-i32 %hx mem))
    (%12 (and-i32 %11 2147483647))
    (%13 (load-i32 %lx mem))
    (%14 (or-i32 %12 %13))
    (%15 (icmp-eq-i32 %14 0)))
  (case %15
    (-1  (@__ieee754_log-%16 mem %1))
    (0 (@__ieee754_log-%19 mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)))))

(defund @__ieee754_log-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %hfsq mem) (alloca-double 'hfsq 1 mem))
    ((mv %f mem) (alloca-double 'f 1 mem))
    ((mv %s mem) (alloca-double 's 1 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %R mem) (alloca-double 'R 1 mem))
    ((mv %w mem) (alloca-double 'w 1 mem))
    ((mv %t1 mem) (alloca-double 't1 1 mem))
    ((mv %t2 mem) (alloca-double 't2 1 mem))
    ((mv %dk mem) (alloca-double 'dk 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    ((mv %i mem) (alloca-i32 'i 1 mem))
    ((mv %j mem) (alloca-i32 'j 1 mem))
    ((mv %lx mem) (alloca-i32 'lx 1 mem))
    (mem (store-double %x %2 mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %hx mem))
    (%6 (bitcast-double*-to-i32* %2))
    (%7 (load-i32 %6 mem))
    (mem (store-i32 %7 %lx mem))
    (mem (store-i32 0 %k mem))
    (%8 (load-i32 %hx mem))
    (%9 (icmp-slt-i32 %8 1048576)))
  (case %9
    (-1  (@__ieee754_log-%10 mem %R %dk %f %hfsq %hx %i %j %k %lx %s %t1 %t2 %w %z %1 %2))
    (0 (@__ieee754_log-%36 mem %R %dk %f %hfsq %hx %i %j %k %s %t1 %t2 %w %z %1 %2)))))

(defund @__ieee754_log (%x)
  (@__ieee754_log-%0 *__ieee754_log-globals* %x))
