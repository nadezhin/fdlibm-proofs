; http://www.computationallogic.com/software/djvm/html-0.5/getfield.html

(in-package "ACL2")
(include-book "new-instance")
(local (include-book "data-structures/alist-defthms" :dir :system))

; Getfield Instruction

;The getfield instruction accesses a field in an instance and pushes the field value onto the operand stack. The instruction takes three arguments:
;
;    A fully-qualified class name
;    A (simple) field name
;    A field type-signature

;The function getfield-wff-inst? checks that its first argument is a syntactically well-formed getfield instruction. The dJVM instruction format requires that resolving indices to constant pool items be performed at load time. So a well-formed getfield instruction will have three string arguments.

(defn getfield-wff-inst? (inst)
  (and (instruction-p inst)
       (equal   'getfield (op-code inst))
       (stringp (arg1 inst))
       (stringp (arg2 inst))
       (stringp (arg3 inst))
       (field-type-sig-p (arg3 inst))))

; The operand stack in the frame must be non-empty, and the top-most operand must be a reference value. It must be a reference to an object considered initialized in the context of the frame.

(defun getfield-proper-arg-types? (inst frame)
  (declare (xargs :guard (and (instruction-p inst)
                              (frame-p frame)))
           (ignore inst))
  (and (non-empty (frame-stack frame))
       (tv-ref-p (stack-top (frame-stack frame)))
       (frame-initialized-ref-p (stack-top (frame-stack frame)) frame)))

;The resolution step is always the identity transformation in the dJVM 0.5. This step is intended as a place-holder for dynamic class loading as a future enhancement of the model.

(defn getfield-resolve-args (inst djvm)
  (declare (ignore inst))
  djvm)

;Remark: The JVMS description of getfield (p. 226) does not state that the type signature of the resolved field must match the type signature given in the getfield instruction. Surely they intended some relation between the two signatures.

;Apparently the JDK checks for equality, and reports a NoSuchFieldError if the signatures do not match. That error is documented as a linkage error and a subtype of IncompatibleClassChangeError, and may be thrown during resolution.[ 12.3.3, p. 221 in JLS]

;I cannot find this behavior documented either in the JLS or the JVMS.


;#+UNUSED
(defthm getfield-resolve-args-defn
  (implies (djvm-p djvm)
           (and (djvm-p (getfield-resolve-args inst djvm))
                (equal (djvm-heap (getfield-resolve-args inst djvm))
                       (djvm-heap djvm))
                (equal (djvm-stack (getfield-resolve-args inst djvm))
                       (djvm-stack djvm))
                (equal (djvm-status (getfield-resolve-args inst djvm))
                       (djvm-status djvm))
                (implies (bound?-equal x (djvm-class-table djvm))
                         (and (bound?-equal x (djvm-class-table
                                         (getfield-resolve-args inst djvm)))
                              (equal (binding-equal x (djvm-class-table
                                                 (getfield-resolve-args inst djvm)))
                                     (binding-equal x (djvm-class-table djvm)))))))
  :hints (("Goal" :in-theory (enable getfield-resolve-args))))


;First, we must test whether the class name identifies an entry in the class table, and that its class declaration declares a field with the appropriate name and type signature. This part of the test only checks the class declarations, it does not look at the object on the operand stack. The operand on top of the operand stack must be an object reference.

;Finally, the object being accessed by the getfield instruction must be an instance of the class named in the instruction.

;    The type of every class instance loaded from or stored into by a getfield or putfield instruction must be an instance of the class type or a subclass of the class type.
;    [ 4.8.2, p. 123 in JVMS]

;Remark: To which ``class type'' are they referring when they say ``the class type?'' Is it the class named in the getfile or putfield instruction? Or is it the current class (of the method)?

;I think this reference means the class named in the instruction.

;Remark: The JVMS description of getfield (p. 226) does not state that the type signature of the resolved field must match the type signature given in the getfield instruction.

;Surely they intended some relation between the two signatures. Apparently the JDK checks for equality, and reports a NoSuchFieldError if the signatures no not match.

;I cannot find this behavior documented either in the JLS or the JVMS. The JLS discussion of binary compatibility addresses the addition and deletion of field declarations, but not changing the declared type of a field.

;Remark: The predicate initialized-instance-of is not used yet. It would simplify some of the get/putfield descriptions, and possibly also method invocation. But I haven't gone through those definitions to structure them so this predicate fits.

(defun initialized-instance-of (object-ref class-name djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (let ((heap (djvm-heap djvm))
        (class-table (djvm-class-table djvm)))
    (and (tv-ref-p object-ref)
         (good-memory-ref-p object-ref heap)
         (instance-p (deref object-ref heap))
         (djvm-initialized-ref-p object-ref djvm)
         (instance-of-class-p (deref object-ref heap)
                              class-name
                              heap
                              class-table))))

(defun getfield-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (getfield-wff-inst? inst)
                              (djvm-p djvm))))
  (let ((class-name (arg1 inst))
        (field-name (arg2 inst))
        (field-sig  (arg3 inst)))
    (and (bound?-equal class-name (djvm-class-table djvm))
         (field-bound? field-name
                       (class-decl-fields (binding-equal class-name
                                                   (djvm-class-table djvm))))
         (equal field-sig
                (field-sig
                 (field-binding field-name
                                (class-decl-fields
                                 (binding-equal class-name
                                          (djvm-class-table djvm))))))
         (non-empty (djvm-stack djvm))
         (frame-p (stack-top (djvm-stack djvm)))
         (non-empty (op-stack (stack-top (djvm-stack djvm))))
         (let ((current-frame (stack-top (djvm-stack djvm))))
           (and (bound?-equal (frame-class current-frame) (djvm-class-table djvm))
                (djvm-field-accessible-p class-name
                                         field-name
                                         ;; frame-class yields a class name.
                                         (frame-class current-frame)
                                         (djvm-class-table djvm))))
         (let ((object-ref (stack-top (op-stack (stack-top (djvm-stack djvm)))))
               (heap (djvm-heap djvm)))
           (and (tv-ref-p object-ref)
                (good-memory-ref-p object-ref heap)
                (instance-p (deref object-ref heap))
                (instance-of-class-p (deref object-ref heap)
                                     class-name
                                     heap
                                     (djvm-class-table djvm))
                )))))

;Note that field-value will return a tagged value. Since the value may be a long integer, we must have a way of representing such values in instances. We choose to store long integer values as single field values in instances. The JVMS does not specify that field values in instances should be word-length values. However, the JVMS does specify that the operand stack and local variables can only hold word-length values.

;Remark: The body of the predicate field-in-instance? appears in numerous other functions. They should be replaced with calls to field-in-instance?.

(defun field-in-instance? (class-name field-name instance)
  (declare (xargs :guard (and (stringp class-name)
                              (stringp field-name)
                              (instance-p instance))))
  (and (bound?-equal class-name (instance-data instance))
       (bound?-equal field-name
               (binding-equal class-name (instance-data instance)))))

(defun field-value (class-name field-name object)
  (declare (xargs :guard (and (stringp class-name)
                              (stringp field-name)
                              (instance-p object)
                              (field-in-instance? class-name
                                                  field-name
                                                  object))))
  (binding-equal field-name (binding-equal class-name
                               (instance-data object))))


(defthm fv-p-field-value
  (implies (and (instance-p object)
                (field-in-instance? class-name field-name object))
           (fv-p (field-value class-name field-name object))))


(defthm tv-ref-p-top-operand-if-getfield-proper-arg-values?
  (implies (and (getfield-proper-arg-values? inst djvm)
                (djvm-stack djvm)
                (djvm-p djvm)
                (instruction-p inst))
           (tv-ref-p (car (frame-stack (car (djvm-stack djvm)))))))

; Finally, we can describe the behavior of the getfield instruction itself.

(defun djvm-execute-getfield-unoptimized (inst djvm)
  (declare (xargs :guard (and (getfield-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (getfield-proper-arg-values? inst djvm))
                  ;;:guard-hints (("Goal" :in-theory (enable sv-p)))
                  ))
    ;; We already know that...
    ;; 1. the call stack is not empty
    ;; 2. the operand stack is not empty
    ;; 3. the top of the operand stack is a reference to an instance
    ;; 4. the getfield instruction is well-formed



  (let ((instance (deref (djvm-top-operand djvm) (djvm-heap djvm)))
        (class-name (arg1 inst))
        (field-name (arg2 inst)))
    (if (field-in-instance? class-name field-name instance)
        (let ((field-value (field-value class-name
                                        field-name
                                        instance)))
          (if (fv-p field-value)
              (if (sv-p field-value)
                  (djvm-push-operand field-value
                                     (djvm-pop-operand djvm))
                (if (tv-long-p field-value)
                    (let ((top-half (tv-wide-top-half field-value))
                          (bot-half (tv-wide-bot-half field-value)))
                      (djvm-push-operand top-half
                                 (djvm-push-operand bot-half
                                                    (djvm-pop-operand djvm))))
                  (djvm-error "Non-sv-p field value is not tv-long-p?!" inst djvm)))
            (djvm-error "Field value is not a tagged value!" inst djvm)))
      (djvm-error "NoSuchField" inst djvm))))

(defthm djvm-p-djvm-execute-getfield-unoptimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (djvm-stk-sig-top? djvm :ref))
           (djvm-p (djvm-execute-getfield-unoptimized inst djvm)))
  :hints (("Goal" :in-theory (enable sv-p))))

(defthm weak-djvm-p-djvm-execute-getfield-unoptimized
  (implies (force (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (djvm-stk-sig-top? djvm :ref)))
           (weak-djvm-p (djvm-execute-getfield-unoptimized inst djvm)))
  :hints (("Goal"
           :in-theory (disable djvm-execute-getfield-unoptimized)
           :use (:instance WEAK-DJVM-P-IF-DJVM-P
                           (x (djvm-execute-getfield-unoptimized inst djvm))))))

(in-theory (disable fv-p))

(defthm djvm-stack-djvm-execute-getfield-unoptimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (djvm-stk-sig-top? djvm :ref))
           (non-empty (djvm-stack (djvm-execute-getfield-unoptimized inst djvm)))))

(defthm djvm-frame-stack-execute-getfield-inst
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (non-empty (frame-stack (car (djvm-stack djvm)))))
           (non-empty (frame-stack
                       (car (djvm-stack
                             (djvm-execute-getfield-unoptimized inst djvm)))))))

(observe io-3278
         (implies (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm)))
                  (sv-listp (djvm-operand-stack djvm))))

(defun getfield-proper-value? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (getfield-wff-inst? inst)



                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (non-empty (djvm-operand-stack djvm)))))
  (let* ((field-sig (arg3 inst))
         (type-list (type-list-for-field-type-sig field-sig)))
    (stack-sig-matches? type-list
                        (djvm-operand-stack djvm))))

; Finally, we can specify the complete getfield instruction.

(in-theory (disable DEREF
                    GOOD-MEMORY-REF-P))

(defthm djvm-execute-getfield-unoptimized-preserves-frame-method
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (non-empty (djvm-operand-stack djvm)))
           (equal (frame-method (car (djvm-stack
                                      (djvm-execute-getfield-unoptimized inst
                                                                         djvm))))
                  (frame-method (car (djvm-stack djvm)))))
  :hints (("Goal" :in-theory (enable djvm-execute-getfield-unoptimized))))

(in-theory (disable djvm-execute-getfield-unoptimized))

(define-defensive-instruction  djvm-execute-getfield
  getfield-wff-inst?
  getfield-proper-arg-types?
  getfield-resolve-args
  getfield-proper-arg-values?
  djvm-execute-getfield-unoptimized
  getfield-proper-value?
  :instruction-length 3)

(defthm djvm-p-djvm-execute-getfield
  (implies (djvm-p djvm)
           (djvm-p (djvm-execute-getfield inst djvm)))
  :hints (("Goal" :in-theory (disable valid-pc?
                                      operand-stack-size-ok?
                                      GETFIELD-WFF-INST?
                                      getfield-proper-value?
                                      djvm-execute-getfield-unoptimized
                                      ))))
(in-theory (disable djvm-execute-getfield))

;Putfield instruction

;Remark: Wouldn't it make sense to move this next to field value?

;And move both of them into a section on manipulating instances?

;Altering an Object Field

;The function set-instance-field alters a specified field in an object. We show that with the appropriate preconditions:
;
;    Given an instance, set-instance-field produces an instance;
;    Given an instance of a class, set-instance-field produces a result that is also an instance of that class;
;    Accessing fields via field-value and setting fields via set-instance-field interact properly.

;The function set-instance-field does not require that the new value be of the type declared for that field in the class declaration; that constraint will be imposed by the putfield instruction.

(defun set-instance-field (class-name field-name new-value object)
  (declare (xargs :guard (and (stringp class-name)
                              (stringp field-name)
                              (instance-p object)
                              (bound?-equal class-name (instance-data object))
                              (bound?-equal field-name
                                      (binding-equal class-name (instance-data object)))
                              (fv-p new-value))))
  (set-instance-data (bind-equal class-name
                           (bind-equal field-name
                                 new-value
                                 (binding-equal class-name (instance-data object)))
                           (instance-data object))
                     object))

(defthm instance-p-set-instance-field
  (implies (and (instance-p object)
                (stringp class-name)
                (stringp field-name)
                (bound?-equal class-name (instance-data object))
                (bound?-equal field-name
                        (binding-equal class-name (instance-data object)))
                (fv-p new-value))
           (instance-p (set-instance-field class-name
                                           field-name
                                           new-value
                                           object)))
  :hints (("Goal" :in-theory (enable set-instance-field))))

(defthm set-instance-field-preserves-instance-of
  (implies (and (instance-p object)
                (stringp class-name)
                (stringp field-name)
                (bound?-equal class-name (instance-data object))
                (bound?-equal field-name
                        (binding-equal class-name (instance-data object)))
                (fv-p new-value)
                (heap-p heap)
                (class-table-p class-table)
                (instance-of-class-p object class-name heap class-table))
           (instance-of-class-p (set-instance-field class-name
                                                    field-name
                                                    new-value
                                                    object)
                                class-name
                                heap
                                class-table)))

(defthm field-value-set-instance-field
  (implies (and (instance-p object)
                (stringp class-name)
                (stringp field-name)
                (bound?-equal class-name (instance-data object))
                (bound?-equal field-name
                        (binding-equal class-name (instance-data object)))
                (fv-p new-value)
                (heap-p heap)
                (class-table-p class-table)
                (instance-of-class-p object class-name heap class-table))
           (equal (field-value class-name-2
                               field-name-2
                               (set-instance-field class-name
                                                   field-name
                                                   new-value
                                                   object))
                  (if (and (equal class-name-2 class-name)
                           (equal field-name-2 field-name))
                      new-value
                    (field-value class-name-2
                                 field-name-2
                                 object)))))

(in-theory (disable set-instance-field))

; Details of the putfield instruction

;    The type of every value stored by a putfield or putstatic instruction must be compatible with the descriptor of the field of the class instance or class stored into.

;    If the descriptor type is a reference type, then the value must be of a type that is assignment compatible with the descriptor type.
;    [4.9.4, p. 123 in JVMS]

; Remark: Must the instance have been initialized?

; If the value being stored is a reference value, must the value be an ``initialized'' instance?

; Where is this stated? Instance initialization handling in the bytecode verifier is described around JVMS p. 132.

; The JLS suggests that a JVM without a bytecode verifier or some other means of consistency checking may not properly implement Java. Does the JVMS anywhere state what role the requirements imposed by the bytecode verifier are meant to play? Especially since code loaded from local disk is not verified!!

(defun putfield-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (instruction-p inst)
       (= (len inst) 4)
       (equal 'putfield (op-code inst))
       (stringp (arg1 inst))
       (stringp (arg2 inst))
       (stringp (arg3 inst))
       (field-type-sig-p (arg3 inst))))

;    The type of a value stored by a putfield instruction must be compatible with the descriptor of the field of the class instance being stored into. If the field descriptor type is byte, char, short, or int, then the value must be an int.
;    [p. 325 in JVMS]

;We also check that the object being altered is an initialized instance in the context of this frame, and that if the value being stored is a reference value that it is a reference to an initialized instance.

;Remark: I think that JVM programs are prohibited from storing references to uninitialized objects into fields.

;Such a restriction is imposed by the bytecode verifier. The bytecode verifier considers references to uninitialized objects not to refer to instances of the object's type until the object has been initialized. (See 4.9.4, page 132, in the Java Virtual Machine Specification.)

;Like many type-safety properties of JVM execution, this seems only to be stated implicitly as a result of bytecode verification.

;I think that the JVM is only intended to execute programs passed by the bytecode verifier. However, the following quote seems to state the constraint in terms of the static and structural constraints given for well-formed class files.

;    The description of each instruction is always given in the context of Java Virtual Machine code that satisfies the static and structural constraints of Chapter 4 [which describes the class file format]. If some constraint in an instruction description is not satisfied at run time, the behavior of the Java Virtual Machine is undefined.
;    [ 6.1, p. 151 in JVMS]

;They later suggest that the bytecode verifier is intended to verify that a class file satisfies these desired constraints.

;    The Java Virtual Machine needs to verify for itself that the desired constraints hold on the class files it attempts to incorporate.

;    Sun's Java Virtual Machine implementation verifies that each class file it considers untrustworthy satisfies the necessary constraints at linking time.

;    Any class file that satisfies the structural criteria and static constraints will be certified by the verifier.
;    [ 4.9, pp. 124-5 in JVMS]

;However, I don't see that the static and structural constraints given in JVMS chapter 4 are strong enough to preclude storing a reference to an uninitialized object into the field of an initialized object.

;The bytecode verifier's enforces the constraint that

;    The type of every value stored by a putfield or putstatic instruction must be compatible with the descriptor of the field.
;    [ 4.8.2, p. 123 in JVMS]

;This implies the prohibition mentioned above if uninitialized instances are not considered compatible with their ``intended'' or ``eventual'' types. The verifier treats uninitialized instances in this fashion. However, JVMS references to ``method invocation compatible'' and ``assignment compatible'' are in JVMS chapter 2 (Java Concepts), and the Java language does not admit the concept of an uninitialized instance (at least not in the sense used here).

;Remark: Is there anything in the JVMS that prohibits storing a reference to an uninitialized instance into a field?

(defun putfield-proper-arg-types? (inst frame)
  (declare (xargs :guard (and (instruction-p inst)
                              (frame-p frame)))
           (ignore inst))
  (and (non-empty (frame-stack frame))
       (if (tv-long-top-half-p (first (frame-stack frame)))
           (and (non-empty (cdr (frame-stack frame)))
                (non-empty (cdr (cdr (frame-stack frame))))
                (tv-long-bot-half-p (second (frame-stack frame)))
                (tv-ref-p (third (frame-stack frame)))
                (frame-initialized-ref-p (third (frame-stack frame))
                                         frame))
         (and (non-empty (cdr (frame-stack frame)))
              (fv-p (first (frame-stack frame)))
              (tv-ref-p (second (frame-stack frame)))
              (frame-initialized-ref-p (second (frame-stack frame))
                                       frame)
              (or (not (tv-ref-p (first (frame-stack frame))))
                  (frame-initialized-ref-p (first (frame-stack frame))
                                           frame))))))

;Remark: The JVMS description of putfield (p. 326) does not state that the type signature of the resolved field must match the type signature given in the putfield instruction.

;Surely they intended some relation between the two signatures. Apparently the JDK checks for equality, and reports a NoSuchFieldError if the signatures no not match.

;I cannot find this behavior documented either in the JLS or the JVMS.

;Remark: The JVMS states that the value on top of the operand stack must be an int value if the field specifier is ``B'' (for byte) or ``S'' (for short). However, there is no indication whether the full 32-bit int value is stored in the byte or short field, or whether only an 8 or 16-bit value should be stored.

;A similar question applies to the definition of getfield. Must the instance field contain a byte or short value, or must it be able to hold an int value?

;The JLS clearly requires this to be a byte value by type-correctness rules. But the JVM allows short and int values where JLS type-checking requires a value to be a narrower integer value. Thus again, we are reminded that the semantics of the JVM are not defined by the semantics of Java. I did find an answer in the JVMS.

;Sun's JDK 1.1 appears to implement byte and short fields as int fields. I believe this was documented in an early version of the JDK (alpha or beta).

;    The bytecode verifier does not need to distinguish between the integral types (e.g., byte, short, char) when determining the value types on the operand stack.
;    [ 4.9.2, p. 129 in JVMS]

;This assumes that the bytecode verifier ignores the narrowing effect of the i2b, i2c, and i2s instructions.

;Note on JVM Semantics: Note: this question does not arise with respect to arrays of byte or arrays of short, because the bastore and sastore instructions are explicitly defined to truncate [not ``narrow''] the int operand value to the appropriate range.

(defun putfield-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (putfield-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))
                  :guard-hints (("Goal" :in-theory
                                 (disable djvm-class-table
                                          class-decl-fields
                                          field-bound?
                                          field-binding
                                          djvm-field-accessible-p
                                          good-memory-ref-p
                                          instance-p)))))
  (let ((class-name (arg1 inst))
        (field-name (arg2 inst))
        (field-sig  (arg3 inst)))
    (and (non-empty (djvm-stack djvm))
         (non-empty (djvm-operand-stack djvm))
         (putfield-proper-arg-types? inst (current-frame djvm))
         (bound?-equal class-name (djvm-class-table djvm))
         (let ((class-decl (binding-equal class-name (djvm-class-table djvm))))
           (and (field-bound? field-name (class-decl-fields class-decl))
                (equal field-sig
                       (field-sig (field-binding field-name
                                                 (class-decl-fields class-decl))))))
         (let ((current-frame (stack-top (djvm-stack djvm))))
           (and (bound?-equal (frame-class current-frame) (djvm-class-table djvm))
                (djvm-field-accessible-p class-name
                                         field-name
                                         ;; frame-class yeilds a class name.
                                         (frame-class current-frame)
                                         (djvm-class-table djvm))))
         (let* ((long-p (tv-long-top-half-p (first (djvm-operand-stack djvm))))
                (object-ref (if long-p
                                (second (djvm-operand-stack djvm))
                                (third (djvm-operand-stack djvm))))
                 (heap (djvm-heap djvm)))
           (and (tv-ref-p object-ref)
                (good-memory-ref-p object-ref heap)
                (instance-p (deref object-ref heap))
                (djvm-initialized-ref-p object-ref djvm)
                (instance-of-class-p (deref object-ref heap)
                                     class-name
                                     (djvm-heap djvm)
                                     (djvm-class-table djvm))
                (field-in-instance? class-name field-name
                                    (deref object-ref heap)))))))

;For reference types putfield-proper-arg-values? must check that the stack value references an object that is an instance of the class named in the field signature. Note that a field signature is the type of a single field. The corresponding type list may have two elements for two-word types (e.g., type long). For all non-reference types the corresponding type list is a list of type tags (related to the type in the obvious way). For reference types the type list is a single structured element composed of the type tag :ref and a class name.

(defun stack-values-satisfy-field-sig (field-sig djvm)
  (declare (xargs :guard (and (stringp field-sig)
                              (field-type-sig-p field-sig)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (non-empty (djvm-operand-stack djvm)))))
  (let ((type-list (type-list-for-field-type-sig field-sig)))
    (case-match type-list
                ('(:int)  (tv-int-p (car (djvm-operand-stack djvm))))
                ('(:long-top-half :long-bot-half)
                 (and (non-empty (cdr (djvm-operand-stack djvm)))
                      (tv-long-top-half-p (first  (djvm-operand-stack djvm)))
                      (tv-long-top-half-p (second (djvm-operand-stack djvm)))))
                (((':ref class-name))
                 (and (tv-ref-p (car (djvm-operand-stack djvm)))
                      (bound?-equal class-name (djvm-class-table djvm))
                      (let ((ref-value (car (djvm-operand-stack djvm)))
                            (heap (djvm-heap djvm)))
                        (and (good-memory-ref-p ref-value heap)
                             (instance-p (deref ref-value heap))
                             (djvm-initialized-ref-p ref-value djvm)
                             (instance-of-class-p (deref ref-value heap)
                                                  class-name
                                                  heap
                                                  (djvm-class-table djvm)))))))))

(defun djvm-execute-putfield-optimized (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (putfield-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (putfield-proper-arg-types? inst (current-frame djvm))
                              (putfield-proper-arg-values? inst djvm))))



    ;; We already know that...
    ;; 1. the call stack is not empty
    ;; 2. the operand stack is not empty
    ;; 3. the top one or two stack operands represent a field-value
    ;; 4. the stack operand below that is a reference
    ;; 5. the putfield instruction is well-formed



  (let* ((long-p (tv-long-top-half-p
                  (first (djvm-operand-stack djvm))))
         (object-ref (if long-p
                         (second (djvm-operand-stack djvm))
                       (third (djvm-operand-stack djvm))))
         (new-field-value (if long-p
                              (make-tv-wide-value (first (djvm-operand-stack djvm))
                                                  (second (djvm-operand-stack djvm)))
                            (first (djvm-operand-stack djvm))))
         (instance (deref object-ref (djvm-heap djvm)))
         (class-name (arg1 inst))
         (field-name (arg2 inst))
         (field-sig  (arg3 inst)))
    (if (stack-values-satisfy-field-sig field-sig djvm)
        (let ((old-address (tv-val object-ref))
              (new-object (set-instance-field class-name
                                              field-name
                                              new-field-value
                                              instance)))
          (set-djvm-heap (bind old-address
                               new-object
                               (djvm-heap djvm))
                         (djvm-pop-operand
                          (djvm-pop-operand
                           (if long-p
                               (djvm-pop-operand djvm)
                             djvm)))))
      (djvm-error "New field value does not satisfy field-type specification."
                  inst djvm))))

(defthm djvm-p-djvm-execute-putfield-optimized
  (implies (force (and (putfield-wff-inst? inst)
                       (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (putfield-proper-arg-types? inst (current-frame djvm))
                       (putfield-proper-arg-values? inst djvm)))
           (djvm-p (djvm-execute-putfield-optimized inst djvm))))

(in-theory (disable djvm-execute-putfield-optimized))

(defthm weak-djvm-p-djvm-execute-putfield-optimized
  (implies (force (and (putfield-wff-inst? inst)
                       (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (putfield-proper-arg-types? inst (current-frame djvm))
                       (putfield-proper-arg-values? inst djvm)))
           (weak-djvm-p (djvm-execute-putfield-optimized inst djvm)))
  :hints (("Goal"
           :in-theory (disable putfield-wff-inst?
                               putfield-proper-arg-types?
                               putfield-proper-arg-values?)
           :use (:instance WEAK-DJVM-P-IF-DJVM-P
                           (x (djvm-execute-putfield-optimized inst djvm))))))

(defun putfield-proper-value? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm)))
           (ignore inst djvm))
  t)

(defthm putfield-proper-arg-types?-ignores-pc-2
  (implies (force (and (frame-p frame)
                       (non-empty (frame-stack frame))
                       (putfield-proper-arg-types? inst frame)))
           (putfield-proper-arg-types? inst (frame-set-pc new-pc frame)))
  :hints (("Goal" :in-theory (enable putfield-proper-arg-types?))))

(defthm putfield-proper-arg-values?-ignores-pc
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (putfield-proper-arg-values? inst djvm))
           (putfield-proper-arg-values? inst (djvm-set-pc new-pc djvm))))

(defthm non-empty-operand-stack-if-putfield-proper-args
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (putfield-proper-arg-types? inst (car (djvm-stack djvm))))
           (non-empty (frame-stack (car (djvm-stack djvm))))))

(defthm djvm-execute-putfield-optimized-preserves-frame-method
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (non-empty (djvm-operand-stack djvm)))
           (equal (frame-method (car (djvm-stack
                                      (djvm-execute-putfield-optimized inst djvm))))
                  (frame-method (car (djvm-stack djvm)))))
  :hints (("Goal" :in-theory (enable djvm-execute-putfield-optimized
                                     djvm-push-operand
                                     djvm-pop-operand
                                     ))))

(in-theory (disable putfield-wff-inst?
                    putfield-proper-arg-types?
                    putfield-proper-arg-values?
                    djvm-execute-putfield-optimized
                    putfield-proper-value?))

(define-defensive-instruction  djvm-execute-putfield
  putfield-wff-inst?
  putfield-proper-arg-types?
  identity-2
  putfield-proper-arg-values?
  djvm-execute-putfield-optimized
  putfield-proper-value?
  :instruction-length 3
  :guard-hints (("Goal" :in-theory (disable djvm-set-pc))))

(defthm djvm-p-djvm-execute-putfield
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-putfield inst djvm))))

(in-theory (disable djvm-execute-putfield))
