(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)

(include-book "tools/with-arith5-help" :dir :system)
(local (acl2::allow-arith5-help))
;(local (in-theory (acl2::enable-arith5)))

(include-book "std/util/bstar" :dir :system)
(include-book "misc/records" :dir :system)
(include-book "models/jvm/m5/m5" :dir :system)

(include-book "llvm")
(local (include-book "rtl/rel11/lib/basic" :dir :system))
(local (include-book "rtl/rel11/lib/bits" :dir :system))
(local (include-book "rtl/rel11/lib/log" :dir :system))


(defrule len-push
  (equal (len (m5::push x stack))
         (1+ (len stack)))
  :enable m5::push)

(defrule pop-cons
  (equal (m5::pop (cons head tail)) tail)
  :enable m5::pop)

(defrule top-cons
  (equal (m5::top (cons head tail)) head)
  :enable m5::top)
#|
(defruled int-fix-long-fix
  (equal (m5::int-fix (m5::long-fix x))
         (m5::int-fix x))
  :enable (m5::int-fix)
  :disable mod)
|#
(defrule bind-formals-0
  (equal (m5::bind-formals 0 stack) ()))

(defrule call-stack-make-thread
  (equal (m5::call-stack
          th
          (m5::make-state
           (m5::bind th (m5::make-thread call-stack status rref) tt)
           heap
           class-table
           options))
         call-stack))

(defrule status-make-thread
  (equal (m5::status
          th
          (m5::make-state
           (m5::bind th (m5::make-thread call-stack status rref) tt)
           heap
           class-table
           options))
         status))

(defrule rref-make-thread
  (equal (m5::rref
          th
          (m5::make-state
           (m5::bind th (m5::make-thread call-stack status rref) tt)
           heap
           class-table
           options))
         rref))

(in-theory (disable m5::make-thread m5::call-stack m5::status m5::rref))
(in-theory (disable m5::class-decl-cp m5::class-decl-methods m5::class-decl-heapref))

;;;;;;;;;;;;;;;;;;;;;

; u/s-fix-default

(defrule u-fix-0
  (equal (m5::u-fix 0 n) 0))

(defrule s-fix-0
  (equal (m5::s-fix 0 n) 0))

(with-arith5-help
 (defrule u-fix-default
   (implies (or (not (integerp x))
                (zp n))
            (equal (m5::u-fix x n) 0))))

(with-arith5-help
 (defrule s-fix-default
   (implies (or (not (integerp x))
                (zp n))
            (equal (m5::s-fix x n) 0))))

(defrule byte-fix-default
  (implies (not (integerp x))
           (equal (m5::byte-fix x) 0)))

(defrule ubyte-fix-default
  (implies (not (integerp x))
           (equal (m5::ubyte-fix x) 0)))

(defrule short-fix-default
  (implies (not (integerp x))
           (equal (m5::short-fix x) 0)))

(defrule int-fix-default
  (implies (not (integerp x))
           (equal (m5::int-fix x) 0))
  :enable m5::int-fix)

(defrule uint-fix-default
  (implies (not (integerp x))
           (equal (m5::uint-fix x) 0)))

(defrule long-fix-default
  (implies (not (integerp x))
           (equal (m5::long-fix x) 0)))

(defrule ulong-fix-default
  (implies (not (integerp x))
           (equal (m5::ulong-fix x) 0)))

(defrule char-fix-default_
  (implies (not (integerp x))
           (equal (m5::char-fix x) 0)))

(defrule float-fix-default
  (implies (not (integerp x))
           (equal (m5::float-fix x) 0)))

(defrule double-fix-default
  (implies (not (integerp x))
           (equal (m5::double-fix x) 0)))

; u/s-fix-type

(with-arith5-help
 (defrule u-fix-type
   (natp (m5::u-fix x n))
   :rule-classes :type-prescription))

(with-arith5-help
 (defrule s-fix-type
   (integerp (m5::s-fix x n))
   :rule-classes :type-prescription))

(defrule byte-fix-type
  (integerp (m5::byte-fix x))
  :rule-classes :type-prescription)

(defrule ubyte-fix-type
  (natp (m5::ubyte-fix x))
  :rule-classes :type-prescription)

(defrule short-fix-type
  (integerp (m5::short-fix x))
  :rule-classes :type-prescription)

(defrule int-fix-type
  (integerp (m5::int-fix x))
  :rule-classes :type-prescription)

(defrule uint-fix-type
  (natp (m5::uint-fix x))
  :rule-classes :type-prescription)

(defrule long-fix-type
  (integerp (m5::long-fix x))
  :rule-classes :type-prescription)

(defrule ulong-fix-type
  (natp (m5::ulong-fix x))
  :rule-classes :type-prescription)

(defrule char-fix-type
  (natp (m5::char-fix x))
  :rule-classes :type-prescription)

; u/s-fix-range

(defrule u-fix-range
  (< (m5::u-fix x n) (expt 2 n))
  :rule-classes :linear)

(with-arith5-nonlinear-help
 (defrule s-fix-range
   (and (<= (- (expt 2 (1- n))) (m5::s-fix x n))
        (< (m5::s-fix x n) (expt 2 (1- n))))
   :rule-classes :linear))

(defrule byte-fix-range
  (and (<= #x-80 (m5::byte-fix x))
       (< (m5::byte-fix x) #x80))
  :rule-classes :linear)

(defrule ubyte-fix-range
  (< (m5::ubyte-fix x) #x100)
  :rule-classes :linear)

(defrule short-fix-range
  (and (<= #x-8000 (m5::byte-fix x))
       (< (m5::byte-fix x) #x8000))
  :rule-classes :linear)

(defrule int-fix-range
  (and (<= #x-80000000 (m5::int-fix x))
       (< (m5::int-fix x) #x80000000))
  :enable m5::int-fix
  :rule-classes :linear)

(defrule uint-fix-range
  (< (m5::uint-fix x) #x100000000)
  :rule-classes :linear)

(defrule long-fix-range
  (and (<= #x-8000000000000000 (m5::long-fix x))
       (< (m5::long-fix x) #x8000000000000000))
  :rule-classes :linear)

(defrule ulong-fix-range
  (< (m5::ulong-fix x) #x10000000000000000)
  :rule-classes :linear)

(defrule char-fix-range
  (< (m5::char-fix x) #x10000)
  :rule-classes :linear)

;;; u/s-fix do nothing

(defrule u-fix-do-nothing
  (implies (and (natp x)
                (< x (expt 2 n)))
           (equal (m5::u-fix x n)
                  x)))

(with-arith5-nonlinear-help
 (defrule s-fix-do-nothing
   (implies (and (integerp x)
                 (integerp n)
                 (<= (- (expt 2 (1- n))) x)
                 (< x (expt 2 (1- n))))
            (equal (m5::s-fix x n)
                   x))))

;;; s-fix-u-fix

(defrule u-fix-u-fix
  (implies (and (integerp m)
                (integerp n))
           (equal (m5::u-fix (m5::u-fix x m) n)
                  (m5::u-fix x (min m n))))
  :prep-lemmas (
    (with-arith5-help
     (defrule lemma1
       (implies (and (posp m)
                     (posp n)
                     (<= m n)
                     (integerp x))
                (equal (m5::u-fix (m5::u-fix x m) n)
                       (m5::u-fix x m)))
       :cases ((not (< (mod x (expt 2 m)) (expt 2 m)))
               (not (<= (expt 2 m) (expt 2 n))))))
    (defrule lemma2
      (implies (and (posp m)
                    (posp n)
                    (> m n)
                    (integerp x))
               (equal (m5::u-fix (m5::u-fix x m) n)
                      (m5::u-fix x n)))
      :enable rtl::mod-of-mod-cor))
  :disable m5::u-fix
  :use (lemma1 lemma2))

(defruled s-fix-as-u-fix-if
  (equal (m5::s-fix x n)
         (let ((ufix (m5::u-fix x n)))
           (if (< ufix (expt 2 (1- n))) ufix (- ufix (expt 2 n))))))

(defruled u-fix-as-s-fix-if
  (equal (m5::u-fix x n)
         (let ((sfix (m5::s-fix x n)))
           (if (>= sfix 0) sfix (+ sfix (expt 2 n))))))

(with-arith5-nonlinear-help
 (defruled s-fix-as-u-fix-mod
   (implies (and (integerp x)
                 (posp n))
            (equal (m5::s-fix x n)
                   (- (m5::u-fix (+ x (expt 2 (1- n))) n) (expt 2 (1- n)))))))

(defruled s-fix-u-fix
  (implies (and (integerp m)
                (integerp n))
           (equal (m5::s-fix (m5::u-fix x n) m)
                  (if (<= m n) (m5::s-fix x m) (m5::u-fix x n))))
  :enable (s-fix-as-u-fix-if expt-is-weakly-increasing-for-base->-1)
  :disable m5::u-fix
  :cases ((<= n (1- m))))

(defrule s-fix-s-fix
  (implies (and (integerp m) (integerp n))
           (equal (m5::s-fix (m5::s-fix x m) n)
                  (m5::s-fix x (min m n))))
  :prep-lemmas (
     (defrule lemma1
       (implies (and (posp m)
                     (posp n)
                     (<= m n)
                     (integerp x))
                (equal (m5::s-fix (m5::s-fix x m) n)
                       (m5::s-fix x m)))
       :disable m5::s-fix
       :use ((:instance s-fix-do-nothing
                        (x (m5::s-fix x m)))
             (:instance s-fix-range
                        (x x)
                        (n m))
             (:instance expt-is-weakly-increasing-for-base->-1
                        (x 2)
                        (m (1- m))
                        (n (1- n)))))
     (with-arith5-help
     (defrule lemma2
       (implies (and (posp m)
                     (posp n)
                     (> m n)
                     (integerp x))
                (equal (m5::s-fix (m5::s-fix x m) n)
                       (m5::s-fix x n)))
       :enable rtl::mod-of-mod-cor)))
  :disable (m5::s-fix m5::u-fix)
  :use (lemma1 lemma2))

(defrule u-fix-s-fix
  (implies (and (integerp m) (integerp n))
           (equal (m5::u-fix (m5::s-fix x m) n)
                  (if (>= m n)
                      (m5::u-fix x n)
                    (let ((sfix (m5::s-fix x m)))
                      (if (>= sfix 0) sfix (+ (expt 2 n) sfix))))))
  :enable u-fix-as-s-fix-if
  :disable (m5::u-fix m5::s-fix))

(defrule get-lo-double-double-fix
  (equal (get-lo-double (m5::double-fix x))
         (get-lo-double x))
  :enable (get-lo-double m5::double-fix)
  :disable M5::u-fix)

(with-arith5-help  ; TODO remove
 (defrule get-hi-double-double-fix
   (equal (get-hi-double (m5::double-fix x))
          (get-hi-double x))
   :enable (get-hi-double m5::double-fix)))

(with-arith5-help ; TODO remove
 (defrule get-hi-double-ulong-fix
  (equal (get-hi-double (m5::ulong-fix x))
         (get-hi-double x))
  :enable get-hi-double))
#|
(defrule make-double-1-long-fix
  (equal (make-double (m5::long-fix hi) lo)
         (make-double hi lo))
  :enable (make-double rtl::binary-cat rtl::bits))

(defrule make-double-1-ulong-fix
  (equal (make-double (m5::ulong-fix hi) lo)
         (make-double hi lo))
  :enable (make-double rtl::binary-cat rtl::bits))

(with-arith5-nonlinear-help
 (defrule make-double-1-int-fix
   (equal (make-double (m5::int-fix hi) lo)
          (make-double hi lo))
   :enable (make-double rtl::binary-cat rtl::bits m5::int-fix)))

(defrule make-double-1-uint-fix
  (equal (make-double (m5::uint-fix hi) lo)
         (make-double hi lo))
  :enable (make-double rtl::binary-cat rtl::bits))

(defrule make-double-2-long-fix
  (equal (make-double hi (m5::long-fix lo))
         (make-double hi lo))
  :enable (make-double rtl::binary-cat rtl::bits))

(defrule make-double-2-ulong-fix
  (equal (make-double hi (m5::ulong-fix lo))
         (make-double hi lo))
  :enable (make-double rtl::binary-cat rtl::bits))

(with-arith5-nonlinear-help ; TODO remove
 (defrule make-double-2-int-fix
   (equal (make-double hi (m5::int-fix lo))
          (make-double hi lo))
   :enable (make-double rtl::binary-cat rtl::bits m5::int-fix)))

(defrule make-double-2-uint-fix
  (equal (make-double hi (m5::uint-fix lo))
         (make-double hi lo))
  :enable (make-double rtl::binary-cat rtl::bits))
|#

(defruled u-fix-logand
  (equal (m5::u-fix (logand x y) n)
         (logand (m5::u-fix x n) (m5::u-fix y n)))
  :disable (floor mod)
  :use rtl::logand-mod
  :cases ((not (integerp x))
          (not (integerp y)))
  :hints (("subgoal 2" :in-theory (enable rtl::logand-def))
          ("subgoal 1" :in-theory (enable rtl::logand-def))))
#|
(defruled s-fix-logand
  (equal (m5::s-fix (logand x y) n)
         (logand (m5::u-fix x n) (m5::u-fix y n)))
  :enable (s-fix-as-u-fix-if)
  :disable (m5::s-fix m5::u-fix)
  :use u-fix-logand
  :do-not-induct t)

(defrule and-i32-1-int-fix
  (equal (and-i32 (m5::int-fix x) y)
         (and-i32 x y))
  :enable (and-i32 u-fix-logand)
  :disable (m5::s-fix m5::u-fix)
  :use ((:instance s-fix-u-fix
                   (x (LOGAND Y (M5::S-FIX X 32)))
                   (m 32)
                  (n 32))
        (:instance s-fix-u-fix
                   (x (LOGAND x y))
                   (m 32)
                  (n 32))))
|#
(defruled uint-fix-as-bits
  (equal (m5::uint-fix x)
         (rtl::bits (ifix x) 31 0))
  :enable rtl::bits-mod
  :disable mod)

(defruled ulong-fix-as-bits
  (equal (m5::ulong-fix x)
         (rtl::bits (ifix x) 63 0))
  :enable rtl::bits-mod
  :disable mod)

(defruled double-fix-as-bits
  (equal (m5::double-fix x)
         (rtl::bits (ifix x) 63 0))
  :enable rtl::bits-mod
  :disable mod)

(defruled get-lo-double-as-bits
  (equal (get-lo-double d)
         (rtl::bits (ifix d) 31 0))
  :enable (get-lo-double uint-fix-as-bits)
  :disable m5::uint-fix)

(with-arith5-help
 (defruled bits-shr
   (implies (and (integerp k)
                 (integerp i)
                 (natp j))
            (equal (rtl::bits (m5::shr x k) i j)
                   (rtl::bits x (+ i k) (+ j k))))
   :enable rtl::fl
   :disable floor
   :use rtl::bits-shift-down-1))

(defruled get-hi-double-as-bits
  (equal (get-hi-double d)
         (rtl::bits (ifix d) 63 32))
  :enable (get-hi-double uint-fix-as-bits bits-shr)
  :disable (m5::uint-fix m5::shr))
#|
(defrule make-double-get-hi-get-lo
  (equal (make-double (get-hi-double d) (get-lo-double d))
         (m5::double-fix d))
  :enable (make-double double-fix-as-bits
                       get-hi-double-as-bits get-lo-double-as-bits)
  :disable (m5::double-fix m5::ulong-fix m5::shr))
|#
