(in-package "ACL2")

(include-book "tools/with-arith5-help" :dir :system)
(local (acl2::allow-arith5-help))
(local (in-theory (acl2::enable-arith5)))

(include-book "std/util/defrule" :dir :system)
(include-book "llvm")
(local (include-book "rtl/rel11/support/bits" :dir :system))
;(local (include-book "rtl/rel11/support/log" :dir :system))
(local (include-book "rtl/rel11/support/reps" :dir :system))
(local (include-book "ihs/logops-lemmas" :dir :system))

(local
 (defrule encodingp-forward-x
  (implies (rtl::encodingp x f)
           (natp x))
  :enable rtl::encodingp
  :rule-classes :forward-chaining))

(local
 (defrule encodingp-qnanize
   (implies
    (rtl::encodingp x f)
    (rtl::encodingp (rtl::qnanize x f) f))
   :prep-books ((include-book "rtl/rel11/lib/log" :dir :system))
   :enable (rtl::encodingp rtl::qnanize rtl::formatp rtl::explicitp rtl::sigw rtl::expw rtl::prec)
   :cases ((rtl::bvecp (expt 2 (- (rtl::prec f) 2)) (+ 1 (rtl::expw f) (rtl::sigw f))))
   :hints (("subgoal 2" :in-theory (enable rtl::bvecp)))))

(local
 (defrule encodingp-nencode
   (implies (and (rtl::formatp f))
            (rtl::encodingp (rtl::nencode u f) f))
   :enable (rtl::encodingp rtl::nencode)))

(local
 (defrule encodingp-dencode
   (implies (and (rtl::formatp f))
            (rtl::encodingp (rtl::dencode u f) f))
   :enable (rtl::encodingp rtl::dencode)))

(local
 (defrule encodingp-zencode
   (equal (rtl::encodingp (rtl::zencode sgn f) f)
          (rtl::formatp f))
   :enable (rtl::encodingp rtl::zencode)))

(local
 (defrule encodingp-iencode
   (equal (rtl::encodingp (rtl::iencode sgn f) f)
          (rtl::formatp f))
   :enable (rtl::encodingp rtl::iencode)))

(local
 (defrule encodingp-indef
   (equal (rtl::encodingp (rtl::indef f) f)
          (rtl::formatp f))
   :enable (rtl::encodingp rtl::indef)))

(local
 (defrule encodingp-sse-binary-pre-comp-val
   (implies
    (rtl::sse-binary-pre-comp-val op a b f)
    (rtl::encodingp
     (rtl::sse-binary-pre-comp-val op a b f)
     f))
   :cases ((rtl::formatp f))
   :hints (("subgoal 2" :in-theory (enable rtl::infp rtl::zerp)))))

(local
 (defrule encodingp-sse-round
   (implies (rtl::formatp f)
            (rtl::encodingp (mv-nth 0 (rtl::sse-round u m5::*mxcsr* f)) f))
   :disable (rtl::set-flag rtl::iencode)))

(local
 (defrule encodingp-sse-binary-post-comp
   (implies
    (rtl::formatp f)
    (rtl::encodingp (mv-nth 0 (rtl::sse-binary-post-comp op a b m5::*mxcsr* f))
                    f))
   :disable (rtl::sse-round rtl::iencode mv-nth)))

(local
 (defrule encodingp-sse-binary-spec
   (implies (and (member op '(rtl::add rtl::sub rtl::mul rtl::div))
                 (rtl::encodingp a f)
                 (rtl::encodingp b f))
            (rtl::encodingp
             (mv-nth 0 (rtl::sse-binary-spec op a b m5::*mxcsr* f))
             f))
   :disable (rtl::sse-binary-pre-comp-val
             rtl::sse-binary-pre-comp-excp
             rtl::sse-binary-post-comp
             mv-nth)))

(local
 (defrule encodingp-fp-binary
   (implies (and (member op '(rtl::add rtl::sub rtl::mul rtl::div))
                 (rtl::encodingp a f)
                 (rtl::encodingp b f))
            (rtl::encodingp (m5::fp-binary op a b f) f))
   :disable (rtl::sse-binary-spec mv-nth)))

(local
 (defrule i32p-int-fix
   (i32p (m5::int-fix x))
   :enable i32p))

(local
 (defruled i32p-as-signed-byte-p
   (equal (i32p x)
          (signed-byte-p 32 x))
   :enable i32p))

;----------

(local
 (defruled uint-fix-as-bits
   (equal (m5::uint-fix x)
          (rtl::bits (ifix x) 31 0))
   :enable rtl::bits-mod
   :disable mod))

(local
 (defruled double-fix-as-bits
   (equal (m5::double-fix x)
          (rtl::bits (ifix x) 63 0))
   :enable rtl::bits-mod
   :disable mod))

(defrule make-i32-get-lo-32
  (implies (i32p x)
           (equal (make-i32 (get-lo-i32 x))
                  x))
  :enable (get-lo-i32 make-i32 i32p wordp))

(defrule get-lo-i32-make-i32
  (implies (wordp w0)
           (equal (get-lo-i32 (make-i32 w0))
                  w0))
  :enable (get-lo-i32 make-i32 wordp i32p))

(local
 (defruled get-lo-double-as-bits
   (equal (get-lo-double d)
          (and (doublep d) (rtl::bits (ifix d) 31 0)))
   :enable (get-lo-double uint-fix-as-bits)
   :disable m5::uint-fix))

(local
 (with-arith5-help
  (defruled bits-shr
    (implies (and (integerp k)
                  (integerp i)
                  (natp j))
             (equal (rtl::bits (m5::shr x k) i j)
                    (rtl::bits x (+ i k) (+ j k))))
    :enable rtl::fl
    :disable floor
    :use rtl::bits-shift-down-1)))

(local
 (defruled get-hi-double-as-bits
   (equal (get-hi-double d)
          (and (doublep d) (rtl::bits (ifix d) 63 32)))
   :enable (get-hi-double uint-fix-as-bits bits-shr)
   :disable (m5::uint-fix m5::shr)))

(defrule make-double-get-hi-get-lo
  (implies (doublep d)
           (equal (make-double (get-hi-double d) (get-lo-double d))
                  d))
  :enable (make-double doublep rtl::encodingp rtl::dp)
  :disable (m5::double-fix m5::ulong-fix m5::shr)
  :cases ((and (wordp (get-hi-double d)) (wordp (get-lo-double d))))
  :hints
  (("subgoal 2" :in-theory (enable wordp get-lo-double get-hi-double))
   ("subgoal 1" :in-theory (enable get-hi-double-as-bits get-lo-double-as-bits))))

(defrule make-double-type
  (implies (and (wordp w0)
                (wordp w1))
           (doublep (make-double w1 w0)))
  :enable (doublep make-double rtl::encodingp rtl::dp))

(defrule get-hi-double-make-double
  (implies (and (wordp w1) (wordp w0))
           (equal (get-hi-double (make-double w1 w0))
                  w1))
  :enable (make-double get-hi-double-as-bits wordp rtl::bits rtl::fl)
  :use make-double-type)

(defrule get-lo-double-make-double
  (implies (and (wordp w1) (wordp w0))
           (equal (get-lo-double (make-double w1 w0))
                  w0))
  :enable (make-double get-lo-double-as-bits wordp rtl::bits rtl::fl)
  :use make-double-type)

;----------

(defrule get-lo-i32-type
  (implies (i32p i)
           (wordp (get-lo-i32 i)))
  :enable (wordp get-lo-i32))

(defrule make-i32-type
  (implies (wordp w0)
           (i32p (make-i32 w0)))
  :enable (i32p make-i32))

(defrule get-lo-double-type
  (implies (doublep d)
           (wordp (get-lo-double d)))
  :enable (wordp get-lo-double))

(defrule get-hi-double-type
  (implies (doublep d)
           (wordp (get-hi-double d)))
  :enable (wordp get-hi-double))

(defrule make-double-type
  (implies (and (wordp w0)
                (wordp w1))
           (doublep (make-double w1 w0)))
  :enable (doublep make-double rtl::encodingp rtl::dp))

(defrule load-double-type
  (implies (and (wordp (nth ofs (m5::binding var mem)))
                (wordp (nth (1+ ofs) (m5::binding var mem))))
;  (implies (and (wordp (nth ofs (g var mem)))
;                (wordp (nth (1+ ofs) (g var mem))))
           (doublep (load-double (cons var ofs) mem)))
  :enable (addressp load-double))
#|
(defrule store-double-type
  (implies (doublep d)
           (equal (store-double d (cons var ofs) mem)
                  (m5::bind
;                  (s
                   var
                   (update-nth
                    (1+ ofs)
                    (get-hi-double d)
                    (update-nth
                     ofs
                     (get-lo-double d)
                     (m5::binding var mem)))
;                     (g var mem)))
                   mem)))
  :enable store-double)
|#

(defrule getelementptr-i32-type
  (implies (and (addressp a)
                (i64p i))
           (addressp (getelementptr-i32 a i)))
  :enable (addressp i64p getelementptr-i32))

(defrule bitcast-double*-to-i32*-type
  (implies (addressp a)
           (addressp (bitcast-double*-to-i32* a)))
  :enable  bitcast-double*-to-i32*)

(defrule fadd-double-type
  (implies (and (doublep x)
                (doublep y))
           (doublep (fadd-double x y)))
  :enable (doublep fadd-double)
  :disable (m5::fp-binary))

(defrule fsub-double-type
  (implies (and (doublep x)
                (doublep y))
           (doublep (fsub-double x y)))
  :enable (doublep fsub-double)
  :disable (m5::fp-binary))

(defrule fmul-double-type
  (implies (and (doublep x)
                (doublep y))
           (doublep (fmul-double x y)))
  :enable (doublep fmul-double)
  :disable (m5::fp-binary))

(defrule fdiv-double-type
  (implies (and (doublep x)
                (doublep y))
           (doublep (fdiv-double x y)))
  :enable (doublep fdiv-double)
  :disable (m5::fp-binary))

(defrule add-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (add-i32 x y)))
  :enable add-i32
  :disable m5::int-fix)

(defrule sub-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (sub-i32 x y)))
  :enable sub-i32
  :disable m5::int-fix)

(defrule sdiv-i32-type
  (implies (and (i32p x)
                (i32p y)
                (not (= y 0)))
           (i32p (sdiv-i32 x y)))
  :enable sdiv-i32
  :disable m5::int-fix)

(defrule and-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (and-i32 x y)))
  :enable (i32p-as-signed-byte-p and-i32))

(defrule or-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (or-i32 x y)))
  :enable (i32p-as-signed-byte-p or-i32))

(defrule xor-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (xor-i32 x y)))
  :enable (i32p-as-signed-byte-p xor-i32))

(defrule shl-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (shl-i32 x y)))
  :enable shl-i32
  :disable m5::int-fix)

(defrule lshr-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (lshr-i32 x y)))
  :enable lshr-i32
  :disable m5::int-fix)

(defrule ashr-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i32p (ashr-i32 x y)))
  :enable ashr-i32
  :disable m5::int-fix)

(defrule icmp-eq-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-eq-i32 x y)))
  :enable icmp-eq-i32)

(defrule icmp-ne-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-ne-i32 x y)))
  :enable icmp-ne-i32)

(defrule icmp-slt-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-slt-i32 x y)))
  :enable icmp-slt-i32)

(defrule icmp-sle-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-sle-i32 x y)))
  :enable icmp-sle-i32)

(defrule icmp-sgt-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-sgt-i32 x y)))
  :enable icmp-sgt-i32)

(defrule icmp-sge-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-sge-i32 x y)))
  :enable icmp-sge-i32)

(defrule icmp-ult-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-ult-i32 x y)))
  :enable icmp-ult-i32)

(defrule icmp-ule-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-ule-i32 x y)))
  :enable icmp-ule-i32)

(defrule icmp-ugt-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-ugt-i32 x y)))
  :enable icmp-ugt-i32)

(defrule icmp-uge-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-uge-i32 x y)))
  :enable icmp-uge-i32)

(defruled i1p=-1
  (implies (i1p x)
           (equal (equal x -1)
                  (not (equal x 0))))
  :enable i1p)

;--------

(defrule get-lo-type
  (implies (doublep d)
           (i32p (get-lo d)))
  :enable get-lo)

(defrule get-hi-type
  (implies (doublep d)
           (i32p (get-hi d)))
  :enable get-hi)

(defrule set-lo-type
  (implies (and (doublep d)
                (i32p lo))
           (doublep (set-lo d lo)))
  :enable set-lo)

(defrule set-hi-type
  (implies (and (doublep d)
                (i32p hi))
           (doublep (set-hi d hi)))
  :enable set-hi)
