; http://www.computationallogic.com/software/djvm/html-0.5/simple-instructions-h-i.html

(in-package "ACL2")
(include-book "define-inst-macro")

; i2l instruction

; Note that when converting an int value to a long value, the upper half of the long value need not be zero. If the int value is negative, then the upper half will be non-zero.

(define-djvm-operation  (i2l)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  (:long-top-half (long-top-half x))
  (:long-bot-half (long-bot-half x))
  <rest-of-stack>)

; i2s instruction

(define-djvm-operation  (i2s)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  (:int (narrow-to-short x))
  <rest-of-stack>)

; iadd instruction

; The JVMS states:

;    If an iadd overflows, then the result is the low-order bits of the true mathematical result in a sufficiently wide two's complement format. If an overflow occurs, then the sign of the result will not be the same as the sign of the mathematical sum of the two values.
;    [p. 238 in JVMS]

;Remark: What does this mean?? Doesn't the result have to be the low-order 32-bits of the true mathematical result? What does ``sufficiently wide'' imply? Can the result be a short or a byte, rather than an int?
;Note that in n-bit two's complement arithmetic just because a sum overflows does not mean that the ``sign bit'' of the low-order n-bits of the result will differ from the sign of the true mathematical result.

;This statement is presumably an oversight by Lindholm and Yellin, since they correctly say ``may not'' in similar descriptions elsewhere.

;The example (2n - 1) + 1 illustrates a case in which their statement is true. However, (2n - 1) + (2n-1) = 2n+1 - 2, which will overflow n bits, but for which bits n will be the same as bit n+1. Here's an example for n=8:
;
;    	0111111112
;    +	0111111112
;    	----------
;    	1111111102

;Note that the 9th bit (the ``sign bit of the true mathematical result'') is the same as the 8th bit (the ``sign bit of the truncated result'').

(define-djvm-operation  (iadd)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  (:int (int-add x y))
  <rest-of-stack>)

(defun int-add (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))))
  (narrow-to-int (+ x y)))

; iand instruction

(define-djvm-operation  (iand)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  (:int (int-logical-and x y))
  <rest-of-stack>)

; iconst_0 instruction

(define-djvm-operation  (iconst_0)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int 0)
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :length 1)

; iconst_1 instruction

(define-djvm-operation  (iconst_1)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int 1)
    <rest-of-stack>)

; iconst_2 instruction

(define-djvm-operation  (iconst_2)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int 2)
  <rest-of-stack>)

; iconst_3 instruction

(define-djvm-operation  (iconst_3)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int 3)
  <rest-of-stack>)

; iconst_4 instruction

(define-djvm-operation  (iconst_4)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int 4)
  <rest-of-stack>)

; iconst_5 instruction

(define-djvm-operation  (iconst_5)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int 5)
  <rest-of-stack>)

; iconst_m1 instruction

(define-djvm-operation  (iconst_m1)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int -1)
  <rest-of-stack>)

; idiv instruction

(define-djvm-operation  (idiv)
  ---STACK---
  (:int denom)
  (:int num)
  <rest-of-stack>
  ==>
  (:int (narrow-to-int (integer-div num denom)))
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :exceptions ((equal denom 0) "ArithmeticException")
  :length 1)

; On the JVM division rounds towards zero. The Common Lisp function truncate does precisely this, yielding the integer quotient of two integers by converting their real quotient (a rational number) to an integer by ``rounding'' toward zero (i.e., truncating).

; We define integer-div to specify in the guard that the arguments must be integers. The ACL2 function truncate accepts rational numbers, as well as integers.

(defun integer-div (x y)
  (declare (xargs :guard (and (integerp x)
                              (integerp y)
                              (not (= 0 y)))))
  (truncate x y))

; if_acmpeq instruction

;Remark: The ifxx instructions are all three bytes long. They may not be prefaced by the wide modifier. Note that if the branch is taken, the offset is relative to the address of the ifxx instruction. In our model, the pc passed into the execute function will already have been incremented by the instruction length, so that function must compensate appropriately if the branch is taken.

;Remark: This raises an exception if the branch target is an invalid pc, regardless of whether the branch is taken or not.

;Although the bytecode verifier prohibits such invalid branch targets, the behavior here is probably wrong. Rather, the invalid pc should only trigger an exception if the branch is taken.

;The exception mechanism in define-djvm-operation tests the arguments before the operation, for example to prevent division by zero in the idiv instruction.

;So, we could either define invalid branch targets as exceptions using this mechanism; or ignore the possibility of an invalid branch target here, let the branch execute, and catch the invalid pc in the general test for invalid pc values within the boiler-plate of the define-defensive-instruction definition form.

(define-djvm-operation  (IF_ACMPEQ offset)
  ---STACK---
  (:ref x)
  (:ref y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (= x y)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_acmpne instruction

(define-djvm-operation  (IF_ACMPNE offset)
  ---STACK---
  (:ref x)
  (:ref y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (not (= x y))
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_icmpeq instruction

(define-djvm-operation  (IF_ICMPEQ offset)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (= x y)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_icmpne instruction

(define-djvm-operation  (IF_ICMPNE offset)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (not (= x y))
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_icmplt instruction

(define-djvm-operation  (IF_ICMPLT offset)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (< y x)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_icmpge instruction

(define-djvm-operation  (IF_ICMPGE offset)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (>= y x)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_icmpgt instruction

(define-djvm-operation  (IF_ICMPGT offset)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (> y x)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; if_icmple instruction

(define-djvm-operation  (IF_ICMPLE offset)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (<= y x)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifeq instruction

(define-djvm-operation  (IFEQ offset)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (= x 0)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifne instruction

(define-djvm-operation  (IFNE offset)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (not (= x 0))
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; iflt instruction

(define-djvm-operation  (IFLT offset)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (< x 0)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifle instruction

(define-djvm-operation  (IFLE offset)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (<= x 0)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifgt instruction

(define-djvm-operation  (IFGT offset)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (> x 0)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifge instruction

(define-djvm-operation  (IFGE offset)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (>= x 0)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifnonnull instruction

(define-djvm-operation  (IFNONNULL offset)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (not (ref-to-null-p x))
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; ifnull instruction

(define-djvm-operation  (IFNULL offset)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>
  ---OTHER-PROPERTIES---
  :assert (short-value-p offset)
  :branch-if (ref-to-null-p x)
  :branch-target (+ offset Current-Instruction-Address)
  :instruction-length 3
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target"))

; iinc instruction

(define-dJVM-Operation  (IINC index const)
  ---LOCALS---
  (:local-var index (:int x))
  ==>
  (:local-var index (:int (int-add x const)))

  ---OTHER-PROPERTIES---
  :assert (and (unsigned-byte-value-p index)
               (byte-value-p const))
  :instruction-length 3)

; iinc_wide instruction

; The wide form of the iinc instruction permits the index and constant instruction arguments to be 16-bit values, rather than being restricted to the 8-bit values permitted by the unmodified form of the instruction. The 16-bit value for the local-variable index value is interpreted as an ``unsigned short'' value, and the constant is interpreted as a short integer value.

(define-dJVM-Operation  (IINC_WIDE index const)
  ---LOCALS---
  (:local-var index (:int x))
  ==>
  (:local-var index (:int (int-add x const)))

  ---OTHER-PROPERTIES---
  :assert (and (unsigned-short-value-p index)
               (short-value-p const))
  :instruction-length 3)

; iload instruction

(define-dJVM-Operation  (ILOAD index)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var index (:int x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :assert (unsigned-byte-value-p index)
  :instruction-length 2)

; iload_wide instruction

(define-dJVM-Operation  (ILOAD_wide index)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int x)
  <rest-of-stack>



  ---LOCALS---
  (:local-var index (:int x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p index)
  :instruction-length 4)

; The abbreviated instructions iload_0, iload_1, iload_2, and iload_3 are all one byte long.

; iload_0 instruction

(define-dJVM-Operation  (ILOAD_0)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 0 (:int x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; iload_1 instruction

(define-dJVM-Operation  (ILOAD_1)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 1 (:int x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; iload_2 instruction

(define-dJVM-Operation  (ILOAD_2)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 2 (:int x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; iload_3 instruction

(define-dJVM-Operation  (ILOAD_3)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 3 (:int x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; imul instruction

; The imul instruction multiplies two int values, and pushes an intresult onto the stack. If the product is outside the range of int values, it is ``truncated'' via narrow-to-int. No arithmetic exception are ever thrown by this instruction.

;    If an int multiplication overflows, then the result is the low-order bits of the mathematical product as an int. If overflow occurs, then the sign of the result may not be the same as the sign of the mathematical produce of the two values.
;    [p. 254 in JVMS]

(define-djvm-operation  (IMUL)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  (:int (int-mul x y))
  <rest-of-stack>)

(defun int-mul (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))))
  (narrow-to-int (* x y)))

; ineg instruction

;    For int values, negation is the same as subtraction from zero. Because the Java Virtual Machine uses two's-complement representation for integer and the range of two's-complement values is not symmetric, the negation of the maximum negative value int results in that same maximum negative number. Despite the fact that overflow has occurred, no exception is thrown.
;    [p. 255 in JVMS]

(define-djvm-operation  (INEG)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  (:int (int-neg x))
  <rest-of-stack>)

; JVM arithmetic is defined in terms of two's-complement representation. Negation is defined in two's complement arithmetic as ``complement and increment'' --- ( x) + 1. For the most negative value in a two's-complement representation, this operation yields its input. The function narrow-to-int properly maps the true negation of the integer x into the range of integers permitted by two's-complement representation using 32-bits. narrow-to-int maps the negation of the most negative value to itself.

(defun int-neg (x)
  (declare (xargs :guard (int-value-p x)))
  (narrow-to-int (- x)))

; ior instruction

(define-djvm-operation  (ior)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  (:int (int-logical-ior x y))
  <rest-of-stack>)

; istore instruction

; The use of (:local-var index tagged-value) implicitly requires that index is a valid index for a local variable in the current frame. If this is not so, the instruction will halt the machine, setting the error status to indicate that the instruction was called with improper argument types.

(define-dJVM-Operation  (ISTORE index)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var index (:int x))

  ---OTHER-PROPERTIES---
  :assert (unsigned-byte-value-p index)
  :instruction-length 2)

; istore_wide instruction

(define-dJVM-Operation  (ISTORE_wide index)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>



  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var index (:int x))

  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p index)
  :instruction-length 4)

; istore_0 instruction

(define-dJVM-Operation  (ISTORE_0)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 0 (:int x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; istore_1 instruction

(define-dJVM-Operation  (ISTORE_1)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 1 (:int x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; istore_2 instruction

(define-dJVM-Operation  (ISTORE_2)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 2 (:int x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; istore_3 instruction

(define-dJVM-Operation  (ISTORE_3)
  ---STACK---
  (:int x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 3 (:int x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; isub instruction

(define-djvm-operation  (ISUB)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  (:int (int-sub y x))
  <rest-of-stack>)

(defun int-sub (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))))
  (narrow-to-int (- x y)))

; ixor instruction

(define-djvm-operation  (IXOR)
  ---STACK---
  (:int x)
  (:int y)
  <rest-of-stack>
  ==>
  (:int (int-logical-xor x y))
  <rest-of-stack>)

(defun int-logical-xor (x y)
  (declare (xargs :guard (and (int-value-p x)
                              (int-value-p y))
                  :guard-hints (("Goal" :in-theory (enable int-value-p)))))
  (narrow-to-int (logxor x y)))
