; http://www.computationallogic.com/software/djvm/html-0.5/internal-operations.html

(in-package "ACL2")
(include-book "frame-operations")
(include-book "state")

;Manipulating the dJVM State

;This chapter defines the internal operations that alter the dJVM state. The dJVM instructions will be defined in terms of these operations.

;Checking Stack Signatures

;Most Java instructions require that the top few elements of the stack contain values of specified data types. For example, the integer addition operation (iadd) requires that the top two elements of the stack contain integer values. The predicate stk-sig-top? is used to state just such requirements. The precondition for iadd would be stated as:
;
;               (stk-sig-top? stk-sig :int :int).

; Remark on ACL2: The predicate stk-sig-top? is defined as a macro, so that it can take a variable number of arguments.

; Note on reference types:
; Although the an extended-type tag list, such as returned by the function type-list-for-field-type-sig-internal, includes both :ref and the specified class name for a reference type, the function stk-sig-top? only checks that the stack value is a reference value. stk-sig-top? is intended to check the basic type-safety preconditions for JVM instructions.

;While some JVM instructions require an argument to be a reference value, some of them require (as a precondition) that value be a reference to an instance of particular class. For example, the athrow instruction has a precondition that its argument be a reference type and that the referenced object is an instance of class java.lang.Throwable. The bytecode verifier checks both of these preconditions. The bytecode verifier attempts to resolve the the declared class of the object being thrown. If resolution fails, the bytecode verification fails. In contrast, some other instructions, such as checkcast and instanceof, take class names as arguments; these instruction argument values are represented as stringsIn the JVM the strings reside in the constant pool for the class. In the dJVM the string values are part of the instruction. and they are not resolved to a class object until execution time.

;We provide a bottom-up description of these macros.
;Remark: I don't believe that unquote-list-elements is needed any longer. Initially I thought this would be used in top-level code, and hadn't decided whether type labels should be quoted or not in that context.

;However, currently this is only used in the define-djvm-operation macro. And those arguments are not explicitly quoted. So, I should pull this out and recompile and reverify.

(defun unquote-list-elements (list)
  (declare (xargs :guard (true-listp list)))
  (if (endp list)
      nil
    (cons (if (and (true-listp (car list))
                   (equal (caar list) 'quote))
              (cadar list)
            (car list))
          (unquote-list-elements (cdr list)))))

(defun stk-sig-top-type-listp (x)
  (declare (xargs :guard (true-listp x)))
  (if (endp x)
      t
    (and (or (symbolp (car x))
             (and (consp (car x))
                  (eql (car (car x)) ':ref)))
         (stk-sig-top-type-listp (cdr x)))))

; In definition of assert-value-typed-properly below, the value of the parameter variable is expected to be an ACL2 expression that accesses a typed-value within the dJVM state (e.g., an element of the operand stack, or a local variable). The macro manipulates ACL2 forms, composing new forms from old ones.

;We use an extended notion of type specifier here, so that we can assert more abstract specifications than merely that a value is of a particular type (e.g., :int). The extended specifiers are:
;
;[:one-word-type] accepts any primitive type whose values occupy one word (i.e., are not half of a two-word value).
;[:not-top-half] accepts any primitive type other than the top-half of a type requiring two words.
;[:not-bot-half] accepts any primitive type other than the bottom-half of a type requiring two words.

;For example, :one-word-type is used in the specification of the pop instruction, in order to prohibit popping the top half of a two-word value. The specifier :not-top-half is used to define the pop2 instruction, which allows any type on top of the stack, and the second element of the stack not to be the top half of a two-word value.

(defun assert-value-typed-properly (extended-type-tag variable)
  (declare (xargs :guard (extended-type-tag? extended-type-tag)))
  (if (jvm-type-tag? extended-type-tag)
      (case extended-type-tag
        (:ref           `(tv-ref-p           ,variable))
        (:int           `(tv-int-p           ,variable))
        (:long-top-half `(tv-long-top-half-p ,variable))
        (:long-bot-half `(tv-long-bot-half-p ,variable))
        (otherwise      `(equal ,extended-type-tag (tv-tag ,variable))))
    (case extended-type-tag
      (:one-word-type   `(tv-one-word-p ,variable))
      (:same            `(sv-p ,variable))
      (:not-top-half    `(not (tv-top-half-p ,variable)))
      (:not-bot-half    `(not (tv-bot-half-p ,variable)))
      (otherwise        `(bad-extended-type-tag-specifier ,extended-type-tag))
      )))

(verify-guards extended-type-tag-listp)

(defun assert-args-typed-value-properly (pre-stack-types stack-name)
  (declare (xargs :guard (and (extended-type-tag-listp pre-stack-types)
                              (symbol-listp pre-stack-types))))
  (if (endp pre-stack-types)
      nil
    (cons (assert-value-typed-properly (car pre-stack-types)
                                       `(car ,stack-name))
          (assert-args-typed-value-properly (cdr pre-stack-types)
                                            `(cdr ,stack-name)))))

(defun Expand-Stk-Sig-Top (stk type-list)
  (declare (xargs :guard (extended-type-tag-listp type-list)))
  (if (endp type-list)
      t
      `(and (consp ,stk)
            ,(if (symbolp (car type-list))
                 (assert-value-typed-properly (car type-list)
                                              `(car ,stk))
               `(bad-type-spec-in-stk-sig-top ,(car type-list)))
            ,(expand-stk-sig-top `(cdr ,stk) (cdr type-list)))))

; Here are the user-callable macros.

(defmacro  Stk-Sig-Top? (stk \&rest types)
  (expand-stk-sig-top stk (unquote-list-elements types)))

(defmacro  Djvm-Stk-Sig-Top? (djvm \&rest types)
  `(stk-sig-top? (frame-stack (car (djvm-stack ,djvm)))
                 ,@types))

; Remark on the Proof: The proofs about frame operations go much faster if sv-p and sv-p-defn are disabled. If we don't need to infer that a constructed value satisfies sv-p, but only that extracted values do (e.g., values extracted via car or assoc or binding), then keeping the definitions of sv-p and sv-p-defn disabled (i.e., preventing those definitions from being opened by the theorem prover) speeds up proofs.

(in-theory (disable sv-p
                    sv-p-defn
                    jvm-type-tag?
                    ))

(defthm weak-tv-p-sv-p
  (implies (sv-p x)
           (weak-tv-p x))
  :hints (("Goal" :in-theory (enable sv-p weak-tv-p)))
  :rule-classes (:forward-chaining))

(defthm weak-tv-p-fv-p
  (implies (fv-p x)
           (weak-tv-p x))
  :hints (("Goal" :in-theory (enable fv-p weak-tv-p)))
  :rule-classes (:forward-chaining))

(in-theory (disable weak-tv-p))

; Here's a version of Stk-Sig-Top? that is called as a function, rather than as a macro. Thus, it can take a computed list as the type signature, where the macro version requires the explicit type-tags appear in the macro call. The macro version is used in defining instructions that manipulate fixed types (e.g., the iadd instruction). This version is used by generic instructions, such as the field access instructions and the method invocation instructions, where the actual type of data being manipulated must be resolved from a class definition.

(defun stack-sig-matches? (type-list stack)
  (declare (xargs :guard (and (true-listp type-list)
                              (sv-listp stack))
                  :guard-hints (("Goal" :in-theory (enable sv-p
                                                           sv-listp)))))
  (if (endp type-list)
      t
    (if (endp stack)
        nil
      (and (if (consp (car type-list))
               (equal (caar type-list) (tv-tag (car stack)))
             (equal (car type-list) (tv-tag (car stack))))
           (stack-sig-matches? (cdr type-list) (cdr stack))))))

; Package Names

;In Java source programs, the dot character (``.'') is used as the separator between elements of a fully qualified name. However, in standard JVM class files, the slash character (``/'') is used.

;We use the constant function dot-char to denote the separator character. Changing the definition of this one function will change the treatment of qualified names throughout the dJVM.It will not change string constants in dJVM programs, however. If the definition of dot-char is changed, dJVM programs may have to be updated appropriately. The function package-for-class-name extracts the package name from a fully-qualified class name. The package name consists of the substring preceding the last occurrence of the ``dot-char'' in the fully-qualified name.

;In Common Lisp (and in ACL2), the expression \#. denotes the character value for ``.'' and \#/ denotes the character value for the ``slash'' character.

(defn dot-char ()
  "The character used as the separator in fully qualified names."
  #\.)

(defun find-last-dot-internal (string i)
  (declare (xargs :guard (and (stringp string)
                              (naturalp i)
                              (< i (length string )))))
      (if (and (naturalp i)
               (equal (char string i) (dot-char)))
          i
        (if (and (naturalp i)
                 (not (zerop i)))
            (find-last-dot-internal string (1- i))
          -1)))

(defun find-last-dot (string)
  (declare (xargs :guard (stringp string)))
  (if (zerop (length string))
      -1
    (find-last-dot-internal string (1- (length string)))))

(defthm find-last-dot-fact-1
  (implies (and (stringp string)
                (naturalp i)
                (< i (length string)))
           (<= (find-last-dot-internal string i)  i))
  :rule-classes :linear)

; We need the following fact in order to satisfy the guard for subseq in package-for-class-name.

(defthm find-last-dot-fact-2
  (implies (stringp string)
           (< (find-last-dot string) (length string))))

; Java classes may be defined in an ``unnamed package'' -- that is, a package with an empty name. So the function package-for-class-name may return the empty string.

; Note on Java Semantics: The complexity of multiple unnamed packages and restricted access to packages is outside the scope of the JVM; it is defined by the host system. [ 7.4.2, p. 119 in JLS]

(defn unnamed-package-name ()
  "")

(in-theory (disable unnamed-package-name))

(defun package-for-class-name (class-name)
  (declare (xargs :guard (stringp class-name)))
  (let ((pos (find-last-dot class-name)))
    (if (plusp pos)
        (subseq class-name 0 (1- pos))
      (unnamed-package-name))))

(defun package-for-class-decl (class-decl)
  (declare (xargs :guard (class-decl-p class-decl)))
  (package-for-class-name (class-decl-name class-decl)))

(in-theory (disable package-for-class-decl
                    package-for-class-name))

; Altering dJVM State Components

; The dJVM state is fairly simple. It contains four components:
;
;    The object heap,
;    The call stack,
;    The class table, and
;    A status flag.
;
; Thus all state changes can be grouped into four basic categories, depending on which of these components is altered.

; Remark: I need to distinguish between the following concepts:
;
;    instruction (i.e., an instruction occurrence in a method body),
;    the execution of an instruction in a particular state,
;    a lower-level operation used in describing the behavior of an instruction.

; In the dJVM most state-change operations affect only a single state component. The status flag may be set by any operation that can detect an error. Once a call-frame is created, the class and method slots cannot be altered, nor can the object-ref slot, which contains a reference to the dispatching object, be altered.

; Future Extensions: The dJVM 0.5 does not support exception handling. Instead, it uses the status field to indicate that the interpreter has encountered an error. A future extension of the dJVM may support exception handling. At that time the status flag may be removed as a component of the dJVM state.

; The dJVM 0.5 does not support multiple threads, so it has only a single call-stack. A future extension of the dJVM may support multiple threads by allowing multiple call stacks, and the dynamic creation and destruction of call stacks.

; Recall that the call frame contains the following additional subcomponents:
;
;    The operand stack
;    The local variables (sometimes called ``registers'') Remark: Where were local variables called registers? I think it was in an early (alpha or beta) version of the JVM spec.
;    The pc register
;    The cia register
;    A list of references to uninitialized instances

; The cia slot is only manipulated by the function djvm-step (section [djvm-step], page [djvm-step]), and the manipulations are described there. General operations for manipulating the other slots are given in the remainder of this chapter.

; During execution, call frames and class instances are created and destroyed. The local operand stack and variables of a method are created or destroyed when its call frame is created or destroyed.

; Thus, we are left with 12 basic state-changing functions:
;
; myCount{0}
;
; [0]{myCount(myCount)}
;
;    alter the current frame
;        alter the operand stack
;            push operand
;            pop operand
;        alter a local variable
;            store value into variable
;        alter the PC
;    alter the heap
;        alter an (existing) object
;            put a value into a field
;        create an object
;        destroy an object (not implemented on dJVM)
;    alter the call stack
;        push a call frame
;        pop a call frame
;    alter the class table
;        create a class
;        destroy a class (not implemented on dJVM)
;    alter the dJVM status

; Every instruction alters the pc.A ``self loop'' does leave the pc value unchanged after execution. However a self loop is implemented by means of a goto or goto_w instruction. The description of both of these instructions specifies that the pc is altered. So we consider all goto and goto_w instructions to assign a value to the pc.

; It could be argued that instructions that return from a method do not alter the pc in the current frame, but rather destroy it. We will not indulge in such pedantry! Even the nop instruction, which is described as ``do[es] nothing,'' actually increments the pc, although this is not mentioned in the JVM Specification. [p. 322 in JVMS]

; Note on JVM Semantics: The JVMS defines the pc register [ 3.5.1, p. 61]. That is the only entry in the index under ``pc.'' The nop instruction is described as ``Do[es] nothing.'' There appears to be no mention anywhere that the pc should be updated after a nop instruction, or, indeed, after every non-branch instruction! Presumably this is considered an intrinsic part of a bytecode, virtual-machine interpreter.

; The definitions of the jsr and jsr_w instructions do not mention the pc! They say the ``address of the opcode of the instruction immediately following this jsr is pushed .''

; It is not clear whether they require any commitment regarding the order of bytes in the method body at run time. They do specify byte order in the class file. And if the run-time representation of the method body is in a different order, then the instruction offsets in jump and branch instructions and the exception table, line-number table, and local-variable-name tables might have to be adjusted.

;    [If the current method is not a native method,] the pc register contains the address of the Java Virtual machine instruction currently being executed. If the method currently being executed by the thread is native, the value of the Java Virtual Machine's pc register is undefined. The Java Virtual Machine's pc register is one word wide, the width guaranteed to hold a returnAddress or a native pointer on the specific platform.
;    [ 3.5.1, p. 62 in JVMS]

; Remark: Tim and Frank seem to have forgotten this point, since all of the branch instructions are described in terms of an offset from the address of the opcode of the branch instruction, rather than relative to the pc value.

; In the current dJVM model, the cia register seems to behave as they specify the pc register should, and the dJVM's pc register is not a required component of a JVM call frame at all. However, recall that the JVMS explicitly allows an implementation to include additional information in a call frame.

; Remark: Regarding byte order in method bodies Since the description of branches is defined in relation to the address of the opcode of the branch instruction, it would seem that the JVM is constrained to preserve the byte order of instructions as it is defined in the class file format. Since the bytecode representation of instructions is defined in terms of a sequence of individual bytes, the issue of big-endian versus little-endian does not seem to arise.

; However, the JVMS does not specify whether multi-byte integer values should be stored in a big-endian or little-endian manner. This detail is left up to the implementation.

; A macro for defining alterations

; Remark: See the discussion of frame-push-operand-defn and frame-push-operand-props for the use of these macros.

; The following form shows how we can define the operation of pushing a value onto the operand stack. To assure that the operand stack continues to satisfy the predicate sv-listp as required by the definition of frame-p (section [frame-p], page [frame-p]), the guard requires the new value to satisfy sv-p (i.e., to be a permissible stack value).
;
; (defun frame-push-operand (value frame)
;   (declare (xargs :guard (and (frame-p frame)
;                               (sv-p value))))
;   (set-frame-stack (cons value (frame-stack frame))
;                    frame))
;
;
;
; (defthm frame-push-operand-defn
;   (implies (and (weak-frame-p frame)
;                 (weak-tv-p value))
;            (let ((new-frame (frame-push-operand value frame)))
;              (and (equal (frame-class      new-frame) (frame-class frame))
;                   (equal (frame-method     new-frame) (frame-method frame))
;                   (equal (frame-pc         new-frame) (frame-pc frame))
;                   (equal (frame-locals     new-frame) (frame-locals frame))
;                   (equal (frame-stack      new-frame) (cons value
;                                                            (frame-stack frame)))
;                   (equal (frame-new-refs   new-frame) (frame-new-refs frame))
;                   (equal (frame-object-ref new-frame) (frame-object-ref frame))))))
;
;The rule frame-push-operand-defn above defines the properties of frame-push-operand that only depend on the structural form of frames. The predicate weak-frame-p tests whether its argument has the structure of a frame. The predicate frame-p adds the semantic assertions (from the structure definition) about the individual component values of the frame. (The predicate frame-p does not include consistency constraints between components of a frame; for example, that if the current method is a bytecoded method, then frame-pc identifies an instruction in the method body.)

;The example rule below defines properties of frame-push-operand that depend on the stronger predicate frame-p.
;
;
; (defthm frame-push-operand-props
;   (implies (and (weak-frame-p frame)
;                 (weak-java-method-p (frame-method frame)))
;            (let ((new-frame (frame-push-operand value frame)))
;              (and (weak-frame-p new-frame)
;                   (equal (frame-max-locals new-frame)
;                          (frame-max-locals frame)))))
;   :hints (("Goal" :in-theory (enable frame-push-operand
;                                      frame-max-locals))))

; Remark: Why is this next rule here???
;
;
;
; (defthm djvm-push-operand-defn
;   (implies (and (Djvm-p djvm)
;                 (non-empty (Djvm-Stack djvm)))
;            (let ((new-djvm (Djvm-Push-Operand value djvm)))
;              (and (equal (Djvm-Heap New-Djvm) (Djvm-Heap Djvm))
;                   (equal (Djvm-Class-Table New-Djvm) (Djvm-Class-Table Djvm))
;                   (equal (Djvm-Stack New-Djvm)
;                          (cons (Frame-Push-Operand Value
;                                                    (car (Djvm-Stack Djvm)))
;                                (cdr (Djvm-Stack Djvm))))
;                   (equal (Djvm-Status New-Djvm) (Djvm-Status Djvm))))))
;
;A brief description of these macros is given below. Their complete definitions appear in Appendix [ch:frame-operations].

;We must define a separate structure-slot manipulation macro for each structure to be altered. For each macro we must:

;    Define a slot-table for the structure, identifying the slot names and the getter and setter functionsWe use the term getter to refer to a function that gets the value of a component in a structure. We use the term setter to refer to a function that sets the value of a component in a structure. Since ACL2 is an applicative language, the setter functions actually return a new structure value with the appropriate change, rather than destructive altering the old structure. The getter functions are sometimes called accessors or readers, and the setter functions are sometimes called updaters or writers. Someday the usage within this report will be more consistent. for them.
;    Define n^2 rules for all combinations of getters and setters.
;    Define altering operations on the structure by way of:
;        defining a function for the operation using setters
;        defining rules for all the getters applied to the function.
;        disabling the function (so the prover does not open its definition, but uses rewrite rules to reason about the operation)

;We define these operations to alter the value of a component in a frame. We often manipulate the top-most frame on the call-stack of a dJVM state. So we define analogous operations that alter components of the top-most call-frame in a dJVM state, yielding a new dJVM state with the alter call-frame on top of the call-stack.

;The dJVM slots, except for the call-stack, are pretty easy to handle. The class-table is not altered during execution. The status field has no structure, and the heap is a simple alist.

;An Aside on the defstructure Macro

;This section provides a rough overview of how the defstructure macro handles alteration of structured values. The defstructure macro was developed by Bishop Brock and used in applications were efficient execution and proofs were critical. So we take note of its design in building our much-simpler facility.
;
;The expansion of the defstructure macro:
;
;    defines a constructor function
;
;    defines the accessors and setters as functions
;
;    disables these function definitions during the proof
;
;    defines a set of normalization rules for the application of the accessors to the constructor
;
;    defines a set of reduction rules for the setters when they are applied to the raw constructor

;The application of these rules depends on asserting the weak structure-predicate, as that is the precondition for normalizing the setters in terms of the raw constructor. Once the setter terms have been rewritten in terms of the constructor, then the getter terms involving the constructor can be reduced.

;And this either all works or none of it works. Because I almost never see a raw constructor floating around in proofs. I don't recall ever seeing a raw constructor get introduced into the proof except when the prover performs ``destructor elimination.'' (See the definition of defs-eliminate-djvm in the generated reduction rules for setters, page [defs-eliminate-djvm]).

;Given a structure declaration,
;
;  (defstructure pair (left) (right))
;
;the expansion of defstructure produces the following normalization rules.


  ;  This lemma normalizes symbolic writes by transforming the symbolic
  ;  structure into an explicit reference of the constructor.  The first
  ;  conjunct is a lemma that will normalize equality tests for this
  ;  structure when one of the objects is an explicit reference of the
  ;  constructor.



;     (defthm defs-Normalize-Pair
;             (implies (weak-pair-p pair)
;                      (and (equal (equal (pair left right) pair)
;                                  (and (equal left (pair-left pair))
;                                       (equal right (pair-right pair))))
;                           (equal (set-pair-left value0 pair)
;                                  (pair value0 (pair-right pair)))
;                           (equal (set-pair-right value0 pair)
;                                  (pair (pair-left pair) value0)))))

  ;  This lemma simplifies reads of an explicit constructor.

;     (defthm defs-Read-Pair
;             (and (equal (pair-left (pair left right))
;                         left)
;                  (equal (pair-right (pair left right))
;                         right)))

  ;  This lemma simplifies writes of an explicit constructor.

;     (defthm defs-Write-Pair
;             (and (equal (set-pair-left value0 (pair left right))
;                         (pair value0 right))
;                  (equal (set-pair-right value0 (pair left right))
;                         (pair left value0))))

;The rules defs-Read-Pair and defs-Write-Pair rewrite terms involving the accessor and setter functions only when applied to the constructor function. The rule defs-Normalize-Pair will rewrite the setter functions when applied to anything, but only if the second argument satisfies the weak-pair-p predicate. It is the application of rewrite rules of this sort that encourages us to carry along assertions concerning the weak structure-predicates. This rewriting strategy is motivated by the idea that proving that a term satisfies the weak structure-predicate is usually easier than proving that it satisfies the strong structure-predicate, and so we expect that overall rewriting may be faster by deferring the application of the strong structure-predicate until after all of the internal rewriting has been completed.

;Here are the normalization rules for the setter functions.

; (defthm defs-normalize-djvm
;   (implies (weak-djvm-p djvm)
;    (and
;         ;; I don't understand what use this first conjunct is.
;         (equal (equal (djvm heap class-table stack status)
;                       djvm)
;                (and (equal heap (djvm-heap djvm))
;                     (equal class-table (djvm-class-table djvm))
;                     (equal stack (djvm-stack djvm))
;                     (equal status (djvm-status djvm))))
;
;         (equal (Set-Djvm-Heap value0 djvm)
;                (Djvm value0
;                      (Djvm-Class-Table djvm)
;                      (Djvm-Stack djvm)
;                      (Djvm-Status djvm)))
;
;         (equal (Set-Djvm-Class-Table value0 djvm)
;                (Djvm (Djvm-Heap djvm)
;                      value0
;                      (Djvm-Stack djvm)
;                      (Djvm-Status djvm)))
;
;         (equal (Set-Djvm-Stack value0 djvm)
;                (Djvm (Djvm-Heap djvm)
;                      (Djvm-Class-Table djvm)
;                      value0
;                      (Djvm-Status djvm)))
;
;         (equal (Set-Djvm-Status value0 djvm)
;                (Djvm (Djvm-Heap djvm)
;                      (Djvm-Class-Table djvm)
;                      (Djvm-Stack djvm)
;                      value0)))))

; Here are the reductions rules for the setter functions:
;
; (defthm defs-write-djvm
;   (and (equal (Set-Djvm-Heap value0 (Djvm Heap Class-Table Stack Status))
;               (Djvm value0 Class-Table Stack Status))

;        (equal (Set-Djvm-Class-Table value0
;                                     (Djvm Heap Class-Table Stack Status))
;               (Djvm Heap value0 Stack Status))
;
;        (equal (Set-Djvm-Stack value0 (Djvm Heap Class-Table Stack Status))
;               (Djvm Heap Class-Table value0 Status))
;
;        (equal (Set-Djvm-Status value0 (Djvm Heap Class-Table Stack Status))
;               (Djvm Heap Class-Table Stack value0))))
;
; (defthm defs-eliminate-djvm
;   (implies (weak-djvm-p djvm)
;            (equal (djvm (djvm-heap djvm)
;                         (djvm-class-table djvm)
;                         (djvm-stack djvm)
;                         (djvm-status djvm))
;                   djvm))
;   :rule-classes (:rewrite :elim))

(in-theory (disable ;(:REWRITE WEAK-CALL-STACK-P-TRUE-LISTP)
                    ;(:REWRITE WEAK-CLASS-DECL-LISTP-TRUE-LISTP)
                    ;(:REWRITE WEAK-FIELD-LISTP-TRUE-LISTP)
                    ;(:REWRITE WEAK-VAR-BINDING-LISTP-TRUE-LISTP)
                    ;(:REWRITE VAR-BINDING-LISTP-TRUE-LISTP)
                    ;(:REWRITE FV-LISTP-TRUE-LISTP)
                    ;(:REWRITE SV-LISTP-TRUE-LISTP)
                    ;(:REWRITE WEAK-TV-LISTP-TRUE-LISTP)
                    ;(:REWRITE TV-REF-LISTP-TRUE-LISTP)
                    (:REWRITE TRUE-LISTP-FLATTEN)
                    (:REWRITE TRUE-LISTP-STRING-LISTP)))

; The macros define-frame-operation and define-djvm-frame-operation are used to define functions that alter slots in a call frame. The macros expand to generate the necessary function and also rewrite rules so that the ACL2 theorem prover can reason about the operations.

;Here's a simple example of using the macros to define a frame operation.
;
;
; (define-frame-operation frame-set-pc (new-pc frame)
;   :slot pc
;   :new-value new-pc
;   :guard (naturalp new-pc))
;
;
; (define-djvm-frame-operation djvm-set-pc (new-pc djvm)
;   :frame-slot pc
;   :new-frame (frame-set-pc new-pc (car (djvm-stack djvm)))
;   :guard (naturalp new-pc))

;Here's an example that defines an operation that alters the operand stack of a call frame by pushing a new value onto the stack. First we define the frame-level operation that pushes an operand onto the operand stack of a frame. Then we define the dJVM-level corresponding operation, altering the current frame in the dJVM call-stack.

;Here's the definition of the frame-level operation.


; (define-frame-operation frame-push-operand (sv frame)
;   :slot stack
;   :new-value (cons sv (frame-stack frame))
;   :guard (sv-p sv)
;   :weak-guard (weak-tv-p sv)
;   )

;Here's the expansion of the frame-level definition.


; (encapsulate nil
;
;
;
;     (defun frame-push-operand (sv frame)
;       (declare (xargs :guard (and (weak-frame-p frame)
;                                   (weak-tv-p sv))))
;       (set-frame-stack (cons sv (frame-stack frame))
;                        frame))
;
;
;
;   (defthm frame-push-operand-defn
;     (implies (force (weak-frame-p frame))
;              (let ((new-frame (frame-push-operand sv frame)))
;                (and (equal (frame-class new-frame)
;                            (frame-class frame))
;                     (equal (frame-method new-frame)
;                            (frame-method frame))
;                     (equal (frame-pc new-frame)
;                            (frame-pc frame))
;                     (equal (frame-cia new-frame)
;                            (frame-cia frame))
;                     (equal (frame-locals new-frame)
;                            (frame-locals frame))
;                     (equal (frame-stack new-frame)
;                            (cons sv (frame-stack frame)))
;                     (equal (frame-new-refs new-frame)
;                            (frame-new-refs frame))
;                     (equal (frame-object-ref new-frame)
;                            (frame-object-ref frame))
;                     (equal (frame-max-locals new-frame)
;                            (frame-max-locals frame)))))
;     :hints (("Goal" :in-theory (enable frame-max-locals))))
;   )
;
;Here's the definition of the corresponding dJVM-level operation.
;
;
; (define-djvm-frame-operation djvm-push-operand (sv djvm)
;   :frame-slot stack
;   :new-frame (frame-push-operand sv (car (djvm-stack djvm)))
;   :guard (sv-p sv)
;   :weak-guard (weak-tv-p sv)
;   )
;
;Here's the expansion of the dJVM-level definition.
;
;
; (encapsulate
;    nil
;    (defun djvm-push-operand (sv djvm)
;      (declare (xargs :guard (and (weak-djvm-p djvm)
;                                  (non-empty (djvm-stack djvm))
;                                  (weak-tv-p sv))))
;      (if (non-empty (djvm-stack djvm))
;          (let ((call-stack (djvm-stack djvm)))
;            (set-djvm-stack (cons (frame-push-operand sv
;                                         (car (djvm-stack djvm)))
;                                  (cdr call-stack))
;                            djvm))
;        djvm))
;
;
;
;  (defthm djvm-push-operand-defn
;    (implies (force (and (weak-djvm-p djvm)
;                         (non-empty (djvm-stack djvm))))
;             (let ((new-djvm (djvm-push-operand sv djvm)))
;               (and (equal (djvm-stack new-djvm)
;                           (cons (frame-push-operand sv
;                                        (car (djvm-stack djvm)))
;                                 (cdr (djvm-stack djvm))))
;                    (equal (djvm-heap new-djvm)
;                           (djvm-heap djvm))
;                    (equal (djvm-class-table new-djvm)
;                           (djvm-class-table djvm))
;                    (equal (djvm-status new-djvm)
;                           (djvm-status djvm))
;                    (let ((frame (car (djvm-stack djvm)))
;                          (new-frame (car (djvm-stack new-djvm))))
;                      (and (equal (frame-class new-frame)
;                                  (frame-class frame))
;                           (equal (frame-method new-frame)
;                                  (frame-method frame))
;                           (equal (frame-pc new-frame)
;                                  (frame-pc frame))
;                           (equal (frame-cia new-frame)
;                                  (frame-cia frame))
;                           (equal (frame-locals new-frame)
;                                  (frame-locals frame))
;                           (equal (frame-stack new-frame)
;                                  (frame-stack
;                                   (frame-push-operand sv
;                                          (car (djvm-stack djvm)))))
;                           (equal (frame-new-refs new-frame)
;                                  (frame-new-refs frame))
;                           (equal (frame-object-ref new-frame)
;                                  (frame-object-ref frame))
;                           (equal (frame-max-locals new-frame)
;                                  (frame-max-locals frame)))))))
;    :hints (("Goal" :in-theory (enable set-frame-stack))))
;
;
;
;  (defthm djvm-p-djvm-push-operand
;    (implies (force (and (djvm-p djvm) (sv-p sv)))
;             (djvm-p (djvm-push-operand sv djvm))))
;
;
;
;  (defthm weak-djvm-p-djvm-push-operand
;    (implies (force (and (weak-djvm-p djvm) (weak-tv-p sv)))
;             (weak-djvm-p (djvm-push-operand sv djvm))))
;
;
;
;  (in-theory (disable djvm-push-operand)))

;The weak-guard is intended to assure the structural requirements for the dJVM operation. The guard should be strong enough to assure both the structural requirements and the slot assertion (from the structure definition) for the altered slot. The local variables full-weak-guard and full-guard augment values of these formal parameters with the standard weak or strong predicates for djvm structures (i.e., weak-djvm-p or djvm-p). Thus when using the define-djvm-operation macro, these standard predicates are implicitly added to any guard explicitly given.

; Manipulating the Operand Stack

; Remark: Somewhere we should specify that the operand stack is well-typed. We already state that it is a sv-listp, but we don't assert that :long-top-half and :long-bot-half values only appear together and in the right order.

; We have not yet specified this as a state invariant, and have not yet proven it is preserved by dJVM execution. Currently each instruction that manipulates the operand stack checks that the portion of the stack manipulated does not leave any unmatched ``long halves'' on the stack.The current restrictions are not as strong as the state invariant. For example, the pop2 instruction (page [djvm-execute-pop2]) will pop any two words off the stack, but it won't break up a two-word value. It does not check whether the top operand is a dangling :long-bot-half value. Although it does assure that the second word it pops is not a :long-top-half, it does not check that the new top of the stack is not an unmatched :long-bot-half. This could only happen if the initial operand stack contained a :long-bot-half as the third word on the stack, and it was not matched by a :long-top-half as the second word on the stack. The pop2 instruction never introduces a violation of the proposed state invariant, but it doesn't check that the entire stack satisfies the invariant.


; Accessing the Operand Stack

(defun frame-top-operand (frame)
  (declare (xargs :guard (and (frame-p frame)
                              (non-empty (frame-stack frame)))))
  (car (frame-stack frame)))

(defun frame-next-top-operand (frame)
  (declare (xargs :guard (and (frame-p frame)
                              (non-empty (cdr (frame-stack frame))))))
  (cadr (frame-stack frame)))

(defthm sv-p-frame-top-operand
  (implies (and (frame-p frame)
                (non-empty (frame-stack frame)))
           (sv-p (frame-top-operand frame))))

(defun djvm-operand-stack (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (frame-stack (current-frame djvm)))

(defun djvm-top-operand (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (non-empty (frame-stack (current-frame djvm)))
                              )))
  (frame-top-operand (current-frame djvm)))

(defun djvm-next-top-operand (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (non-empty (frame-stack (current-frame djvm)))
                              (non-empty (cdr (frame-stack (current-frame djvm))))
                              )))
  (frame-next-top-operand (current-frame djvm)))

(defthm sv-p-djvm-top-operand
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (non-empty (frame-stack (current-frame djvm))))
           (sv-p (djvm-top-operand djvm))))

(defthm sv-p-djvm-next-top-operand
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (non-empty (frame-stack (current-frame djvm)))
                (non-empty (cdr (frame-stack (current-frame djvm)))))
           (sv-p (djvm-next-top-operand djvm))))

; Pushing values onto the Operand Stack

(in-theory (disable sv-p sv-p-defn))

(in-theory (disable ;(:REWRITE WEAK-CALL-STACK-P-TRUE-LISTP)
                    ;(:REWRITE WEAK-CLASS-DECL-LISTP-TRUE-LISTP)
                    ;(:REWRITE WEAK-FIELD-LISTP-TRUE-LISTP)
                    ;(:REWRITE WEAK-VAR-BINDING-LISTP-TRUE-LISTP)
                    ;(:REWRITE VAR-BINDING-LISTP-TRUE-LISTP)
                    ;(:REWRITE FV-LISTP-TRUE-LISTP)
                    ;(:REWRITE SV-LISTP-TRUE-LISTP)
                    ;(:REWRITE WEAK-TV-LISTP-TRUE-LISTP)
                    ;(:REWRITE TV-REF-LISTP-TRUE-LISTP)
                    (:REWRITE TRUE-LISTP-FLATTEN)
                    (:REWRITE TRUE-LISTP-STRING-LISTP)))

(in-theory (disable weak-tv-p))

(define-frame-operation  frame-push-operand (sv frame)
   :slot stack
   :new-value (cons sv (frame-stack frame))
   :guard (sv-p sv)
   :weak-guard (weak-tv-p sv)
   )

(define-djvm-frame-operation  djvm-push-operand (sv djvm)
   :frame-slot stack
   :new-frame  (frame-push-operand sv (current-frame djvm))
   :guard (sv-p sv)
   :weak-guard (weak-tv-p sv)
   )

(defthm consp-djvm-push-operand
  (implies (force (and (weak-djvm-p djvm)
                       (non-empty (djvm-stack djvm))))
           (consp
            (djvm-stack
             (djvm-push-operand x djvm))))
  :hints (("Goal" :in-theory (enable  djvm-push-operand)))
  :rule-classes (:type-prescription))

(defthm non-empty-djvm-stack-djvm-push-operand
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (non-empty (djvm-stack (djvm-push-operand x djvm))))
  :hints (("Goal" :in-theory (enable  djvm-push-operand)))
  :rule-classes ((:rewrite
                  :corollary (implies (and (djvm-p djvm)
                                           (non-empty (djvm-stack djvm)))
                                      (djvm-stack (djvm-push-operand x djvm))))
                 (:rewrite
                 :corollary
                         (implies (and (djvm-p djvm)
                                       (non-empty (djvm-stack djvm)))
                                  (non-empty (djvm-stack
                                                  (djvm-push-operand x djvm))))
                  )))




;Popping the operand stack

;Here are analogous functions for popping the operand stack.


(define-frame-operation  frame-pop-operand (frame)
  :slot stack
  :new-value  (cdr (frame-stack frame))
  :guard      (non-empty (frame-stack frame))
  :weak-guard (non-empty (frame-stack frame))
  )

(define-djvm-frame-operation  djvm-pop-operand (djvm)
  :frame-slot stack
  :new-frame  (frame-pop-operand (current-frame djvm))
  :guard      (non-empty (frame-stack (current-frame djvm)))
  :weak-guard (non-empty (frame-stack (current-frame djvm)))
  )

(defthm consp-djvm-pop-operand
  (implies (force (and (weak-djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (non-empty (frame-stack (car (djvm-stack djvm))))))
           (consp
            (djvm-stack
             (djvm-pop-operand djvm))))
  :rule-classes (:type-prescription :rewrite))

; Altering the PC

; After non-branching instructions the PC is incremented by the length of the instruction.

(defthm naturalp-frame-pc-car-djvm-stack
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (naturalp (FRAME-PC (CURRENT-FRAME DJVM))))
  :rule-classes (:rewrite :type-prescription))

; Jumps

; A ``jump'' changes the PC either conditionally or unconditionally, usually to address an instruction other than the one following the jump. Some of the jump instructions also pop an entry from the operand stack, but for this discussion we only consider effects on the CP.

(define-frame-operation  frame-set-pc (new-pc frame)
   :slot pc
   :new-value new-pc
   :guard (naturalp new-pc))

(define-djvm-frame-operation  djvm-set-pc (new-pc djvm)
   :frame-slot pc
   :new-frame (frame-set-pc new-pc (current-frame djvm))
   :guard (naturalp new-pc))

; Incrementing the PC

(defun frame-increment-pc (delta frame)
  (declare (xargs :guard (and (integerp delta)
                              (frame-p frame)
                              (naturalp (+ delta (frame-pc frame))))))
  (frame-set-pc (+ delta (frame-pc frame)) frame))

(defun djvm-increment-pc (inc djvm)
  (declare (xargs :guard (and (djvm-P djvm)
                              (integerp inc)
                              (non-empty (djvm-stack djvm))
                              (naturalp (+ inc (djvm-pc djvm))))))
  (if (non-empty (djvm-stack djvm))
      (djvm-set-pc (+ inc (djvm-pc djvm)) djvm)
    djvm))

; If we chose to keep the function definitions frame-increment-pc and djvm-increment-pc disabled, then we would need to define rewrite rules such as those below. But we choose to let frame-increment-pc and djvm-increment-pc remain enabled.

; These rules handle the case in which the PC may be incremented by a negative number. This is legal so long as the resulting PC is still non-negative. (The constraint that the PC point to an instruction will be handled later, in the predicate valid-pc?.)

; Altering Local Variables

(define-frame-operation  frame-store-local (index value frame)
  :slot locals
  :new-value  (bind-equal index value (frame-locals frame))
;  :new-value  (bind index value (frame-locals frame))
  :guard      (and (naturalp index)
                   (< index (frame-max-locals frame))
                   (sv-p value)
                   (local-vars-listp (frame-locals frame)))
  :weak-guard (and (naturalp index)
                   (weak-tv-p value)
                   (weak-local-vars-listp (frame-locals frame))))

(define-djvm-frame-operation  djvm-store-local (index value djvm)
  :frame-slot locals
  :new-frame  (frame-store-local index value (current-frame djvm))
  :guard      (and (naturalp index)
                   (< index (frame-max-locals (current-frame djvm)))
                   (sv-p value))
  :weak-guard (and (naturalp index)
                   (weak-tv-p value)
                   (weak-local-vars-listp (frame-locals (current-frame djvm)))))

(defthm non-empty-djvm-stack-djvm-store-local
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (naturalp index)
                (weak-tv-p value))
           (non-empty (djvm-stack (djvm-store-local index value djvm)))))

(in-theory (disable FV-LISTP-TRUE-LISTP))

(in-theory (disable sv-listp naturalp-listp))

(defthm frame-p-set-frame-locals
  (implies (and (frame-p frame)
                (local-vars-listp locals))
           (frame-p (set-frame-locals locals frame)))
  :hints (("Goal" :in-theory (enable local-vars-listp
                                     weak-local-vars-listp))))

(defthm local-vars-listp-bind-all
        (implies (and (local-vars-listp locals)
                      (naturalp-listp indices)
                      (sv-listp values))
                 (local-vars-listp (bind-all-equal indices values locals)))
;                 (local-vars-listp (bind-all indices values locals)))
        :hints (("Goal" :in-theory (disable sv-p sv-p-defn)
                        :hands-off (true-listp))))

(defthm weak-local-vars-listp-bind-all
        (implies (and (weak-local-vars-listp locals)
                      (naturalp-listp indices)
                      (weak-tv-listp values))
                 (weak-local-vars-listp (bind-all-equal indices values locals))))
;                 (weak-local-vars-listp (bind-all indices values locals))))

(defthm sv-listp-is-weak-tv-listp
  (implies (sv-listp x)
           (weak-tv-listp x))
  :hints (("Goal" :in-theory (enable sv-listp weak-tv-listp)))
  :rule-classes (:forward-chaining))

(in-theory (enable sv-listp-true-listp
                   naturalp-listp-true-listp))

(verify-guards naturalp-listp)

(define-frame-operation  frame-store-locals (indices values frame)
  :slot locals
  :new-value  (bind-all-equal indices values (frame-locals frame))
;  :new-value  (bind-all indices values (frame-locals frame))
  :guard      (and (naturalp-listp indices)
                   (sv-listp values)
                   (bounded-naturals-listp indices
                                           (frame-max-locals frame)))
  :weak-guard (and (naturalp-listp indices)
                   (sv-listp values)
                   (weak-local-vars-listp (frame-locals frame))))

(in-theory (disable sv-listp-true-listp
                    naturalp-listp-true-listp))

(define-djvm-frame-operation  djvm-store-locals (indices values djvm)
  :frame-slot locals
  :new-frame  (frame-store-locals indices values (current-frame djvm))
  :guard      (and (naturalp-listp indices)
                   (sv-listp values)
                   (bounded-naturals-listp indices
                                           (frame-max-locals
                                            (current-frame djvm))))
  :weak-guard (and (naturalp-listp indices)
                   (sv-listp values)
                   (weak-local-vars-listp (frame-locals (current-frame djvm)))))

(defthm non-empty-djvm-stack-djvm-store-locals
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (naturalp-listp indices)
                (sv-listp values))
           (non-empty (djvm-stack (djvm-store-locals indices values djvm)))))

(defthm local-vars-listp-true-listp-forward
  (implies (local-vars-listp x)
           (true-listp x))
  :rule-classes :forward-chaining)

(defthm djvm-p-set-djvm-stack
  (implies (and (djvm-p djvm)
                (call-stack-p new-stack))
           (djvm-p (set-djvm-stack new-stack djvm))))

; Altering Fields

; Remark: Move the low-level field manipulations from getfield.lisp and getstatic.lisp to here.

; Tracking References to Uninitialized Instances.

; When an instance is created, it is considered as uninitialized in the context of the current method. The instance is considered initialized after the current method has invoked an instance-initialization method (i.e., an instance method named <init>) and that instance-initialization method has returned normally (i.e., via a return instruction). Until the instance is considered initialized, the current method may not access the instance's data fields nor invoke any of the instance's methods, except an instance-initialization method, nor store a reference to the instance in a field that is assignment-compatible with the class of the uninitialized instance.

; An instance-initialization method is invoked on an instance via the invokespecial instruction. The instance used as the object-reference argument to the invokespecial instruction be considered uninitialized in the context of the current method. Otherwise the current method completes abruptly.The dJVM version 0.5 does not support exception handling. Conditions that would trigger ``abrupt completion'' in the normal JVM cause the dJVM 0.5 to halt with a status condition indicating the error or exception condition. When the dJVM is extended to handle exceptions, an exception condition will be defined for this case. When an instance-initialization method is invoked, the object-reference argument to the invokespecial instruction is considered uninitialized in the context of the instance-initialization method. As above, the instance will be considered initialized when the instance-initialization method itself has invoked another instance-initialization method and that other instance-initialization method has completed normally.

; This requirement is modeled in the dJVM by the new-refs field in call frames. The new-refs field keeps a list of references to instances considered uninitialized in the context of the method invocation corresponding to that call frame. When a new instance is created (via the new instruction), a reference to it is added to the new-refs field. When an instance-initialization method is invoked, the object-reference used to invoke the method is considered uninitialized in the context of that instance-initialization method invocation. When an instance is considered initialized in the context of a method invocation, the reference to it is removed from the new-refs field.

; Additions to the new-refs field are triggered by execution of the new instruction and the creation of a call-frame for an instance-initialization method. Deletions from the new-refs field are triggered by execution of the return instruction within an instance-initialization method. (It is an error for an instance-initialization method to execute a return instruction if the dispatching object-reference is not considered initialized within the context of the instance-initialization invocation.)

; The function frame-mark-new-ref adds a reference to a frame's new-refs field. The function frame-mark-inited removes a reference from a frame's new-refs list. This should only be called when we know that the reference is actually in the list. Removing the reference from the list corresponds to the instance having been initialized. The list new-refs contains references to all new and uninitialized instances created by the frame's method or uninitialized instances being initialized by the frame's method (in the case of an instance-initialization method). It is an error to attempt to initialize an object already initialized. If the reference is not in the new-refs list, then it was already considered initialized (at least in the context of that frame). So we do not allow frame-mark-inited to be used in this fashion.

(defun frame-initialized-ref-p (object-ref frame)
  (declare (xargs :guard (and (tv-ref-p object-ref)
                              (frame-p frame))))
  (not (member-equal object-ref (frame-new-refs frame))))

(defun djvm-initialized-ref-p (object-ref djvm)
  (declare (xargs :guard (and (tv-ref-p object-ref)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (frame-initialized-ref-p object-ref (car (djvm-stack djvm))))

(defun frame-mark-inited (object-ref frame)
  (declare (xargs :guard (and (tv-ref-p object-ref)
                              (frame-p frame)
                              (member-equal object-ref (frame-new-refs frame)))))
  (set-frame-new-refs (remove-equal object-ref
                                    (frame-new-refs frame))
                      frame))

(defun frame-mark-new-ref (object-ref frame)
  (declare (xargs :guard (and (tv-ref-p object-ref)
                              (frame-p frame))))
  (set-frame-new-refs (cons object-ref (frame-new-refs frame))
                      frame))

(defun djvm-mark-new-ref (object-ref djvm)
  (declare (xargs :guard (and (tv-ref-p object-ref)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (set-djvm-stack (cons (frame-mark-new-ref object-ref
                                            (car (djvm-stack djvm)))
                        (cdr (djvm-stack djvm)))
                  djvm))

(defun refs-to-initialized-instances-p (n operand-stack new-refs)
  (declare (xargs :guard (and (naturalp n)
                              (sv-listp operand-stack)
                              (tv-ref-listp new-refs))))
  (if (zp n)
      t
    (if (atom operand-stack)
        nil
      (if (tv-ref-p (car operand-stack))
          (and (not (member-equal (car operand-stack) new-refs))
               (refs-to-initialized-instances-p (1- n)
                                                (cdr operand-stack)
                                                new-refs))
        (refs-to-initialized-instances-p (1- n)
                                                (cdr operand-stack)
                                                new-refs)))))

(defun stack-instances-initialized-p (n frame)
  (declare (xargs :guard (and (naturalp n)
                              (frame-p frame))))
  (refs-to-initialized-instances-p n
                                   (frame-stack frame)
                                   (frame-new-refs frame)))

; Manipulating the Call Stack
; Pushing a Call Frame

; Remark: Defining this operation would save space in the invoke-XXX instructions, and possibly simplify the functions for class initialization.

; Note that popping a call frame is a trivial operation: it is just the Common Lisp cdr function, which removes the first element of a list.

; Altering the dJVM Status

(define-djvm-slot-operation  djvm-error (err-msg inst djvm)
  :slot status
  :new-value (list ':error err-msg inst))

; Remark: Move the definition of running-p and company from the stack-overflow proof script to here.

; Member Access Protection

; Remark: This section lacks an introduction to member access protection.

; This belongs back near the discussion of method lookup ([sec:method-lookup]) and field lookup ([sec:field-lookup]).

; Field Access

; Access to a field in an instance is permitted:

;    If the field is protected, then it must be either a member of the current class or a member of a superclass of the current class, and the class of objectref must be either the current class or a subclass of the current class.
;    [ 6.4, p226 in JVMS]

; The phrase ``a member of the current class or a member of a superclass of the current class'' is needed to include fields declared in a superclass that have been hidden in the current class.

; However, two earlier descriptions of the meaning of protected state different requirements.

;    To be precise, a protected member may be accessed from anywhere in the package in which it is declared and, in addition, it may be accessed from within any declaration of a subclass of the class type that contains its declaration, provided that certain restrictions are obeyed.
;    [ 2.7.8, p. 23 in JVMS]

; There is no cross-reference to where the ``certain restrictions'' are elaborated. The paragraph quoted above states explicitly that other classes in the same package may freely access the protected member regardless of any subclass or superclass relationship with the class declaring the member.

; But the following description of structural constraints on bytecoded methods in class files does not mention packages!

;    If a getfield or putfield [instruction] is used to access a protected field of a superclass, then the type of the class instance being accessed must be the same as or a subclass of the current class.
;    [ 4.8.2, p. 123 in JVMS]

; Neither do the descriptions of access to protected members in individual instructions mention packages.

; Class name argument to getfield

; The JLS binary-compatibility requirements impose some constraints on the form of getfield and getstatic instructions in (compiled) class files. Specifically, the class specified in the getfield and getstatic instructions must be the class that declared the field; it may not be a class that merely inherits the field. Sun's Java compiler (JDK 1.0.2) emits code satisfying this requirements.

;    A reference to a field of another class or interface must be resolved at compile time to a symbolic reference to the class or interface in which the field is declared, plus the simple name of the field. (Including the exact class or interface in which the field is declared makes the binaries more robust since adding another field with the same name, even in a subclass, cannot cause confusion at link time. This rule does mean, however, that moving a field to a superclass is not a binary compatible change.)[Emphasis added.]
;    [ 13.1, p. 239 in JLS]

;    Deleting a field [declaration] from a class will break compatibility with any pre-existing binaries that reference this field, and a NoSuchFieldError will be thrown when such a reference from a pre-existing binary is linked.
;    [ 13.4.7, p. 250 in JLS]

; However, private fields may safely be deleted, because references are only permitted within the declaring class and the entire class definition must be recompiled at the same time, leaving no inconsistent references within it (assuming the class declaration compiles without errors).

; Recall that the getfield and getstatic instructions take (constant pool) arguments providing a class name, a field name, and a type signature. The binary compatibility requirements of Java imply that the class name argument of a getfield or getstatic instruction must name the class in which the field was declared. It may not name a subclass that inherits the field.

;Here's an example to illustrate this:
;
;
;    class One {
;      static int x = 0;
;      int y = 1;
;    }
;
;    class Two extends One {
;      int z = 2;
;
;
;
;      int test () {
;        return (Two.x + Two.y + z);
;      }
;    }

;The method Two.test accesses an inherited static variable (x), an inherited instance variable (y), and a locally-declared instance variable (z). Sun's Java compiler (JDK 1.0.2) generates the following bytecode:


;    Method int test()
;     0 getstatic #4 <Field One.x I>
;     3 aload_0
;     4 getfield #5 <Field One.y I>
;     7 iadd
;     8 aload_0
;     9 getfield #6 <Field Two.z I>
;    12 iadd
;    13 ireturn

;Note that the getstatic instruction explicitly references the static field as One.x, even though it was referenced as Two.x in the source code. Similarly, the first getfield instruction explicitly references the instance variable as One.y, even though it was referenced as Two.y in the source code.

; Note on JVM Semantics: The JVMS does not appear to state explicitly the above requirement on the arguments of the getfield and getstatic instructions.

; The description of resolving field references merely states:
;
;    If the referenced field does not exist in the specified class or interface, field resolution throws a NoSuchFieldError.
;    [ 5.2, p. 147 in JVMS]

;There is no suggestion that the field must have been explicitly declared within the class, only that it must ``exist in the specified class.'' If the ``specified class'' referred to the class representation described for class files, then it would be clear, because the fields table in a class file ``includes only those fields that are declared by this class.'' However, it is obvious that the notion of a ``resolved class'' at run time includes more information than is contained in the class file. For the description of getfield includes the following:

;    The [Fieldref] item is resolved, determining both the field width and the field offset.

;The Java compiler does not assume a specific layout for instance data. Rather the choice of layout is left to the JVM. Thus, the class file cannot reflect specific field widths and offsets. Such implementation-specific information must be supplied by the JVM. But the description of class loading in the JVM does not (and should not) describe such implementation-specific behavior.

;Remark: I am presuming that the JDK bytecode verifier will reject a getfield instruction whose Fieldref references a class in which the field is inherited, rather than declared. I need a bytecode assembler/class-file compiler to test this, since the JDK Java compiler will not generate such a class file.

;But the Java binary-compatibility requirements suggest this cannot work, because it would be indistinguishable from moving the field declaration to a superclass.

;However, this requirement may be inferred from the binary-compatibility requirements of the Java language, and expectation that the JVM supports the language requirements in a straightforward manner consistent with the other, explicit JVM requirements.

;    A reference to a field of another class or interface must be resolved at compile time to a symbolic reference to the class or interface in which the field is declared, plus the simple name of the field. (Including the exact class or interface in which the field is declared makes the binaries more robust. This rule does mean, however, that moving a field to a superclass is not a binary compatible change.
;    [ 13.1, p. 239 in JLS]

;    During resolution, the linker looks only in the class that was identified at compile time.
;    [ 13.4.5, p. 246 in JLS]

(defun subclass-decl-p (subclass-decl class-decl)
  "Check whether SUBCLASS-DECL declares a subclass of CLASS-DECL."
  (declare (xargs :guard (and (class-decl-p subclass-decl)
                              (class-decl-p class-decl))))
  (member-equal-p (class-decl-name class-decl)
                  (class-decl-superclasses subclass-decl)))


;    Whether a package is accessible is determined by the host system
;    [ 6.6, p. 99 in JLS]

;    The hieracrhical naming structure for packages is intended to be convenient but has not significance. There is no special access relationship in the Java language between a package named oliver and another package named oliver.twist, or between packages named evelyn.wood and evelyn.Waugh.
;    [ 7.1, p. 7.2.1 in JLS]

;The JVMS describes the last step of class resolution as checking whether the resolved class is accessible to the ``current class.''

;    If the current class or interface does not have permission to access the class or interface being resolved, class or interface resolution throws an IllegalAccessError. This condition can occur, for example, if a class that is originally declared public is changed to be private [sic] after another class that refers to the class has been compiled.
;    [ 5.1.1, p. 144 in JVMS]

; Remark: Clearly they meant to say: if a class declared public is changed to [default protection].

(defthm protection-modifier-p-field-protection-expanded
 (implies (field-p x)
          (MEMBER  (field-protection x)
                   '(:PUBLIC :PRIVATE
                              :PROTECTED :DEFAULT-PROTECTION))))

(defthm protection-modifier-p-java-method-protection-expanded
 (implies (java-method-p x)
          (MEMBER  (java-method-protection x)
                   '(:PUBLIC :PRIVATE
                              :PROTECTED :DEFAULT-PROTECTION))))

(defun Djvm-Class-Accessible-p (Target-Class Accessing-Class)
  (declare (xargs :guard (and (Class-Decl-p Target-Class)
                              (Class-Decl-p Accessing-Class))))
  (case (Class-Decl-Protection Target-Class)
;  (exhaustive-case (Class-Decl-Protection Target-Class)
    (:public t)
    (:default-protection (equal (Package-For-Class-Decl Target-Class)
                                (Package-For-Class-Decl Accessing-Class)))))


;Note on Java Semantics: The Java definition of permitted access to protected class members is given in terms of compile-time types. Thus at the language level access is permitted based on the declared type of an object reference, field value, or method invocation expression. [ 6.6.2, p. 100 in JLS]

;Note on JVM Semantics: The Java Virtual Machine Specification defines access to protected fields and methods in the descriptions of each instruction. The description is given in terms of the run-time class of the object being referenced. This is a weaker restriction than that imposed by the language specification.

;However, any program that satisfies the static requirements of the language will also satisfy the dynamic requirements of the JVM.
;The JLS [p. 100] describes special rules for access to protected constructors. In particular, it restricts the use of the method Class.newInstance.

;Note on the dJVM Model: The Java language only permits access of protected constructors from within the package in which the constructor is defined. [ 6.6.2, p. 100 in JLS]

;The JVMS does not seem to reflect that restriction, and neither does the dJVM.

;Remark: The JLS states that ``a protected constructor can be accessed by a class instance creation expression only from within the package in which it is defined.'' [ 6.6.4, p. 100 in JLS].

;However, the JVMS description of invokespecial describes access to protected methods just as for the other method-invocation instructions: ``if the method is protected, then it must be either a member of the current class or a member of a superclass of the current class, and the class of objectref must be either the current class or a subclass of the current class.'' [p. 262 in JVMS] This suggests that protected instance initialization methods may be accessed from outside the package of the class in which it is defined.

(defun Djvm-Member-Accessible-p (Protection Target-Class Accessing-Class)
  (declare (xargs :guard (and (Protection-Modifier-p Protection)
                              (Class-Decl-p Target-Class)
                              (Class-Decl-p Accessing-Class))))
  (and (Djvm-Class-Accessible-p Target-Class Accessing-Class)
       (case Protection
;       (exhaustive-case Protection
         (:public t)
         (:private (equal Target-Class Accessing-Class))
         (:protected (or (equal Target-Class Accessing-Class)
                         (Subclass-Decl-p Target-Class Accessing-Class)))
         (:default-protection (equal (Package-For-Class-Decl Target-Class)
                                     (Package-For-Class-Decl Accessing-Class))))))

(defthmd tttt_0
  (implies (and (stringp target-class-name)
                (stringp field-name)
                ;(stringp current-class-name)
                (class-table-p class-table)
                (bound?-equal target-class-name class-table)
                ;(bound?-equal current-class-name class-table)
                (field-bound? field-name
                              (class-decl-fields
                               (binding-equal target-class-name
                                              class-table)))
                )
           (protection-modifier-p
            (field-protection
             (field-binding
              field-name
              (class-decl-fields
               (binding-equal target-class-name class-table))))))
  :hints (("goal" :do-not-induct t
           :in-theory (disable protection-modifier-p)
           :cases ((not (field-listp
                         (class-decl-fields
                          (binding-equal target-class-name class-table))))))
 ;         ("subgoal 2" :in-theory (disable (:REWRITE DEFS-CLASS-DECL-ASSERTIONS . 6)))
          )
)

(defun djvm-field-accessible-p (target-class-name field-name
                                current-class-name class-table)
  (declare (xargs :guard (and (stringp target-class-name)
                              (stringp field-name)
                              (stringp current-class-name)
                              (class-table-p class-table)
                              (bound?-equal target-class-name class-table)
                              (bound?-equal current-class-name class-table)
                              (field-bound? field-name
                                            (class-decl-fields
                                             (binding-equal target-class-name
                                                      class-table))))
                  :guard-hints (("goal" :use tttt_0))))
  (let* ((target-class (binding-equal target-class-name class-table))
         (protection   (field-protection
                        (field-binding field-name
                                       (class-decl-fields target-class)))))
    (djvm-member-accessible-p protection
                              target-class
                              (binding-equal current-class-name class-table))))

(in-theory (disable DJVM-Field-Accessible-p
                    DJVM-Member-Accessible-p
                    Subclass-Decl-p))

;Note on Java Semantics:

;    References to fields that are static, final, and initialized with compile-time constant expressions are resolved at compile time to the constant value that is denoted. No reference to such a constant field should be present in the code in a binary file (except in the class or interface containing the constant field, which will have code to initialize it), and such constant fields must always appear to have been initialized; the default initial value for the type of such a field must never be observed.
;    [ 13.1, page 239 in JLS]

;Remark: Must we check that the field access is not to a static or final field that had a constant value? After the fact it's hard to tell whether the field was initialized to a compile-time constant value!

; Method Access

;    If [the] invokevirtual [instruction] is used to access a protected method of a superclass, then the type of the class instance being accessed must be the same as or a subclass of the current class.
;    [p. 123 in JVMS]

; Note on JVM Semantics: Like the field access instructions, the method invocation instructions specify a class name. However the use of the class name to look up a method is different than that to look-up a field.

; A method with that name and (complete) signature must be declared in the specified class. It is not sufficient that it merely be a member of the class (i.e., inherited from a superclass). [ 13.4.5 in JLS]

; In a JVM implementation that uses method-dispatch vectors, the above requirement could be used to great advantage. Since the method must have been declared in the named class, we can utilize that class declaration to determine the appropriate index into the method-dispatch vector. Even though the method declared in that class may have been overridden in a subclass declaration, all subclasses will use the same index position in the dispatch vector for those overriding methods. This information can then be cached in the instruction by replacing the invokevirtual instruction with an invokevirtual_quick instruction.

;    The descriptor of the resolved method must be identical to the descriptor of one of the methods of the resolved class. [sic]

;    The constant pool entry representing the resolved method includes an unsigned index into the method table of the resolved class and an unsigned byte nargs that must not be zero.
;    [p. 267-8 in JVMS]

; Remark: Does the above passage from the JVMS make any sense (outside of the context of an implementation based on dispatch-vectors)?

; A constant pool entry of type CONSTANT_MethodRef does not include a field named ``index'' nor one named ``nargs.'' These values might be computed as part of the process of resolution, but the passage above explicitly refers to ``the constant pool entry'' as including these values.

; Ah ha! The use of ``nargs'' appears to come from the description of the (pseudo-instruction) invokevirtual_quick! The invokevirtual_quick instruction has two argument bytes: index and nargs, described as:

;    The index operand is an unsigned byte and the nargs operand is an unsigned byte, which must not be zero. The index is an index into the method table of the class of the type of objectref. The table entry at that index includes the method's code and its modifier information.

;These values are not in any constant-pool entry!

;    The objectref must be of type reference. The index is used as an index into the method table of the class of the type of objectref. The table entry at that index includes a direct reference to the method's code and its modifier information.
;    [p. 268 in JVMS]

;Remark: I believe the two passages above are based on:

;    An underlying implementation model not explicitly described in the JVMS, and
;    Two different interpretations of ``index'' and ``method table'' used without distincting one from the other.

;They use ``method table'' to refer both to (the internal representation of) the method table of a class file, and also to the method-dispatch table of their presumed implementation model.

;They use ``index'' to index both of these tables, where there is no requirement that the same index identifies related entries in the two tables. (Except that their underlying implementation model is intended to give a special meaning to the index that is shared between the class declaring the method and the class of the instance on the stack.)

;Note on JVM Semantics: The JVMS does not appear to specify how the invokevirtual instruction should resolve the method reference and identify which method to invoke.

;The description of the invokevirtual instruction is given in terms of class' method tables, but that concept is not elaborated elsewhere in the JVMS.

;This language in the description of invokevirtual is the same as the description of the invokevirtual_quick instruction [ 9.2, p. 411 in JVMS], where the implementation -dependent description seems more appropriate.

;Dynamic Method Lookup

;    If the invocation mode is static, no target reference is needed and overriding is not allowed.

;    If the invocation mode is nonvirtual, overriding is not allowed. Method M of class T [the method and class determined at compile time] is the one to be invoked.

;    Otherwise the invocation mode is interface, virtual, or super, and overriding may occur. A dynamic method lookup is used.
;    [ 14.11.4.4, p. 335 in JLS]

;Static methods are inherited and hidden (in the manner of inherited and hidden fields).

;    The signature of a method consists of the name of the method and the number and types of formal parameters to the method. A class may not declare two methods with the same signature [even if one of the declarations is abstract.]
;    [ 8.4.2, p. 157 in JLS]

;    If a class declares an instance method, then the declaration of that method is said to override any and all methods with the same signature [i.e., name and formal-parameter types] in the superclasses and superinterfaces of the class that would otherwise be accessible to the code in the class. Moreover, if the method declared in the class is not abstract, then the declaration of that method is said to implement any and all declarations of abstract methods with the same signature in the superclasses and superinterfaces of the class that would otherwise be accessible to code in the class.
;    [ 8.4.6.1, p. 165 in JLS]

;Note that although compile-time method overriding ignores the return type of the method, run-time dynamic method lookup does not.

;    A compile-time error occurs if an instance method overrides a static method. In this respect, overriding of methods differs from hiding of fields, for it is permissible for an instance variable to hide a static variable.

;    An overridden method can be accessed by using a method invocation expression that contains the keyword super. Note that a qualified name of a cast to a superclass type is not effective in attempting to access an overridden [instance] method; in this respect, overriding methods differs from hiding of fields.
;    [ 8.4.6.1, p. 165 in JLS]

;    If a class declares a static method, then the declaration of that method is said to hide any and all methods with the same signature in the superclasses and superinterfaces of the class that would otherwise be accessible to code in the class. A compile-time error occurs if a static method hides an instance method. In this respect, hiding of [static] methods differs from hiding of fields, for it is permissible for a static variable to hide an instance variable.

;    A hidden [static] method can be accessed by using a qualified name or by using a method invocation expression that contains the keyword super or a cast to a superclass type. In this respect, hiding of [static] methods is similar to hiding of fields.
;    [ 8.4.6.2, p. 165-166 in JLS]

;Remark: If the method is a class instance method (i.e, is a static method), then must the invokestatic instruction name the class declaring the static method, even if the Java program referenced the method as an inherited class-method in a subclass? I expect so.

;Method Access Protection

;    Changing the declared access of a member or constructor to permit less access may break compatibility with pre-existing binaries, causing a linkage error to be thrown when these binaries are resolved.
;    [ 13.4.6, p. 248 in JLS]

;The JLS goes on to state that there is a strict ordering on the access modifiers regarding which provide ``less access'' than others. This strict ordering is:

;    private < default < protected < public

;Remark: The following two passages from JLS appear slightly contradictory.

;    Although it is a compile-time error for a subclass to override a method by one with more restricted access, this situation need not cause a linkage error at run time.
;    [ 13.4.6, p. 249 in JLS].

;    [As] part of the loading and linking process the virtual machine checks that an overriding method is at least as accessible as the overridden method; an IncompatibleClassChangeError occurs if this is not the case.
;    [ 15.11.4.4, p. 336 in JLS]

;    A method that overrides or hides another method, including methods that implement abstract methods defined in interfaces, may not be declared to throw more checked exceptions than the overridden or hidden method.
;    [ 8.4.4, p. 190 in JLS]

;    Note that a private method is never accessible to subclasses and so cannot be hidden or overridden in the technical sense of those two terms. This means that a subclass can declare a method with the same signature as a private method [declared] in one of its superclasses, and there is no requirement that the return type or throws clause of such a method bear any relationship to those of the private method in the superclass.
;    [ 8.4.6.3, p. 166 in JLS]

;Remark: See JLS 15.11.4.3 for clear rules about accessibility of classes and methods.

;I could not find any discussion of this situation in JVMS.

(defthmd tttt_1
  (implies (and (stringp target-class-name)
                (stringp method-name)
                (stringp method-sig)
                (class-table-p class-table)
                (bound?-equal target-class-name class-table)
                (java-method-bound? method-name
                                    method-sig
                              (class-decl-methods
                               (binding-equal target-class-name
                                              class-table)))
                )
           (protection-modifier-p
            (java-method-protection
             (java-method-binding
              method-name
              method-sig
              (class-decl-methods
               (binding-equal target-class-name class-table))))))
  :hints (("goal" :do-not-induct t
           :in-theory (disable protection-modifier-p JAVA-METHOD-LISTP-CLASS-DECL-METHODS)
           :cases ((not (java-method-listp
                         (class-decl-methods
                          (binding-equal target-class-name class-table))))))
 ;         ("subgoal 2" :in-theory (disable (:REWRITE DEFS-CLASS-DECL-ASSERTIONS . 6)))
          )
)

(defun djvm-method-accessible-p (target-class-name method-name
                                                   method-sig
                                                   current-class-name
                                                   class-table)
  (declare (xargs :guard (and (stringp target-class-name)
                              (stringp method-name)
                              (stringp method-sig)
                              (stringp current-class-name)
                              (class-table-p class-table)
                              (bound?-equal target-class-name class-table)
                              (bound?-equal current-class-name class-table)
                              (java-method-bound? method-name
                                                  method-sig
                                                  (class-decl-methods
                                                   (binding-equal target-class-name
                                                                  class-table))))
                  :guard-hints (("goal" :use tttt_1))))
  (let* ((target-class (binding-equal target-class-name class-table))
         (protection   (java-method-protection
                        (java-method-binding method-name
                                             method-sig
                                             (class-decl-methods target-class)))))
    (djvm-member-accessible-p protection
                              target-class
                              (binding-equal current-class-name class-table))))

(in-theory (disable DJVM-Method-Accessible-p))

;Accessing Superclass Methods

;    The super keyword can be used to access a method declared in a superclass, bypassing any methods declared in the current class. The expression:

;        super.Identifier

;    is resolved, at compile time, to be a method M declared in a particular superclass S [not necessarily the direct superclass]. The method M must still be declared in that class at run time or a linkage error will result. If the method M is an instance method, then the method MR invoked at run time is the method with the same signature as M that is a member of the direct superclass of the class containing the expression involving super.
;    [ 13.4.5, p. 247 in JLS]

;Note that the invoked method must be ``a member of the direct superclass,'' but need not be declared in the superclass.

;The Standard Form of Instructions

;Java's Shared-Memory Model

;Future Extensions: dJVM 0.5 does not include threads and synchronization. So it does not need to model shared-memory. However, we mention some of the issues related to shared-memory which may be dealt with in a future extension of the dJVM.


;The Java language includes threads and synchronization. In support of them the language includes the concepts of locks and monitors. It also includes an explicit model of memory access that addresses how each thread in a multithreaded program accesses a main memory shared by all threads.

;The language definition specifies that there is a main memory that is shared by all threads, and that each thread has its own working memory. The main memory contains the ``master copy'' of every variable. It also contains a lock associated with each object in main memory. Each thread operates on values from its working memory, copying values between its working memory and main memory as necessary. Chapter 17 of the Java Language Specification addresses when such copying is necessary, as well as which memory operations are atomic, and ordering requirements between program actions (e.g., the level of reordering of actions within a single thread and the interleaving of actions between multiple threads).

;Standard Parts of Instruction Definitions

;Since we are defining the defensive Java Virtual Machine, each instruction must perform various tests to assure that its arguments and results are well-formed and type-correct. For each instruction we define a function that implements that instruction. That function performs all the required tests and (if the tests succeed) updates the state of the dJVM to reflect execution of the instruction. Since each instruction-implementation function requires these tests and halts with similar errors if any test fails, the body of each follows the same form.

;Each instruction implementation consists of six steps:
;
;    Check that the instruction is syntactically well-formed.
;
;    (We could include checks that static local variable indices are less than the number of local varibles specified in the method declaration. But that would require the additional context of the method declaration, which we will skip here. This index range-checking is done in step [arg-value-check] below.)
;
;    Check that the arguments are of the proper number and type.
;
;    For objects, this merely checks that the operand is a reference type. It does not check the actual class of the operand.
;
;    Resolve any referenced classes, fields, or methods if necessary.
;
;    (This step would perform dynamic class-loading if it were supported.)
;
;    Check that the argument values are permissible.
;
;    This tests any required semantic preconditions for the instruction. For example, the idiv instruction must check that the divisor is non-zero, and the getfield instruction that the object reference is not null.
;
;    Execute the instruction and update the pc register.
;
;    Check that any result values are permissible.

;    For example, method invocations and field accesses should leave a value of the required type on the operand stack. This test is degenerate for instructions that always yield a fixed-type result, but is required for ``generic'' instructions (e.g., getfield, new, etc.)

;    These tests should always be redundant in a type-safe program. Since the dJVM is intended to detect type errors, these checks are made explicitly. However, these tests should be provably true if the loaded JVM methods are all type-safe.

;    Check that the operand stack hasn't overflowed.

;    Check that the updated pc register is valid if the current method is a bytecoded method.The JVM does not define the value of the pc register when the current method is a native method. So it only makes sense to ask whether the pc is valid when executing a bytecoded method.

;    The dJVM 0.5 does not currently support execution of native methods. However, to permit future support for native methods the dJVM 0.5 defines a representation of native methods in stack frames. Thus, for example, after execution of a return instruction the current method may be either a bytecoded method or a native method. Of course, if it's a native method then the dJVM 0.5 will subsequently halt, since it cannot currently execute native methods --- but the return instruction will have completed normally.

;    Check that if the call stack is empty, then the dJVM status is :halted.

;    Strictly speaking this is not a requirement of the JVM definition. In the dJVM the return is defined to set the machine status to :halted if it is exiting from the only frame on the call stack. No other instruction that completes normally should result in an empty call stack. The other return instructions (ireturn, areturn, etc.) return a result value to a calling frame, and so they should never be executed unless there are at least two frames on the call stack. An unhandled error or exception could also halt the computation, but the dJVM does not yet handle exceptions.

;Remark: Where do exceptions fit in??? Any instruction can throw an exception.

;Remark: The JVMS claims to document and order all exceptions that can arise as a result of constant pool resolution. So we must be careful that we honor that order!

;    A Java Virtual Machine throws an object that is an instance of a subclass of the class VirtualMachineError when an internal error or resource limitation prevents it from implementing the semantics of the Java Language. [Emphasis added.] The Java Virtual Machine specification cannot predicate where resource limitations or internal errors may be encountered and does not mandate precisely when they can be reported. Thus, any of the virtual machine errors listed as subclasses of VirtualMachineError may be thrown at any time during the operation of the Java Virtual Machine.
;    [JVMS 6.3, p. 152]

;Remark: To some extent the JVMS description seems to intermingle the idea that the JVM is tied to Java semantics and that the JVM is a separately specified machine. The quote above is just one example.

;For each instruction we define a separate function to accomplish each of these steps. By convention each of these functions takes a standard argument list as follows:

;    (getfield-wff-inst? inst)
;
;    (getfield-proper-arg-types? inst frame)
;    This predicate takes the instruction and the current frame. It can check the type of values in local variable and on the operand stack, but it cannot examine objects in the heap.

;    (getfield-resolve-args inst djvm)

;    (getfield-proper-arg-values? inst resolved-djvm)
;    This predicate takes the instruction and the full dJVM state (after any class resolution, which in an extended dJVM might trigger dynamic class loading). Thus this predicate can examine heap objects and check their class.

;    (djvm-execute-getfield-inst inst (djvm-increment-pc ins-len resolved-djvm))

;    (getfield-proper-value? inst new-djvm)) Remark: Should the xxx-value? functions be renamed as xxx-result?

;In order to make these declarations more compact and to assure uniformity, we use a macro to construct the actual function definition. Below is an example of the general form, using the getfield instruction. Note that the operand stack is always checked for overflow. Since this is always done, the test need not be provided as an argument to define-defensive-instruction.

;Remark: We don't check that the stack hasn't overflowed in the initial state of the instruction. We only check that we don't leave the stack in an overflowed state.

;IS THIS GOOD ENOUGH?

;Here's the call to define-defensive-instruction that defines the getfield instruction:


; (define-defensive-instruction djvm-do-getfield
;   getfield-wff-inst?
;   getfield-proper-arg-types?
;   getfield-resolve-args
;   getfield-proper-arg-values?
;   djvm-execute-getfield-inst
;   getfield-proper-value?)

;And here's the expanded form of the description above:


; (defun djvm-do-getfield (inst djvm)
;   (declare (xargs :guard (and (instruction-p inst)
;                               (djvm-p djvm)
;                               (non-empty (djvm-stack djvm))
;                               (java-bytecode-method-p
;                                (frame-method (car (djvm-stack djvm)))))))
;    (let* ((frame (stack-top (djvm-stack djvm))))
;     (if (getfield-wff-inst? inst)
;      (if (getfield-proper-arg-types? inst frame)
;       (let ((djvm-resolved (getfield-resolve-args inst djvm)))
;        (if (getfield-proper-arg-values? inst djvm-resolved)
;         (let ((new-djvm (djvm-execute-getfield-inst
;                          inst
;                          (djvm-increment-pc nil djvm-resolved))))
;           (if (non-empty (djvm-stack new-djvm))
;               (if (getfield-proper-value? inst new-djvm)
;                   (if (operand-stack-size-ok? new-djvm)
;                       (if (valid-pc? (djvm-pc new-djvm)
;                                      (frame-method (current-frame new-djvm)))
;                           new-djvm
;                           (djvm-error "PC about to become invalid."
;                                       inst djvm))
;                       (djvm-error "Operand stack about to overflow"
;                                   inst djvm))
;                   (djvm-error "Improper result-value" inst new-djvm))
;             ;; If the call-stack is empty, the machine should be halted!
;               (if (equal (djvm-STATUS new-djvm) ':HALTED)
;                   new-djvm
;                   (djvm-error "Execution about to halt unexpectedly."
;                               inst djvm))))
;         (djvm-error "Improper argument values" inst djvm)))
;       (djvm-error "Improper argument types" inst djvm))
;      (djvm-error "Ill-formed instruction" inst djvm))))

;The functions operand-stack-size-ok? and valid-pc? are used in the standard form of instruction definitions, as these tests are always performed on the defensive JVM. Since the operand stack is represented as a list, it cannot underflow, but it can overflow (i.e., exceed the maximum size specified by the current method). The value of the PC is invalid if it does not correspond to an instruction address in the current method. Recall that a bytecoded method body is represented as an alist mapping instruction addresses to (symbolic) instructions.

(defun operand-stack-size-ok? (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (let ((frame (stack-top (djvm-stack djvm))))
    (<= (length (frame-stack frame))
        (java-method-max-stack (frame-method frame)))))

(defun valid-pc? (pc method)
  (declare (xargs :guard (java-bytecode-method-p method)))
  (bound?-equal pc (java-method-body method)))

(observe io-104
  (implies (instance-p object)
           (instance-data-p (instance-data object))))

(observe io-105
 (implies (and (instance-p object)
               (bound?-equal name (instance-data object)))
          (var-binding-p (binding name (instance-data object)))))

(observe io-106
         (implies (instance-data-p instance-data)
                  (alistp (binding name instance-data)))
         :hints (("Goal" :in-theory  (enable instance-data-p binding))))

(defun djvm-valid-pc? (pc djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (consp (djvm-stack djvm)))))
  (let ((current-method (frame-method (stack-top (djvm-stack djvm)))))
    (and (naturalp pc)
         (java-bytecode-method-p current-method)
         (valid-pc? pc current-method))))

(defmacro  define-defensive-instruction (instruction-fn-name
                                   wff-inst-p
                                   proper-arg-types-p
                                   resolve-args-fn
                                   proper-arg-values-p
                                   execute-inst-fn
                                   proper-result-value-p
                                   \&key
                                   instruction-length
                                   guard-hints)


  `(encapsulate ()
   (defun ,instruction-fn-name (inst djvm)
     (declare (xargs :guard (and (instruction-p inst)
                                 (djvm-p djvm)
                                 (non-empty (djvm-stack djvm))
                                 (java-bytecode-method-p
                                  (frame-method (car (djvm-stack djvm)))))
                     ;; Suppress induction in the guard proof
                     ;; so the proof will fail more quickly.
                     :guard-hints ,(or guard-hints
                                       '(("Goal" :do-not-induct t)))
                     ))
     (let* ((frame (stack-top (djvm-stack djvm))))
     (if (,wff-inst-p inst)
         (if (,proper-arg-types-p inst frame)
             (let ((djvm-resolved (,resolve-args-fn inst djvm)))
               (if (,proper-arg-values-p inst djvm-resolved)
                   (let ((new-djvm (,execute-inst-fn inst
                                                     (djvm-increment-pc
                                                      ,instruction-length
                                                      djvm-resolved))))
                     (if (non-empty (djvm-stack new-djvm))
                         (if (,proper-result-value-p inst new-djvm)
                             (if (operand-stack-size-ok? new-djvm)
                                 (if (or (not (java-bytecode-method-p
                                               (current-method new-djvm)))
                                         (valid-pc? (djvm-pc new-djvm)
                                                    (current-method new-djvm)))
                                     new-djvm
                                   (djvm-error "PC about to become invalid." inst djvm))
                               (djvm-error "Operand stack about to overflow" inst djvm))
                           (djvm-error "Improper result-value" inst new-djvm))
                       (if (equal (djvm-status new-djvm) ':halted)
                           new-djvm
                         (djvm-error "Execution about to halt unexpectedly."
                                     inst djvm))))
                 (djvm-error "Improper argument values" inst djvm)))
           (djvm-error "Improper argument types" inst djvm))
       (djvm-error "Ill-formed instruction" inst djvm))))))

;Facts about dJVM Manipulations

;This section contains some facts about the internal primitives used to manipulate the dJVM state. These facts will be used in the proofs about the dJVM instructions.

(observe io-3011
         (implies (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (non-empty (djvm-operand-stack djvm))
                       (sv-p x)
                       (naturalp i)
                       (< i (frame-max-locals (car (djvm-stack djvm)))))
                  (and (djvm-p (djvm-pop-operand djvm))
                       (djvm-p (djvm-increment-pc i djvm))
                       (djvm-p (djvm-store-local i x djvm))
                       (djvm-p (djvm-push-operand x djvm))))
         :hints (("Goal" :in-theory (enable  sv-p))))

(observe io-3012
         (implies (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (non-empty (djvm-operand-stack djvm))
                       (sv-p x)
                       (naturalp i)
                       (< i (frame-max-locals (car (djvm-stack djvm)))))
                  (and (weak-djvm-p (djvm-pop-operand djvm))
                       (weak-djvm-p (djvm-increment-pc i djvm))
                       (weak-djvm-p (djvm-store-local i x djvm))
                       (weak-djvm-p (djvm-push-operand x djvm))))
         :hints (("Goal" :in-theory (enable  sv-p))))

; Here are some facts that will be useful rewrite rules.

(defthm naturalp-frame-max-locals-1
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (naturalp (FRAME-MAX-LOCALS (CAR (DJVM-STACK DJVM)))))
  :rule-classes (:rewrite :type-prescription))

(defthm naturalp-frame-pc-type-prescription
  (implies (frame-p frame)
           (naturalp (FRAME-PC frame)))
  :rule-classes (:type-prescription :rewrite))

(in-theory (disable frame-max-locals))

; All frames in the call stack are associated with an active invocation of a bytecoded method. Invocation of native methods (when added to the dJVM model) will not add frames to the call stack. Here are some lemmas showing that the basic frame manipulations do not destroy this property.

(defmacro  frame-bytecoded-method-p (frame)
  `(java-bytecode-method-p (frame-method ,frame)))

(in-theory (disable java-bytecode-method-p))

(defthm java-bytecode-method-p-preserved
  (implies (and (weak-frame-p frame)
                (frame-bytecoded-method-p frame))
           (and (frame-bytecoded-method-p (frame-push-operand x frame))
                (frame-bytecoded-method-p (frame-pop-operand frame))
                (frame-bytecoded-method-p (frame-pop-operand frame))
                (frame-bytecoded-method-p (frame-set-pc new-pc frame))
                (frame-bytecoded-method-p (frame-store-local index
                                                             value
                                                             frame))
                (frame-bytecoded-method-p (frame-store-local indices
                                                             values
                                                             frame))))
  :hints (("Goal" :in-theory (enable frame-push-operand
                                     frame-pop-operand
                                     frame-set-pc
                                     frame-store-local
                                     frame-store-locals))))

; Remark: It is not clear whether these rewrite rules are useful. For example, they would only be useful if the function current-frame is disabled, and it is generally left enabled.

(defthm djvm-pop-operand-preserves-frame-method
  (implies (weak-djvm-p djvm)
           (equal (frame-method (current-frame (djvm-pop-operand djvm)))
                  (frame-method (current-frame djvm))))
  :hints (("Goal" :in-theory (enable djvm-pop-operand))))

(defthm djvm-push-operand-preserves-frame-method
 (implies (weak-djvm-p djvm)
          (equal (frame-method (current-frame (djvm-push-operand x djvm)))
                 (frame-method (current-frame djvm))))
 :hints (("Goal" :in-theory (enable djvm-push-operand))))

(defthm frame-set-pc-preserves-frame-method
  (implies (weak-frame-p frame)
           (equal (frame-method (frame-set-pc new-pc frame))
                  (frame-method frame)))
  :hints (("Goal" :in-theory (enable frame-set-pc))))

(defthm djvm-set-pc-preserves-frame-method
  (implies (weak-djvm-p djvm)
           (equal (frame-method (current-frame (djvm-set-pc new-pc djvm)))
                  (frame-method (current-frame djvm))))
  :hints (("Goal" :in-theory (enable djvm-set-pc))))

(defthm djvm-error-preserves-frame-method
  (implies (weak-djvm-p djvm)
           (equal (frame-method (current-frame (djvm-error error inst djvm)))
                  (frame-method (current-frame djvm))))
  :hints (("Goal" :in-theory (enable djvm-error))))

