(in-package "ACL2")
(include-book "../llvm")
(include-book "s_fabs")

(defconst *atan-globals* '(
  (atanhi #x0561bb4f #x3fddac67 #x54442d18 #x3fe921fb #xd281f69b #x3fef730b #x54442d18 #x3ff921fb)
  (atanlo #x222f65e2 #x3c7a2b7f #x33145c07 #x3c81a626 #x7af0cbbd #x3c700788 #x33145c07 #x3c91a626)
  (aT #x5555550d #x3fd55555 #x9998ebc4 #xbfc99999 #x920083ff #x3fc24924 #xfe231671 #xbfbc71c6 #xc54c206e #x3fb745cd #xaf749a6d #xbfb3b0f2 #xa0d03d51 #x3fb10d66 #x52defd9a #xbfadde2d #x24760deb #x3fa97b4b #x2c6a6c2f #xbfa2b444 #xe322da11 #x3f90ad3a)))

(defund @atan-%173 (mem %1)
  (b* (
    (%174 (load-double %1 mem)))
  %174))

(defund @atan-%171 (mem %1 %172)
  (b* (
    ; %172 = phi double [ %168, %166 ], [ %170, %169 ]
    (mem (store-double %172 %1 mem)))
  (@atan-%173 mem %1)))

(defund @atan-%169 (mem %z %1)
  (b* (
    (%170 (load-double %z mem)))
  (@atan-%171 mem %1 %170)))

(defund @atan-%166 (mem %z %1)
  (b* (
    (%167 (load-double %z mem))
    (%168 (fsub-double #x8000000000000000 %167)))
  (@atan-%171 mem %1 %168)))

(defund @atan-%146 (mem %hx %id %s1 %s2 %z %1 %2)
  (b* (
    (%147 (load-i32 %id mem))
    (%148 (sext-i32-to-i64 %147))
    (%149 (getelementptr-double '(atanhi . 0) %148))
    (%150 (load-double %149 mem))
    (%151 (load-double %2 mem))
    (%152 (load-double %s1 mem))
    (%153 (load-double %s2 mem))
    (%154 (fadd-double %152 %153))
    (%155 (fmul-double %151 %154))
    (%156 (load-i32 %id mem))
    (%157 (sext-i32-to-i64 %156))
    (%158 (getelementptr-double '(atanlo . 0) %157))
    (%159 (load-double %158 mem))
    (%160 (fsub-double %155 %159))
    (%161 (load-double %2 mem))
    (%162 (fsub-double %160 %161))
    (%163 (fsub-double %150 %162))
    (mem (store-double %163 %z mem))
    (%164 (load-i32 %hx mem))
    (%165 (icmp-slt-i32 %164 0)))
  (case %165
    (-1 (@atan-%166 mem %z %1))
    (0 (@atan-%169 mem %z %1)))))

(defund @atan-%138 (mem %s1 %s2 %1 %2)
  (b* (
    (%139 (load-double %2 mem))
    (%140 (load-double %2 mem))
    (%141 (load-double %s1 mem))
    (%142 (load-double %s2 mem))
    (%143 (fadd-double %141 %142))
    (%144 (fmul-double %140 %143))
    (%145 (fsub-double %139 %144))
    (mem (store-double %145 %1 mem)))
  (@atan-%173 mem %1)))

(defund @atan-%87 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (%88 (load-double %2 mem))
    (%89 (load-double %2 mem))
    (%90 (fmul-double %88 %89))
    (mem (store-double %90 %z mem))
    (%91 (load-double %z mem))
    (%92 (load-double %z mem))
    (%93 (fmul-double %91 %92))
    (mem (store-double %93 %w mem))
    (%94 (load-double %z mem))
    (%95 (load-double (getelementptr-double '(aT . 0) 0) mem))
    (%96 (load-double %w mem))
    (%97 (load-double (getelementptr-double '(aT . 0) 2) mem))
    (%98 (load-double %w mem))
    (%99 (load-double (getelementptr-double '(aT . 0) 4) mem))
    (%100 (load-double %w mem))
    (%101 (load-double (getelementptr-double '(aT . 0) 6) mem))
    (%102 (load-double %w mem))
    (%103 (load-double (getelementptr-double '(aT . 0) 8) mem))
    (%104 (load-double %w mem))
    (%105 (load-double (getelementptr-double '(aT . 0) 10) mem))
    (%106 (fmul-double %104 %105))
    (%107 (fadd-double %103 %106))
    (%108 (fmul-double %102 %107))
    (%109 (fadd-double %101 %108))
    (%110 (fmul-double %100 %109))
    (%111 (fadd-double %99 %110))
    (%112 (fmul-double %98 %111))
    (%113 (fadd-double %97 %112))
    (%114 (fmul-double %96 %113))
    (%115 (fadd-double %95 %114))
    (%116 (fmul-double %94 %115))
    (mem (store-double %116 %s1 mem))
    (%117 (load-double %w mem))
    (%118 (load-double (getelementptr-double '(aT . 0) 1) mem))
    (%119 (load-double %w mem))
    (%120 (load-double (getelementptr-double '(aT . 0) 3) mem))
    (%121 (load-double %w mem))
    (%122 (load-double (getelementptr-double '(aT . 0) 5) mem))
    (%123 (load-double %w mem))
    (%124 (load-double (getelementptr-double '(aT . 0) 7) mem))
    (%125 (load-double %w mem))
    (%126 (load-double (getelementptr-double '(aT . 0) 9) mem))
    (%127 (fmul-double %125 %126))
    (%128 (fadd-double %124 %127))
    (%129 (fmul-double %123 %128))
    (%130 (fadd-double %122 %129))
    (%131 (fmul-double %121 %130))
    (%132 (fadd-double %120 %131))
    (%133 (fmul-double %119 %132))
    (%134 (fadd-double %118 %133))
    (%135 (fmul-double %117 %134))
    (mem (store-double %135 %s2 mem))
    (%136 (load-i32 %id mem))
    (%137 (icmp-slt-i32 %136 0)))
  (case %137
    (-1 (@atan-%138 mem %s1 %s2 %1 %2))
    (0 (@atan-%146 mem %hx %id %s1 %s2 %z %1 %2)))))

(defund @atan-%86 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* ()
  (@atan-%87 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%85 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* ()
  (@atan-%86 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%82 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (mem (store-i32 3 %id mem))
    (%83 (load-double %2 mem))
    (%84 (fdiv-double #xbff0000000000000 %83))
    (mem (store-double %84 %2 mem)))
  (@atan-%85 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%75 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (mem (store-i32 2 %id mem))
    (%76 (load-double %2 mem))
    (%77 (fsub-double %76 #x3ff8000000000000))
    (%78 (load-double %2 mem))
    (%79 (fmul-double #x3ff8000000000000 %78))
    (%80 (fadd-double #x3ff0000000000000 %79))
    (%81 (fdiv-double %77 %80))
    (mem (store-double %81 %2 mem)))
  (@atan-%85 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%72 (mem %hx %id %ix %s1 %s2 %w %z %1 %2)
  (b* (
    (%73 (load-i32 %ix mem))
    (%74 (icmp-slt-i32 %73 1073971200)))
  (case %74
    (-1 (@atan-%75 mem %hx %id %s1 %s2 %w %z %1 %2))
    (0 (@atan-%82 mem %hx %id %s1 %s2 %w %z %1 %2)))))

(defund @atan-%71 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* ()
  (@atan-%86 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%65 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (mem (store-i32 1 %id mem))
    (%66 (load-double %2 mem))
    (%67 (fsub-double %66 #x3ff0000000000000))
    (%68 (load-double %2 mem))
    (%69 (fadd-double %68 #x3ff0000000000000))
    (%70 (fdiv-double %67 %69))
    (mem (store-double %70 %2 mem)))
  (@atan-%71 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%58 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (mem (store-i32 0 %id mem))
    (%59 (load-double %2 mem))
    (%60 (fmul-double #x4000000000000000 %59))
    (%61 (fsub-double %60 #x3ff0000000000000))
    (%62 (load-double %2 mem))
    (%63 (fadd-double #x4000000000000000 %62))
    (%64 (fdiv-double %61 %63))
    (mem (store-double %64 %2 mem)))
  (@atan-%71 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%55 (mem %hx %id %ix %s1 %s2 %w %z %1 %2)
  (b* (
    (%56 (load-i32 %ix mem))
    (%57 (icmp-slt-i32 %56 1072037888)))
  (case %57
    (-1 (@atan-%58 mem %hx %id %s1 %s2 %w %z %1 %2))
    (0 (@atan-%65 mem %hx %id %s1 %s2 %w %z %1 %2)))))

(defund @atan-%50 (mem %hx %id %ix %s1 %s2 %w %z %1 %2)
  (b* (
    (%51 (load-double %2 mem))
    (%52 (@fabs %51))
    (mem (store-double %52 %2 mem))
    (%53 (load-i32 %ix mem))
    (%54 (icmp-slt-i32 %53 1072889856)))
  (case %54
    (-1 (@atan-%55 mem %hx %id %ix %s1 %s2 %w %z %1 %2))
    (0 (@atan-%72 mem %hx %id %ix %s1 %s2 %w %z %1 %2)))))

(defund @atan-%49 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (mem (store-i32 -1 %id mem)))
  (@atan-%87 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%48 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* ()
  (@atan-%49 mem %hx %id %s1 %s2 %w %z %1 %2)))

(defund @atan-%46 (mem %1 %2)
  (b* (
    (%47 (load-double %2 mem))
    (mem (store-double %47 %1 mem)))
  (@atan-%173 mem %1)))

(defund @atan-%42 (mem %hx %id %s1 %s2 %w %z %1 %2)
  (b* (
    (%43 (load-double %2 mem))
    (%44 (fadd-double #x7e37e43c8800759c %43))
    (%45 (fcmp-ogt-double %44 #x3ff0000000000000)))
  (case %45
    (-1 (@atan-%46 mem %1 %2))
    (0 (@atan-%48 mem %hx %id %s1 %s2 %w %z %1 %2)))))

(defund @atan-%39 (mem %hx %id %ix %s1 %s2 %w %z %1 %2)
  (b* (
    (%40 (load-i32 %ix mem))
    (%41 (icmp-slt-i32 %40 1042284544)))
  (case %41
    (-1 (@atan-%42 mem %hx %id %s1 %s2 %w %z %1 %2))
    (0 (@atan-%49 mem %hx %id %s1 %s2 %w %z %1 %2)))))

(defund @atan-%36 (mem %hx %id %ix %s1 %s2 %w %z %1 %2)
  (b* (
    (%37 (load-i32 %ix mem))
    (%38 (icmp-slt-i32 %37 1071382528)))
  (case %38
    (-1 (@atan-%39 mem %hx %id %ix %s1 %s2 %w %z %1 %2))
    (0 (@atan-%50 mem %hx %id %ix %s1 %s2 %w %z %1 %2)))))

(defund @atan-%31 (mem %1)
  (b* (
    (%32 (load-double (getelementptr-double '(atanhi . 0) 3) mem))
    (%33 (fsub-double #x8000000000000000 %32))
    (%34 (load-double (getelementptr-double '(atanlo . 0) 3) mem))
    (%35 (fsub-double %33 %34))
    (mem (store-double %35 %1 mem)))
  (@atan-%173 mem %1)))

(defund @atan-%27 (mem %1)
  (b* (
    (%28 (load-double (getelementptr-double '(atanhi . 0) 3) mem))
    (%29 (load-double (getelementptr-double '(atanlo . 0) 3) mem))
    (%30 (fadd-double %28 %29))
    (mem (store-double %30 %1 mem)))
  (@atan-%173 mem %1)))

(defund @atan-%24 (mem %hx %1)
  (b* (
    (%25 (load-i32 %hx mem))
    (%26 (icmp-sgt-i32 %25 0)))
  (case %26
    (-1 (@atan-%27 mem %1))
    (0 (@atan-%31 mem %1)))))

(defund @atan-%20 (mem %1 %2)
  (b* (
    (%21 (load-double %2 mem))
    (%22 (load-double %2 mem))
    (%23 (fadd-double %21 %22))
    (mem (store-double %23 %1 mem)))
  (@atan-%173 mem %1)))

(defund @atan-%16 (mem %hx %1 %2)
  (b* (
    (%17 (bitcast-double*-to-i32* %2))
    (%18 (load-i32 %17 mem))
    (%19 (icmp-ne-i32 %18 0)))
  (case %19
    (-1 (@atan-%20 mem %1 %2))
    (0 (@atan-%24 mem %hx %1)))))

(defund @atan-%13 (mem %hx %ix %1 %2)
  (b* (
    (%14 (load-i32 %ix mem))
    (%15 (icmp-eq-i32 %14 2146435072)))
  (case %15
    (-1 (@atan-%16 mem %hx %1 %2))
    (0 (@atan-%24 mem %hx %1)))))

(defund @atan-%10 (mem %hx %ix %1 %2)
  (b* (
    (%11 (load-i32 %ix mem))
    (%12 (icmp-sgt-i32 %11 2146435072)))
  (case %12
    (-1 (@atan-%20 mem %1 %2))
    (0 (@atan-%13 mem %hx %ix %1 %2)))))

(defund @atan-%0 (mem %x)
  (b* (
    ((mv %1 mem) (alloca-double 'ret 1 mem))
    ((mv %2 mem) (alloca-double 'x 1 mem))
    ((mv %w mem) (alloca-double 'w 1 mem))
    ((mv %s1 mem) (alloca-double 's1 1 mem))
    ((mv %s2 mem) (alloca-double 's2 1 mem))
    ((mv %z mem) (alloca-double 'z 1 mem))
    ((mv %ix mem) (alloca-i32 'ix 1 mem))
    ((mv %hx mem) (alloca-i32 'hx 1 mem))
    ((mv %id mem) (alloca-i32 'id 1 mem))
    (mem (store-double %x %2 mem))
    (%3 (bitcast-double*-to-i32* %2))
    (%4 (getelementptr-i32 %3 1))
    (%5 (load-i32 %4 mem))
    (mem (store-i32 %5 %hx mem))
    (%6 (load-i32 %hx mem))
    (%7 (and-i32 %6 2147483647))
    (mem (store-i32 %7 %ix mem))
    (%8 (load-i32 %ix mem))
    (%9 (icmp-sge-i32 %8 1141899264)))
  (case %9
    (-1 (@atan-%10 mem %hx %ix %1 %2))
    (0 (@atan-%36 mem %hx %id %ix %s1 %s2 %w %z %1 %2)))))

(defund @atan (%x)
  (@atan-%0 *atan-globals* %x))
