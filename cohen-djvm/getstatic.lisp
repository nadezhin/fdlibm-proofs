; http://www.computationallogic.com/software/djvm/html-0.5/getstatic.html

(in-package "ACL2")
(include-book "getfield")
(local (include-book "data-structures/alist-defthms" :dir :system))

; Getstatic Instruction

(defun static-field-value (field-name object)
  "Extract the value corresponding to FIELD-NAME in class-surrogate object OBJECT."
  (declare (xargs :guard (and (stringp field-name)
                              (a-class-p object)
                              (bound?-equal field-name (a-class-data object)))))
  (binding-equal field-name (a-class-data object)))

(defthm fv-p-static-field-value
  (implies (and (a-class-p object)
                (bound?-equal field-name (a-class-data object)))
           (fv-p (static-field-value field-name object))))

(defun static-field-in-class-surrogate? (field-name object)
  "Check whether the name FIELD-NAME is bound in the class-surrogate OBJECT."
  (declare (xargs :guard (and (stringp field-name)
                              (a-class-p object))))
  (bound?-equal field-name (a-class-data object)))

(defun getstatic-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (instruction-p inst)
       (equal   'getstatic (op-code inst))
       (stringp (arg1 inst))
       (stringp (arg2 inst))
       (stringp (arg3 inst))
       (field-type-sig-p (arg3 inst))))

(defun getstatic-proper-arg-types? (inst frame)
  (declare (xargs :guard (and (instruction-p inst)
                              (frame-p frame)))
           (ignore inst frame))
  t)

(in-theory (disable FV-LISTP-TRUE-LISTP
                    TV-REF-LISTP-CAR
                    TV-REF-LISTP
                    FV-P-DEFN
                    WEAK-TV-LISTP-CAR
                    WEAK-TV-LISTP
                    fv-p))

(defun static-field? (field-decl)
  "Test whether FIELD-DECL is a declaration of a static field."
  (declare (xargs :guard (field-p field-decl)
                  :guard-hints (("Goal"
                                 :in-theory
                                   (enable FIELD-ACCESS-FLAG-LISTP-true-listp)))))
  (memberp ':static (field-access-flags field-decl)))

(defun instance-field? (field-decl)
  "Test whether FIELD-DECL is a declaration of an instance field."
  (declare (xargs :guard (field-p field-decl)
                  :guard-hints (("Goal"
                                 :in-theory
                                   (enable FIELD-ACCESS-FLAG-LISTP-true-listp)))))
  (not (memberp ':static (field-access-flags field-decl))))

(defun getstatic-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm))
                  :guard-hints (("Goal" :do-not-induct t))))
  (let ((class-name (arg1 inst))
        (field-name (arg2 inst))
        (field-sig  (arg3 inst)))
    (and (bound?-equal class-name (djvm-class-table djvm))
         (let* ((class-decl (binding-equal class-name (djvm-class-table djvm)))
                (class-surrogate-ref (class-decl-surrogate class-decl))
                (field-decl (field-binding field-name
                                           (class-decl-fields
                                            (binding-equal class-name
                                                     (djvm-class-table djvm)))))
                (heap (djvm-heap djvm)))
         (and (field-bound? field-name (class-decl-fields class-decl))
              (equal field-sig (field-sig field-decl))
              (static-field? field-decl)
              (good-memory-ref-p class-surrogate-ref heap)
              (a-class-p (deref class-surrogate-ref heap))
              (bound?-equal field-name
                      (a-class-data (deref class-surrogate-ref heap))))))))

(defun djvm-execute-getstatic-optimized (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (getstatic-wff-inst? inst)
                              (getstatic-proper-arg-values? inst djvm))))



  (let* ((class-name (arg1 inst))
         (field-name (arg2 inst))
         (class-decl (binding-equal class-name (djvm-class-table djvm)))
         (class-surrogate-ref (class-decl-surrogate class-decl))
         (class-surrogate (deref class-surrogate-ref (djvm-heap djvm)))
         (field-value (static-field-value field-name class-surrogate)))
    (if (fv-p field-value)
        (if (sv-p field-value)
            (djvm-push-operand field-value djvm)
          (if (tv-long-p field-value)
              (let ((top-half (tv-wide-top-half field-value))
                    (bot-half (tv-wide-bot-half field-value)))
                (djvm-push-operand top-half
                                   (djvm-push-operand bot-half djvm)))
            (djvm-error "Non-sv-p field value is not tv-long-p?!" inst djvm)))
      (djvm-error "Field value is not a tagged value!" inst djvm))))

(defthm djvm-p-djvm-execute-getstatic-optimized
  (implies (djvm-p djvm)
           (djvm-p (djvm-execute-getstatic-optimized inst djvm))))

(defthm djvm-stack-djvm-execute-getstatic-optimized
  (implies (force (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))))
           (non-empty (djvm-stack (djvm-execute-getstatic-optimized inst djvm)))))

(defthm djvm-execute-getstatic-unoptimized-preserves-frame-method
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (equal (frame-method (car (djvm-stack
                                      (djvm-execute-getstatic-optimized inst djvm))))
                  (frame-method (car (djvm-stack djvm))))))

(in-theory (disable djvm-execute-getstatic-optimized))

(defthm weak-djvm-p-djvm-execute-getstatic-optimized
  (implies (force (djvm-p djvm))
           (weak-djvm-p (djvm-execute-getstatic-optimized inst djvm)))
  :hints (("Goal"
           :use (:instance WEAK-DJVM-P-IF-DJVM-P
                           (x (djvm-execute-getstatic-optimized inst djvm))))))

(defun getstatic-proper-value? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (getstatic-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (let* ((field-sig (arg3 inst))
         (type-list (type-list-for-field-type-sig field-sig)))
    (and (non-empty (djvm-operand-stack djvm))
         (stack-sig-matches? type-list
                             (djvm-operand-stack djvm)))))

(define-defensive-instruction  djvm-execute-getstatic
  getstatic-wff-inst?
  getstatic-proper-arg-types?
  identity-2
  getstatic-proper-arg-values?
  djvm-execute-getstatic-optimized
  getstatic-proper-value?
  :instruction-length 3)

(encapsulate ()
    (in-theory (disable OPERAND-STACK-SIZE-OK?
                                      djvm-pc
                                      valid-pc?
                                      STATIC-FIELD?
                                      GOOD-MEMORY-REF-P
                                      DEREF
                                      GETSTATIC-PROPER-ARG-VALUES?))
(defthm djvm-p-djvm-execute-getstatic
  (implies (djvm-p djvm)
           (djvm-p (djvm-execute-getstatic inst djvm)))))

(in-theory (disable djvm-execute-getstatic))

; Putstatic instruction

; Altering a Static Field

; The function set-static-field alters a specified field in a class object.

(defun set-static-field (field-name new-value object)
  (declare (xargs :guard (and (stringp field-name)
                              (a-class-p object)
                              (bound?-equal field-name (a-class-data object)))))
  (set-a-class-data (bind-equal field-name
                          new-value
                          (a-class-data object))
                     object))

(defthm a-class-p-set-static-field
  (implies (and (stringp field-name)
                (a-class-p object)
                (fv-p new-value))
           (a-class-p (set-static-field field-name
                                        new-value
                                        object))))

(defthm static-field-value-set-static-field
  (implies (and (stringp field-name)
                (a-class-p object)
                (fv-p new-value))
           (equal (static-field-value field-name-2
                                      (set-static-field field-name
                                                        new-value
                                                        object))
                  (if (equal field-name-2 field-name)
                      new-value
                    (static-field-value field-name-2 object)))))

(in-theory (disable set-static-field))

(defun putstatic-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (instruction-p inst)
       (equal   'putstatic (op-code inst))
       (stringp (arg1 inst))
       (stringp (arg2 inst))
       (stringp (arg3 inst))
       (field-type-sig-p (arg3 inst))))

(defun putstatic-proper-arg-types? (inst frame)
  (declare (xargs :guard (and (instruction-p inst)
                              (putstatic-wff-inst? inst)
                              (frame-p frame)))
           (ignore inst))
  (and (non-empty (frame-stack frame))
       (or (fv-p (first (frame-stack frame)))
           (and (non-empty (cdr (frame-stack frame)))
                (tv-long-top-half-p (first (frame-stack frame)))
                (tv-long-bot-half-p (second (frame-stack frame)))))))

(in-theory (disable FV-LISTP-TRUE-LISTP
                    TV-REF-LISTP-CAR
                    TV-REF-LISTP
                    FV-P-DEFN
                    WEAK-TV-LISTP-CAR
                    WEAK-TV-LISTP
                    fv-p))

(defun field-sig-ref-type? (field-sig)
  (declare (xargs :guard (stringp field-sig)))
  (and (stringp field-sig)
       (field-type-sig-p field-sig)
       (> (length field-sig) 2)
       (equal #\L (char field-sig 0))
       (equal #\; (char field-sig (1- (length field-sig))))))

(defun field-sig-class-name (field-sig)
  (declare (xargs :guard (and (stringp field-sig)
                              (field-sig-ref-type? field-sig))))
  (subseq field-sig 1 (- (length field-sig) 1)))

(defthm stringp-field-sid-class-name
  (implies (stringp field-sig)
           (stringp (field-sig-class-name field-sig)))
  :rule-classes (:type-prescription))

(defun putstatic-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (putstatic-wff-inst? inst)
                              (putstatic-proper-arg-types? inst (current-frame djvm)))
                  :guard-hints (("Goal" :do-not-induct t))))
  (let ((class-name (arg1 inst))
        (field-name (arg2 inst))
        (field-sig  (arg3 inst)))
    (and (non-empty (djvm-stack djvm))
         (non-empty (djvm-operand-stack djvm))
         (let ((new-value (car (djvm-operand-stack djvm))))
           (if (field-sig-ref-type? field-sig)
               (and (tv-ref-p new-value)
                    (good-memory-ref-p new-value (djvm-heap djvm))
                    (instance-of-class-p (deref new-value (djvm-heap djvm))
                                         (field-sig-class-name field-sig)
                                         (djvm-heap djvm)
                                         (djvm-class-table djvm)))
             (not (tv-ref-p new-value))))
         (bound?-equal class-name (djvm-class-table djvm))
         (let* ((class-decl (binding-equal class-name (djvm-class-table djvm)))
                (class-surrogate-ref (class-decl-surrogate class-decl))
                (field-decl (field-binding field-name
                                           (class-decl-fields
                                            (binding-equal class-name
                                                     (djvm-class-table djvm))))))
           (and (field-bound? field-name (class-decl-fields class-decl))
                (equal field-sig (field-sig field-decl))
                (static-field? field-decl)
                (good-memory-ref-p class-surrogate-ref (djvm-heap djvm))
                (a-class-p (deref class-surrogate-ref (djvm-heap djvm)))
                (bound?-equal field-name
                        (a-class-data (deref class-surrogate-ref (djvm-heap djvm))))))
         (let ((current-frame (stack-top (djvm-stack djvm))))
           (and (bound?-equal (frame-class current-frame) (djvm-class-table djvm))
                (djvm-field-accessible-p class-name
                                         field-name
                                         ;; frame-class yeilds a class name.
                                         (frame-class current-frame)
                                         (djvm-class-table djvm))))
         (if (equal field-sig "J")
             (and (non-empty (cdr (djvm-operand-stack djvm)))
                  (tv-long-top-half-p (first (djvm-operand-stack djvm)))
                  (tv-long-bot-half-p (second (djvm-operand-stack djvm))))
           (if (equal field-sig "I")
               (tv-int-p (first (djvm-operand-stack djvm)))
             (stack-values-satisfy-field-sig field-sig djvm)))
         )))

(defthm putstatic-helper-1
  (IMPLIES (AND (DJVM-P DJVM)
                (CONSP (DJVM-STACK DJVM))
                (WEAK-TV-P (CAR (FRAME-STACK (CAR (DJVM-STACK DJVM)))))
                (EQUAL (TV-TAG (CAR (FRAME-STACK (CAR (DJVM-STACK DJVM)))))
                       :LONG-TOP-HALF)
                (UNSIGNED-INT-VALUE-P (TV-VAL (CAR (FRAME-STACK
                                                    (CAR (DJVM-STACK DJVM)))))))
           (TV-TOP-HALF-P (CAR (FRAME-STACK (CAR (DJVM-STACK DJVM))))))
  :hints (("Goal" :in-theory '((:DEFINITION IMPLIES)
                               (:DEFINITION TV-TOP-HALF-P)
                               (:REWRITE UNSIGNED-INT-VALUE-P-TV-LONG-TOP-HALF-P)
                               (:TYPE-PRESCRIPTION UNSIGNED-INT-VALUE-P)
                               (:TYPE-PRESCRIPTION WEAK-TV-P)
                               (:EXECUTABLE-COUNTERPART EQUAL)
                               (:TYPE-PRESCRIPTION TV-TOP-HALF-P)))))

(defun djvm-execute-putstatic-optimized (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (putstatic-wff-inst? inst)
                              (putstatic-proper-arg-types? inst (current-frame djvm))
                              (putstatic-proper-arg-values? inst djvm))))



  (let* ((class-name (arg1 inst))
         (field-name (arg2 inst))
         (field-sig  (arg3 inst))
         (long-p (equal field-sig "J"))
         (new-field-value (if long-p
                              (make-tv-wide-value (first (djvm-operand-stack djvm))
                                                  (second (djvm-operand-stack djvm)))
                            (first (djvm-operand-stack djvm))))
         (class-decl (binding-equal class-name (djvm-class-table djvm)))
         (class-surrogate-ref (class-decl-surrogate class-decl))
         (class-surrogate (deref class-surrogate-ref (djvm-heap djvm))))
    (if (fv-p new-field-value)
        (let ((old-address (tv-val class-surrogate-ref))
              (new-object (set-static-field field-name
                                            new-field-value
                                            class-surrogate)))
          (set-djvm-heap (bind-equal old-address
                               new-object
                               (djvm-heap djvm))
                         (djvm-pop-operand
                          (if long-p
                              (djvm-pop-operand djvm)
                            djvm))))
      (djvm-error "Internal error: New field value does not satisfy fv-p!"
                  inst djvm))))

(defthm heap-p-bind-object-p
  (implies (force (and (heap-p heap)
                       (naturalp addr)
                       (object-p object)))
           (heap-p (bind-equal addr object heap))))

(defthm djvm-p-djvm-execute-putstatic-optimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (putstatic-wff-inst? inst)
                (putstatic-proper-arg-types? inst (current-frame djvm))
                (putstatic-proper-arg-values? inst djvm))
           (djvm-p (djvm-execute-putstatic-optimized inst djvm))))

(in-theory (disable djvm-execute-putstatic-optimized))

(defthm weak-djvm-p-djvm-execute-putstatic-optimized
  (implies (force (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (putstatic-wff-inst? inst)
                       (putstatic-proper-arg-types? inst (current-frame djvm))
                       (putstatic-proper-arg-values? inst djvm)))
           (weak-djvm-p (djvm-execute-putstatic-optimized inst djvm)))
  :hints (("Goal"
           :use ((:instance WEAK-DJVM-P-IF-DJVM-P
                            (x (djvm-execute-putstatic-optimized inst djvm)))))))

(defthm putstatic-proper-arg-types?-ignores-pc
  (implies (force (and (frame-p frame)
                       (non-empty (frame-stack frame))
                       (putstatic-proper-arg-types? inst frame)))
           (putstatic-proper-arg-types? inst (frame-set-pc new-pc frame)))
  :hints (("Goal" :in-theory (enable putstatic-proper-arg-types?))))

(defthm putstatic-proper-arg-values?-ignores-pc
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (putstatic-proper-arg-values? inst djvm))
           (putstatic-proper-arg-values? inst (djvm-set-pc new-pc djvm))))

(defthm non-empty-operand-stack-if-putstatic-proper-args
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (putstatic-proper-arg-types? inst (car (djvm-stack djvm))))
           (non-empty (frame-stack (car (djvm-stack djvm))))))

(in-theory (disable putstatic-proper-arg-types?
                    putstatic-proper-arg-values?))

(define-defensive-instruction  djvm-execute-putstatic
  putstatic-wff-inst?
  putstatic-proper-arg-types?
  identity-2
  putstatic-proper-arg-values?
  djvm-execute-putstatic-optimized
  true-2
  :instruction-length 3)

(defthm djvm-p-djvm-execute-putstatic
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-putstatic inst djvm))))

(in-theory (disable djvm-execute-putstatic))

