; http://www.computationallogic.com/software/djvm/html-0.5/simple-instructions-j-z.html

(in-package "ACL2")
(include-book "define-inst-macro")

; l2i instruction

(define-djvm-operation  (l2i)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  (:int (narrow-to-int (make-long x y)))
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; ladd instruction

(define-djvm-operation  (ladd)
  ---STACK---
  (:long-top-half x1)
  (:long-bot-half x2)
  (:long-top-half y1)
  (:long-bot-half y2)
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half (+ (make-long x1 x2)
                                               (make-long y1 y2))))
  (:long-bot-half (long-bot-half (+ (make-long x1 x2)
                                               (make-long y1 y2))))
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; land instruction

(define-djvm-operation  (land)
  ---STACK---
  (:long-top-half x1)
  (:long-bot-half x2)
  (:long-top-half y1)
  (:long-bot-half y2)
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half (logand (make-long x1 x2)
                                                    (make-long y1 y2))))
  (:long-bot-half (long-bot-half (logand (make-long x1 x2)
                                                    (make-long y1 y2))))
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lcmp instruction

; The lcmp instruction compares two long integer values on the operand stack. Each long integer value occupies two words in the operand stack. The two long values (four words) are popped from the operand stack. The integer result of the comparison is pushed onto the operand stack. If the top-most long value on the stack is top, and the second long value on the stack is lower, then the result is +1 if lower > top, 0 if lower = top, and -1 if lower < top.

(defun long-compare (x y)
  (declare (xargs :guard (and (integerp x) (integerp y))))
  (if (> y x)
      +1
    (if (= y x)
        0
      -1)))

(define-djvm-operation  (lcmp)
  ---STACK---
  (:long-top-half x1)
  (:long-bot-half x2)
  (:long-top-half y1)
  (:long-bot-half y2)
  <rest-of-stack>
  ==>
  (:int (long-compare (make-long x1 x2) (make-long y1 y2)))
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lconst_0 instruction

; Remark: Perhaps it's overkill not to acknowledge that the two halves of a long zero are both zero!

(define-djvm-operation  (lconst_0)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half 0))
  (:long-bot-half (long-bot-half 0))
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lconst_1 instruction

(define-djvm-operation  (lconst_1)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half 1))
  (:long-bot-half (long-bot-half 1))
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; ldc instruction

; ldc -- load constant from constant pool {(ldc index)} { 0x12 (hex), 18 (decimal)} {*GENERIC* for the JVM, int for the dJVM 0.5}

; Remark: Define what ``*GENERIC*'' means.

; In full JVM the ldc instruction can load a single word value from the constant pool. The single word value can be an int value, a float value, or a (reference to a) String value.

; Since the dJVM 0.5 does not include either floating point or the class String, within the dJVM 0.5 model the ldc instruction can only load integer values.

; The dJVM 0.5 requires that constant-pool resolution be performed statically before the program is loaded. Thus in the dJVM model, unlike the raw JVM, the instruction argument to the ldc is not the index of an entry in the constant pool, but the value of that entry itself.

;#+Ignore
(define-djvm-operation  (ldc constant)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int constant)
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :assert (int-value-p constant)
;  :assert (int-value-p index)
  :instruction-length 2)

;ldc_w instruction

;ldc_w -- load constant from constant pool {(ldc_w index)} { 0x13 (hex), 19 (decimal)} {*GENERIC* for the JVM, int for the dJVM 0.5}

;The ldc_w instruction has the same behavior as the ldc instruction, but has a 16-bit index into the constant pool, while the ldc instruction only has an 8-bit index. Since the dJVM does constant pool resolution at ``compile time,'' the only effective difference between the two on the dJVM is the instruction length.


#+Ignore
(define-djvm-operation  (ldc_w constant)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int constant)
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :assert (int-value-p constant)
;  :assert (int-value-p index)
  :instruction-length 3)

;ldc2_w instruction

;ldc2_w -- load 2 word constant from constant pool {(ldc2_w index)} { 0x14 (hex), 20 (decimal)} {*2-WORD-GENERIC* for the JVM, long for the dJVM 0.5}

;Remark: Define what ``*2-WORD-GENERIC*'' means.

;The ldc2_w instruction loads double-word values from the constant pool. In the full JVM these can be values of type long (64-bit integers) or type double (64-bit floating point values). Since the dJVM does not include floating point, within the dJVM the ldc2_w instruction can only load long integer values.

;#+Ignore
(define-djvm-operation  (ldc2_w constant)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half constant))
  (:long-bot-half (long-bot-half constant))
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :assert (long-value-p constant)
;  :assert (long-value-p index)
  :instruction-length 3)

; ldiv instruction

(define-djvm-operation  (ldiv)
  ---STACK---
  (:long-top-half denom1)
  (:long-bot-half denom2)
  (:long-top-half num1)
  (:long-bot-half num2)
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half (integer-div (make-long num1   num2)
                                              (make-long denom1 denom2))))
  (:long-bot-half (long-bot-half (integer-div (make-long num1   num2)
                                              (make-long denom1 denom2))))
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :exceptions ((= 0 (make-long denom1 denom2)) "ArithmeticException")
  :length 1)

; On the JVM division rounds towards zero. The Common Lisp function truncate does precisely this, yielding the integer quotient of two integers by converting their real quotient (a rational number) to an integer by ``rounding'' toward zero (i.e., truncating) if necessary.

; We define integer-div to specify in the guard that the arguments must be integers. The ACL2 function truncate accepts rational numbers, not just integers.

(defun integer-div (x y)
  (declare (xargs :guard (and (integerp x)
                              (integerp y)
                              (not (= 0 y)))))
  (truncate x y))

; lload instruction

(in-theory (disable true-listp))

(define-djvm-operation  (lload index)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>

  ---LOCALS---
  (:local-var index      (:long-top-half x))
  (:local-var (1+ index) (:long-bot-half y))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :assert (unsigned-byte-value-p index)
  :instruction-length 2)

; lload_wide instruction

(define-djvm-operation  (lload_wide index)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>

  ---LOCALS---
  (:local-var index      (:long-top-half x))
  (:local-var (1+ index) (:long-bot-half y))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p index)
  :instruction-length 4)

; lload_0 instruction

(define-djvm-operation  (lload_0)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 0 (:long-top-half x))
  (:local-var 1 (:long-bot-half y))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lload_1 instruction

(define-djvm-operation  (lload_1)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 1 (:long-top-half x))
  (:local-var 2 (:long-bot-half y))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lload_2 instruction

(define-djvm-operation  (lload_2)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 2 (:long-top-half x))
  (:local-var 3 (:long-bot-half y))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lload_3 instruction

(define-djvm-operation  (lload_3)
  ---STACK---
  <rest-of-stack>
  ==>
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 3 (:long-top-half x))
  (:local-var 4 (:long-bot-half y))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lstore instruction

(define-djvm-operation  (lstore index)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var index      (:long-top-half x))
  (:local-var (1+ index) (:long-bot-half y))

  ---OTHER-PROPERTIES---
  :assert (unsigned-byte-value-p index)
  :instruction-length 2)

; lstore_wide instruction

(define-djvm-operation  (lstore_wide index)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var index      (:long-top-half x))
  (:local-var (1+ index) (:long-bot-half y))

  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p index)
  :instruction-length 4)

; lstore_0 instruction

(define-djvm-operation  (lstore_0)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 0 (:long-top-half x))
  (:local-var 1 (:long-bot-half y))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lstore_1 instruction

(define-djvm-operation  (lstore_1)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 1 (:long-top-half x))
  (:local-var 2 (:long-bot-half y))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lstore_2 instruction

(define-djvm-operation  (lstore_2)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 2 (:long-top-half x))
  (:local-var 3 (:long-bot-half y))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; lstore_3 instruction

(define-djvm-operation  (lstore_3)
  ---STACK---
  (:long-top-half x)
  (:long-bot-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 3 (:long-top-half x))
  (:local-var 4 (:long-bot-half y))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; nop instruction

(define-djvm-operation  (nop)
  ---STACK---
  <no-constraints>
  ==>
  <unchanged>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; pop instruction

(define-djvm-operation  (pop)
  ---STACK---
  (:one-word-type x)
  <rest-of-stack>
  ==>
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; pop2 instruction

(define-djvm-operation  (pop2)
  ---STACK---
  (:not-bot-half x)
  (:not-top-half y)
  <rest-of-stack>
  ==>
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)


; Remark: What guarantees does pop2 make about the resulting operand stack??

; Why do we care if the top of the stack is an unmatched long-bot-half??

; This instruction appears to notice ill-formed stack values within the values it manipulates. Seems odd.

; The pop2 instruction will halt with an error if the top-most entry on the stack is a long-bot-half or if the entry below that is a long-top-half.

; If the pop2 instruction completes normally, then it is guaranteed not to introduce a violation of a state invariant. That is, pop2 will not introduce any unmatched long-half values into the operand stack.

; sipush instruction

(define-djvm-operation  (sipush value)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int value)
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :assert (short-value-p value)
  :instruction-length 3)

; swap instruction

(define-djvm-operation  (swap)
  ---STACK---
  (:one-word-type x)
  (:one-word-type y)
  <rest-of-stack>
  ==>
  (:same y)
  (:same x)
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)
