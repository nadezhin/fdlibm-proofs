; http://www.computationallogic.com/software/djvm/html-0.5/invokestatic.html

(in-package "ACL2")
(include-book "invokevirtual")
(local (include-book "data-structures/alist-defthms" :dir :system))

;Invokestatic

(defun djvm-current-class-name (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (frame-class (current-frame djvm)))

(defun class-defined? (class-name djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (djvm-p djvm))))
  (bound?-equal class-name (djvm-class-table djvm)))

(defun current-class-defined? (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (class-defined? (djvm-current-class-name djvm) djvm))

(defun superclass-p (superclass-name class-name class-table)
  (declare (xargs :guard (and (stringp superclass-name)
                              (stringp class-name)
                              (class-table-p class-table))))
  (and (bound?-equal class-name class-table)
       (let ((class-decl (binding-equal class-name class-table)))
         (member-equal-p superclass-name
                         (class-decl-superclasses class-decl)))))

(defun super-class-name (class-name class-table)
  (declare (xargs :guard (and (stringp class-name)
                              (class-table-p class-table)
                              (bound?-equal class-name class-table))))
  (class-decl-superclass (binding-equal class-name class-table)))

(defthm stringp-class-decl-superclass
  (implies (class-decl-p class-decl)
           (stringp (class-decl-superclass class-decl))))

(defthm super-class-name-type-prescription
  (implies (and (stringp class-name)
                (class-table-p class-table)
                (bound?-equal class-name class-table))
           (stringp (super-class-name class-name class-table)))
  :rule-classes (:rewrite :type-prescription))

(defun class-decl-access-super-p (class-decl)
  (declare (xargs :guard (class-decl-p class-decl)))
  (member ':super (class-decl-access-flags class-decl)))

(defun djvm-class-access-super-p (class-name djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (djvm-p djvm)
                              (bound?-equal class-name (djvm-class-table djvm)))))
  (class-decl-access-super-p (binding-equal class-name (djvm-class-table djvm))))

(defun java-method-accessible-p (method current-class-name class-table)
  (declare (xargs :guard (and (java-method-p method)
                              (stringp current-class-name)
                              (class-table-p class-table)
                              (bound?-equal (java-method-class-name method)
                                      class-table)
                              (bound?-equal current-class-name class-table))))
  (let* ((target-class-name (java-method-class-name method))
         (target-class (binding-equal target-class-name class-table))
         (protection   (java-method-protection method)))
    (djvm-member-accessible-p protection
                              target-class
                              (binding-equal current-class-name class-table))))

(defun invokestatic-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (instruction-p inst)
       (equal (car inst) 'invokestatic)
       (stringp (arg1 inst))
       (stringp (arg2 inst))
       (stringp (arg3 inst))
       (method-type-sig-p (arg3 inst))
       (equal (len inst) 4)))

(defun invokestatic-proper-arg-types? (instruction frame)
  (declare (xargs :guard (and (instruction-p instruction)
                              (frame-p frame))))
  (and (non-empty (frame-stack frame))
       (let ((class-name (arg1 instruction))
             (method-name (arg2 instruction))
             (method-sig (arg3 instruction)))
         (and (stringp class-name)
              (stringp method-name)
              (stringp method-sig)
              (method-type-sig-p method-sig)
              (let ((type-list (type-list-for-method-parameters method-sig)))
                (stack-sig-matches? (reverse type-list)
                                    (frame-stack frame)))))))

(defun invokestatic-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (invokestatic-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (let* ((class-name  (arg1 inst))
         (Method-Name (arg2 INST))
         (Method-Sig  (arg3 INST))
         (N-Word-Args (Sig-Argument-Word-Count Method-Sig)))
    (and (bound?-equal class-name (djvm-class-table djvm))
         (resolvable-method? class-name method-name method-sig djvm)
         (<= N-Word-Args (len (Djvm-Operand-Stack DJVM)))
         (let ((type-list (type-list-for-method-parameters method-sig))
               (current-frame (stack-top (djvm-stack djvm))))
           (and (>= (len (frame-stack current-frame))
                    (len type-list))
                (extended-jvm-type-listp type-list)
                (assignment-compatible-stack? (reverse type-list)
                                              (frame-stack current-frame)
                                              (djvm-class-table djvm)
                                              (djvm-heap djvm))
                (stack-instances-initialized-p (len type-list)
                                               (car (djvm-stack djvm)))))
         )))

(defmacro  invoke-static-method-macro ()
  `(if (Java-Static-Method-p Selected-Method)



       ;; Let NEW-FRAME be a new stack frame for the method, and bind
       ;; the object-ref and arguments as locals.

       (let ((New-Frame (Make-Frame :CLASS (Java-Method-Class-Name selected-Method)
                                    :METHOD selected-Method
                                    :PC     0
                                    :LOCALS (Bind-Arguments-As-Local-Vars
                                             N-Word-Args
                                             (Djvm-Operand-Stack DJVM))
                                    :STACK  nil
                                    :object-ref (ref-to-null)))
             (Calling-Frame (car (Djvm-Stack DJVM))))



         (if (not (equal "<clinit>" (java-method-name selected-method)))
             (if (not (equal "<init>" (java-method-name selected-method)))



                 ;; Now pop the operands from the operand stack in the calling
                 ;; frame, and push the new frame onto the call stack.

                 (set-Djvm-Stack (cons New-Frame
                                       (cons (Frame-Pop-N-Operands (1+ N-Word-Args)
                                                                   Calling-Frame)
                                             (cdr (Djvm-Stack DJVM))))
                                 DJVM)
               (djvm-error "Attempt to invoke a static method named <init>." inst djvm))
           (djvm-error "Attempt to invoke a static method named <clinit>." inst djvm)))
     (djvm-error "Attempt to invoke an instance method via invokestatic." inst DJVM)))

(defun execute-invokestatic-unoptimized (INST DJVM)
  (declare (xargs :guard (and (instruction-p INST)
                              (Djvm-p DJVM)
                              (non-empty (Djvm-Stack DJVM))
                              (non-empty (Frame-Stack (car (Djvm-Stack DJVM))))
                              (invokestatic-wff-inst? inst)
                              (Invokestatic-Proper-Arg-Types? INST (car (Djvm-Stack DJVM)))
                              (Invokestatic-Proper-Arg-Values? INST DJVM))
                  :guard-hints (("Goal" :do-not-induct t))
                  :verify-guards t))
  (let* ((class-name  (arg1 inst))
         (Method-Name (arg2 INST))
         (Method-Sig  (arg3 INST))
         (N-Word-Args (Sig-Argument-Word-Count Method-Sig)))
    (if (<= N-Word-Args (len (Djvm-Operand-Stack DJVM)))
        (if (class-defined? (djvm-current-class-name djvm) djvm)
            (let* ((resolved-method (resolved-method class-name method-name method-sig djvm)))
              (if (java-method-p resolved-method)
                  (if (class-defined? (java-method-class-name resolved-method) djvm)
                      (let ((selected-method resolved-method))
                        (if (java-method-p selected-method)
                            (if (java-bytecode-method-p selected-method)
                                (if (java-method-accessible-p selected-method
                                                              (djvm-current-class-name djvm)
                                                              (djvm-class-table djvm))
                                    (invoke-static-method-macro)
                                  (djvm-error "IllegalAccessError" inst djvm))
                              (djvm-error "Native methods not yet supported."
                                          inst djvm))
                          (djvm-error "Inconsistent Class Declarations" inst djvm)))
                    (djvm-error "Class of resolved method is not defined in class table."
                                inst djvm))
                (djvm-error "IncompatibleClassChangeError" inst djvm)))
          (djvm-error "Current class not defined in class-table." inst djvm))
      (djvm-error "Invokestatic applied with too few operands on the stack." inst DJVM))))

(defthm djvm-p-execute-invokestatic-unoptimized
  (implies (and (instruction-p INST)
                (Djvm-p DJVM)
                (non-empty (Djvm-Stack DJVM))
                (non-empty (Frame-Stack (car (Djvm-Stack DJVM))))
                (invokestatic-wff-inst? inst))
           (djvm-p (execute-invokestatic-unoptimized INST DJVM))))

(in-theory (disable execute-invokestatic-unoptimized))

(defthm weak-djvm-p-execute-invokestatic-unoptimized
  (implies (and (instruction-p INST)
                (Djvm-p DJVM)
                (non-empty (Djvm-Stack DJVM))
                (non-empty (Frame-Stack (car (Djvm-Stack DJVM))))
                (invokestatic-wff-inst? inst))
           (weak-djvm-p (execute-invokestatic-unoptimized INST DJVM)))
  :hints (("Goal"
           :in-theory (disable invokestatic-wff-inst?
                               invokestatic-proper-arg-types?
                               invokestatic-proper-arg-values?)
           :use (:instance WEAK-DJVM-P-IF-DJVM-P
                           (x (execute-invokestatic-unoptimized INST DJVM))))))


(define-defensive-instruction  djvm-execute-invokestatic
  invokestatic-wff-inst?
  invokestatic-proper-arg-types?
  identity-2
  invokestatic-proper-arg-values?
  execute-invokestatic-unoptimized
  identity-2
  :instruction-length 3)

(in-theory (disable execute-invokestatic-unoptimized))

(defthm djvm-p-djvm-execute-invokestatic
  (implies (djvm-p djvm)
           (djvm-p (djvm-execute-invokestatic inst djvm))))

(in-theory (disable djvm-execute-invokestatic))


