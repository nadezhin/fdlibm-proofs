; http://www.computationallogic.com/software/djvm/html-0.5/preliminaries.html

(in-package "ACL2")

; The Common Lisp function char extracts the i^{th} character of a string. Our proofs below don't depend on the definition of char. We tell the theorem-prover to ``disable'' it, which instructs the theorem-prover not to expand the definition of char in proofs.

(in-theory (disable char))

(defthm a-cons-is-not-false
  (iff (cons x y) t))


;The macro naturalp recognizes natural numbers (i.e., non-negative integers). The macro positivep recognizes positive integers.

;(defmacro  memberp (x y)
;  `(not (null (member ,x ,y))))

(defmacro  member-equal-p (x y)
  `(not (null (member-equal ,x ,y))))

(defmacro  true ()
  't)

(defmacro  false ()
  'nil)

(defmacro  non-nil-non-t-symbolp (x)
  `(and (symbolp ,x)
        (not (equal ,x nil))
        (not (equal ,x t))))

; Facts about strings

(defthm stringp-subseq-stringp
  (implies (stringp x)
           (stringp (subseq x i j)))
  :rule-classes (:rewrite :type-prescription))

; Some General Macros

; Some macros to make the code more readable.
;
;The macro non-empty is used to recognize stacks that are not empty.This definition relies on two facts: (1) that we use nil to represent an empty stack, and (2) that Common Lisp -- and hence ACL2 -- considers any value other than nil to be true. Thus the expression (not (null (foo x))) has the same truth value as (foo x), even though it may have a different non-nil value.

(defmacro  non-empty (stack)
  `(consp ,stack))

(defmacro  stack-empty-p (x)
  `(null ,x))

(defmacro  stack-top (x)
  `(car ,x))

(defmacro  observe (name term \&rest defthm-options)
  `(defthm ,name
     ,term
     :rule-classes ()
     ,@defthm-options))

; Some small functions

;These functions are used at various places when defining instructions. They are trivial functions and are used mainly as a ``do nothing'' place-holder where a function is required in the standard form definition of some instructions.

(defun true-2 (x y)
  (declare (ignore x y)
           (xargs :guard t))
  t)

(defun identity-2 (x y)
  (declare (ignore x)
           (xargs :guard t))
  y)
