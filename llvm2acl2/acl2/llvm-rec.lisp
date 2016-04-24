(in-package "ACL2")
(include-book "std/util/bstar" :dir :system)
(include-book "misc/records" :dir :system)
(include-book "models/jvm/m5/m5" :dir :system)

(defund addressp (a)
  (and (consp a)
       (symbolp (car a))
       (integerp (cdr a))))

(defund wordp (w)
  (and (natp w) (< w (expt 2 32))))

(defund i1p (x)
  (and (integerp x)
       (<= (- (expt 2 0)) x)
       (< x (expt 2 0))))

(defund i32p (x)
  (and (integerp x)
       (<= (- (expt 2 31)) x)
       (< x (expt 2 31))))

(defund i64p (x)
  (and (integerp x)
       (<= (- (expt 2 63)) x)
       (< x (expt 2 63))))

(defund get-lo-i32 (x)
  (and (i32p x) (m5::uint-fix x)))

(defund make-i32 (w0)
  (and (wordp w0) (m5::int-fix w0)))

(defund doublep (x)
  (rtl::encodingp x (rtl::dp)))

(defund get-lo-double (d)
  (and (doublep d) (m5::uint-fix d)))

(defund get-hi-double (d)
  (and (doublep d) (m5::uint-fix (m5::shr (ifix d) 32))))

(defund make-double (w1 w0)
  (and (wordp w1) (wordp w0) (rtl::cat w1 32 w0 32)))

(defund alloca-double (var n mem)
  (s var (make-list (* 2 n)) mem))

(defund alloca-i32 (var n mem)
  (s var (make-list n) mem))

(defund alloca-pointer (var mem)
  (s var '(nil) mem))

(defund store-double (d a mem)
  (let* ((var (car a))
         (ofs (cdr a))
         (old (g var mem))
         (w0 (and (doublep d) (get-lo-double d)))
         (w1 (and (doublep d) (get-hi-double d)))
         (new (update-nth (1+ ofs) w1 (update-nth ofs w0 old))))
    (s var new mem)))

(defund store-i32 (i a mem)
  (let* ((var (car a))
         (ofs (cdr a))
         (old (g var mem))
         (w0 (and (i32p i) (get-lo-i32 i)))
         (new (update-nth ofs w0 old)))
    (s var new mem)))

(defund store-pointer (p a mem)
  (let* ((var (car a))
         (ofs (cdr a))
         (old (g var mem))
         (w0 (and (addressp p) p))
         (new (update-nth ofs w0 old)))
    (s var new mem)))

(defund load-double (a mem)
  (let* ((var (car a))
         (ofs (cdr a))
         (val (g var mem))
         (w0 (nth ofs val))
         (w1 (nth (1+ ofs) val)))
    (and (wordp w0) (wordp w1) (make-double w1 w0))))

(defund load-i32 (a mem)
  (let* ((var (car a))
         (ofs (cdr a))
         (val (g var mem))
         (w0 (nth ofs val)))
    (and (wordp w0) (make-i32 w0))))

(defund load-pointer (a mem)
  (let* ((var (car a))
         (ofs (cdr a))
         (val (g var mem))
         (w0 (nth ofs val)))
    (and (addressp w0) w0)))

(defund getelementptr-double (a i)
  (and (addressp a)
       (i64p i)
       (cons (car a) (+ (cdr a) (* 2 i)))))

(defund getelementptr-i32 (a i)
  (and (addressp a)
       (i64p i)
       (cons (car a) (+ (cdr a) i))))

(defund bitcast-double*-to-i32* (a)
  (and (addressp a) a))

(defund sext-i32-to-i64 (x)
  (and (i32p x) x))

(defund zext-i32-to-i64 (x)
  (and (i32p x) (m5::ulong-fix x)))

(defund fptosi-double-to-i32 (x)
  (and (doublep x) (m5::fp2int x (rtl::dp) 32)))

(defund sitofp-i32-to-double (x)
  (and (i32p x) (m5::int2fp x (rtl::dp))))

(defund fadd-double (x y)
  (and (doublep x) (doublep y) (m5::fpadd x y (rtl::dp))))

(defund fsub-double (x y)
  (and (doublep x) (doublep y) (m5::fpsub x y (rtl::dp))))

(defund fmul-double (x y)
  (and (doublep x) (doublep y) (m5::fpmul x y (rtl::dp))))

(defund fdiv-double (x y)
  (and (doublep x) (doublep y) (m5::fpdiv x y (rtl::dp))))

(defund fcmp-oeq-double (x y)
  (and (doublep x) (doublep y) (if (= (m5::fpcmp x y (rtl::dp) -1) 0) -1 0)))

(defund fcmp-oge-double (x y)
  (and (doublep x) (doublep y) (if (>= (m5::fpcmp x y (rtl::dp) -1) 0) -1 0)))

(defund fcmp-ogt-double (x y)
  (and (doublep x) (doublep y) (if (equal (m5::fpcmp x y (rtl::dp) -1) +1) -1 0)))

(defund fcmp-ole-double (x y)
  (and (doublep x) (doublep y) (if (<= (m5::fpcmp x y (rtl::dp) +1) 0) -1 0)))

(defund fcmp-olt-double (x y)
  (and (doublep x) (doublep y) (if (equal (m5::fpcmp x y (rtl::dp) +1) -1) -1 0)))

(defund add-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (+ x y))))

(defund sub-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (- x y))))

(defund mul-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (* x y))))

(defund sdiv-i32 (x y)
  (and (i32p x) (i32p y) (not (= y 0)) (m5::int-fix (truncate x y))))

(defund and-i32 (x y)
  (and (i32p x) (i32p y) (logand x y)))

(defund or-i32 (x y)
  (and (i32p x) (i32p y) (logior x y)))

(defund xor-i32 (x y)
  (and (i32p x) (i32p y) (logxor x y)))

(defund shl-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (m5::shl x (m5::5-bit-fix y)))))

(defund lshr-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (m5::shr (m5::uint-fix x) (m5::5-bit-fix y)))))

(defund ashr-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (m5::shr x (m5::5-bit-fix y)))))

(defund icmp-eq-i32 (x y)
  (and (i32p x) (i32p y) (if (= x y) -1 0)))

(defund icmp-ne-i32 (x y)
  (and (i32p x) (i32p y) (if (not (= x y)) -1 0)))

(defund icmp-slt-i32 (x y)
  (and (i32p x) (i32p y) (if (< x y) -1 0)))

(defund icmp-sle-i32 (x y)
  (and (i32p x) (i32p y) (if (<= x y) -1 0)))

(defund icmp-sgt-i32 (x y)
  (and (i32p x) (i32p y) (if (> x y) -1 0)))

(defund icmp-sge-i32 (x y)
  (and (i32p x) (i32p y) (if (>= x y) -1 0)))

(defund icmp-ult-i32 (x y)
  (and (i32p x) (i32p y) (if (< (m5::uint-fix x) (m5::uint-fix y)) -1 0)))

(defund icmp-ule-i32 (x y)
  (and (i32p x) (i32p y) (if (<= (m5::uint-fix x) (m5::uint-fix y)) -1 0)))

(defund icmp-ugt-i32 (x y)
  (and (i32p x) (i32p y) (if (> (m5::uint-fix x) (m5::uint-fix y)) -1 0)))

(defund icmp-uge-i32 (x y)
  (and (i32p x) (i32p y) (if (>= (m5::uint-fix x) (m5::uint-fix y)) -1 0)))

(defund select-double (x y z)
  (and (i1p x) (doublep y) (doublep z) (if (not (= x 0)) y z)))

;--------

(defund get-lo (d)
  (make-i32 (get-lo-double d)))

(defund get-hi (d)
  (make-i32 (get-hi-double d)))

(defund set-lo (d lo)
  (make-double (get-hi-double d) (get-lo-i32 lo)))

(defund set-hi (d hi)
  (make-double (get-lo-i32 hi) (get-lo-double d)))
