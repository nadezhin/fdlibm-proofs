; http://www.computationallogic.com/software/djvm/html-0.5/method-returns.html

(in-package "ACL2")
(include-book "invokevirtual")

;Returning from a Method

;There are several variants of the return instruction, depending what type of value is to be returned or if no value is to be returned.
;
;    The ireturn instruction terminates a method invocation and returns an int value.
;    The lreturn instruction terminates a method invocation and returns a long integer value.
;    The areturn instruction terminates a method invocation and returns an object reference.
;    The return terminates a method invocation without returning any value.

;Instance-initialization methods (i.e., methods named <init>) must exit using the return instruction. They do not return a reference to the object being initialized. The calling method must have saved a reference to the object if it is to access the object after initialization. In addition, when an instance-initialization method executes a return instruction, the object being initialized must no longer be in the frame's new-refs list. Also as part of the return instruction the object being initialized is removed from the new-refs field in the calling stack frame. (That is, after the initialization method completes normally, the object is considered to have been initialized in the context of the calling method.) Further, it is an error if the object being initialized is not in the new-refs list in the calling frame. This behavior is the same regardless of whether the calling method was an instance-initialization method or not; the factor that determines whether the return instruction has this additional behavior is whether the current method (i.e., the method executing the return instruction) is named <init>.

;Note that the areturn instruction is not permitted to return a reference to an instance that is considered uninitialized in the current frame.

;Parsing Return-Type Signatures

(defun char-position-internal (char string i)
  (declare (xargs :guard (and (characterp char)
                              (stringp string)
                              (naturalp i)
                              (<= i (length string)))
                  :measure (max 0 (- (length string) (acl2-count i)))))
  (if (and (naturalp i)
           (< i (length string)))
      (if (equal (char string i) char)
        i
      (char-position-internal char string (1+ i)))
    nil))

(defun char-position (char string)
  (declare (xargs :guard (and (characterp char)
                              (stringp string))))
  (char-position-internal char string 0))

(defun type-list-for-method-return-value-internal (sig pos)
  (declare (xargs :guard (and (stringp sig)
                              (method-type-sig-p sig)
                              (naturalp pos))))
  (if (< pos (length sig))
      (case (char sig pos)
        (#\I '(:INT))
        (#\J '(:LONG-TOP-HALF :LONG-BOT-HALF))
        (#\L (list (list ':REF (field-type-sig-class-name sig (1+ pos)))))
        (#\V '(:VOID))
        (#\Z '(:INT))
        (otherwise '(:error)))
    '(:error)))

(defun type-list-for-method-return-value (sig)
  (declare (xargs :guard (and (stringp sig)
                              (method-type-sig-p sig))))
  (if (and (> (length sig) 0)
           (equal (char sig 0) #\())
      (let ((position (char-position #\) sig)))
        (if (naturalp position)
            (type-list-for-method-return-value-internal sig (1+ position))
          '(:error)))
    '(:error)))

(defun stk-sig-consistent-with-return-type? (sig djvm)
  (declare (xargs :guard (and (stringp sig)
                              (method-type-sig-p sig)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (let ((type-list (type-list-for-method-return-value sig))
        (current-frame (stack-top (djvm-stack djvm))))
    (and (>= (len (frame-stack current-frame))
             (len type-list))
         (extended-jvm-type-listp type-list)
         (assignment-compatible-stack? type-list
                                       (frame-stack current-frame)
                                       (djvm-class-table djvm)
                                       (djvm-heap djvm)))))

(verify-guards jvm-type-tag-listp)

(defun sig-return-type-p (type-tag-list method-sig)
  (declare (xargs :guard (and (jvm-type-tag-listp type-tag-list)
                              (method-type-sig-p method-sig))))
  (equal type-tag-list
         (type-list-for-method-return-value method-sig)))

; ireturn instruction

(defun execute-ireturn-optimized (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (non-empty (cdr (djvm-stack djvm)))))
           (ignore inst))
  (let ((return-value (stack-top (djvm-operand-stack djvm))))
    ;; Presumably Ireturn-Proper-Arg-Types? has checked that
    ;; the top-most value on the stack is an int value.
    ;;
    ;; We must still check that the type of the return value is
    ;; consistent with the current method's signature.



    (if (and (djvm-stk-sig-top? djvm :int)
             (sig-return-type-p '(:int) (java-method-sig
                                         (frame-method (car (djvm-stack djvm))))))
        (djvm-push-operand return-value
                           (set-djvm-stack (cdr (djvm-stack djvm))
                                           djvm))
      (set-djvm-status "Inconsistent return type in method" djvm))))

(defun ireturn-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (true-listp inst)
       (equal (car inst) 'ireturn)
       (= (len inst) 1)))

(defun ireturn-proper-arg-types? (inst frame)
  (declare (xargs :guard (frame-p frame)))
  (declare (ignore inst))
  (and (non-empty (frame-stack frame))
       (tv-int-p (car (frame-stack frame)))))

(defun ireturn-proper-arg-values? (inst djvm)
  (declare (xargs :guard t))
  (declare (ignore inst))
  (and (djvm-p djvm)
       (non-empty (djvm-stack djvm))
       (non-empty (cdr (djvm-stack djvm)))))

(defun ireturn-proper-value? (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (declare (ignore inst))
  (and (non-empty (djvm-operand-stack djvm))
       (tv-int-p (car (djvm-operand-stack djvm)))))

(define-defensive-instruction  djvm-execute-ireturn
  ireturn-wff-inst?
  ireturn-proper-arg-types?
  identity-2
  ireturn-proper-arg-values?
  execute-ireturn-optimized
  ireturn-proper-value?
  :instruction-length 1)

(defthm djvm-p-execute-ireturn-optimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (execute-ireturn-optimized inst djvm))))

(in-theory (disable ireturn-wff-inst?
                    ireturn-proper-arg-types?
                    ireturn-proper-arg-values?
                    execute-ireturn-optimized))

(defthm djvm-p-djvm-execute-ireturn
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-ireturn inst djvm))))

(in-theory (disable djvm-execute-ireturn))

; areturn instruction

(defun djvm-tos-initialized-ref-p (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (let ((frame (car (djvm-stack djvm))))
    (and (non-empty (frame-stack frame))
         (tv-ref-p (car (frame-stack frame)))
         (frame-initialized-ref-p (car (frame-stack frame)) frame))))

(defun execute-areturn-optimized (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (non-empty (cdr (djvm-stack djvm))))))
  (if (non-empty (djvm-operand-stack djvm))
      (let ((return-value (stack-top (djvm-operand-stack djvm)))
            (expanded-type-spec (type-list-for-method-return-value
                                 (java-method-sig
                                  (frame-method (current-frame djvm)))))
            (class-table  (djvm-class-table djvm))
            (heap         (djvm-heap djvm)))



        ;; Presumably Areturn-Proper-Arg-Types? has checked that
        ;; the top-most value on the stack is a reference  value.



        ;; We must still check that the type of the return value is
        ;; consistent with the current method's signature.



        ;; We do not assume the return-spec for the method is
        ;; well-formed.  We would need to prove additional facts
        ;; about Type-List-For-Method-Return-Value if we did.



        (if (and (tv-ref-p return-value)
                 (good-memory-ref-p return-value heap)
                 (extended-jvm-type? expanded-type-spec)
                 (assignment-compatible-value? return-value
                                               expanded-type-spec
                                               class-table
                                               heap))
            (if (djvm-tos-initialized-ref-p djvm)
                (djvm-push-operand return-value
                                   (set-djvm-stack (cdr (djvm-stack djvm))
                                                   djvm))
              (set-djvm-status "Attempt to return a reference to an uninitialized instance."
                               djvm))
          (set-djvm-status "Inconsistent return type in method" djvm)))
    (djvm-error "Attempt to execute ARETURN with empty operand stack."
                inst djvm)))

(defun areturn-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (true-listp inst)
       (equal (car inst) 'areturn)
       (= (len inst) 1)))

(defun areturn-proper-arg-types? (inst frame)
  (declare (xargs :guard (frame-p frame)))
  (declare (ignore inst))
  (and (non-empty (frame-stack frame))
       (tv-ref-p (car (frame-stack frame)))))

(defun areturn-proper-arg-values? (inst djvm)
  (declare (xargs :guard t))
  (declare (ignore inst))
  (and (djvm-p djvm)
       (non-empty (djvm-stack djvm))
       (non-empty (cdr (djvm-stack djvm)))))

(defun areturn-proper-value? (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (declare (ignore inst))
  (and (non-empty (djvm-operand-stack djvm))
       (tv-ref-p (car (djvm-operand-stack djvm)))))

(defthm djvm-p-execute-areturn-optimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (execute-areturn-optimized inst djvm))))

(in-theory (disable execute-areturn-optimized))

(define-defensive-instruction  djvm-execute-areturn
  areturn-wff-inst?
  areturn-proper-arg-types?
  identity-2
  areturn-proper-arg-values?
  execute-areturn-optimized
  areturn-proper-value?
  :instruction-length 1)

(in-theory (disable areturn-wff-inst?
                    areturn-proper-arg-types?
                    areturn-proper-arg-values?
                    execute-areturn-optimized))

(defthm djvm-p-djvm-execute-areturn
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-areturn inst djvm))))

(in-theory (disable djvm-execute-areturn))

;return instruction

;If the method executing the return instruction is an instance-initialization method (i.e., is named <init>), then we remove the object being initialized from the new-refs list in the calling frame. If the <init> method belongs to any class but java.lang.Object, then the object being initialized must not be in the current frame's list of uninitialized objects. Normally an object gets removed from the frame's list of uninitialized objects after it has invoked another <init> method (either in this class or in its superclass) and that method has returned normally. However, this ``grounds out'' at the <init> method in class java.lang.Object, since there is no superclass method to call. So when returning from java.lang.Object.<init>, we always remove the object from the calling frame's list of uninitialized objects.

;The return type-signature for the current method must be ``V'' (corresponding to a Java method that was declared void).

(defthm stringp-if-method-type-sig-p-2
  (implies (method-type-sig-p x)
           (stringp x))
  :rule-classes :rewrite)

(defun object-ref-set-if-init-method (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (implies (equal (java-method-name
                   (frame-method
                    (current-frame djvm)))
                  "<init>")
           (tv-ref-p (Frame-Object-Ref
                      (Current-Frame djvm)))))

(defun execute-return (INST DJVM)
  (declare (xargs :guard (and (Instruction-p INST)
                              (Djvm-p DJVM)
                              (non-empty (Djvm-Stack DJVM)))))
  (if (equal '(:void)
             (Type-List-For-Method-Return-Value
              (Java-Method-Sig
               (Frame-Method (car (Djvm-Stack DJVM))))))
      (let* ((Current-Frame (Stack-Top (Djvm-Stack DJVM)))
             (Current-Method (Frame-Method Current-Frame)))
        (if (equal "<init>" (Java-Method-Name Current-Method))
            (if (non-empty (cdr (djvm-stack djvm)))
                (let* ((Object-Ref (Frame-Object-Ref (car (Djvm-Stack DJVM))))
                       (Calling-Frame (cadr (Djvm-Stack DJVM))))
                  (if (or (Frame-Initialized-Ref-p Object-Ref Current-Frame)
                          (equal (Java-Method-Class-name Current-Method)
                                 "java.lang.Object"))
                      (if (not (Frame-Initialized-Ref-p Object-Ref Calling-Frame))
                          (Set-Djvm-Stack (cons (Frame-Mark-Inited Object-Ref
                                                                   Calling-Frame)
                                                (cddr (Djvm-Stack DJVM)))
                                          DJVM)



                        (Set-Djvm-Status "Just initialized a previously-initialized object!"
                                         DJVM))



                    (Set-Djvm-Status "<init> did not initialize the instance." DJVM)))

              ;; An <init> method is exiting with no calling frame.
              ;; This is not right.



              (djvm-error "No calling frame for <init> method."
                          inst djvm))

          ;; Not an <init> method. If there's a calling-frame, just
          ;; return control it.  Otherwise halt the machine.



          (if (non-empty (cdr (djvm-stack djvm)))
              (Set-Djvm-Stack (cdr (Djvm-Stack DJVM))
                              DJVM)
            (Set-Djvm-Stack (cdr (Djvm-Stack DJVM))
                            (Set-Djvm-Status ':halted
                                             DJVM)))))



    ;; Attempt to use "return" on a method whose result-type is not "void".



    (Set-Djvm-Status "Inconsistent return type in method" DJVM)))

(defun return-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (true-listp inst)
       (equal (car inst) 'return)
       (= (len inst) 1)))

(defun return-proper-arg-types? (inst frame)
  (declare (xargs :guard t))
  (declare (ignore inst frame))
  t)

(defun return-proper-arg-values? (inst djvm)
  (declare (xargs :guard t))
  (declare (ignore inst))
  (and (djvm-p djvm)
       (non-empty (djvm-stack djvm))))

(defun return-proper-value? (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (declare (ignore inst djvm))
  t)

(defthm djvm-p-execute-return
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (execute-return inst djvm))))

(in-theory (disable execute-return))

(define-defensive-instruction  djvm-execute-return
  return-wff-inst?
  return-proper-arg-types?
  identity-2
  return-proper-arg-values?
  execute-return
  return-proper-value?
  :instruction-length 1)

(in-theory (disable return-wff-inst?
                    return-proper-arg-types?
                    return-proper-arg-values?))

(defthm djvm-p-djvm-execute-return
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-return inst djvm))))

(in-theory (disable djvm-execute-return))
