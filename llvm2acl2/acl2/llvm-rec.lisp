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

(defund get-lo-i32 (x)
  (m5::uint-fix x))

(defund make-i32 (w0)
  (and (wordp w0) (m5::int-fix w0)))

(defund doublep (x)
  (rtl::encodingp x (rtl::dp)))

(defund get-lo-double (d)
  (m5::uint-fix d))

(defund get-hi-double (d)
  (m5::uint-fix (m5::shr (ifix d) 32)))

(defund make-double (w1 w0)
  (and (wordp w1) (wordp w0) (rtl::cat w1 32 w0 32)))

(defund alloca-double-1 (var mem)
  (mv (cons var 0) (s var '(nil nil) mem)))

(defund alloca-i32-1 (var mem)
  (mv (cons var 0) (s var '(nil) mem)))

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

(defund getelementptr-i32 (a i)
  (and (addressp a)
       (i32p i)
       (cons (car a) (+ (cdr a) i))))

(defund bitcast-double*-to-i32* (a)
  (and (addressp a) a))

(defund fadd-double (x y)
  (and (doublep x) (doublep y) (m5::fpadd x y (rtl::dp))))

(defund fsub-double (x y)
  (and (doublep x) (doublep y) (m5::fpsub x y (rtl::dp))))

(defund fmul-double (x y)
  (and (doublep x) (doublep y) (m5::fpmul x y (rtl::dp))))

(defund fdiv-double (x y)
  (and (doublep x) (doublep y) (m5::fpdiv x y (rtl::dp))))

(defund add-i32 (x y)
  (and (i32p x) (i32p y) (m5::int-fix (+ x y))))

(defund sdiv-i32 (x y)
  (and (i32p x) (i32p y) (not (= y 0)) (m5::int-fix (/ x y))))

(defund and-i32 (x y)
  (and (i32p x) (i32p y) (logand x y)))

(defund or-i32 (x y)
  (and (i32p x) (i32p y) (logior x y)))

(defund xor-i32 (x y)
  (and (i32p x) (i32p y) (logxor x y)))

(defund icmp-eq-i32 (x y)
  (and (i32p x) (i32p y) (if (= x y) -1 0)))

(defund icmp-slt-i32 (x y)
  (and (i32p x) (i32p y) (if (< x y) -1 0)))

(defund icmp-sge-i32 (x y)
  (and (i32p x) (i32p y) (if (>= x y) -1 0)))

