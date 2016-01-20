(in-package "ACL2")
(include-book "../llvm")

(defconst *log1p-globals* '(
  (zero #x00000000 #x00000000)))

(defund @log1p-%239 (mem %1)
  (b* (
    (%240 (load-double %1 mem)))
  %240))

(defund @log1p-%219 (mem %R %c %f %hfsq %k %s %1)
  (b* (
    (%220 (load-i32 %k mem))
    (%221 (sitofp-i32-to-double %220))
    (%222 (fmul-double %221 #x3FE62E42FEE00000))
    (%223 (load-double %hfsq mem))
    (%224 (load-double %s mem))
    (%225 (load-double %hfsq mem))
    (%226 (load-double %R mem))
    (%227 (fadd-double %225 %226))
    (%228 (fmul-double %224 %227))
    (%229 (load-i32 %k mem))
    (%230 (sitofp-i32-to-double %229))
    (%231 (fmul-double %230 #x3DEA39EF35793C76))
    (%232 (load-double %c mem))
    (%233 (fadd-double %231 %232))
    (%234 (fadd-double %228 %233))
    (%235 (fsub-double %223 %234))
    (%236 (load-double %f mem))
    (%237 (fsub-double %235 %236))
    (%238 (fsub-double %222 %237))
    (mem (store-double %238 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%209 (mem %R %f %hfsq %s %1)
  (b* (
    (%210 (load-double %f mem))
    (%211 (load-double %hfsq mem))
    (%212 (load-double %s mem))
    (%213 (load-double %hfsq mem))
    (%214 (load-double %R mem))
    (%215 (fadd-double %213 %214))
    (%216 (fmul-double %212 %215))
    (%217 (fsub-double %211 %216))
    (%218 (fsub-double %210 %217))
    (mem (store-double %218 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%179 (mem %R %c %f %hfsq %k %s %z %1)
  (b* (
    (%180 (load-double %f mem))
    (%181 (load-double %f mem))
    (%182 (fadd-double #x4000000000000000 %181))
    (%183 (fdiv-double %180 %182))
    (mem (store-double %183 %s mem))
    (%184 (load-double %s mem))
    (%185 (load-double %s mem))
    (%186 (fmul-double %184 %185))
    (mem (store-double %186 %z mem))
    (%187 (load-double %z mem))
    (%188 (load-double %z mem))
    (%189 (load-double %z mem))
    (%190 (load-double %z mem))
    (%191 (load-double %z mem))
    (%192 (load-double %z mem))
    (%193 (load-double %z mem))
    (%194 (fmul-double %193 #x3FC2F112DF3E5244))
    (%195 (fadd-double #x3FC39A09D078C69F %194))
    (%196 (fmul-double %192 %195))
    (%197 (fadd-double #x3FC7466496CB03DE %196))
    (%198 (fmul-double %191 %197))
    (%199 (fadd-double #x3FCC71C51D8E78AF %198))
    (%200 (fmul-double %190 %199))
    (%201 (fadd-double #x3FD2492494229359 %200))
    (%202 (fmul-double %189 %201))
    (%203 (fadd-double #x3FD999999997FA04 %202))
    (%204 (fmul-double %188 %203))
    (%205 (fadd-double #x3FE5555555555593 %204))
    (%206 (fmul-double %187 %205))
    (mem (store-double %206 %R mem))
    (%207 (load-i32 %k mem))
    (%208 (icmp-eq-i32 %207 0)))
  (case %208
    (-1 (@log1p-%209 mem %R %f %hfsq %s %1))
    (0 (@log1p-%219 mem %R %c %f %hfsq %k %s %1)))))

(defund @log1p-%165 (mem %R %c %f %k %1)
  (b* (
    (%166 (load-i32 %k mem))
    (%167 (sitofp-i32-to-double %166))
    (%168 (fmul-double %167 #x3FE62E42FEE00000))
    (%169 (load-double %R mem))
    (%170 (load-i32 %k mem))
    (%171 (sitofp-i32-to-double %170))
    (%172 (fmul-double %171 #x3DEA39EF35793C76))
    (%173 (load-double %c mem))
    (%174 (fadd-double %172 %173))
    (%175 (fsub-double %169 %174))
    (%176 (load-double %f mem))
    (%177 (fsub-double %175 %176))
    (%178 (fsub-double %168 %177))
    (mem (store-double %178 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%161 (mem %R %f %1)
  (b* (
    (%162 (load-double %f mem))
    (%163 (load-double %R mem))
    (%164 (fsub-double %162 %163))
    (mem (store-double %164 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%153 (mem %R %c %f %hfsq %k %1)
  (b* (
    (%154 (load-double %hfsq mem))
    (%155 (load-double %f mem))
    (%156 (fmul-double #x3FE5555555555555 %155))
    (%157 (fsub-double #x3ff0000000000000 %156))
    (%158 (fmul-double %154 %157))
    (mem (store-double %158 %R mem))
    (%159 (load-i32 %k mem))
    (%160 (icmp-eq-i32 %159 0)))
  (case %160
    (-1 (@log1p-%161 mem %R %f %1))
    (0 (@log1p-%165 mem %R %c %f %k %1)))))

(defund @log1p-%142 (mem %c %k %1)
  (b* (
    (%143 (load-i32 %k mem))
    (%144 (sitofp-i32-to-double %143))
    (%145 (fmul-double %144 #x3DEA39EF35793C76))
    (%146 (load-double %c mem))
    (%147 (fadd-double %146 %145))
    (mem (store-double %147 %c mem))
    (%148 (load-i32 %k mem))
    (%149 (sitofp-i32-to-double %148))
    (%150 (fmul-double %149 #x3FE62E42FEE00000))
    (%151 (load-double %c mem))
    (%152 (fadd-double %150 %151))
    (mem (store-double %152 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%140 (mem %1)
  (b* (
    (%141 (load-double '(zero . 0) mem))
    (mem (store-double %141 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%137 (mem %c %k %1)
  (b* (
    (%138 (load-i32 %k mem))
    (%139 (icmp-eq-i32 %138 0)))
  (case %139
    (-1 (@log1p-%140 mem %1))
    (0 (@log1p-%142 mem %c %k %1)))))

(defund @log1p-%133 (mem %R %c %f %hfsq %k %1)
  (b* (
    (%134 (load-double %f mem))
    (%135 (load-double '(zero . 0) mem))
    (%136 (fcmp-oeq-double %134 %135)))
  (case %136
    (-1 (@log1p-%137 mem %c %k %1))
    (0 (@log1p-%153 mem %R %c %f %hfsq %k %1)))))

(defund @log1p-%126 (mem %R %c %f %hfsq %hu %k %s %z %1)
  (b* (
    (%127 (load-double %f mem))
    (%128 (fmul-double #x3fe0000000000000 %127))
    (%129 (load-double %f mem))
    (%130 (fmul-double %128 %129))
    (mem (store-double %130 %hfsq mem))
    (%131 (load-i32 %hu mem))
    (%132 (icmp-eq-i32 %131 0)))
  (case %132
    (-1 (@log1p-%133 mem %R %c %f %hfsq %k %1))
    (0 (@log1p-%179 mem %R %c %f %hfsq %k %s %z %1)))))

(defund @log1p-%123 (mem %R %c %f %hfsq %hu %k %s %u %z %1)
  (b* (
    (%124 (load-double %u mem))
    (%125 (fsub-double %124 #x3ff0000000000000))
    (mem (store-double %125 %f mem)))
  (@log1p-%126 mem %R %c %f %hfsq %hu %k %s %z %1)))

(defund @log1p-%113 (mem %R %c %f %hfsq %hu %k %s %u %z %1)
  (b* (
    (%114 (load-i32 %k mem))
    (%115 (add-i32 %114 1))
    (mem (store-i32 %115 %k mem))
    (%116 (load-i32 %hu mem))
    (%117 (or-i32 %116 1071644672))
    (%118 (bitcast-double*-to-i32* %u))
    (%119 (getelementptr-i32 %118 1))
    (mem (store-i32 %117 %119 mem))
    (%120 (load-i32 %hu mem))
    (%121 (sub-i32 1048576 %120))
    (%122 (ashr-i32 %121 2))
    (mem (store-i32 %122 %hu mem)))
  (@log1p-%123 mem %R %c %f %hfsq %hu %k %s %u %z %1)))

(defund @log1p-%108 (mem %R %c %f %hfsq %hu %k %s %u %z %1)
  (b* (
    (%109 (load-i32 %hu mem))
    (%110 (or-i32 %109 1072693248))
    (%111 (bitcast-double*-to-i32* %u))
    (%112 (getelementptr-i32 %111 1))
    (mem (store-i32 %110 %112 mem)))
  (@log1p-%123 mem %R %c %f %hfsq %hu %k %s %u %z %1)))

(defund @log1p-%103 (mem %R %c %f %hfsq %hu %k %s %u %z %1)
  (b* (
    (%104 (load-i32 %hu mem))
    (%105 (and-i32 %104 1048575))
    (mem (store-i32 %105 %hu mem))
    (%106 (load-i32 %hu mem))
    (%107 (icmp-slt-i32 %106 434334)))
  (case %107
    (-1 (@log1p-%108 mem %R %c %f %hfsq %hu %k %s %u %z %1))
    (0 (@log1p-%113 mem %R %c %f %hfsq %hu %k %s %u %z %1)))))

(defund @log1p-%95 (mem %R %c %f %hfsq %hu %k %s %u %z %1 %2)
  (b* (
    (%96 (load-double %2 mem))
    (mem (store-double %96 %u mem))
    (%97 (bitcast-double*-to-i32* %u))
    (%98 (getelementptr-i32 %97 1))
    (%99 (load-i32 %98 mem))
    (mem (store-i32 %99 %hu mem))
    (%100 (load-i32 %hu mem))
    (%101 (ashr-i32 %100 20))
    (%102 (sub-i32 %101 1023))
    (mem (store-i32 %102 %k mem))
    (mem (store-double #x0000000000000000 %c mem)))
  (@log1p-%103 mem %R %c %f %hfsq %hu %k %s %u %z %1)))

(defund @log1p-%90 (mem %R %c %f %hfsq %hu %k %s %u %z %1 %91)
  (b* (
    ; %91 = phi double [ %84, %80 ], [ %89, %85 ]
    (mem (store-double %91 %c mem))
    (%92 (load-double %u mem))
    (%93 (load-double %c mem))
    (%94 (fdiv-double %93 %92))
    (mem (store-double %94 %c mem)))
  (@log1p-%103 mem %R %c %f %hfsq %hu %k %s %u %z %1)))

(defund @log1p-%85 (mem %R %c %f %hfsq %hu %k %s %u %z %1 %2)
  (b* (
    (%86 (load-double %2 mem))
    (%87 (load-double %u mem))
    (%88 (fsub-double %87 #x3ff0000000000000))
    (%89 (fsub-double %86 %88)))
  (@log1p-%90 mem %R %c %f %hfsq %hu %k %s %u %z %1 %89)))

(defund @log1p-%80 (mem %R %c %f %hfsq %hu %k %s %u %z %1 %2)
  (b* (
    (%81 (load-double %u mem))
    (%82 (load-double %2 mem))
    (%83 (fsub-double %81 %82))
    (%84 (fsub-double #x3ff0000000000000 %83)))
  (@log1p-%90 mem %R %c %f %hfsq %hu %k %s %u %z %1 %84)))

(defund @log1p-%69 (mem %R %c %f %hfsq %hu %k %s %u %z %1 %2)
  (b* (
    (%70 (load-double %2 mem))
    (%71 (fadd-double #x3ff0000000000000 %70))
    (mem (store-double %71 %u mem))
    (%72 (bitcast-double*-to-i32* %u))
    (%73 (getelementptr-i32 %72 1))
    (%74 (load-i32 %73 mem))
    (mem (store-i32 %74 %hu mem))
    (%75 (load-i32 %hu mem))
    (%76 (ashr-i32 %75 20))
    (%77 (sub-i32 %76 1023))
    (mem (store-i32 %77 %k mem))
    (%78 (load-i32 %k mem))
    (%79 (icmp-sgt-i32 %78 0)))
  (case %79
    (-1 (@log1p-%80 mem %R %c %f %hfsq %hu %k %s %u %z %1 %2))
    (0 (@log1p-%85 mem %R %c %f %hfsq %hu %k %s %u %z %1 %2)))))

(defund @log1p-%66 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%67 (load-i32 %hx mem))
    (%68 (icmp-slt-i32 %67 1128267776)))
  (case %68
    (-1 (@log1p-%69 mem %R %c %f %hfsq %hu %k %s %u %z %1 %2))
    (0 (@log1p-%95 mem %R %c %f %hfsq %hu %k %s %u %z %1 %2)))))

(defund @log1p-%63 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%64 (load-i32 %k mem))
    (%65 (icmp-ne-i32 %64 0)))
  (case %65
    (-1 (@log1p-%66 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2))
    (0 (@log1p-%126 mem %R %c %f %hfsq %hu %k %s %z %1)))))

(defund @log1p-%59 (mem %1 %2)
  (b* (
    (%60 (load-double %2 mem))
    (%61 (load-double %2 mem))
    (%62 (fadd-double %60 %61))
    (mem (store-double %62 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%56 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%57 (load-i32 %hx mem))
    (%58 (icmp-sge-i32 %57 2146435072)))
  (case %58
    (-1 (@log1p-%59 mem %1 %2))
    (0 (@log1p-%63 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))))

(defund @log1p-%55 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* ()
  (@log1p-%56 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))

(defund @log1p-%53 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (mem (store-i32 0 %k mem))
    (%54 (load-double %2 mem))
    (mem (store-double %54 %f mem))
    (mem (store-i32 1 %hu mem)))
  (@log1p-%55 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))

(defund @log1p-%50 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%51 (load-i32 %hx mem))
    (%52 (icmp-sle-i32 %51 -1076707645)))
  (case %52
    (-1 (@log1p-%53 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2))
    (0 (@log1p-%55 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))))

(defund @log1p-%47 (mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%48 (load-i32 %hx mem))
    (%49 (icmp-sgt-i32 %48 0)))
  (case %49
    (-1 (@log1p-%53 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2))
    (0 (@log1p-%50 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))))

(defund @log1p-%40 (mem %1 %2)
  (b* (
    (%41 (load-double %2 mem))
    (%42 (load-double %2 mem))
    (%43 (load-double %2 mem))
    (%44 (fmul-double %42 %43))
    (%45 (fmul-double %44 #x3fe0000000000000))
    (%46 (fsub-double %41 %45))
    (mem (store-double %46 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%38 (mem %1 %2)
  (b* (
    (%39 (load-double %2 mem))
    (mem (store-double %39 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%35 (mem %ax %1 %2)
  (b* (
    (%36 (load-i32 %ax mem))
    (%37 (icmp-slt-i32 %36 1016070144)))
  (case %37
    (-1 (@log1p-%38 mem %1 %2))
    (0 (@log1p-%40 mem %1 %2)))))

(defund @log1p-%30 (mem %ax %1 %2)
  (b* (
    (%31 (load-double %2 mem))
    (%32 (fadd-double #x4350000000000000 %31))
    (%33 (load-double '(zero . 0) mem))
    (%34 (fcmp-ogt-double %32 %33)))
  (case %34
    (-1 (@log1p-%35 mem %ax %1 %2))
    (0 (@log1p-%40 mem %1 %2)))))

(defund @log1p-%27 (mem %R %ax %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%28 (load-i32 %ax mem))
    (%29 (icmp-slt-i32 %28 1042284544)))
  (case %29
    (-1 (@log1p-%30 mem %ax %1 %2))
    (0 (@log1p-%47 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))))

(defund @log1p-%19 (mem %1 %2)
  (b* (
    (%20 (load-double %2 mem))
    (%21 (load-double %2 mem))
    (%22 (fsub-double %20 %21))
    (%23 (load-double %2 mem))
    (%24 (load-double %2 mem))
    (%25 (fsub-double %23 %24))
    (%26 (fdiv-double %22 %25))
    (mem (store-double %26 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%16 (mem %1)
  (b* (
    (%17 (load-double '(zero . 0) mem))
    (%18 (fdiv-double #xC350000000000000 %17))
    (mem (store-double %18 %1 mem)))
  (@log1p-%239 mem %1)))

(defund @log1p-%13 (mem %1 %2)
  (b* (
    (%14 (load-double %2 mem))
    (%15 (fcmp-oeq-double %14 #xbff0000000000000)))
  (case %15
    (-1 (@log1p-%16 mem %1))
    (0 (@log1p-%19 mem %1 %2)))))

(defund @log1p-%10 (mem %R %ax %c %f %hfsq %hu %hx %k %s %u %z %1 %2)
  (b* (
    (%11 (load-i32 %ax mem))
    (%12 (icmp-sge-i32 %11 1072693248)))
  (case %12
    (-1 (@log1p-%13 mem %1 %2))
    (0 (@log1p-%27 mem %R %ax %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))))

(defund @log1p-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %hfsq mem) (alloca-double 'hfsq 1 mem))
    ((mv %f mem) (alloca-double 'f 1 mem))
    ((mv %c mem) (alloca-double 'c 1 mem))
    ((mv %s mem) (alloca-double 's 1 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %R mem) (alloca-double 'R 1 mem))
    ((mv %u mem) (alloca-double 'u 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    ((mv %hu mem) (alloca-i32 'hu 1 mem))
    ((mv %ax mem) (alloca-i32 'ax 1 mem))
    (mem (store-double %x %2 mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %hx mem))
    (%6 (load-i32 %hx mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 %ax mem))
    (mem (store-i32 1 %k mem))
    (%8 (load-i32 %hx mem))
    (%9 (icmp-slt-i32 %8 1071284858)))
  (case %9
    (-1 (@log1p-%10 mem %R %ax %c %f %hfsq %hu %hx %k %s %u %z %1 %2))
    (0 (@log1p-%56 mem %R %c %f %hfsq %hu %hx %k %s %u %z %1 %2)))))

(defund @log1p (%x)
  (@log1p-%0 *log1p-globals* %x))
