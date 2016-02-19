; http://www.computationallogic.com/software/djvm/html-0.5/simple-instructions-a-h.html

(in-package "ACL2")
(include-book "define-inst-macro")

;Simple Instructions

;Simple instructions are those that manipulate values on the operand stack and simple control flow operations within a method. They do not invoke or return from methods, or access the heap or the class table. Mostof the JVM instructions fall into this category. All except the last two instructions in this chapter (tableswitch and lookupswitch) are defined using the define-djvm-operation macro. A summary of the macro is given below. The full definition of this macro appears in Appendix [ch:Define-JVM-Instruction-Macro] of this document.

;The Define-JVM-Instruction Macro

;Remark: Fill this in!

;For the moment, see section [sec:simple-inst-examples], page [sec:simple-inst-examples] for a dozen or so examples of the macro.



;aconst_null instruction

;aconst_null -- push the constant null onto the stack {(aconst_null)} {0x1 (hex), 1 (decimal)} null

;The heap address 0 is reserved. A reference to heap address 0 is defined to be a reference to null.

(defn addr-of-null ()
  0)

(define-djvm-operation  (aconst_null)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref (addr-of-null))
  <rest-of-stack>)

; aload instruction

; aload -- push the reference value stored in a local variable onto the stack {(aload index)} {0x19 (hex), 25 (decimal)} :ref

(define-djvm-operation  (aload index)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var index (:ref x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :assert (unsigned-byte-value-p index)
  :instruction-length 2)

; aload_wide instruction

; aload_wide -- push the reference value stored in a local variable onto the stack {(aload wide_index)} Corresponds to a wide instruction on the JVM :ref

(define-djvm-operation  (aload_wide index)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var index (:ref x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p index)
  :instruction-length 4)

; aload_0 instruction

; aload_0 -- push the reference value stored in local variable 0 onto the stack {(aload_0)} {0x2a (hex), 42 (decimal)} :ref

(define-djvm-operation  (aload_0)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 0 (:ref x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; aload_1 instruction

; aload_1 -- push the reference value stored in local variable 1 onto the stack {(aload_1)} {0x2b (hex), 43 (decimal)} :ref

(define-djvm-operation  (aload_1)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 1 (:ref x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; aload_2 instruction

(define-djvm-operation  (aload_2)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 2 (:ref x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; aload_3 instruction

(define-djvm-operation  (aload_3)
  ---STACK---
  <rest-of-stack>
  ==>
  (:ref x)
  <rest-of-stack>

  ---LOCALS---
  (:local-var 3 (:ref x))
  ==>
  <unchanged>

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; astore instruction

; Remark: When we add support for exception handling, and the jsr and ret instructions, the definition of the astore instructions will have to change, because astore is allowed to store instruction addresses. Currently our model does not include the jsr instruction, so there is no way to put an instruction address onto the operand stack.

(define-djvm-operation  (astore index)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var index (:ref x))

  ---OTHER-PROPERTIES---
  :assert (unsigned-byte-value-p index)
  :instruction-length 2)

; astore_wide instruction

(define-djvm-operation  (astore_wide index)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var index (:ref x))

  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p index)
  :instruction-length 4)

; astore_0 instruction

(define-djvm-operation  (astore_0)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 0 (:ref x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; astore_1 instruction

(define-djvm-operation  (astore_1)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 1 (:ref x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; astore_2 instruction

(define-djvm-operation  (astore_2)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 2 (:ref x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; astore_3 instruction

(define-djvm-operation  (astore_3)
  ---STACK---
  (:ref x)
  <rest-of-stack>
  ==>
  <rest-of-stack>

  ---LOCALS---
  <no-constraints>
  ==>
  (:local-var 3 (:ref x))

  ---OTHER-PROPERTIES---
  :instruction-length 1)

; bipush instruction

(define-djvm-operation  (bipush value)
  ---STACK---
  <rest-of-stack>
  ==>
  (:int value)
  <rest-of-stack>

  ---OTHER-PROPERTIES---
  :assert (byte-value-p value)
  :instruction-length 2)

; dup instruction

(define-djvm-operation  (dup)
  ---STACK---
  (:one-word-type x)
  <rest-of-stack>
  ==>
  (:same x)
  (:same x)
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; dup_x1 instruction

(define-djvm-operation  (dup_x1)
  ---STACK---
  (:one-word-type x)                  ;TOP OF STACK
  (:one-word-type y)
  <rest-of-stack>
  ==>
  (:same x)                           ;TOP OF STACK
  (:same y)
  (:same x)
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; dup_x2 instruction

(defthm weak-djvm-p-if-djvm-p-forward
  (implies (djvm-p x)
           (weak-djvm-p x))
  :hints (("Goal" :in-theory (enable djvm-p)))
  :rule-classes (:forward-chaining))

(define-djvm-operation  (dup_x2)
  ---STACK---
  (:one-word-type x)
  (:not-bot-half y)
  (:not-top-half z)
  <rest-of-stack>
  ==>
  (:same x)
  (:same y)
  (:same z)
  (:same x)
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; dup2 instruction

(define-djvm-operation  (dup2)
  ---STACK---
  (:not-bot-half x)
  (:not-top-half y)
  <rest-of-stack>
  ==>
  (:same x)
  (:same y)
  (:same x)
  (:same y)
  <rest-of-stack>



  ---OTHER-PROPERTIES---
  :instruction-length 1)

; dup2_x1 instruction

(define-djvm-operation  (dup2_x1)
  ---STACK---
  (:not-bot-half x)
  (:not-top-half y)
  (:one-word-type z)
  <rest-of-stack>
  ==>
  (:same x)
  (:same y)
  (:same z)
  (:same x)
  (:same y)
  <rest-of-stack>)

; dup2_x2 instruction

;#+TAKES-TOO-LONG
(define-djvm-operation  (dup2_x2)
  ---STACK---
  (:one-word-type w)
  (:not-bot-half x)
  (:not-top-half y)
  (:one-word-type z)
  <rest-of-stack>
  ==>
  (:same w)
  (:same x)
  (:same y)
  (:same z)
  (:same x)
  (:same y)
  <rest-of-stack>)

; goto instruction

(define-djvm-operation  (GOTO offset)
  ---OTHER-PROPERTIES---
  :assert (unsigned-short-value-p offset)
  :branch-if t
  :branch-target (+ offset Current-Instruction-Address)
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target")
  :instruction-length 3)

; goto_w instruction

(define-djvm-operation  (goto_w offset)
  ---OTHER-PROPERTIES---
  :assert (unsigned-int-value-p offset)
  :branch-if t
  :branch-target (+ offset Current-Instruction-Address)
  :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
                "Invalid branch target")
  :instruction-length 5)
