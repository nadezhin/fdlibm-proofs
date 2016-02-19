; http://www.computationallogic.com/software/djvm/html-0.5/invokevirtual.html

(in-package "ACL2")
(include-book "define-inst-macro")
(local (include-book "data-structures/alist-defthms" :dir :system))

;Method Invocation

;There are several different mechanisms for invoking methods in the JVM:
;
;    The invokevirtual instruction for non-private instance methods;
;    The invokespecial instruction for
;        private instance methods,
;        instance-initialization (<init>) methods, and
;        overridden methods of a superclass;
;    The invokestatic instruction for (static) class methods; and
;    The implicit invocation of class initialization (<clinit>) methods as part of class initialization by the JVM.
;
;These are described in 3.8, p. 69, of the Java Virtual Machine Specification.

;Method Resolution and Selection

;The three invocation instructions each take instruction arguments that provide a class name, a method name, and a method signature. As part of the execution of the instruction, the method name is resolved to a reference to a method declared in the named class.The error IncompatibleClassChangeError should be signaled if the named method is not a member of the named class, or if the named method is inherited, rather than declared within that class. We call this process method resolution, and we call the method that it produces the resolved method. After resolving the method named in the instruction, the different method invocation instructions select which method to invoke in one of several ways. This selected method must satisfy some additional constraints before being invoked. These constraints are described in the discussion of the individual method-invocation instructions. We give an overview of method selection below.

;The invokevirtual instruction throws away the resolved method, and searches for the ``closest method'' with the name and signature given in the instruction, looking first in the class of the dispatching object, and then up the superclass chain until a match is found. Since the dispatching object is required to be an instance of class named in the instruction, if method resolution was successful, then we know this search will also succeed.

;The invokestatic instruction invokes the resolved method, effectively implementing static method dispatch.

;The invokespecial instruction breaks into three cases. When invoking an instance-initialization (<init>) method or a private method, the resolved method is selected. When invoking a superclass method, the invokespecial instruction first checks that the class of the resolved method is a superclass of the current class.This requirement is specified as a ``structural requirement'' of method bodies [JVMS 4.8.2, p. 122]. Verification ensures that the binary representation of a class or interface is structurally correct. [JVMS 2.16.3, p. 44] Thus, if this test fails at run time in the dJVM, presumably it should signal VerifyError. If so, then the invokespecial instruction searches for the ``closest method'' with the name and signature given in the instruction, looking first in the direct superclass of the current class, and then up the superclass chain until a match is found.

;Remark: It is not clear from the description of invokespecial what error should be signaled if the resolved class is not a superclass of the current class. [JVMS, p. 261ff]. You must refer back to the structural constraints ( 4.8.2) and the discussion of linking and verification ( 2.16.3) to clarify this point.

;    The resolution step is optional at the time of initial linkage. An implementation may resolve a symbolic reference from a class or interface that is being linked very early, even to the point of resolving all symbolic references from the classes and interfaces that are further referenced, recursively. (This resolution may result in errors from further loading and linking steps.) This implementation choice represents one extreme and is similar to the kind of static linkage that has been done for many years in simple implementations of the C language.
;    [ 2.16.1, p. 41 in JVMS]

;    During resolution, the linker looks only in the class that was identified at compile time.
;    [ 13.4.5, p. 246 in JLS]

;The method invocation instructions and the field accessing instructions all have arguments (in the constant pool) naming the class and class member that was identified at compile time.

;The following errors may occur during method resolution:
;
;    IncompatibleClassChangeError
;    IllegalAccessError
;    InstantiationError (may occur during linking if the class named is abstract or an interface; the corresponding exception, InstantiationException, may occur at run time if the newInstance method is invoked in a similar situation)
;    NoSuchFieldError
;    NoSuchMethodError
;    UnsatisfiedLinkError (if a referenced native method is not found).

;General Requirements of Method Invocation

;There are a number of requirements regarding method invocation. The Java Virtual Machine specification includes them in several places. In the list of structural constraints on class files, we find:

;    The arguments to each method invocation must be method invocation compatible with the method descriptor.
;    [ 4.8.2, p. 123 in JVMS]

;While in the description of the individual method invocation instructions (invokeinterface, invokespecial, invokestatic and invokevirtual the requirement is phrased as:

;    The number of words of arguments and the type and order of the values they represent must be consistent with the descriptor of the dots [resolved static or selected instance or selected interface] method.
;    [p. 262, p.266, p. 269 in JVMS]

;Remark: Unfortunately, they don't define the term consistent, and don't refer to method invocation compatibility in the instruction descriptions.

;    An abstract method must never be invoked.
;    [ 4.8.2, p. 123 in JVMS]

;Remark: Presumably this excludes <clinit> methods, for which we ignore the attribute flags.

;    When an instance method is invoked, or when any instance variable [a.k.a. instance field?] is accessed, the class instance that contains the instance method or instance variable [sic] must have already be initialized.
;    [ 4.8.2, p. 122 in JVMS]

;Remark:
;
;    It's not clear that this and super are defined for at the JVM level.
;    Presumably this means ``before its instance members are accessed'' within this method activation. Although by transitivity, we can actually assert than all the instance-initialization methods are invoked before any of them can access the instance or invoke any method other than an instance-initialization method on this object.


;    If the method returns a reference type, it must do so using an areturn instruction, and the returned value must be assignment compatible with the return descriptor of the method. All instance-initialization methods, static initializers, and methods declared to return void must only use the return instruction.
;    [ 4.8.1, p. 123 in JVMS]

;    A valid Java method descriptor must require 255 or fewer words of method arguments, where the limit includes the word for this in the case of instance method invocations.
;    [ 4.10, p. 137 in JVMS]

;    [The verifier] ensures that every normal return of [an instance-initialization] method has either invoked an [instance] initialization method in the class of this method or in the direct superclass.
;    [ 4.9.4, p. 132 in JVMS]

;Invokevirtual Instruction

;Here's an example of the invokevirtual instruction:
;
;
;  (invokevirtual "myPackage.Point" "move" "(II)v")

;The opcode is invokevirtual. The first argument is the name of a class containing the method declaration. The second argument is the name of the method, in this case ``move''. The third argument is the method signature, in this case ``(II)v,'' specifying that the method takes two integer arguments and returns no value.We sometimes describe this by saying the function ``returns void.'' Note that the specified signature includes the return type or class, as well as the required types or classes of the actual parameters. These three arguments allow the JVM to resolve the method identifier and select the appropriate method to invoke.

;Here are some of the preconditions for the invokevirtual instruction:
;
;    The method name must not be <init> or <clinit>.
;
;    The method must not be private. Remark: I believe that neither the resolved method nor the selected method may be private.

;    Certainly it is an error if the resolved method is private and the current class is not the class of the resolved method.

;        If the current class does not have permission to access the method being resolved, method resolution throws an IllegalAccessError exception.
;        [ 5.2, p. 148 in JVMS]

;    But I don't see anything in the description of invokevirtual that says it cannot invoke a private instance method!!

;    3.11.8 specifies that invokespecial is used for instance methods require ``special handling,'' and mentions private methods.

;        Invoke an instance method of an object, dispatching on the (virtual) type of the object: invokevirtual. This is the normal method dispatch in Java.

;        Invoke an instance method require special handling, either an instance initialization method <init>, a private method, or a superclass method: invokespecial.
;        [ 3.11.8, p.80 in JVMS]

;    Note that there is no special characteristic of superclass methods. Rather the special handling is at the point invocation. Thus we cannot draw any interference from this that private methods are always and only handled by invokespecial.

;    The objectref (on the operand stack) must not be null.

;    If the selected method is protected, then it must be a member of the current class or a member of a superclass of the current class, and the class of the objectref (i.e., the object used to dynamically resolve the method) must be an instance of either the current class or a subclass of the current class.See section [sec:call-frames], page [sec:call-frames], for a definition of current class.

;    The number and order of the argument values on the stack must be assignment compatible with the types and classes given in the method signature given in the instruction.

;The descriptor of the selected method must be identical to the descriptor from the instruction. (See [p. 268 in JVMS]) If the objectref is null, then the instruction should throw NullPointerException.

;Assignment conversionAssignment conversion is discussed briefly in the Java Virtual Machine Specification ( 2.6.6, pp. 17-18). allows the use of the the following conversions:

;    Identity conversion,
;    Widening primitive conversion,
;    Widening reference conversion, and
;    (sometimes) Narrowing primitive conversion.

;However, method invocation conversion explicitly disallows the narrowing of integer constants as part of assignment conversion. (See [p. 19 in JVMS])

;Two instances, X and Y, are assignment compatible if both X and Y are of the same class, or the class of X is a subclass of the class of Y.

;Note that assignment compatible is an asymmetric relation. When we say that ``X is assignment compatible with Y,'' we mean that the value of the variable X can be assigned to the variable Y.

;Resolution is the process wherein a symbolic referenced is checked to be correct. (See [ 2.16.3, p. 45 in JVMS])

;    When the method is invoked, the values of the actual argument expressions initialize the newly created parameter variables, each of the declared type, before execution of the body of the method. The signature of a method consists of the name of the method and the number and type of formal parameters to the method.
;    [ 2.10.1, p. 28 in JVMS]

;Remark: Define parameter values.

;The definition of identifier-p below is somewhat weaker than the real meaning of identifier in Java. However, this test is used within the JVM to distinguish normal methods from special initialization methods. Initialization methods cannot be invoked using the invokevirtual instruction. Instance initialization methods can only be invoked via the invokespecial instruction. Class initialization methods are never invoked explicitly. They are only invoked implicitly as part of the class loading process.The dJVM 0.5 does not support dynamic loading of classes. Class initialization methods are currently invoked when the dJVM 0.5 state is created. This is not an accurate reflection of the Java Language Specification. However, the Java Virtual Machine Specification states that classes are initialized as part of class resolution. And JVMS 2.16.1 permits class resolution at initial linkage time, which corresponds to state-creation time in this current model.

;Instance initialization methods always have the name <init>. Class initialization methods always have the name <clinit>. The invokevirtual instruction may not invoke either sort. Since both sorts must have names that begin with ``<'', it suffices to disallow invocation of methods whose names begin with ``<'' via invokevirtual.

;    At the level of the Java Virtual Machine, every constructor ( 2.12) appears as an instance initialization method that has the special name <init>. Instance initialization methods may only be invoked with the Java Virtual Machine by the invokespecial instruction, and they may only be invoked on uninitialized class instances.

;    Class and interface initialization methods are invoked implicitly by the Java Virtual Machine; they are never invoked directly from Java code.
;    [ 3.8, p. 69 in JVMS]

(defun identifier-p (x)
  (declare (xargs :guard t))
  (and (stringp x)
       (< 0 (length x))
       (not (equal (char x 0) #\<))))


(defn invokevirtual-wff-inst? (inst)
  (and (true-listp inst)
       (equal (first inst) 'invokevirtual)
       (let ((class-name  (second inst))
             (method-name (third  inst))
             (method-sig  (fourth inst)))
         (and (stringp class-name)
              (stringp method-name)
              (stringp method-sig)
              (method-type-sig-p method-sig)))))

(defun invokevirtual-proper-arg-types? (instruction frame)
  (declare (xargs :guard (and (instruction-p instruction)
                              (frame-p frame))))
  (and (non-empty (frame-stack frame))
       (let ((class-name (arg1 instruction))
             (method-name (arg2 instruction))
             (method-sig (arg3 instruction)))
         (and (stringp class-name)
              (identifier-p method-name)
              (stringp method-sig)
              (method-type-sig-p method-sig)
              (let ((type-list (type-list-for-method-parameters method-sig)))
                (stack-sig-matches? (reverse type-list)
                                    (frame-stack frame)))))))

(defun assignment-compatible-classes? (actual-class target-class class-table)
  (declare (xargs :guard (and (stringp actual-class)
                              (stringp target-class)
                              (class-table-p class-table))))
  (or (equal actual-class target-class)
      (and (bound?-equal actual-class class-table)
           (bound?-equal target-class class-table)
           (member-equal-p target-class
                           (class-decl-superclasses (binding-equal actual-class
                                                             class-table))))))
(defun class-name-of-ref (ref heap)
  (declare (xargs :guard (and (tv-ref-p ref)
                              (heap-p heap))))
  (if (good-memory-ref-p ref heap)
      (let ((instance (deref ref heap)))
        (if (instance-p instance)
            (if (good-memory-ref-p (instance-class instance) heap)
                (let ((his-class-surrogate (deref (instance-class instance)
                                                  heap)))
                  (if (a-class-p his-class-surrogate)
                      (a-class-name his-class-surrogate)
                    `(:bad-class-surrogate ,his-class-surrogate)))
              `(:bad-ref-to-class-surrogate ,instance))
          `(:bad-instance ,instance)))
    `(:bad-ref ,ref)))

(defthm stringp-class-name-of-ref
  (implies (and (tv-ref-p ref)
                (heap-p heap)
                (good-memory-ref-p ref heap)
                (instance-p (deref ref heap))
                (good-memory-ref-p (instance-class (deref ref heap)) heap)
                (a-class-p (deref (instance-class (deref ref heap)) heap)))
           (stringp (class-name-of-ref ref heap)))
  :rule-classes (:rewrite :type-prescription))

(in-theory (disable class-name-of-ref))

(defun assignment-compatible-value? (val type-spec class-table heap)
  (declare (xargs :guard (and (sv-p val)
                              (extended-jvm-type? type-spec)
                              (class-table-p class-table)
                              (heap-p heap))
                  :guard-hints (("Goal" :in-theory (enable tv-val
                                                           tv-tag)))))
  (if (atom type-spec)
      (case type-spec
        (:ref           (tv-ref-p           val))
        (:int           (tv-int-p           val))
        (:long-top-half (tv-long-top-half-p val))
        (:long-bot-half (tv-long-bot-half-p val))
        (otherwise        nil))
    (if (and (weak-tv-p type-spec)
             (equal (tv-tag type-spec) ':ref)
             (stringp (tv-val type-spec))
             (tv-ref-p val))
        (let ((his-class-name (class-name-of-ref val heap)))
          (if (stringp his-class-name)
              (assignment-compatible-classes? his-class-name
                                              (cadr type-spec)
                                              class-table)
            nil))
      nil)))

(verify-guards extended-jvm-type-listp)

(defun assignment-compatible-stack? (type-list stack class-table heap)
  (declare (xargs :guard (and (extended-jvm-type-listp type-list)
                              (sv-listp stack)
                              (class-table-p class-table)
                              (heap-p heap))))
  (if (endp type-list)
      t
    (if (endp stack)
        nil
      (and (assignment-compatible-value? (car stack)
                                         (car type-list)
                                         class-table
                                         heap)
           (assignment-compatible-stack? (cdr type-list)
                                         (cdr stack)
                                         class-table
                                         heap)))))

(in-theory (disable arg1 arg2 arg3))

(observe fact-515
     (implies (and (stringp sig)
                   (naturalp i)
                   (<= i (length sig))
                   (field-type-sig-internal-p sig i))
              (type-list-for-field-type-sig-internal sig i)))

(defun method-arg-sig-internal-p (sig i)
  (declare (xargs :guard (and (stringp sig)
                              (naturalp i)
                              (<= i (length sig)))))
  (if (>= i (length sig))
      nil
    (case (char sig i)
      ;; One-word types
      (#\I (1+ i))
      (#\J (1+ i))
      ;; Class names
      (#\L (field-type-sig-class-p sig (1+ i)))
      ;; Arrays are not handled in dJVM 0.5
      (#\[ nil)
      (otherwise nil))))


(observe fact-520
     (implies (FIELD-TYPE-SIG-CLASSNAME-P sig i)
              (integerp (FIELD-TYPE-SIG-CLASSNAME-P sig i)))
     :hints (("Goal" :in-theory (enable  FIELD-TYPE-SIG-CLASSNAME-P))))

(observe fact-521
     (implies (and (stringp sig)
                   (FIELD-TYPE-SIG-CLASSNAME-P sig i))
              (stringp (field-type-sig-class-name sig i)))
     :hints (("Goal" :in-theory (set-difference-theories
                                 (enable FIELD-TYPE-SIG-CLASSNAME-P
                                         field-type-sig-class-name)
                                 '(subseq)
                                 ))))

(observe fact-522
     (implies (and (stringp sig)
                   (method-arg-sig-internal-p sig i))
              (extended-jvm-type? (car
                                   (type-list-for-field-type-sig-internal sig i))))
     :hints (("Goal" :in-theory (enable  weak-tv-p tv-tag tv-val))))

(defthm extended-jvm-type-listp-type-list-for-field-type-sig-internal
        (implies (and (stringp sig)
                      (method-arg-sig-internal-p sig i))
              (extended-jvm-type-listp
               (type-list-for-field-type-sig-internal sig i)))
     :hints (("Goal" :in-theory (enable weak-tv-p tv-tag tv-val))))

(observe fact-523
     (implies (and (stringp sig)
                   (method-arg-sig-internal-p sig i))
              (extended-jvm-type-listp
               (type-list-for-field-type-sig-internal sig i)))
     :hints (("Goal" :in-theory (disable method-arg-sig-internal-p
                                         extended-jvm-type-listp
                                         type-list-for-field-type-sig-internal))))

(defun sig-argument-word-count (method-sig)
  (declare (xargs :guard (and (stringp method-sig)
                              (method-type-sig-p method-sig))))
  (len (type-list-for-method-parameters method-sig)))

;We dynamically test that the method signature argument of the instruction (derived from a string in the constant pool) is well-formed. Actually, we test a derived property: that the result of applying type-list-for-method-parameters to the method signature yields a well-formed extended JVM type-list.It would be cleaner to merely test the method signature directly, and prove that a proper signature assures that type-list-for-method-parameters yields a well-formed JVM type-list. This proof was skipped for expediency.

;All object references being passed as arguments to the method must reference initialized objects in the context of the calling frame. (See section [sec:uninitialized-instances], page [sec:uninitialized-instances], for more on uninitialized instances.) Uninitialized objects can only be passed as the dispatching object to an instance-initialization method, and then only via invokespecial. None of the arguments to an invokevirtual instruction may be uninitialized instances.

;The instruction operands identify a class name, method name, method signature. the class name must be the name of a class in the class table. That class must contain a declaration of an instance method with the given name and signature. This is called the resolved method.

;The resolved method must be declared in the named class. It may not be inherited, though it may override a method in its superclass. The resolved method may not be a private method, an instance or class initialization method, or a static method.

;Remark: Justify the exclusion of private methods?! You cannot!

(defun resolvable-method? (class-name method-name method-sig djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (stringp method-name)
                              (method-type-sig-p method-sig)
                              (djvm-p djvm))))
  (and (bound?-equal class-name (djvm-class-table djvm))
       (java-method-bound? method-name
                           method-sig
                           (class-decl-methods (binding-equal class-name
                                                        (djvm-class-table djvm))))))

(defun resolved-method (class-name method-name method-sig djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (stringp method-name)
                              (method-type-sig-p method-sig)
                              (djvm-p djvm)
                              (resolvable-method? class-name
                                                  method-name
                                                  method-sig
                                                  djvm))))
  (java-method-binding method-name
                       method-sig
                       (class-decl-methods (binding-equal class-name
                                                    (djvm-class-table djvm)))))

(defun invokevirtual-proper-arg-values? (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm))))
  (let* ((class-name  (arg1 inst))
         (method-name (arg2 inst))
         (method-sig  (arg3 inst)))
    (and (stringp class-name)
         (stringp method-name)
         (stringp method-sig)
         (method-type-sig-p method-sig)
         (non-empty (djvm-stack djvm))
         (frame-p (stack-top (djvm-stack djvm)))
         (non-empty (op-stack (stack-top (djvm-stack djvm))))
         (bound?-equal class-name (djvm-class-table djvm))
         (resolvable-method? class-name method-name method-sig djvm)
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
                                               (car (djvm-stack djvm)))
                )))))

(defun frame-pop-n-operands (n frame)
  (declare (xargs :guard (and (frame-p frame)
                              (naturalp n))))
  (if (zp n)
      frame
    (if (non-empty (frame-stack frame))
        (frame-pop-n-operands (1- n)
                            (frame-pop-operand frame))
      frame)))

(defthm weak-frame-p-pop-n-operand
  (implies (force (weak-frame-p frame))
           (weak-frame-p (frame-pop-n-operands n frame))))

(defthm frame-p-pop-n-operand
  (implies (force (frame-p frame))
           (frame-p (frame-pop-n-operands n frame))))

(defun djvm-pop-n-operands (n djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (naturalp n))))
  (if (or (zp n)
          (null (djvm-operand-stack djvm)))
      djvm
    (if (and (non-empty (djvm-stack djvm))
             (non-empty (djvm-operand-stack djvm)))
        (djvm-pop-n-operands (1- n)
                           (djvm-pop-operand djvm))
      (set-djvm-status "Attempt to pop an empty stack." djvm))))

(defthm weak-djvm-p-djvm-pop-n-operands
  (implies (force (and (weak-djvm-p djvm)
                       (non-empty (djvm-stack djvm))))
           (weak-djvm-p (djvm-pop-n-operands n djvm))))

(defthm djvm-p-djvm-pop-n-operands
  (implies (force (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))))
           (djvm-p (djvm-pop-n-operands n djvm))))

(defun bind-arguments-as-local-vars (n stack)
  (declare (xargs :guard (and (naturalp n)
                              (sv-listp stack)
                              (<= n (len stack)))
                  :verify-guards nil))
  (if (or (zp n)
          (null stack))
      nil
    (bind-equal (1- n)
          (car stack)
          (bind-arguments-as-local-vars (1- n)
                                        (cdr stack)))))

(defthm alistp-bind-arguments-as-local-vars
  (alistp (bind-arguments-as-local-vars n stack)))

(verify-guards bind-arguments-as-local-vars)

(defthm true-listp-frame-stack
  (implies (frame-p frame)
           (true-listp (frame-stack frame)))
  :rule-classes (:rewrite :type-prescription))

(observe fact-525
     (implies (class-decl-p cdecl)
              (java-method-listp (class-decl-methods cdecl))))

(observe fact-526
     (implies (and (java-method-listp methods)
                   (java-method-bound? name sig methods))
              (java-method-p (java-method-binding name sig methods))))

(defun java-static-method-p (java-method)
  (declare (xargs :guard (Java-Method-p java-method)
                  :guard-hints (("Goal"
                                 :in-theory
                                   (enable method-access-flag-listp-true-listp)))))
  (member ':static (Java-Method-Access-Flags JAVA-METHOD)))

;Remark: We don't check that the resolved method was not private or static or inaccessible in the proper-arg-values test; but we do so inside of invokespecial itself. Checking these as part of the standard preconditions would be cleaner.

(defun java-private-method-p (java-method)
  (declare (xargs :guard (Java-Method-p JAVA-METHOD)))
  (equal ':private (java-method-protection java-method)))

(in-theory (disable java-static-method-p
                    java-private-method-p))

; The function execute-invokevirtual-unoptimized implements the invokevirtual instruction. In the dJVM the invokevirtual instruction has the form:
;
;
;         (invokevirtual class-name method-name method-signature)

;The class-name must identify an entry in the class table. That class declaration must contain a method declaration named method-name with signature method-signature. This method is called the ``resolved method.'' However, this method is not necessarily the method to be invoked.

;From the method-signature we can determine the number of arguments to the method. These arguments should appear on the operand stack. Immediately below these arguments should be an object reference, called the dispatching object-reference, or object-ref.

;Having established that the resolved method exists and is not private, we then ignore it and search for the method with the same name and signature whose declaration is the class closest to the class of object-ref. We call this the selected method. Both the resolved method and the selected method must be accessible to the current class (i.e., they may not be private methods of another class nor protected methods that are inaccessible to the current class. (See the discussion of member access, [sec:member-access], page [sec:member-access], and the discussion of method access, [sec:method-access], page [sec:method-access].)

;Remark:

;WARNING: The definition of execute-invokevirtual-unoptimized appears to be incorrect.

;It does not appear to perform a full check of whether the method is accessible. It checks explicitly for private methods, but does not call djvm-method-accessible-p to handle the :protected and :default-protect cases. Further, in the :protected case, invokevirtual must check that the dispatching object is of the current class or a subclass of the current class.

;The guards below assert that the proper type and number of arguments are on the operand stack. Since the dJVM 0.5 does not model dynamic class loading or initialization, we don't have to check that the resolved class and the dispatching class is fully initialized, although a full implementation of the JVM would have to.

;Remark: The definition execute-invokevirtual-unoptimized should be decomposed into several smaller concepts. The concept dispatchable object would help make this function more compact.

;Until then, in order to make current definition nearly fit the page width, this definition is being printed in a smaller font.

(defun execute-invokevirtual-unoptimized (INST DJVM)
  (declare (xargs :guard (and (Instruction-p INST)
                              (Djvm-p DJVM)
                              (non-empty (Djvm-Stack DJVM))
                              (non-empty (Frame-Stack (car (Djvm-Stack DJVM))))
                              (invokevirtual-wff-inst? inst)
                              (Invokevirtual-Proper-Arg-Types? INST (car (Djvm-Stack DJVM)))
                              (Invokevirtual-Proper-Arg-Values? INST DJVM))
                  :verify-guards t))
  (let* ((Method-Name (arg2 INST))
         (Method-Sig  (arg3 INST))
         (N-Word-Args (Sig-Argument-Word-Count Method-Sig)))
    (if (< N-Word-Args (len (Djvm-Operand-Stack DJVM)))
        (let ((Object-Ref (nth N-Word-Args (Djvm-Operand-Stack DJVM))))
          (if (and (TV-Ref-p Object-Ref)
                   (stringp (Class-Name-Of-Ref Object-Ref (Djvm-Heap DJVM))))
              (if (not (Ref-To-Null-p Object-Ref))
                  (if (Djvm-Initialized-Ref-p Object-Ref DJVM)
                      (let* ((Object-Class-Name (Class-Name-Of-Ref Object-Ref
                                                                   (Djvm-Heap DJVM)))
                             (Closest-Method   (Lookup-Method Method-Name
                                                              Method-Sig
                                                              Object-Class-Name
                                                              (Djvm-Class-Table DJVM))))
                        (if (Java-Method-P Closest-Method)
                            (if (not (Java-Static-Method-p Closest-Method))
                                (if (not (Java-Private-Method-p Closest-Method))

                                    (if (Java-Bytecode-Method-p Closest-Method)
                                        ;; Let NEW-FRAME be a new stack frame for the resolved-method,
                                        ;; and bind the object-ref and arguments as locals.



                                        (let ((New-Frame (Make-Frame :CLASS (Java-Method-Class-Name
                                                                             Closest-Method)
                                                                     :METHOD Closest-Method
                                                                     :PC     0
                                                                     :cia    0
                                                                     :LOCALS (Bind-Arguments-As-Local-Vars
                                                                              (1+ N-Word-Args)
                                                                              (Djvm-Operand-Stack DJVM))
                                                                     :STACK  nil
                                                                     :object-ref (ref-to-null)))
                                              (Calling-Frame (car (Djvm-Stack DJVM))))



                                          ;; Now pop the operands from the operand stack in the calling
                                          ;; frame, and push the new frame onto the call stack.



                                          (set-Djvm-Stack (cons New-Frame
                                                                (cons (Frame-Pop-N-Operands (1+ N-Word-Args)
                                                                                            Calling-Frame)
                                                                      (cdr (Djvm-Stack DJVM))))
                                                          DJVM))
                                      (Djvm-Error "Native methods not yet implemented."
                                                  inst DJVM))
                                  (Set-Djvm-Status "IllegalAccessError" DJVM))
                              (Set-Djvm-Status "Invokevirtual applied to a static method." DJVM))
                          (Set-Djvm-Status "Invokevirtual applied to an unbound method spec." DJVM)))
                    (Set-Djvm-Status "Invokevirtual applied to an uninitialized object." DJVM))
                (Djvm-Error "NullPointerException" inst djvm))
            (Set-Djvm-Status "Invokevirtual applied to a non-reference stack value." DJVM)))
      (Set-Djvm-Status "Invokevirtual applied with too few operands on the stack." DJVM))))

(defthm local-vars-listp-bind-arguments-as-local-vars
  (implies (force (sv-listp stack))
           (local-vars-listp (bind-arguments-as-local-vars n stack))))

(defthm weak-local-vars-listp-bind-arguments-as-local-vars
  (implies (force (weak-tv-listp stack))
           (weak-local-vars-listp (bind-arguments-as-local-vars n stack))))

(defthm weak-djvm-p-execute-invokevirtual-unoptimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (weak-djvm-p (execute-invokevirtual-unoptimized inst djvm))))

(defthm djvm-p-execute-invokevirtual-unoptimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (execute-invokevirtual-unoptimized inst djvm))))

(define-defensive-instruction  djvm-execute-invokevirtual
  invokevirtual-wff-inst?
  invokevirtual-proper-arg-types?
  identity-2
  invokevirtual-proper-arg-values?
  execute-invokevirtual-unoptimized
  identity-2
  :instruction-length 3)

(in-theory (disable invokevirtual-wff-inst?
                    invokevirtual-proper-arg-types?
                    invokevirtual-proper-arg-values?
                    execute-invokevirtual-unoptimized))

(defthm djvm-p-djvm-execute-invokevirtual
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-invokevirtual inst djvm))))

(in-theory (disable djvm-execute-invokevirtual))

; Invokespecial Instruction

; The invokespecial instruction is used to invoke-instance initialization methods, private methods, and methods declared in a superclass but not necessarily inherited by the class of the dispatching instance.

; The invokespecial instruction is used to invoke a method of an object's superclass that is overridden by a method of its class (i.e., ``run super''). That is, if a method M is declared in a superclass S, and inherited by class C, and obj is an initialized instance of C, then the method-call expression
;
;
;    super.M()
;
;will invoke method S.M, just as the regular method-call expression
;
;
;    obj.M()
;
;will.

;Here is a portion of the description of ``super'' from the JLS:

;    The super keyword can be used to access a method declared in a superclass bypassing any methods declared in the current class. [Consider the case in which] The expression
;
;
;          super.Identifier
;
;    is resolved, at compile time, to a method M declared in a particular superclass S. The method M must still be declared in that class at run time or a linkage error will result. If the method M is an instance method, then the method MR invoked at run time is the method with the same signature as M that is a member of the direct superclass of the class containing the expression invoking super.
;    [ 13.4.5, p. 247 in JLS]

;Remark: There appears to be a bug in the JVM implementation of invokenonvirtual in JDK 1.0.2. When dispatching via super, the resolved method (i.e., the method identified at compile time) is dispatched, even if it is not a member of the direct superclass of the current class. The method with the same name and signature that is a member of the direct superclass should be invoked instead. As noted above the member of the direct superclass may or may not be the method identified at compile time.

;Instance Initialization

;The Java language requires that each constructor (i.e., class initialization method) begin with a call to another constructor of the same class or a call to a constructor of the class' immediate superclass (except for the class Object, which has no superclass). Further, the language grammar precludes this initial call from being protected by an exception handler or a finally clause. The Java Language Specification grammar specifies [ 19.8.5, p. 445]:

;ConstructorBody:
;    { ExplicitConstructorInvocationopt BlockStatementsopt }

;ExplicitConstructorInvocation:
;    this ( ArgumentListopt ) ;
;    super ( ArgumentListopt ) ;

;These requirements are almost reflected in the structural constraints on well-formed JVM programs. Specifically:

;    There must never be an uninitialized class instance in a local variable in code protected by an exception handler or a finally clause.
;    [ 4.8.2, p. 122 in JVMS]

;Since an instance-initialization method implicitly has the uninitialized instance this as local variable zero, the code up to the required call to another instance initialization method is prohibited from being protected by an exception handler. However, if the code overwrote the value of local variable zero, so that it no longer contained a reference to an uninitialized instance, then this restriction would not be sufficient.

;Remark: Isn't all code in a method dynamically protected by any exception handler protecting the method invocation in a calling method/frame?

;Perhaps this passage only refers to static coverage by exception handlers.

;Remark: The JVMS says somewhere else that an instance-initialization method must not complete normally without having initialized this. Do I have the quote?

;Remark: I don't think that ``finally clause'' (quoted from JVMS above) is a concept at the JVM level. (See JVMS 4.9.6, p. 134, which suggests it looks like an exception handler for any exception.

;It is illegal to use a reference to an uninitialized instance in the following contexts within the JVM:
;
;    As an operand of the invokevirtual or invokestatic instructions
;    As the dispatching operand of the invokevirtual instruction
;    As the dispatching operand to the getfield or putfield instructions

;Remark: References to uninitialized instances may not be stored via putfield or putstatic, it says somewhere.

;Remark: I presume that in an invokespecial instruction only the dispatching object may be a reference to an uninitialized instance.

;Remark: Can the areturn instruction be used to return a reference to an uninitialized instance?

;The description of the bytecode verifier does not appear to prohibit this, but Frank Yellin says the implementation does.

;    Each instance initialization method, except for the instance initialization method derived from the constructor of the class Object, must call either another instance-initialization method of this or an instance-initialization method of its immediate superclass (super) before its instance members are accessed. However, this is not necessary in the case of the class Object, which does not have a superclass.
;    [ 4.8.2, p. 122 in JVMS]

;    Instance-initialization methods may only be invoked within the JVM by the invokespecial instruction, and they may only be invoked on uninitialized class instances.
;    [ 3.8, p. 69 in JVMS]

;The bytecode verifier enforces the requirement that the ``dispatching instance'' in a call to an instance initialization method must not have previously been initialized, and also enforced the requirement that all other objects passed as parameters to the instance initialization method must have previously been initialized.

