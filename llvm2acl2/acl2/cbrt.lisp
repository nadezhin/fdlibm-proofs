(in-package "ACL2")
(include-book "llvm/s_cbrt")

(defund @cbrt-%50-opt (%sign.0 %t.5 %x.1)
  (b* ((%53 (fmul-double %t.5 %t.5))
       (%r.0 (fdiv-double %53 %x.1))
       (%58 (fmul-double %r.0 %t.5))
       (%s.0 (fadd-double #x3FE15F15F15F15F1 %58))
       (%61 (fadd-double %s.0 #x3FF6A0EA0EA0EA0F))
       (%63 (fdiv-double #xBFE691DE2532C834 %s.0))
       (%64 (fadd-double %61 %63))
       (%65 (fdiv-double #x3FF9B6DB6DB6DB6E %64))
       (%66 (fadd-double #x3FD6DB6DB6DB6DB7 %65))
       (%t.6 (fmul-double %t.5 %66))
       (%t.7 (set-lo %t.6 0))
       (%72 (get-hi %t.7))
       (%73 (add-i32 %72 1))
       (%t.8 (set-hi %t.7 %73))
       (%s.0 (fmul-double %t.8 %t.8))
       (%r.1 (fdiv-double %x.1 %s.0))
       (%w.0 (fadd-double %t.8 %t.8))
       (%85 (fsub-double %r.1 %t.8))
       (%88 (fadd-double %w.0 %r.1))
       (%r.2 (fdiv-double %85 %88))
       (%93 (fmul-double %t.8 %r.2))
       (%t.9 (fadd-double %t.8 %93))
       (%98 (get-hi %t.9))
       (%99 (or-i32 %98 %sign.0))
       (%t.10 (set-hi %t.9 %99)))
    %t.10))

(defund @cbrt-%44-opt (%hx.1 %sign.0 %t.0 %x.1)
  (b* ((%46 (sdiv-i32 %hx.1 3))
       (%47 (add-i32 %46 715094163))
       (%t.4 (set-hi %t.0 %47)))
    (@cbrt-%50-opt %sign.0 %t.4 %x.1)))

(defund @cbrt-%31-opt (%sign.0 %t.0 %x.1)
  (b* ((%t.1 (set-hi %t.0 1129316352))
       (%t.2 (fmul-double %t.1 %x.1))
       (%39 (get-hi %t.2))
       (%40 (sdiv-i32 %39 3))
       (%41 (add-i32 %40 696219795))
       (%t.3 (set-hi %t.2 %41)))
    (@cbrt-%50-opt %sign.0 %t.3 %x.1)))

(defund @cbrt-%25-cond (%hx.1)
  (b* ()
    (icmp-slt-i32 %hx.1 1048576)))

(defund @cbrt-%25-opt (%hx.1 %sign.0 %t.0 %x.0)
  (b* ((%x.1 (set-hi %x.0 %hx.1))
       (%30 (icmp-slt-i32 %hx.1 1048576)))
    (if (not (= %30 0))
        (@cbrt-%31-opt %sign.0 %t.0 %x.1)
      (@cbrt-%44-opt %hx.1 %sign.0 %t.0 %x.1))))

(defund @cbrt-%23-opt (%x.0)
  (b* ()
    %x.0))

(defund @cbrt-%17-cond (%hx.1 %x.0)
  (b* ((%20 (get-lo %x.0))
       (%21 (or-i32 %hx.1 %20)))
    (icmp-eq-i32 %21 0)))

(defund @cbrt-%17-opt (%hx.1 %sign.0 %t.0 %x.0)
  (b* ((%20 (get-lo %x.0))
       (%21 (or-i32 %hx.1 %20))
       (%22 (icmp-eq-i32 %21 0)))
    (if (not (= %22 0))
        (@cbrt-%23-opt %x.0)
      (@cbrt-%25-opt %hx.1 %sign.0 %t.0 %x.0))))

(defund @cbrt-%13-opt (%x.0)
  (b* ((%16 (fadd-double %x.0 %x.0)))
    %16))

(defund @cbrt-%0-cond (%x.0)
  (b* ((%hx.0 (get-hi %x.0))
       (%sign.0 (and-i32 %hx.0 -2147483648))
       (%hx.1 (xor-i32 %hx.0 %sign.0)))
    (icmp-sge-i32 %hx.1 2146435072)))

(defund @cbrt-%0-hx1 (%x.0)
  (b* ((%hx.0 (get-hi %x.0))
       (%sign.0 (and-i32 %hx.0 -2147483648)))
    (xor-i32 %hx.0 %sign.0)))

(defund @cbrt-%0-opt (%x.0)
  (b* ((%t.0 #x0000000000000000)
       (%hx.0 (get-hi %x.0))
       (%sign.0 (and-i32 %hx.0 -2147483648))
       (%hx.1 (xor-i32 %hx.0 %sign.0))
       (%12 (icmp-sge-i32 %hx.1 2146435072)))
    (if (not (= %12 0))
        (@cbrt-%13-opt %x.0)
      (@cbrt-%17-opt %hx.1 %sign.0 %t.0 %x.0))))

(defund @cbrt-opt (%x)
  (@cbrt-%0-opt %x))
