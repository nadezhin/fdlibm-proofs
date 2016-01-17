(in-package "ACL2")

(include-book "tools/with-arith5-help" :dir :system)
(local (acl2::allow-arith5-help))
(local (in-theory (acl2::enable-arith5)))

(include-book "std/util/defrule" :dir :system)
(include-book "llvm-rec")
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
  (implies (and (wordp (nth ofs (g var mem)))
                (wordp (nth (1+ ofs) (g var mem))))
           (doublep (load-double (cons var ofs) mem)))
  :enable (addressp load-double))

(defrule store-double-type
  (implies (doublep d)
           (equal (store-double d (cons var ofs) mem)
                  (s
                   var
                   (update-nth
                    (1+ ofs)
                    (get-hi-double d)
                    (update-nth
                     ofs
                     (get-lo-double d)
                     (g var mem)))
                   mem)))
  :enable store-double)


(defrule getelementptr-i32-type
  (implies (and (addressp a)
                (i32p i))
           (addressp (getelementptr-i32 a i)))
  :enable (addressp i32p getelementptr-i32))

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

(defrule icmp-eq-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-eq-i32 x y)))
  :enable icmp-eq-i32)

(defrule icmp-slt-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-slt-i32 x y)))
  :enable icmp-slt-i32)

(defrule icmp-sge-i32-type
  (implies (and (i32p x)
                (i32p y))
           (i1p (icmp-sge-i32 x y)))
  :enable icmp-sge-i32)
