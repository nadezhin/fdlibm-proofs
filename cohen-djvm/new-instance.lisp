; http://www.computationallogic.com/software/djvm/html-0.5/new-instance.html

(in-package "ACL2")
(include-book "define-inst-macro")
(local (include-book "data-structures/alist-defthms" :dir :system))

; Building and Manipulating Instances

;Building an Instance Value

;    All the instance variables in the new object, including those declared in superclasses, are initialized to their default values.
;    [ 12.5, p. 288 in JLS]

;Note on Java Semantics: Instance fields and static fields are always given initial values by the JVM. These default initial values may be superseded by actions of the class and instance initialization methods.

;In contrast, local variables of a method are not given default initial values by the JVM. Thus the Java compiler and the JVM are obliged to assure that each local variable has been assigned a value before any attempted use of the variable's value.

;Note on JVM Semantics: The dJVM tests whether a variable has been assigned a value before each attempt to use that variable's value. However, to improve efficiency the standard JVM tests for ``definite assignment'' to the local variable using static analysis of the method body as part of the bytecode verification process. The bytecode verifier has two conflicting goals: (1) to reject all unsafe programs and (2) to analyze programs quickly. As a practical compromise the JVM specifies a conservative analysis algorithm that rejects some safe programs, but runs relatively quickly compared to other algorithms that reject fewer safe programs.

;The definition of default-value-for-sig below takes advantage of the fact that (:ref 0) is a reference to null, which is the default initial value for reference types. If the first character of the field signature is ``I'' then the default value will be (:int 0); if it is ``J'' then the default will be (:long 0); and if it is ``L'' then the default will be (:ref 0), which is a reference to null.

;Remark: This definition of default-value-for-sig is a cheap hack. It should return (ref-to-null) for reference types. Currently it takes advantage of (ref-to-null) being (:ref 0).

(defun default-value-for-sig (field-sig)
  (declare (xargs :guard (and (field-sig-p field-sig)
                              (< 0 (length field-sig)))))
   (let ((tag (case (char field-sig 0)
                (#\I ':int)
                (#\J ':long)
                (#\L ':ref))))
     (make-tv tag 0)))

(defun Field-Default-Value (Field-Decl)
  (declare (xargs :guard (and (Field-p Field-Decl)
                              (Field-Sig-p (Field-Sig Field-Decl)))))
  (Default-Value-For-Sig (Field-Sig Field-Decl)))

(defun Build-Class-Field-Bindings (Field-List)
  (declare (xargs :guard (Field-listp Field-List)))
  (if (endp Field-List)
      nil
    (bind-equal (Field-Name (car Field-List))
          (if (Field-Sig-p (Field-Sig (car Field-List)))
              (Field-Default-Value (car Field-List))
            ':unbound)
          (Build-Class-Field-Bindings (cdr Field-List)))))

(observe fact-501
         (implies (field-listp fields)
                  (var-binding-p (build-class-field-bindings fields))))

(observe fact-502
         (implies (class-decl-p cdecl)
                  (field-listp (class-decl-fields cdecl))))

(observe fact-503
         (implies (field-p fdecl)
                  (field-sig-p (field-sig fdecl))))

(observe fact-504
         (implies (and (djvm-p djvm)
                       (bound?-equal class-name (djvm-class-table djvm)))
                  (field-listp (class-decl-fields
                                      (binding-equal class-name
                                               (djvm-class-table djvm))))))

(defun build-immediate-instance-data (class-decl)
  (declare (xargs :guard (class-decl-p class-decl)))
  (cons (class-decl-name class-decl)
        (build-class-field-bindings (class-decl-fields class-decl))))

(defun build-instance-data (class-names class-table)
  (declare (xargs :guard (and (string-listp class-names)
                              (class-table-p class-table)
                              (all-bound?-equal  class-names class-table))))
  (if (endp class-names)
      nil
    (cons (build-immediate-instance-data (binding-equal (car class-names)
                                                  class-table))
          (build-instance-data (cdr class-names) class-table))))


(defthm var-binding-p-build-class-field-bindings
   (implies (field-listp fields)
            (var-binding-p (build-class-field-bindings fields))))

(defthm stringp-class-decl-name
  (implies (class-decl-p cdecl)
           (stringp (class-decl-name cdecl)))
  :rule-classes (:rewrite :type-prescription))

(defthm instance-data-p-build-instance-data
  (implies (and (string-listp class-names)
                (class-table-p class-table)
                (all-bound?-equal  class-names class-table))
           (instance-data-p (build-instance-data class-names class-table)))
  :hints (("Goal" :in-theory (enable instance-data-p))))

(in-theory (disable build-instance-data))

(defthm consp-if-weak-class-decl-p
  (implies (weak-class-decl-p x)
           (consp x))
  :hints (("Goal" :in-theory (enable weak-class-decl-p)))
  :rule-classes (:forward-chaining))

; Before building an instance of a class, we check that the class is not declared abstract. Any class that contains an abstract method, whether as a locally declared method or as an inherited method, should be declared abstract.

; We choose only to check whether the immediate class has been declared abstract. Of course this means we must check that we never attempt to invoke an abstract method, since we have not checked that all abstract methods have been overridden with implementated methods. We do not check the requirement on superclasses here. That invariant may be required for well-formed JVM states.

(defun class-decl-class-names (class-decl)
  (declare (xargs :guard (class-decl-p class-decl)))
  (cons (class-decl-name class-decl)
        (class-decl-superclasses class-decl)))

(defthm true-listp-class-decl-superclasses
  (implies (class-decl-p x)
           (true-listp (class-decl-superclasses x)))
  :rule-classes (:rewrite :type-prescription))

(defthm true-listp-class-decl-class-names
  (implies (class-decl-p x)
           (true-listp (class-decl-class-names x)))
  :rule-classes (:rewrite :type-prescription))

(defthm true-listp-class-decl-super-classes
  (implies (class-decl-p x)
           (true-listp (class-decl-superclasses x)))
  :rule-classes (:rewrite :type-prescription))

(defun class-superclasses-all-bound? (class-name class-table)
  (declare (xargs :guard (and (stringp class-name)
                              (class-table-p class-table)
                              (bound?-equal class-name class-table))))
  (all-bound?-equal (class-decl-superclasses (binding-equal class-name class-table))
              class-table))

(defun build-an-instance (class-name class-table)
  (declare (xargs :guard (and (stringp class-name)
                              (class-table-p class-table)
                              (bound?-equal class-name class-table)
                              (class-superclasses-all-bound? class-name
                                                             class-table))))
  (let ((cdecl (binding-equal class-name class-table)))
    (make-an-instance :class (class-decl-surrogate cdecl)
                      :data  (build-instance-data
                              (cons class-name (class-decl-superclasses cdecl))
                              class-table)
                      :lock   nil)))

(defthm instance-p-build-an-instance
  (implies (and (djvm-p djvm)
                (stringp class-name)
                (bound?-equal class-name (djvm-class-table djvm))
                (class-superclasses-all-bound? class-name (djvm-class-table djvm)))
           (instance-p (build-an-instance class-name (djvm-class-table djvm)))))

(defthm instance-p-build-an-instance-2
  (implies (and (class-table-p class-table)
                (stringp class-name)
                (bound?-equal class-name class-table)
                (class-superclasses-all-bound? class-name class-table))
           (instance-p (build-an-instance class-name class-table)))
  :hints (("Goal" :in-theory (enable build-an-instance))))

(in-theory (disable build-an-instance))

; Finding an Unused Heap Address

; Each object in the heap is associated with a unique address (i.e., a unique natural number). When we allocate a new object in the heap, we must associate the new object with a new address. In the dJVM we choose the new address to be the smallest natural number not already associated with an object in the heap. The function min-unused-heap-address computes that value.

(defun min-missing-integer (i addresses)
  (declare (xargs :guard (and (naturalp i)
                              (naturalp-listp addresses))
                  :measure (len addresses)
                  :guard-hints (("Goal" :in-theory (enable naturalp-listp)))))
  (if (null (member i addresses))
      i
    (min-missing-integer (1+ i)
                         (remove i addresses))))

(defthm min-missing-integerp-type-prescription
  (implies (naturalp i)
           (naturalp (min-missing-integer i naturals)))
  :rule-classes (:rewrite :type-prescription))

(defthm min-missing-integer-linear
  (<= i (min-missing-integer i naturals))
  :rule-classes :linear)

(defthm member-equal-is-member-on-integers
  (implies (integerp x)
           (and (equal (member-equal x list)
                       (member x list))
                (equal (remove-equal x list)
                       (remove x list))))
  :rule-classes ())

(defthm min-missing-integer-fact-1
  (not (equal (min-missing-integer (+ 1 i) addresses)
              i)))

(defthm min-missing-integer-fact-2
  (implies (< j0 j)
           (not (equal (min-missing-integer j addresses)
                       j0))))

(defthm car-remove
  (implies (and (eqlablep x)
                (eqlablep y)
                (not (equal x y))
                (equal (car list) x))
           (equal (car (remove y list))
                  (car list))))

(defthm member-remove
  (implies (and (EQLABLEP x)
                (eqlablep y)
                (not (equal x y)))
           (iff (member x (remove y list))
                (member x list))))

(defthm min-missing-integer-property
  (implies (naturalp i)
           (equal (member (min-missing-integer i addresses) addresses)
                  nil)))

;Note that we can't use heap address zero, as that address is distinguished as referencing the null object. So min-unused-heap-address searches for the smallest unused heap-address greater than zero.

(defun min-unused-heap-address (heap)
  (declare (xargs :guard (heap-p heap)
                  :guard-hints (("goal" :in-theory (disable domain)))))
  (min-missing-integer 1 (domain heap)))

(defthm min-unused-heap-address-type-prescription
  (naturalp (min-unused-heap-address heap))
  :rule-classes (:rewrite :type-prescription))

(defthm not-member-min-unused-heap-address-domain-heap
  (implies (heap-p heap)
           (not (member (min-unused-heap-address heap)
                        (domain heap)))))

(defthm member-equal-is-member
  (implies (eqlablep x)
           (iff (member-equal x list)
                (member x list)))
  :rule-classes ())

(defthm not-member-equal-min-unused-heap-address-domain-heap
  (implies (and (integerp (min-unused-heap-address heap))
                (heap-p heap))
           (not (member-equal (min-unused-heap-address heap)
                              (domain heap)))))

; The lemma member-equal-domain is taken from the book alist-defthms.

(defthm member-equal-domain
  (implies (alistp a)
           (iff (member-equal x (domain a))
                (bound?-equal x a)))
  :hints (("Goal" :induct (assoc-equal x a)
           :in-theory (enable domain bound?))))

(defthm not-bound?-min-unused-heap-address
        (implies (heap-p heap)
                 (not (bound?-equal (min-unused-heap-address heap)
                              heap)))
        :hints (("Goal"
                 :in-theory (disable member-equal-domain)
                 :use (:instance member-equal-domain
                                 (x (min-unused-heap-address heap))
                                 (a heap)))))

(defthm unbound-min-unused-heap-address
  (implies (heap-p heap)
           (not (bound?-equal (min-unused-heap-address heap) heap)))
  :hints (("Goal" :in-theory (disable min-unused-heap-address bound?-equal))))

(in-theory (disable min-unused-heap-address))

; Creating a new instance in the heap

(defun djvm-make-new-instance-optimized (class-name djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (bound?-equal class-name (djvm-class-table djvm)))
                  :guard-hints (("Goal" :in-theory (enable value-of-type?)))))
  (let* ((class-table (djvm-class-table djvm))
         (cdecl (binding-equal class-name class-table)))
    (if (and (class-decl-p cdecl)
             (not (abstract-class-p cdecl))
             (all-bound?-equal (class-decl-superclasses cdecl)
                         class-table)
             (good-memory-ref-p (class-decl-surrogate cdecl) (djvm-heap djvm))
             (let ((class-surrogate (deref (class-decl-surrogate cdecl)
                                           (djvm-heap djvm))))
               (and (a-class-p class-surrogate)
                    (equal class-name (A-CLASS-NAME class-surrogate)))))
        (let ((new-object  (build-an-instance class-name class-table))
              (new-address (min-unused-heap-address (djvm-heap djvm))))
          (if (unsigned-int-value-p new-address)
              (let ((ref-to-new-object (make-tv :ref new-address)))
                (djvm-mark-new-ref
                 ref-to-new-object
                 (djvm-push-operand ref-to-new-object
                                    (set-djvm-heap (bind-equal new-address
                                                         new-object
                                                         (djvm-heap djvm))
                                                   djvm))))
            (set-djvm-status "OutOfMemoryError" djvm)))
      (set-djvm-status "Ill-formed class definition" djvm))))

; After we make a new instance, the previous min-unused-heap-address is bound to the new object. We can deduce that it is no longer unbound.

(observe fact-510
     (implies (and (djvm-p djvm)
                   (non-empty (djvm-stack djvm))
                   (stringp class-name)
                   (bound?-equal class-name (djvm-class-table djvm))
                   (class-superclasses-all-bound? class-name
                                                  (djvm-class-table djvm)))
              (djvm-p (djvm-make-new-instance-optimized class-name djvm))))

(observe fact-510a
     (implies (and (djvm-p djvm)
                   (non-empty (djvm-stack djvm))
                   (stringp class-name)
                   (bound?-equal class-name (djvm-class-table djvm))
                   (class-superclasses-all-bound? class-name
                                                  (djvm-class-table djvm)))
              (djvm-p (djvm-make-new-instance-optimized class-name djvm)))
     ;;:hints (("Goal" :in-theory (disable sv-p-make-tv-ref)))
     )

(observe fact-511
     (implies (and (djvm-p djvm)
                   (non-empty (djvm-stack djvm))
                   (stringp class-name)
                   (bound?-equal class-name (djvm-class-table djvm))
                   (class-superclasses-all-bound? class-name
                                                  (djvm-class-table djvm))
                   (equal ':run (djvm-status djvm)))
              (iff (equal ':run
                          (djvm-status
                           (djvm-make-new-instance-optimized class-name djvm)))
                   (bound?-equal (min-unused-heap-address (djvm-heap djvm))
                           (djvm-heap (djvm-make-new-instance-optimized class-name
                                                                        djvm))))))

; InstanceOf Instruction

; The instanceOf instruction takes an operand on the stack and checks to see whether it is an instance of the class name provided as the instruction argument. The operand should be a value of a reference type. The operand is popped from the stack. The int value 1 if the operand is an instance of the named class, and the int value 0 is pushed otherwise.

;Check whether an object is an instance of a given class. We only check that:
;
;    The object is an instance.
;    The given class name is bound in the class table.
;    The object's class surrogate points to a class declaration that claims to be the given class or a subclass of the given class.

;    [1]#1 An objectref that is not null is an instance of the resolved type: if S is the class of the object referred to by objectref and [class] T is the resolved class , instanceof determines whether objectref is an instance of T if S [is] the same class as T or a subclass of T.
;    [ 6.4, p. 256-7 in JVMS]

;Note on JVM Semantics: It is unclear how the instanceof instruction should behave on uninitialized instances. The bytecode verifier will reject such programs, because a reference value is not considered to be of the declared type until the instance has been initialized. So the JDK verifier will fail with the message


;      Expecting to find object/array on stack

;because the type associated with the new reference is not yet considered to be a reference type.

;Since the Java Virtual Machine Specification only specifies the behavior of programs that passed by the bytecode verifier, the appropriate behavior of a defensive JVM is not clear.

;Remark: We should probably check that the instance has been initialized. That's the most conservative thing to do.

;We expect that the object is also an instance of all of the superclasses of the given class, but we do not check that here. Since we don't check that property here, we must check each time a field and method access is attempted that the named field or method actually exists for the instance.

;Presumably such a property is one part of being a well-formed JVM state. If we knew the that the dJVM state satisfied this property, then we could elide the run-time check mentioned above, and would only need to check statically that the field or method named existed in the appropriate class declaration.


(defun instance-of-class-p (x class-name heap class-table)
  (declare (xargs :guard (and (stringp class-name)
                              (heap-p heap)
                              (class-table-p class-table))))
  (and (instance-p x)
       (bound?-equal class-name class-table)
       (good-memory-ref-p (instance-class x) heap)
       (let ((his-class-surrogate (deref (instance-class x) heap)))
         (and (a-class-p his-class-surrogate)
              (bound?-equal (a-class-name his-class-surrogate) class-table)
              (let ((his-class-decl (binding-equal (a-class-name his-class-surrogate)
                                             class-table)))
                (or (equal class-name (class-decl-name his-class-decl))
                    (member-equal-p class-name
                                    (class-decl-superclasses his-class-decl))))))))


; Observe that instance-of-class-p recognizes objects built using build-an-instance. However, instance-of-class-p requires additional consistency constraints between the object's class-surrogate and the corresponding class-table entry.

;Recall than an instance identifies its class via a reference to the class-surrogate object in the heap. Thus, instance-of-class-p must retrieve the class name through the class surrogate, where build-an-instance is given the class-name as an argument. Thus, instance-of-class-p requires some additional conditions beyond those required to build the instance:
;
;    The class-surrogate object must exist in the heap.
;    The class-surrogate must identify an existing entry in the class table.
;    The class name used to look up an entry in the class table must be consistent with the class name in that entry (i.e., that class declaration structure).

;These are all constraints on semantically consistent states of the JVM. Because the dJVM is defensive, we can test these constraints during execution. In an optimized JVM description we would be obliged to assure that these constraints are satisfied in any well-formed JVM state.

(observe fact-instance-of
         (implies (and (class-table-p class-table)
                       (heap-p heap)
                       (stringp class-name)
                       (bound?-equal class-name class-table)
                       (equal cdecl (binding class-name class-table))
                       (equal class-name (class-decl-name cdecl))
                       (class-superclasses-all-bound? class-name class-table)
                       (good-memory-ref-p (class-decl-surrogate cdecl) heap)
                       (a-class-p (deref (class-decl-surrogate cdecl) heap))
                       (equal class-name
                              (A-CLASS-NAME (deref (class-decl-surrogate cdecl)
                                                   heap))))
                  (instance-of-class-p (build-an-instance class-name class-table)
                                       class-name heap class-table))
         :hints (("Goal" :in-theory (enable build-an-instance))))

; new instruction

; Now that we have defined how to build an instance, and how to recognize an instance of a class, we can define the behavior of the instruction new.

; The new instruction takes a class name as its argument. The name should match that of a class entry in dJVM class table. If so, then a new instance of the class is constructed. The fields of the instance are initialized to default values appropriate for their declared types. The new instance is inserted into the heap at an unused address. The heap address is pushed onto the operand stack.

(defun new-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (true-listp inst)
       (equal   (first inst) 'new)
       (stringp (second inst))
       (= (len inst) 2)))

(defun new-proper-arg-types? (inst frame)
  (declare (xargs :guard t))
  (declare (ignore inst frame))
  t)

; Recall that the new-proper-arg-values? test is performed after the instruction arguments have been resolved. So the argument of new should name a class table entry.

; Since the dJVM does not support dynamic loading, resolution will not add entries to the class table. However, if the dJVM is extended to support dynamic loading, we could expect at this point that the instruction argument names a class or the resolution step would have signaled an error.

(defun new-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (new-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (bound?-equal (second inst) (djvm-class-table djvm)))

(defun djvm-execute-new-optimized (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (new-wff-inst? inst)
                              (new-proper-arg-values? inst djvm))))
  (let ((class-name (second inst)))
    (djvm-make-new-instance-optimized class-name djvm)))


(defthm djvm-p-djvm-make-new-optimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (new-wff-inst? inst)
                (new-proper-arg-values? inst djvm))
           (djvm-p (djvm-execute-new-optimized inst djvm))))

; We should be able to prove that new-proper-result-type? is always satisfied if the new instruction completes normally. Then it would be safe to remove this test. But we haven't done that proof yet.

(defun new-proper-result-type? (inst djvm)
  (declare (xargs :guard (and (new-wff-inst? inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (new-proper-arg-values? inst djvm))))
  (and (non-empty (frame-stack (car (djvm-stack djvm))))
       (let ((top-of-stack (car (frame-stack (car (djvm-stack djvm)))))
             (class-name (second inst)))
         (and (bound?-equal class-name (djvm-class-table djvm))
              (tv-ref-p top-of-stack)
              (good-memory-ref-p top-of-stack (djvm-heap djvm))
              (instance-of-class-p (deref top-of-stack (djvm-heap djvm))
                                   class-name
                                   (djvm-heap djvm)
                                   (djvm-class-table djvm))))))

(defthm weak-frame-p-car-djvm-stck-djvm-execut-new-optimized
  (implies (and (new-wff-inst? inst)
                (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (new-proper-arg-values? inst djvm))
           (weak-frame-p
            (car
             (djvm-stack
              (djvm-execute-new-optimized inst djvm))))))

(defthm djvm-p-djvm-execute-new-optimized
  (implies (and (new-wff-inst? inst)
                (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (new-proper-arg-values? inst djvm))
           (djvm-p
            (djvm-execute-new-optimized inst djvm))))

(defthm weak-djvm-p-djvm-execute-new-optimized
  (implies (and (new-wff-inst? inst)
                (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (new-proper-arg-values? inst djvm))
           (weak-djvm-p
            (djvm-execute-new-optimized inst djvm))))

(defthm new-proper-arg-types?-ignores-pc
  (implies (and (weak-frame-p frame)
                (new-proper-arg-types? inst frame))
           (new-proper-arg-types? inst (frame-set-pc new-pc frame)))
  :hints (("Goal" :in-theory (enable new-proper-arg-types?))))

(defthm new-proper-arg-values?-ignores-pc
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (new-proper-arg-values? inst djvm))
           (new-proper-arg-values? inst (djvm-set-pc new-pc djvm)))
  :hints (("Goal" :in-theory (enable new-proper-arg-values?))))

(defthm djvm-execute-new-optimized-preserves-new-proper-arg-values
  (implies (and (new-wff-inst? inst)
                (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (new-proper-arg-values? inst djvm))
           (new-proper-arg-values? inst (djvm-execute-new-optimized inst djvm))))

(defthm djvm-increment-pc-preserves-frame-method
  (implies (djvm-p djvm)
           (equal (frame-method (car
                                 (djvm-stack
                                  (djvm-increment-pc n djvm))))
                  (frame-method (car (djvm-stack djvm))))))

(defthm djvm-execute-new-optimized-preserves-frame-method
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (equal (frame-method (car
                                 (djvm-stack
                                  (djvm-execute-new-optimized inst djvm))))
                  (frame-method (car (djvm-stack djvm)))))
  :hints (("Goal" :in-theory (enable djvm-execute-new-optimized))))

(in-theory (disable new-wff-inst?
                    new-proper-arg-types?
                    new-proper-arg-values?
                    djvm-execute-new-optimized
                    ))

(define-defensive-instruction  djvm-execute-new
  new-wff-inst?
  new-proper-arg-types?
  identity-2
  new-proper-arg-values?
  djvm-execute-new-optimized
  new-proper-result-type?
  :instruction-length 3)

(defthm djvm-p-djvm-execute-new
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-new inst djvm))))

(in-theory (disable djvm-execute-new))
