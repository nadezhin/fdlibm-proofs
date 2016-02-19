;  http://www.computationallogic.com/software/djvm/html-0.5/initial-djvm.html

(in-package "ACL2")
(include-book "run-djvm")
;(include-book "define-inst-macro")
;(local (include-book "data-structures/alist-defthms" :dir :system))

;Initial Classes and Objects

;The initial dJVM state must include the classes java.lang.Object and java.lang.Class, as well as the object null.Within the discussion of the dJVM, we use the Java language syntax for fully-qualified names (e.g., java.lang.Object), rather than the JVM internal form (e.g., java/lang/Object). The class java.lang.Object must have an instance initialization (<init>) method.

;We have committed to using a specific heap address to reference the object null, because instructions such as ifnull must test for a reference to null. We have chosen heap address 0. Thus references to the object at heap address 0 are considered to be references to the object null.

;Remark: Should we guard against applying deref to null?

;This would be automatic if 0 were not a valid heap address.

;However, if null is not in the heap, then we have to define valid-reference? as a reference to a valid heap address or a referenced to null. But we haven't defined that yet!

;In this model we have chosen to allocate the null object. This is not necessary for all JVM models. It is required that a distinguished heap address be associated with the null object. In our model the proper argument checks for the invokevirtual, invokespecial, and invokespecial test that all reference types passes as arguments actually address objects in the heap. If they treated references to null as a special case, then we would not have to allocate the null object. The function min-unused-heap-address, which is used to assign heap addresses when allocating new objects, will never return 0 as an unused address, even if no object occupies that address in the heap.

;Because each object must reference the class surrogate for its class, we must know the heap address for the class java.lang.Object in order to construct the null object. We have chosen to use heap address 1 for the class surrogate for java.lang.Object, and heap address 2 for the class surrogate for java.lang.Class. We introduce these two class together, because unlike classes added later, these two classes form a cycle, rather than a hierarchy. The class Object is an instance of class, and the class Class is a subclass of class Object. The class Class is an instance of itself. Thus, neither class Class nor class Object can be loaded into the dJVM state before the other. This situation arises because these classes are used to ``bootstrap'' the Java world, and cannot arise with any later classes definitions.

;We define the method and class declarations as constant functions (i.e., functions of no arguments), so that the description of the initial class-table will be more compact.

(defn method-object-init ()
  (make-java-method :access-flags '()
                    :protection ':public
                    :name "<init>"
                    :class-name "java.lang.Object"
                    :sig "()V"
                    :max-stack 0
                    :max-locals 1
                    :body '((0 return))
                    :exception-table nil
                    :attrs nil))

(defn class-decl-for-class-object ()
  (make-class-decl :name          "java.lang.Object"
                   :surrogate     (make-tv :ref 1)
                   :access-flags  '(:public)
                   :status        'resolved
                   :superclass    "java.lang.Object"
                   :superclasses  nil
                   :interfaces    nil
                   :fields        nil
                   :methods       (list (method-object-init))
                   ))

(defn class-decl-for-class-class ()
  (make-class-decl :name          "java.lang.Class"
                   :surrogate     (make-tv :ref 2)
                   :access-flags  '(:public)
                   :status        'resolved
                   :superclass     "java.lang.Object"
                   :superclasses   (list "java.lang.Object")
                   :interfaces    nil
                   :fields        nil
                   :methods       nil
                   :attrs         nil
                   ))

(defn null-object ()
  (make-an-instance :class  (make-tv :ref 1)
                    :data   '(("java.lang.Object"))
                    :lock   nil))

(defn initial-heap ()
  `((0 . ,(null-object))))

(observe heap-p-initial-heap
  (heap-p (initial-heap)))

;Loading Classes into the DJVM state

;The process of loading classes into the JVM is slightly more complex than that of loading and linking programs in a traditional, static, compiled programming language. Java supports ``dynamic loading of classes'' and ``lazy resolution'' of class references. These ideas are a boon to dynamic execution of programs across a network.

;    Loading and linking errors cannot be signaled until ``a point in the program that might, directly or indirectly, require linkage to the class or interface involved in the error.'' [ 2.16.1, p. 42 in JVMS]

;The JVM specification suggests that all user-defined classes are loaded using a class loader. The description of a top-level call to the JVM says (paraphrased):

;    The initial attempt to execute the method main of the specified class discovers that the class is not loaded --- that is, the virtual machine does not currently contain a representation of this class. The virtual machine then uses a ClassLoader to attempt to find an external (binary) representation of the class.
;    [ 2.16.1, p. 41 in JVMS]

;The function djvm-add-class-decl adds a new class declaration to the class table. It does nothing if the class table already contains an entry with the same name. A surrogate class object is also created and added to the heap.

;Note that both a class-decl and the class-surrogate object have a status field. That status field should have a value that is one of the symbols: loaded, unresolved, resolved, prepared, or initialized.

;    [As] part of the loading and linking process the virtual machine checks that an overriding method is at least as accessible as the overridden method; an IncompatibleClassChangeError occurs if this is not the case.
;    [ 15.11.4, p. 336 in JLS]

;Note on JVM Semantics: It appears that the JDK 1.1 does not appear enforce this restriction, regardless of whether the bytecode verifier is used.

;Remark: Every class that is ever instantiated must have an instance-initialization method. But we're allowed to load classes that will never be instantiated (e.g., classes that are only used by instanceof or as class objects).

;Does Java suggest that a class constructor is generated for an abstract class?

;The JVM does not require that classes contain <init> methods.

(defun make-static-data (class-decl)
  (declare (xargs :guard (class-decl-p class-decl)))
  (build-class-field-bindings (class-decl-fields class-decl)))

(defun djvm-add-class-decl (class-decl djvm)
  (declare (xargs :guard (and (class-decl-p class-decl)
                              (djvm-p djvm))))
  (if (bound?-equal (class-decl-name class-decl)
              (djvm-class-table djvm))
      ;; Don't redefine an existing class definition.
      djvm
    (let* ((class-surrogate (make-a-class :name   (class-decl-name  class-decl)
                                          :data   (make-static-data class-decl)
                                          :status 'loaded
                                          :lock   nil
                                          :loader (ref-to-null)))
           (surrogate-addr (min-unused-heap-address (djvm-heap djvm)))
           (new-class-decl (set-class-decl-surrogate
                            (make-tv :ref surrogate-addr)
                            (set-class-decl-status 'loaded
                                                   class-decl))))
      (if (unsigned-int-value-p surrogate-addr)
          (set-djvm-class-table (bind-equal (class-decl-name class-decl)
                                      new-class-decl
                                      (djvm-class-table djvm))
                                (set-djvm-heap (bind-equal surrogate-addr
                                                     class-surrogate
                                                     (djvm-heap djvm))
                                               djvm))
        (set-djvm-status "OutOfMemoryError" djvm)))))

(defthm djvm-p-djvm-add-class-decl
  (implies (and (djvm-p djvm)
                (class-decl-p class-decl))
           (djvm-p (djvm-add-class-decl class-decl djvm))))


(in-theory (disable djvm-add-class-decl))

; Since neither class java.lang.Object nor java.lang.Class have a class initialization function, it is sufficient merely to add their class declarations to the class table, and their class surrogates to the initial heap. This will be our initial dJVM state.

(defun Initial-Djvm ()
  (declare (xargs :guard t))
  (Djvm-Add-Class-Decl
               (Class-Decl-For-Class-Class)
               (Djvm-Add-Class-Decl (Class-Decl-For-Class-Object)
                                    (make-djvm :status     ':initialized
                                               :stack       nil
                                               :class-table nil
                                               :heap        (Initial-Heap)))))

; Running Class Initializers

;Class initialization methods may be present in a class.A class is note required to have Instance any initialization methods, either. In fact a class lacking an instance initialization method can be instantiated by the JVM. However, since the instances can never be initialized, their utility is limited. The JVM requires class initialization methods to be named <clinit>.
;Remark: Must they take a null parameter list? Presumably.
;If the class has a class initialization method, it is invoked internally by the JVM. Note on JVM Semantics: The Java Virtual Machine Specification states that classes are initialized the first time the class name is resolved. This appears to accurately describe the behavior of the JDK versions 1.02 and 1.1.

;However, the Java Language Specification states that classes should be initialized only on their first active use.

;Thus, it appears that under some circumstances the JVM is defined to initialize a class where the Java Language Specification does not allow it.

;I think this circumstance only arises if the instanceof or checkcast instructions are used before the named class has been actively used. The JVM must resolve the class name given as an argument to the instanceof or checkcast instruction, and so it will initialize the class. However, this use of the class is not defined as an active use by the Language Specification.

(defun set-up-call-frame (method djvm)
  (declare (xargs :guard (and (java-bytecode-method-p method)
                              (djvm-p djvm))))
  (set-djvm-stack (list (make-frame :CLASS (java-method-class-name method)
                                    :method method
                                    :PC 0
                                    :LOCALS nil
                                    :STACK nil
                                    :object-ref (ref-to-null)))
                  djvm))

(observe djvm-p-set-up-call-frame
         (implies (and (java-bytecode-method-p method)
                       (djvm-p djvm))
                  (djvm-p (set-up-call-frame method djvm))))

; The class initialization methods are always named <clinit>. They are called implicitly by the JVM. The access flags associated with a class initialization method are ignored. (I.e., the method declaration need not be marked public, static, or void.) We cannot simply issue an invokestatic instruction to call the initialization method, because invokestatic checks that the class of the calling frame has access to the resolved method, and in this case there is no ``calling frame.''

(defun java-public-method-p (method)
  (declare (xargs :guard (java-method-p method)))
  (equal ':public (java-method-protection method)))

(defun java-synchronized-method-p (method)
  (declare (xargs :guard (java-method-p method)
                  :guard-hints (("Goal"
                                 :in-theory
                                 (enable method-access-flag-listp-true-listp)))))
  (memberp ':synchronized (java-method-access-flags method)))

(defun java-abstract-method-p (method)
  (declare (xargs :guard (java-method-p method)
                  :guard-hints (("Goal"
                                 :in-theory
                                 (enable method-access-flag-listp-true-listp)))))
  (memberp ':abstract (java-method-access-flags method)))

(defun java-top-level-method-p (method)
  (declare (xargs :guard t))
  (and (java-method-p method)
       (java-static-method-p method)
       (java-public-method-p method)
       (not (java-abstract-method-p method))))

(defun java-clinit-method-p (method)
  (declare (xargs :guard (java-method-p method)))
  (equal "<clinit>" (java-method-name method)))

(in-theory (disable java-clinit-method-p))

; Class initialization methods (i.e., those named <clinit>) are not declared within a Java program. They are generated by the Java compiler. So it is unclear exactly what requirements the JVM imposes on a class initialization method other than it be named <clinit>.

;    Class and interface initialization methods, that is, methods named <clinit>, are called implicitly by the Java Virtual Machine; the value of their access_flags item is ignored.
;    [4.6, p. 105 in JVMS]

; Remark: The class initialization code below is very incomplete.

; It ignores any run-time errors that occur during initialization.

; It ignores incomplete initialization if the given clock is too small to allow the class initialization call to complete.

; This should be fixed!

(defun Run-Top-Level-Method (method clock djvm)
  (declare (xargs :guard (and (java-bytecode-method-p method)
                              (naturalp clock)
                              (djvm-p djvm))))
  (if (or (Java-Top-Level-Method-p Method)
          (java-clinit-method-p method))
      (Djvm-Run clock (Set-Up-Call-Frame Method Djvm))
    (set-djvm-status
         "Only public, static, void (or <clinit>) methods may be run at top level"
          djvm)))

(defun Djvm-Run-clinit-Method (class-decl clock djvm)
  (declare (xargs :guard (and (class-decl-p class-decl)
                              (naturalp clock)
                              (djvm-p djvm))))
  (let ((method (java-method-binding "<clinit>" "()V"
                                     (class-decl-methods class-decl))))
    (if (and (java-bytecode-method-p method)
             (java-clinit-method-p method))
        (Run-Top-Level-Method method clock djvm)
      ;; A class is not required to have an initialization method.
      ;; So if we didn't find one, we just do nothing.
      djvm)))

(defthm djvm-p-djvm-run-clinit-method
  (implies (and (Djvm-p Djvm)
                (naturalp Clock)
                (Class-Decl-p Class-Decl))
           (Djvm-p (Djvm-Run-Clinit-Method Class-Decl
                                           Clock
                                           Djvm))))

(defthm weak-djvm-p-djvm-run-clinit-method
  (implies (and (djvm-p djvm)
                (naturalp clock)
                (class-decl-p class-decl))
           (weak-djvm-p
            (djvm-run-clinit-method class-decl
                                    clock
                                    djvm)))
  :hints (("Goal" :cases ((djvm-p (djvm-run-clinit-method class-decl
                                                          clock
                                                          djvm))))))


(in-theory (disable djvm-run-clinit-method))

(defun Djvm-Initialize-Class (class-name clock djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (naturalp clock)
                              (djvm-p djvm))
                  :guard-hints (("Goal"
                                 :in-theory
                                 (disable Djvm-Run-Clinit-Method)))))
  (if (bound?-equal Class-Name (Djvm-Class-Table Djvm))
      (let ((New-Djvm (Djvm-Run-clinit-Method (binding-equal Class-Name
                                                       (Djvm-Class-Table Djvm))
                                              clock
                                              Djvm)))
        (if (Stack-Empty-p (Djvm-Stack New-Djvm))
            (set-Djvm-Status ':Running New-Djvm)
          (set-Djvm-Status (list "<clinit> method did not exit normally"
                                 (Djvm-Status New-Djvm))
                           New-Djvm)))
    (set-Djvm-Status (list "Class Not Found" Class-Name)
                     Djvm)))

(defthm djvm-p-djvm-initialize-class
  (implies (and (djvm-p djvm)
                (naturalp clock)
                (class-decl-p class-decl))
           (djvm-p (djvm-initialize-class class-name
                                          clock
                                          djvm))))

(defthm weak-djvm-p-djvm-initialize-class
  (implies (and (djvm-p djvm)
                (naturalp clock)
                (class-decl-p class-decl))
           (weak-djvm-p
            (djvm-initialize-class class-name
                                    clock
                                    djvm)))
  :hints (("Goal" :cases ((djvm-p (djvm-initialize-class class-name
                                                         clock
                                                         djvm))))))

(in-theory (disable djvm-initialize-class))

;The class-decl structures constructed by the dJVM class-file converter currently does not compute the complete list of superclasses, which is normally recorded in the superclasses So we fill in that slot of the class-decl structure when it is loaded into a dJVM state by the function Djvm-Load-Class-Decl. This function is normally used to construct an initial dJVM state on which to run the dJVM interpreter.

(defun Compute-Superclasses-List (cdecl djvm)
  "Compute the list of superclass names for CDECL using class-table from DJVM."
  (declare (xargs :guard (and (Class-Decl-p CDECL)
                              (Djvm-p DJVM))))
  (let* ((Super-Name (Class-Decl-Superclass CDECL))
         (Superclass (binding-equal Super-Name (Djvm-Class-Table DJVM))))
    (if (Class-Decl-p Superclass)
        (cons Super-Name (Class-Decl-Superclasses Superclass))
      (list Super-Name))))

(defun Djvm-Load-Class-Decl (Class-Decl Clock Djvm)
  "Load CLASS-DECL into the DJVM state and initialize it by running
   its <clinit> method.  Also initialize the class-decl-superclasses slot."
  (declare (xargs :guard (and (Class-Decl-P Class-Decl)
                              (naturalp Clock)
                              (Djvm-p Djvm))
                  :guard-hints (("Goal"
                                 :in-theory
                                 (disable Djvm-Initialize-Class)))))
  (let* ((Superclasses (Compute-Superclasses-List Class-Decl Djvm))
         (Class-To-Add (Set-Class-Decl-Superclasses Superclasses Class-Decl)))
    (Djvm-Initialize-Class (Class-Decl-Name Class-Decl)
                           Clock
                           (Djvm-Add-Class-Decl Class-To-Add
                                                Djvm))))

;    A Java Virtual Machine starts execution by invoking the method main of some specified class.
;    [ 12.1, p. 215 in JLS]

(defun Run-Class-Main (class-name clock djvm)
  (declare (xargs :guard (and (stringp class-name)
                              (naturalp clock)
                              (djvm-p djvm))))
  (if (bound?-equal class-name (djvm-class-table djvm))
      (let* ((class-decl (binding-equal class-name (djvm-class-table djvm)))
             (method (java-method-binding "main" "()V"
                                          (class-decl-methods class-decl))))
        (if (and (java-top-level-method-p method)
                 (java-bytecode-method-p method))
            (run-top-level-method method clock djvm)
          (set-djvm-status "Method main ()V was not found" djvm)))
    (set-djvm-status "NoClassDefFoundError" djvm)))

(observe run-class-main-fact
         (implies (djvm-p djvm)
                  (djvm-p (run-class-main class-name clock djvm))))




