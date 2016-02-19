; http://www.computationallogic.com/software/djvm/html-0.5/arith.html

(in-package "ACL2")
(include-book "data-structures/deflist" :dir :system)
(include-book "std/lists/list-fix" :dir :system)
(include-book "std/osets/primitives" :dir :system)
(include-book "std/osets/delete" :dir :system)
(include-book "std/osets/sort" :dir :system)
(include-book "std/osets/intersect" :dir :system)
(include-book "std/osets/difference" :dir :system)
(include-book "defsort/duplicated-members" :dir :system)
(local (include-book "centaur/gl/gl" :dir :system))

; Define 32-bit Integer Arithmetic

;This appendix describes the bounded, 2's-compliment arithmetic used by the Defensive Java Virtual Machine (dJVM).

; Some Facts About Arithmetic

;This section contains some basic facts about integer arithmetic. We add these rules to the standard ACL2 rule-base to support the proof of the guard-conjectures generated while defining the dJVM model.

;Type-prescription rules

;Although ACL2 handles integers, rationals, and complex numbers, our model only deals with integers. So we define some rules to handle this restricted case. Defining these rules avoids more general arithmetic-reasoning in many of our proofs.

(defthm integerp-+-integerp
  (implies (and (integerp x)
                (integerp y))
           (integerp (+ x y)))
  :rule-classes (:rewrite :type-prescription))

(defthm integerp-difference-integerp
  (implies (and (integerp x)
                (integerp y))
           (integerp (- x y)))
  :rule-classes (:rewrite :type-prescription))

(defthm integerp-*-integerp
  (implies (and (integerp x)
                (integerp y))
           (integerp (* x y)))
  :rule-classes (:rewrite :type-prescription))

(defthm integerp-minus
  (implies (integerp x)
           (integerp (- x)))
  :rule-classes (:rewrite :type-prescription))

(defthm rationalp-if-integerp
  (implies (integerp x)
           (rationalp x)))


;The predicate acl2-numberp recognizes all forms of numbers acceptable to ACL2, including rational and complex-rational numbers. This back-chaining rule will prompt ACL2 to check whether a term is known to have an integer value when trying to prove that the term is an ACL2 number.

(defthm acl2-number-p-if-integerp
  (implies (integerp x)
           (acl2-numberp x)))

(defmacro  naturalp (n)
  `(and (integerp ,n)
        (<= 0 ,n)))

(defmacro  positive-integer-p (n)
  `(and (integerp ,n)
        (< 0 ,n)))

(deflist naturalp-listp (l)
  naturalp)

(in-theory (disable naturalp-listp-true-listp))

(deflist positive-integer-listp (l)
  positive-integer-p)

(in-theory (disable positive-integer-listp-true-listp))

; Bounded Naturals

; These predicates will be used to recognize lists of numbers that can be used as indices into a data structure. For example, if the upper bound is the number of local variables in a frame, then all the elements of the list are valid indices for accessing local variables in the frame.


(defun bounded-natural-p (x lub)
  "Recognizes a natural number less than the given upper-bound."
  (declare (xargs :guard t))
  (and (naturalp x)
       (naturalp lub)
       (< x lub)))

(defun bounded-naturals-listp (lst lub)
  "Recognizes lists of naturals, each less than the given upper-bound."
  (if (atom lst)
      (equal lst nil)
    (and (bounded-natural-p (car lst) lub)
         (bounded-naturals-listp (cdr lst) lub))))

(defthm car-bounded-naturals-listp
  (implies (and (bounded-naturals-listp lst lub)
                (consp lst))
           (bounded-natural-p (car lst) lub)))

(defthm cdr-bounded-naturals-listp
  (implies (bounded-naturals-listp lst lub)
           (bounded-naturals-listp (cdr lst) lub)))

(defthm bounded-naturals-listp-true-listp
  (implies (bounded-naturals-listp lst lub)
           (true-listp lst))
  :rule-classes (:rewrite :forward-chaining))

(in-theory (disable (:rewrite bounded-naturals-listp-true-listp)))

; Recognizers for Bounded Integers

; This section defines recognizers for n-bit signed and unsigned 2's complement integers.

(defun n-bit-integer-p (x n-bits)
  (declare (xargs :guard t))
  (and (integerp x)
       (integerp n-bits)
       (let ((limit (expt 2 (1- n-bits))))
         (and (<= (- limit) x)
              (<  x limit)))))

(defun n-bit-unsigned-integer-p
 (x n-bits)
  (declare (xargs :guard t))
  (and (integerp x)
       (integerp n-bits)
       (let ((limit (expt 2 n-bits)))
         (and (<= 0 x)
              (<  x limit)))))

(defthm integer-p-if-n-bit-integer-p
  (implies (n-bit-integer-p x n)
           (integerp x)))

(defthm natural-p-if-n-bit-unsigned-integer-p
  (implies (n-bit-unsigned-integer-p x n)
           (naturalp x)))

;Predicates named in style of XXX-VALUE-P are recognizers for value of the type XXX. Those named in the style of XXX-P are recognizeers for tagged values of the type XXX. (See section [sec:tagged-values], page [sec:tagged-values], for more discussion of tagged values.)

(defun byte-value-p (x)
  "Recognize an 8-bit signed integer."
  (declare (xargs :guard t))
  (n-bit-integer-p x 8))

(defun short-value-p (x)
  "Recognize a 16-bit signed integer."
  (declare (xargs :guard t))
  (n-bit-integer-p x 16))

(defun int-value-p (x)
  "Recognize a 32-bit signed integer."
  (declare (xargs :guard t))
  (n-bit-integer-p x 32))

(defun long-value-p (x)
  "Recognize a 64-bit signed integer."
  (declare (xargs :guard t))
  (n-bit-integer-p x 64))

(defthm integer-subtype-implication
  (and (implies (byte-value-p x)
                (short-value-p x))
       (implies (short-value-p x)
                (int-value-p x))
       (implies (int-value-p x)
                (long-value-p x))
       (implies (long-value-p x)
                (integerp x))))

(defun unsigned-byte-value-p (x)
  "Recognize a 8-bit unsigned integer."
  (declare (xargs :guard t))
  (n-bit-unsigned-integer-p x 8))

(defun unsigned-short-value-p (x)
  "Recognize a 16-bit unsigned integer."
  (declare (xargs :guard t))
  (n-bit-unsigned-integer-p x 16))

(defun unsigned-int-value-p (x)
  "Recognize a 32-bit unsigned integer."
  (declare (xargs :guard t))
  (n-bit-unsigned-integer-p x 32))

(defthm naturals-subtype-implication
  (and (implies (unsigned-byte-value-p x)
                (unsigned-short-value-p x))
       (implies (unsigned-short-value-p x)
                (unsigned-int-value-p x))
       (implies (unsigned-int-value-p x)
                (naturalp x))
       (implies (unsigned-int-value-p x)
                (rationalp x))))

(defthm integerp-if-subint-value-p
  (implies (int-value-p x)
           (integerp x))
  :rule-classes (:rewrite))

(defthm integerp-if-unsigned-int-value-p
  (implies (unsigned-int-value-p x)
           (integerp x))
  :rule-classes (:rewrite))

(defthm integerp-if-long-value-p
  (implies (long-value-p x)
           (integerp x))
  :rule-classes (:rewrite))

(defthm n-bit-unsigned-integer-p-forward
 (implies (N-BIT-UNSIGNED-INTEGER-P i n)
          (naturalp i))
  :rule-classes (:forward-chaining))

(defthm unsigned-byte-value-p-forward
       (implies (unsigned-byte-value-p i)
                (naturalp i))
  :rule-classes (:forward-chaining))

(defthm unsigned-short-value-p-forward
       (implies (unsigned-short-value-p i)
                (naturalp i))
  :rule-classes (:forward-chaining))

(defthm unsigned-int-value-p-forward
       (implies (unsigned-int-value-p i)
                (naturalp i))
  :rule-classes (:forward-chaining))

; Narrowing Integer Values

; The function narrow-to-n-bits maps an arbitrary integer value (x) to a corresponding integer within the range representable by n-bit two's-complement notation. There are 2^n integers representable in n bits, specifically those in the range [-2^{n-1} .. 2^{n-1}-1]. narrow-to-n-bits maps integers into this range as follows:
;
;    If x is within the representable range, then it maps to itself.
;    If x is a positive integer outside that range, then consider the integer x\;{mod}\; 2^n. This value will be a non-negative integer in the range [0..2^n-1]. If this value is in the representable range, then the original integer maps to this value.
;    Otherwise the original integer maps to (x\;{mod}\;2^n) - 2^{n-1}, which is guaranteed to be in the representable range.

(defun narrow-to-n-bits (x n)
  (declare (xargs :guard (and (integerp x)
                              (naturalp n))))
  (let* ((modulus (expt 2 n))
         (y (mod (ifix x) modulus)))
    (if (>= y (floor modulus 2))
        (- y modulus)
      y)))


(defun narrow-to-int (x)
  (declare (xargs :guard (integerp x)))
  (narrow-to-n-bits x 32))

(defun narrow-to-short (x)
  (declare (xargs :guard (integerp x)))
  (narrow-to-n-bits x 16))

(defun narrow-to-byte (x)
  (declare (xargs :guard (integerp x)))
  (narrow-to-n-bits x 8))

(defun narrow-to-long (x)
  (declare (xargs :guard (integerp x)))
  (narrow-to-n-bits x 64))

;The functions long-bot-half and long-top-half extract the ``bottom half'' and ``top half'' of a long integer value. The function make-long puts the two halfs back together. There are four requirements for these functions:
;
;  (implies (long-value-p x)
;           (unsigned-int-value-p (long-top-half x)))
;
;  (implies (long-value-p x)
;           (unsigned-int-value-p (long-bot-half x)))
;
;  (implies (and (unsigned-int-value-p top)
;                (unsigned-int-value-p bot))
;           (long-value-p (make-long top bot)))
;
;  (implies (long-value-p x)
;           (equal (make-long (long-top-half x) (long-bot-half x))
;                  x))
;
;Exactly which bits of the long integer value form the ``top half'' and which form the ``bottom half'' does not matter. We provide specific definitions of these three functions below so that this model will be executable. Nothing else in the dJVM model depends on these specific definitions, but only on the properties listed above (and defined explicitly below).
;
;Note on the dJVM Model: Note that these functions return unsigned 32-bit integer values. The JVM Specification only requires that the two halves have values that can be represented by a 32-bit word, and says nothing about how the half-long values may be interpreted.
;
;The dJVM model defines a concrete interpretation for half-long values so that the model will be executable. The dJVM specification should only include the axiomatic description of long-top-half, long-bot-half, and make-long given above.

(defun long-bot-half (x)
  (declare (xargs :guard (integerp x)))
  (logand x (1- (expt 2 32))))

(defun long-top-half (x)
  (declare (xargs :guard (integerp x)))
  (long-bot-half (floor x (expt 2 32))))

(defthm integerp-ash-integer
  (implies (and (integerp x)
                (integerp n))
           (integerp (ash x n))))

(in-theory (disable ash))

(defun make-long (top-half bot-half)
  (declare (xargs :guard (and (unsigned-int-value-p top-half)
                              (unsigned-int-value-p bot-half))))
  (let ((bits (logior (ash top-half 32) bot-half)))
    (if (>= bits (expt 2 63))
        (- bits (expt 2 64))
      bits)))

(defthm integerp-make-long
  (integerp (make-long x y))
  :rule-classes (:rewrite :type-prescription))

(encapsulate ()
  (local (in-theory (disable floor)))

  (local
   (encapsulate ()
     (local (include-book "arithmetic-5/top" :dir :system))
     (defthm lemma1
       (unsigned-int-value-p (long-bot-half x)))))

  (local
   (defthm lemma2
     (unsigned-int-value-p (long-top-half x))
     :hints (("goal" :in-theory (disable long-bot-half)))))

  (local (def-gl-thm lemma3
    :hyp (and (unsigned-int-value-p top)
              (unsigned-int-value-p bot))
    :concl (long-value-p (make-long top bot))
    :g-bindings `((bot ,(gl::g-int 0 1 33))
                  (top ,(gl::g-int 33 1 33)))))

  (local (def-gl-thm lemma4
    :hyp (long-value-p x)
    :concl (equal (make-long (long-top-half x) (long-bot-half x))
                  x)
    :g-bindings `((x ,(gl::g-int 0 1 64)))))

 (defthm  compose-and-decompose-longs
  (and (unsigned-int-value-p (long-top-half x))

       (unsigned-int-value-p (long-bot-half x))

       (implies (and (unsigned-int-value-p top)
                     (unsigned-int-value-p bot))
                (long-value-p (make-long top bot)))

       (implies (long-value-p x)
                (equal (make-long (long-top-half x) (long-bot-half x))
                       x)))
  :hints (("goal" :in-theory (disable long-top-half long-bot-half make-long long-value-p)))))

(in-theory (disable long-top-half
                    long-bot-half
                    make-long))

(defthm reassemble-long-value
  (implies (and (equal (long-top-half long) x)
                (equal (long-bot-half long) y)
                (long-value-p long))
           (equal (make-long x y)
                  long)))

;For pragmatic reasons we will simply assume some arithmetic properties of the ``narrowing'' functions above.
;
;We assume that the functions narrow-to-int , long-top-half, and long-bot-half all return integers satisfying int-value-p. Rather than construct the proof that the arithmetic shifts and modular arithmetic always yield integers in the required range, we simply assert these propositions as axioms. These are the only unproven axioms in the dJVM model. Additionally, we assume that make-long returns a long-integer value. Note that although these axioms are stated unconditionally, the guards for the functions are used to assure that they are only applied to proper arguments. (E.g., narrow-to-int is never applied to a floating-point value.)

(encapsulate ()
  (local (include-book "arithmetic-5/top" :dir :system))
  (defthm  narrowing-facts
  (and (int-value-p (narrow-to-int x))
       (short-value-p (narrow-to-short x))
       (byte-value-p (narrow-to-byte x))
       (long-value-p (narrow-to-long x)))))

(in-theory (disable byte-value-p
                    short-value-p
                    int-value-p
                    long-value-p

                    unsigned-short-value-p
                    unsigned-int-value-p

                    narrow-to-int
                    narrow-to-short
                    narrow-to-byte
                    narrow-to-long

                    long-bot-half
                    long-top-half
                    n-bit-integer-p
                    n-bit-unsigned-integer-p
                    ))

(in-theory (disable make-long))

(defthm integerp-narrow-to-int
  (integerp (narrow-to-int x))
  :rule-classes (:rewrite :type-prescription))

(defthm integerp-narrow-to-short
  (integerp (narrow-to-short x))
  :rule-classes (:rewrite :type-prescription))

(defthm integerp-narrow-to-byte
  (integerp (narrow-to-byte x))
  :rule-classes (:rewrite :type-prescription))

(defthm integerp-narrow-to-long
  (integerp (narrow-to-long x))
  :rule-classes (:rewrite :type-prescription))

(defthm naturalp-long-bot-half
  (naturalp (long-bot-half x))
  :rule-classes (:rewrite :type-prescription))

(defthm naturalp-long-top-half
  (naturalp (long-top-half x))
  :rule-classes (:rewrite :type-prescription))

; 32-bit Integer Arithmetic

; Integer arithmetic on the JVM is defined to conform to arithmetic using 32-bit two's-complement representation. For most arithmetic operations it suffices to perform the arithmetic function on unbounded integers and then narrow the result to an integer representable in 32-bit two's-complement representation.

(defun int-add (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))))
  (narrow-to-int (+ x y)))

(defun int-sub (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))))
  (narrow-to-int (- x y)))

; JVM arithmetic is defined in terms of two's-complement representation. Negation is defined in two's-complement arithmetic as ``complement and increment'' --- ( x) + 1. For the most-negative value in a two's-complement representation, this operation yields its input. The function narrow-to-int properly maps the true negation of the integer x into the range of integers permitted by two's-complement representation using 32-bits. narrow-to-int maps the negation of the most negative value to itself.

(defun int-neg (x)
  (declare (xargs :guard (int-value-p x)))
  (narrow-to-int (- x)))

(defun int-mul (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))))
  (narrow-to-int (* x y)))

; Remark: Check the boundary cases...y=0 and y=-2^{31}.

(defun int-div (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y)
                              (not (= 0 y)))))
  (narrow-to-int (truncate x y)))

(defthm int-value-p-int-div
  (implies (and (int-value-p x)
                (int-value-p y)
                (not (= 0 y)))
           (int-value-p (int-div x y))))

(in-theory (disable int-div))

(defun int-logical-and (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))
                  :guard-hints (("Goal" :in-theory (enable int-value-p)))))
  (narrow-to-int (logand x y)))

(defthm logand-type-prescription
  (integerp (logand x y))
  :rule-classes (:type-prescription))

(defun int-logical-ior (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))
                  :guard-hints (("Goal" :in-theory (enable int-value-p)))))
  (narrow-to-int (logior x y)))

(defun int-logical-xor (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))
                  :guard-hints (("Goal" :in-theory (enable int-value-p)))))
  (narrow-to-int (logxor x y)))

;On the JVM division rounds towards zero. The Common Lisp function truncate does precisely this, yielding the integer quotient of two integers by converting their real quotient (a rational number) to an integer by ``rounding'' toward zero (i.e., truncating)

(defun integer-div (x y)
  (declare (xargs :guard (and (integerp x)
                              (integerp y)
                              (not (= 0 y)))))
  (truncate x y))

(in-theory (disable integer-div))

