(in-package "ACL2")
(include-book "../llvm")

(defconst *expm1-globals* '())

(defund @expm1-%258 (mem %1)
  (b* (
    (%259 (load-double %1 mem)))
  %259))

(defund @expm1-%256 (mem %y %1)
  (b* (
    (%257 (load-double %y mem))
    (mem (store-double %257 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%255 (mem %y %1)
  (b* ()
  (@expm1-%256 mem %y %1)))

(defund @expm1-%236 (mem %e %k %t %y %1 %2)
  (b* (
    (%237 (load-i32 %k mem))
    (%238 (sub-i32 1023 %237))
    (%239 (shl-i32 %238 20))
    (%240 (bitcast-double*-to-i32* %t))
    (%241 (getelementptr-i32 %240 1))
    (mem (store-i32 %239 %241 mem))
    (%242 (load-double %2 mem))
    (%243 (load-double %e mem))
    (%244 (load-double %t mem))
    (%245 (fadd-double %243 %244))
    (%246 (fsub-double %242 %245))
    (mem (store-double %246 %y mem))
    (%247 (load-double %y mem))
    (%248 (fadd-double %247 #x3ff0000000000000))
    (mem (store-double %248 %y mem))
    (%249 (load-i32 %k mem))
    (%250 (shl-i32 %249 20))
    (%251 (bitcast-double*-to-i32* %y))
    (%252 (getelementptr-i32 %251 1))
    (%253 (load-i32 %252 mem))
    (%254 (add-i32 %253 %250))
    (mem (store-i32 %254 %252 mem)))
  (@expm1-%255 mem %y %1)))

(defund @expm1-%219 (mem %e %k %t %y %1 %2)
  (b* (
    (%220 (load-i32 %k mem))
    (%221 (ashr-i32 2097152 %220))
    (%222 (sub-i32 1072693248 %221))
    (%223 (bitcast-double*-to-i32* %t))
    (%224 (getelementptr-i32 %223 1))
    (mem (store-i32 %222 %224 mem))
    (%225 (load-double %t mem))
    (%226 (load-double %e mem))
    (%227 (load-double %2 mem))
    (%228 (fsub-double %226 %227))
    (%229 (fsub-double %225 %228))
    (mem (store-double %229 %y mem))
    (%230 (load-i32 %k mem))
    (%231 (shl-i32 %230 20))
    (%232 (bitcast-double*-to-i32* %y))
    (%233 (getelementptr-i32 %232 1))
    (%234 (load-i32 %233 mem))
    (%235 (add-i32 %234 %231))
    (mem (store-i32 %235 %233 mem)))
  (@expm1-%255 mem %y %1)))

(defund @expm1-%216 (mem %e %k %t %y %1 %2)
  (b* (
    (mem (store-double #x3ff0000000000000 %t mem))
    (%217 (load-i32 %k mem))
    (%218 (icmp-slt-i32 %217 20)))
  (case %218
    (-1 (@expm1-%219 mem %e %k %t %y %1 %2))
    (0 (@expm1-%236 mem %e %k %t %y %1 %2)))))

(defund @expm1-%203 (mem %e %k %y %1 %2)
  (b* (
    (%204 (load-double %e mem))
    (%205 (load-double %2 mem))
    (%206 (fsub-double %204 %205))
    (%207 (fsub-double #x3ff0000000000000 %206))
    (mem (store-double %207 %y mem))
    (%208 (load-i32 %k mem))
    (%209 (shl-i32 %208 20))
    (%210 (bitcast-double*-to-i32* %y))
    (%211 (getelementptr-i32 %210 1))
    (%212 (load-i32 %211 mem))
    (%213 (add-i32 %212 %209))
    (mem (store-i32 %213 %211 mem))
    (%214 (load-double %y mem))
    (%215 (fsub-double %214 #x3ff0000000000000))
    (mem (store-double %215 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%200 (mem %e %k %t %y %1 %2)
  (b* (
    (%201 (load-i32 %k mem))
    (%202 (icmp-sgt-i32 %201 56)))
  (case %202
    (-1 (@expm1-%203 mem %e %k %y %1 %2))
    (0 (@expm1-%216 mem %e %k %t %y %1 %2)))))

(defund @expm1-%197 (mem %e %k %t %y %1 %2)
  (b* (
    (%198 (load-i32 %k mem))
    (%199 (icmp-sle-i32 %198 -2)))
  (case %199
    (-1 (@expm1-%203 mem %e %k %y %1 %2))
    (0 (@expm1-%200 mem %e %k %t %y %1 %2)))))

(defund @expm1-%191 (mem %e %1 %2)
  (b* (
    (%192 (load-double %2 mem))
    (%193 (load-double %e mem))
    (%194 (fsub-double %192 %193))
    (%195 (fmul-double #x4000000000000000 %194))
    (%196 (fadd-double #x3ff0000000000000 %195))
    (mem (store-double %196 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%185 (mem %e %1 %2)
  (b* (
    (%186 (load-double %e mem))
    (%187 (load-double %2 mem))
    (%188 (fadd-double %187 #x3fe0000000000000))
    (%189 (fsub-double %186 %188))
    (%190 (fmul-double #xc000000000000000 %189))
    (mem (store-double %190 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%182 (mem %e %1 %2)
  (b* (
    (%183 (load-double %2 mem))
    (%184 (fcmp-olt-double %183 #xbfd0000000000000)))
  (case %184
    (-1 (@expm1-%185 mem %e %1 %2))
    (0 (@expm1-%191 mem %e %1 %2)))))

(defund @expm1-%179 (mem %e %k %t %y %1 %2)
  (b* (
    (%180 (load-i32 %k mem))
    (%181 (icmp-eq-i32 %180 1)))
  (case %181
    (-1 (@expm1-%182 mem %e %1 %2))
    (0 (@expm1-%197 mem %e %k %t %y %1 %2)))))

(defund @expm1-%173 (mem %e %1 %2)
  (b* (
    (%174 (load-double %2 mem))
    (%175 (load-double %e mem))
    (%176 (fsub-double %174 %175))
    (%177 (fmul-double #x3fe0000000000000 %176))
    (%178 (fsub-double %177 #x3fe0000000000000))
    (mem (store-double %178 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%160 (mem %c %e %hxs %k %t %y %1 %2)
  (b* (
    (%161 (load-double %2 mem))
    (%162 (load-double %e mem))
    (%163 (load-double %c mem))
    (%164 (fsub-double %162 %163))
    (%165 (fmul-double %161 %164))
    (%166 (load-double %c mem))
    (%167 (fsub-double %165 %166))
    (mem (store-double %167 %e mem))
    (%168 (load-double %hxs mem))
    (%169 (load-double %e mem))
    (%170 (fsub-double %169 %168))
    (mem (store-double %170 %e mem))
    (%171 (load-i32 %k mem))
    (%172 (icmp-eq-i32 %171 -1)))
  (case %172
    (-1 (@expm1-%173 mem %e %1 %2))
    (0 (@expm1-%179 mem %e %k %t %y %1 %2)))))

(defund @expm1-%152 (mem %e %hxs %1 %2)
  (b* (
    (%153 (load-double %2 mem))
    (%154 (load-double %2 mem))
    (%155 (load-double %e mem))
    (%156 (fmul-double %154 %155))
    (%157 (load-double %hxs mem))
    (%158 (fsub-double %156 %157))
    (%159 (fsub-double %153 %158))
    (mem (store-double %159 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%115 (mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)
  (b* (
    (%116 (load-double %2 mem))
    (%117 (fmul-double #x3fe0000000000000 %116))
    (mem (store-double %117 %hfx mem))
    (%118 (load-double %2 mem))
    (%119 (load-double %hfx mem))
    (%120 (fmul-double %118 %119))
    (mem (store-double %120 %hxs mem))
    (%121 (load-double %hxs mem))
    (%122 (load-double %hxs mem))
    (%123 (load-double %hxs mem))
    (%124 (load-double %hxs mem))
    (%125 (load-double %hxs mem))
    (%126 (fmul-double %125 #xBE8AFDB76E09C32D))
    (%127 (fadd-double #x3ED0CFCA86E65239 %126))
    (%128 (fmul-double %124 %127))
    (%129 (fadd-double #xBF14CE199EAADBB7 %128))
    (%130 (fmul-double %123 %129))
    (%131 (fadd-double #x3F5A01A019FE5585 %130))
    (%132 (fmul-double %122 %131))
    (%133 (fadd-double #xBFA11111111110F4 %132))
    (%134 (fmul-double %121 %133))
    (%135 (fadd-double #x3ff0000000000000 %134))
    (mem (store-double %135 %r1 mem))
    (%136 (load-double %r1 mem))
    (%137 (load-double %hfx mem))
    (%138 (fmul-double %136 %137))
    (%139 (fsub-double #x4008000000000000 %138))
    (mem (store-double %139 %t mem))
    (%140 (load-double %hxs mem))
    (%141 (load-double %r1 mem))
    (%142 (load-double %t mem))
    (%143 (fsub-double %141 %142))
    (%144 (load-double %2 mem))
    (%145 (load-double %t mem))
    (%146 (fmul-double %144 %145))
    (%147 (fsub-double #x4018000000000000 %146))
    (%148 (fdiv-double %143 %147))
    (%149 (fmul-double %140 %148))
    (mem (store-double %149 %e mem))
    (%150 (load-i32 %k mem))
    (%151 (icmp-eq-i32 %150 0)))
  (case %151
    (-1 (@expm1-%152 mem %e %hxs %1 %2))
    (0 (@expm1-%160 mem %c %e %hxs %k %t %y %1 %2)))))

(defund @expm1-%114 (mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)
  (b* ()
  (@expm1-%115 mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)))

(defund @expm1-%113 (mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)
  (b* (
    (mem (store-i32 0 %k mem)))
  (@expm1-%114 mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)))

(defund @expm1-%104 (mem %t %1 %2)
  (b* (
    (%105 (load-double %2 mem))
    (%106 (fadd-double #x7e37e43c8800759c %105))
    (mem (store-double %106 %t mem))
    (%107 (load-double %2 mem))
    (%108 (load-double %t mem))
    (%109 (load-double %2 mem))
    (%110 (fadd-double #x7e37e43c8800759c %109))
    (%111 (fsub-double %108 %110))
    (%112 (fsub-double %107 %111))
    (mem (store-double %112 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%101 (mem %c %e %hfx %hx %hxs %k %r1 %t %y %1 %2)
  (b* (
    (%102 (load-i32 %hx mem))
    (%103 (icmp-ult-i32 %102 1016070144)))
  (case %103
    (-1 (@expm1-%104 mem %t %1 %2))
    (0 (@expm1-%113 mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)))))

(defund @expm1-%92 (mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)
  (b* (
    (%93 (load-double %hi mem))
    (%94 (load-double %lo mem))
    (%95 (fsub-double %93 %94))
    (mem (store-double %95 %2 mem))
    (%96 (load-double %hi mem))
    (%97 (load-double %2 mem))
    (%98 (fsub-double %96 %97))
    (%99 (load-double %lo mem))
    (%100 (fsub-double %98 %99))
    (mem (store-double %100 %c mem)))
  (@expm1-%115 mem %c %e %hfx %hxs %k %r1 %t %y %1 %2)))

(defund @expm1-%76 (mem %c %e %hfx %hi %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%77 (load-double %2 mem))
    (%78 (fmul-double #x3FF71547652B82FE %77))
    (%79 (load-i32 %xsb mem))
    (%80 (icmp-eq-i32 %79 0))
    (%81 (select-double %80 #x3fe0000000000000 #xbfe0000000000000))
    (%82 (fadd-double %78 %81))
    (%83 (fptosi-double-to-i32 %82))
    (mem (store-i32 %83 %k mem))
    (%84 (load-i32 %k mem))
    (%85 (sitofp-i32-to-double %84))
    (mem (store-double %85 %t mem))
    (%86 (load-double %2 mem))
    (%87 (load-double %t mem))
    (%88 (fmul-double %87 #x3FE62E42FEE00000))
    (%89 (fsub-double %86 %88))
    (mem (store-double %89 %hi mem))
    (%90 (load-double %t mem))
    (%91 (fmul-double %90 #x3DEA39EF35793C76))
    (mem (store-double %91 %lo mem)))
  (@expm1-%92 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)))

(defund @expm1-%75 (mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)
  (b* ()
  (@expm1-%92 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)))

(defund @expm1-%72 (mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)
  (b* (
    (%73 (load-double %2 mem))
    (%74 (fadd-double %73 #x3FE62E42FEE00000))
    (mem (store-double %74 %hi mem))
    (mem (store-double #xBDEA39EF35793C76 %lo mem))
    (mem (store-i32 -1 %k mem)))
  (@expm1-%75 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)))

(defund @expm1-%69 (mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)
  (b* (
    (%70 (load-double %2 mem))
    (%71 (fsub-double %70 #x3FE62E42FEE00000))
    (mem (store-double %71 %hi mem))
    (mem (store-double #x3DEA39EF35793C76 %lo mem))
    (mem (store-i32 1 %k mem)))
  (@expm1-%75 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)))

(defund @expm1-%66 (mem %c %e %hfx %hi %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%67 (load-i32 %xsb mem))
    (%68 (icmp-eq-i32 %67 0)))
  (case %68
    (-1 (@expm1-%69 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2))
    (0 (@expm1-%72 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %y %1 %2)))))

(defund @expm1-%63 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%64 (load-i32 %hx mem))
    (%65 (icmp-ult-i32 %64 1072734898)))
  (case %65
    (-1 (@expm1-%66 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %xsb %y %1 %2))
    (0 (@expm1-%76 mem %c %e %hfx %hi %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%60 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%61 (load-i32 %hx mem))
    (%62 (icmp-ugt-i32 %61 1071001154)))
  (case %62
    (-1 (@expm1-%63 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2))
    (0 (@expm1-%101 mem %c %e %hfx %hx %hxs %k %r1 %t %y %1 %2)))))

(defund @expm1-%59 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* ()
  (@expm1-%60 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))

(defund @expm1-%58 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* ()
  (@expm1-%59 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))

(defund @expm1-%57 (mem %1)
  (b* (
    (mem (store-double #xbff0000000000000 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%53 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%54 (load-double %2 mem))
    (%55 (fadd-double %54 #x01a56e1fc2f8f359))
    (%56 (fcmp-olt-double %55 #x0000000000000000)))
  (case %56
    (-1 (@expm1-%57 mem %1))
    (0 (@expm1-%58 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%50 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%51 (load-i32 %xsb mem))
    (%52 (icmp-ne-i32 %51 0)))
  (case %52
    (-1 (@expm1-%53 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2))
    (0 (@expm1-%59 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%49 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* ()
  (@expm1-%50 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))

(defund @expm1-%48 (mem %1)
  (b* (
    (mem (store-double #x7FF0000000000000 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%45 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%46 (load-double %2 mem))
    (%47 (fcmp-ogt-double %46 #x40862E42FEFA39EF)))
  (case %47
    (-1 (@expm1-%48 mem %1))
    (0 (@expm1-%49 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%43 (mem %1 %44)
  (b* (
    ; %44 = phi double [ %41, %40 ], [ #xbff0000000000000, %42 ]
    (mem (store-double %44 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%42 (mem %1)
  (b* ()
  (@expm1-%43 mem %1 #xbff0000000000000)))

(defund @expm1-%40 (mem %1 %2)
  (b* (
    (%41 (load-double %2 mem)))
  (@expm1-%43 mem %1 %41)))

(defund @expm1-%37 (mem %xsb %1 %2)
  (b* (
    (%38 (load-i32 %xsb mem))
    (%39 (icmp-eq-i32 %38 0)))
  (case %39
    (-1 (@expm1-%40 mem %1 %2))
    (0 (@expm1-%42 mem %1)))))

(defund @expm1-%33 (mem %1 %2)
  (b* (
    (%34 (load-double %2 mem))
    (%35 (load-double %2 mem))
    (%36 (fadd-double %34 %35))
    (mem (store-double %36 %1 mem)))
  (@expm1-%258 mem %1)))

(defund @expm1-%26 (mem %hx %xsb %1 %2)
  (b* (
    (%27 (load-i32 %hx mem))
    (%28 (and-i32 %27 1048575))
    (%29 (bitcast-double*-to-i32* %2))
    (%30 (load-i32 %29 mem))
    (%31 (or-i32 %28 %30))
    (%32 (icmp-ne-i32 %31 0)))
  (case %32
    (-1 (@expm1-%33 mem %1 %2))
    (0 (@expm1-%37 mem %xsb %1 %2)))))

(defund @expm1-%23 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%24 (load-i32 %hx mem))
    (%25 (icmp-uge-i32 %24 2146435072)))
  (case %25
    (-1 (@expm1-%26 mem %hx %xsb %1 %2))
    (0 (@expm1-%45 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%20 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%21 (load-i32 %hx mem))
    (%22 (icmp-uge-i32 %21 1082535490)))
  (case %22
    (-1 (@expm1-%23 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2))
    (0 (@expm1-%50 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%15 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%16 (load-i32 %hx mem))
    (%17 (and-i32 %16 2147483647))
    (mem (store-i32 %17 %hx mem))
    (%18 (load-i32 %hx mem))
    (%19 (icmp-uge-i32 %18 1078159482)))
  (case %19
    (-1 (@expm1-%20 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2))
    (0 (@expm1-%60 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1-%12 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%13 (load-double %2 mem))
    (%14 (fsub-double #x8000000000000000 %13))
    (mem (store-double %14 %y mem)))
  (@expm1-%15 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))

(defund @expm1-%10 (mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)
  (b* (
    (%11 (load-double %2 mem))
    (mem (store-double %11 %y mem)))
  (@expm1-%15 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))

(defund @expm1-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %y mem) (alloca-double 'y 1 mem))
    ((mv %hi mem) (alloca-double 'hi 1 mem))
    ((mv %lo mem) (alloca-double 'lo 1 mem))
    ((mv %c mem) (alloca-double 'c 1 mem))
    ((mv %t mem) (alloca-double 't 1 mem))
    ((mv %e mem) (alloca-double 'e 1 mem))
    ((mv %hxs mem) (alloca-double 'hxs 1 mem))
    ((mv %hfx mem) (alloca-double 'hfx 1 mem))
    ((mv %r1 mem) (alloca-double 'r1 1 mem))
    ((mv %k mem) (alloca-i32 'k 1 mem))
    ((mv %xsb mem) (alloca-i32 'xsb 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    (mem (store-double %x %2 mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %hx mem))
    (%6 (load-i32 %hx mem))
    (%7 (and-i32 %6 -2147483648))
    (mem (store-i32 %7 %xsb mem))
    (%8 (load-i32 %xsb mem))
    (%9 (icmp-eq-i32 %8 0)))
  (case %9
    (-1 (@expm1-%10 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2))
    (0 (@expm1-%12 mem %c %e %hfx %hi %hx %hxs %k %lo %r1 %t %xsb %y %1 %2)))))

(defund @expm1 (%x)
  (@expm1-%0 *expm1-globals* %x))
