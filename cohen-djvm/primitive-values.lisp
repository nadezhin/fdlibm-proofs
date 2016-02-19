; http://www.computationallogic.com/software/djvm/html-0.5/primitive-values.html

(in-package "ACL2")
(include-book "preliminaries")
(include-book "arith")

; Primitive Values

; The dJVM manipulates data values. Within the dJVM state each data value has an associated type. A type defines the set of values that a variable may hold, that an input value or output value must be within.

; The Java language defines seven primitive numeric types and allows declaration of reference types, whose values refer to class instances or null.The value null is defined in Java to be a distinct type, rather than a value shared by each reference type. At the level of the JVM the value null is a value that is shared by all reference types.

; We use the term primitive values to include both numeric values (i.e., values of the primitive numeric types) and reference values.

; Primitive Types

;[1] The Java language has seven primitive types. They are defined in terms of the numeric values that variables of these types are permitted to hold.

;    byte values are in the range [-2-7 .. 27-1]
;    short values are in the range [-2-15 .. 215-1]
;    int values are in the range [-2-31 .. 231-1]
;    long values are in the range [-2-63 .. 263-1]
;    char values are in the range [ 0 .. 216-1]
;    float (not used in the dJVM)
;    double (not used in the dJVM)

;The JVM has direct support for four of these primitive types (int, long, float, and double), as well the reference type. The JVM does not directly support either byte, char, or short integer types. The ``narrower'' integer types (byte, short, and char) are not directly supported, but are represented as int values during processing.The JVM provides support for storing byte, short, and char values in arrays. The dJVM 0.5 model does not support arrays. The JVM operand stack and local variables are defined to hold 32-bit values. So 64-bit long values that are stored on the operand stack or in local variables must be represented as two 32-bit entries.

;The dJVM does not support floating point variables (i.e., types float or double).

;Java also admits the reference type, which permits references to class instances.

;Tagged Values

;Within the dJVM operand values are stored as tagged values. Each of the primitive data values appearing in the dJVM state is actually a pair, consisting of a type tag and a primitive value of the appropriate type. Each primitive value is tagged with its type (int, long, or ref).

;The JVM specifies that certain internal data is stored as abstract words. Each abstract word can at least hold values corresponding to 32-bit two's-complement integers (i.e., corresponding to the int primitive type). The operand stack and local variables, which will be components of call frames (section [sec:call-frames], page [sec:call-frames]) are defined to hold abstract words. Because a long value will not fit into a single abstract word, long values must be stored as two entries on the operand stack or as two local variables.

;Future Extensions: This will affect atomicity of dJVM operations when the dJVM is extended to model concurrency, because access to multiple words may require multiple memory references, and so can be interleaved with other operations. Be warned!

;The predicate tv-p tests whether its argument is a tagged value --- that is, a pair whose first element is a type tag (e.g., such as :int), which satisfies the predicate jvm-type?, and whose second element is any atomic value (e.g., an integer) appropriate to the type tag.

;We use the macro def-tv to define recognizers for several sorts of tagged-value terms. Each tagged value is a type tag and a value satisfying an appropriate predicate. The accessors tv-tag and tv-val extract the tag and value (respectively) from a tagged-value.

;The form


; (def-tv tv-ref-p (:ref unsigned-int-p))

;defines the recognizer tv-ref-p. Subsequently the term (tv-ref-p alpha) has the meaning


; (and (weak-tv-p alpha)
;      (equal (tv-tag alpha) :ref)
;      (unsigned-int-p (tv-val alpha)))

;The test (weak-tv-p alpha) checks that we can safely apply tv-tag and tv-val to access the components of alpha.

(defmacro  def-tv (name car-and-cadr-p)
  (declare (xargs :guard (and (consp car-and-cadr-p)
                              (symbolp (car car-and-cadr-p))
                              (symbolp (cadr car-and-cadr-p)))))
  (let ((car-p (car car-and-cadr-p))
        (cadr-p (cadr car-and-cadr-p)))
    `(defmacro ,name (x)
       (list 'and
             (list 'weak-tv-p x)
             ,(if (keywordp car-p)
                  `(list 'equal (list 'tv-tag x) ,car-p)
                `(list ',car-p (list 'tv-tag x)))
             ,(if (keywordp cadr-p)
                  `(list 'equal (list 'tv-val x) ,cadr-p)
                `(list ',cadr-p (list 'tv-val x)))))))

;Note on JVM Semantics: Reference values are addresses of heap objects. Since they can reside in the operand stack, and values in the operand stack must be representable in abstract words, heap addresses are implicitly limited to 32-bits.

;Below are recognizers for the dJVM tagged values. The tags :long -top -half and :long -bot -half identify the two parts of a long value when it is represented as a pair of abstract words. The tag :long is used when the long integer value is represented as a single tagged value.Obviously such a tagged long integer value cannot reside on the operand stack, or in a local variable. But it will be able to reside in an instance field, as we will see in section [sec:sv-and-fv], page [sec:sv-and-fv].

(def-tv  tv-int-p (:int int-value-p))

(def-tv  tv-long-p (:long long-value-p))

(def-tv  tv-ref-p (:ref unsigned-int-value-p))

(def-tv  tv-long-top-half-p (:long-top-half unsigned-int-value-p))

(def-tv  tv-long-bot-half-p (:long-bot-half unsigned-int-value-p))

; Appendix [ch:arithmetic] of this document defines bounded integer arithmetic for int and long integer values. The predicate int-value-p recognizes integer values in the range permitted by the type int. Similarly the predicate long-value-p recognizes integer values permitted by the type long. The predicate unsigned-int-value-p recognizes integer values in the range [\,0\;..\;2^{32}-1\,]. The JVM instructions do not support unsigned arithmetic operations, but unsigned 32-bit integers are used in the dJVM to represent parts of long values values and heap addresses.

(defun value-of-type? (type-tag value)
  (case type-tag
    (:int    (int-value-p    value))
    (:long   (long-value-p   value))
    (:ref    (unsigned-int-value-p    value))
    ((:Long-Top-Half
      :Long-Bot-Half
      )      (unsigned-int-value-p    value))
    (otherwise nil)
    ))


;The function make-tv constructs a tagged-value pair from a type tag and a value. It does not check that the value is appropriate for the given type tag. In the contexts in which we use make-tv, we know that the value is in fact appropriate, and ACL2'S guard verification will generally enforce this requirement.Tagged values will ultimately be stored on the operand stack, in local variables, or in an instance field. All of these are required to be properly-tagged values, and guard verification will enforce this requirement.

;As mentioned above, the predicate weak-tv-p tests whether its argument has the form of a tagged value, suitable for accessing via tv-tag and tv-val. Concretely, it checks that its argument is a proper list of two elements.

(defun make-tv (tag val)
  (declare (xargs :guard t))
  (list tag val))

(defun weak-tv-p (x)
  (declare (xargs :guard t))
  (and (consp x)
       (consp (cdr x))
       (not (consp (cddr x)))))

(defun tv-tag (x)
  (declare (xargs :guard (weak-tv-p x)))
  (first x))

(defun tv-val (x)
  (declare (xargs :guard (weak-tv-p x)))
  (second x))

(defthm weak-tv-p-make-tv
  (weak-tv-p (make-tv tag val)))

(defthm make-tv-pieces
  (and (equal (tv-tag (make-tv x y)) x)
       (equal (tv-val (make-tv x y)) y))
  :hints (("Goal" :in-theory (enable make-tv tv-tag tv-val))))

; Stack Values and Field Values

; We distinguish between values that are permitted on the operand stack (or in local variables) and values that may appear in instance and class fields. The distinction concerns the handling of long integer values. The operand stack always manipulates 32-bit data.Of course in the dJVM the 32-bit data values are always tagged. So when a 64-bit integer (long) value must be pushed onto the stack, it is divided in half, and the two halves are pushed onto the stack individually. However, we do not make the same restriction on long values stored in an object field. A field declared to hold a long value can hold the entire 64-bit integer value.

; The Java Virtual Machine Specification describes stack values as:

;    No mention has been made of the storage requirements for values of various Java Virtual Machine types, only ranges those values may take. The Java Virtual Machine defines an abstract notion of a word that has a platform-specific size. A word is large enough to hold a value of type byte, char, short, int, float, reference, returnAddress, or to hold a native pointer. Two words are large enough to hold values of the larger types, long and double. Java's run-time data areas are all defined in terms of these abstract words.
;    [ 3.4, p. 61 in JVMS]

;Our discussion in this section is slightly more concrete than that, in that we specify that stack values must be representable with words of only 32 bits. This addition is intended to make the dJVM model more closely resemble current-day JVM implementations. Further, during execution of the dJVM model, we divide long values precisely into two 32-bit halves when storing the long value on the operand stack or into local variables. Again this is intended to make execution states more closely resemble common implementations.

;Remark: We should first define the specifications and functions axiomatically, and then provide executable versions. This will clarify the formal requirements from the executable implementation of the dJVM.

;We refer to values that are permitted on the operand stack as stack values, and we refer to values that are permitted in object fields as field values. Observe that these two sets are not disjoint. Tagged values of type :ref and :int are both legal stack values and field values.

;When data moves between object fields and the operand stack, long values will have to be converted between their 64-bit integer representation and the corresponding two 32-bit ``half-long'' values. We will see this conversion as part of the getfield, putfield, getstatic, and putstatic instructions

;    Implementors are free to decide the appropriate way to divide a 64-bit data value between two local variables.
;    [ 3.6.1, p. 67 in JVMS]

;    Implementors are free to decide the appropriate way to divide a 64-bit data value between two operand stack words.
;    [ 3.6.2, p. 67 in JVMS]

;Remark: Since these descriptions appear in two separate sections, presumably the implementor is free to choose differently for the stack and for local variables. This would significantly complicate the instructions for dealing with loading and storing double-word values, and this possibility is not addressed in those instructions.

;Remark: Does the JLS or JVMS say anything about how values are stored in object fields?

;I think the implementor is free to do what he likes in the object representation.

;However they do state that accessing long and double fields is not an atomic operation. Since long and double are stored as two words in the stack, we know that such accesses will at least make two references to the local frame, and this may be enough to imply that such accesses may not be atomic --- regardless of how the long or double field values are actually stored.

;They explicitly state that byte, short, and char values are stored as "word" values on the stack and in local variables (except for arrays). They define a notion of an abstract word of unspecified size, but capable of representing all int values. The JVM always reserves two words for long and double values, even though on some implementations (e.g., platforms with 64-bit words) a single word might be capable of representing long and double values.

;The JVM specification does not state how long values should be represented in fields within an instance. We have chosen to represent long values as single entries in an instance. Thus, an instance field may contain a value of any type except the long-top-half and long-bot-half types, which are only permitted on the operand stack and in local variables. Collectively we refer to the values permitted in instance fields as field values. The predicate fv-p recognizes legal field values.

(defun fv-p (x)
  (declare (xargs :guard t))
  (or (tv-int-p  x)
      (tv-long-p x)
      (tv-ref-p  x)))

;Local variables and the operand stack may hold values of any type, except long. Long values must be represented using two smaller values, one of type long-top-half and one of type long-bot-half. Collectively we refer to these values as legal stack values. The predicate sv-p recognizes legal stack values.

(defun sv-p (x)
  (declare (xargs :guard t))
  (or (tv-int-p x)
      (tv-ref-p x)
      (tv-long-top-half-p x)
      (tv-long-bot-half-p x)))

(defthm sv-p-is-weak-tv-p-forward
  (implies (sv-p x)
           (weak-tv-p x))
  :hints (("Goal" :in-theory (enable sv-p)))
  :rule-classes (:forward-chaining))

(defthm sv-p-if-fv-p-and-not-long
  (implies (and (fv-p x)
                (not (tv-long-p x)))
           (sv-p x))
  :hints (("Goal" :in-theory (enable fv-p sv-p))))

(defthm sv-p-recomposed-sv
  (and (implies (sv-p x)
                (sv-p (make-tv (tv-tag x) (tv-val x))))
       (implies (and (sv-p tv)
                     (equal tag (tv-tag tv))
                     (equal val (tv-val tv)))
                (sv-p (make-tv tag val)))))

(defthm sv-p-make-tv-int
  (implies (int-value-p val)
           (sv-p (make-tv :int val))))

(defthm sv-p-remake-tv-ref-p
  (implies (tv-ref-p x)
           (SV-P (MAKE-TV :REF (tv-val x)))))

(defthm sv-p-make-tv-unsigned-int-case
  (implies (and (unsigned-int-value-p val)
                (member tag '(:ref :long-top-half :long-bot-half)))
           (sv-p (make-tv tag val))))

;#+NOT-NEEDED
(defthm sv-p-make-tv-ref
  (implies (unsigned-int-value-p x)
           (SV-P (MAKE-TV :REF x)))
  :hints (("Goal" :in-theory (enable sv-p))))

(defthm sv-p-make-tv-long-xxx-half
  (implies (integerp x)
           (and (sv-p (make-tv :long-bot-half (long-bot-half x)))
                (sv-p (make-tv :long-top-half (long-top-half x)))))
  :hints (("Goal" :in-theory (enable tv-tag
                                     tv-val
                                     sv-p
                                     ))))

; Define predicates that recognize lists of stack values (sv-listp) and lists of field values (fv-listp).

(deflist sv-listp (l)
  sv-p)

(defthm sv-listp-is-true-listp-forward
  (implies (sv-listp x)
           (true-listp x))
  :rule-classes (:forward-chaining))

(in-theory (disable sv-listp-true-listp))

(deflist fv-listp (l)
  fv-p)

(defthm fv-listp-is-true-listp-forward
  (implies (fv-listp x)
           (true-listp x))
  :rule-classes (:forward-chaining))

(in-theory (disable fv-listp-true-listp))

(defthm sv-p-defn
  (implies (or (tv-ref-p x)
               (tv-int-p x)
               (tv-long-top-half-p x)
               (tv-long-bot-half-p x))
           (sv-p x)))

(defthm fv-p-defn
  (implies (or (tv-ref-p x)
               (tv-int-p x)
               (tv-long-p x))
           (fv-p x)))

; The function tv-ref-listp recognizes a list of (tagged) object references.

(deflist tv-ref-listp (l)
              tv-ref-p)

;Below are type prescription lemmas giving type information for applications of tv-val to tagged values. Obviously the type yielded by tv-val depends on the type-tag of the tagged value.

;First we observe that all of the standard tagged-values have integers as their tv-val component. Then we give the type information as type-prescription lemmas and provide tighter integer-bounds in rewrite rules.

(defthm tv-val-type-prescription
  (implies (or (sv-p x)
               (fv-p x))
           (integerp (tv-val x)))
  :rule-classes (:rewrite :type-prescription))

(defthm naturalp-tv-val-type-prescription
  (implies (or (tv-ref-p x)
               (tv-long-top-half-p x)
               (tv-long-bot-half-p x))
           (naturalp (tv-val x))))

(defthm int-value-p-tv-int-p
  (implies (tv-int-p x)
           (int-value-p (tv-val x))))

(defthm long-value-p-tv-long-p
  (implies (tv-long-p x)
           (long-value-p (tv-val x))))

(defthm unsigned-int-value-p-tv-ref-p
  (implies (tv-ref-p x)
           (unsigned-int-value-p (tv-val x))))

(defthm unsigned-int-value-p-tv-long-top-half-p
  (implies (tv-long-top-half-p x)
           (unsigned-int-value-p (tv-val x))))

(defthm unsigned-int-value-p-tv-long-bot-half-p
  (implies (tv-long-bot-half-p x)
           (unsigned-int-value-p (tv-val x))))

(defun tv-one-word-p (x)
  (declare (xargs :guard t))
  (or (tv-int-p x)
      (tv-ref-p x)))

(defun tv-two-word-p (x)
  (declare (xargs :guard t))
  (or (tv-long-top-half-p x)
      (tv-long-bot-half-p x)))

(in-theory (disable make-tv tv-tag tv-val))

; The Null object

; Remark: We should also define functions that give the default value for each primitive type -- including (ref-to-null) for reference types.

; Note: there is no default initial value for :addr values. We only need default values for declared fields, and fields cannot be declared of type address.

(defn addr-of-null ()
  0)

(defn ref-to-null ()
  (make-tv :ref (addr-of-null)))

(defn ref-to-null-p (x)
  (equal x (ref-to-null)))

;64-bit wide types

;Wide-type-tags lists the type tags associated with 64-bit data values. Wide values can only be stored on the stack or in local variables if they are split into two parts that will fit within the 32-bit size of individual stack entries and local variables. For each type tag denoting a wide (64-bit) value, we define two associated type tags that denote two 32-bit values to be associated with the 64-bit value. We call these two 32-bit values the ``top half'' and the ``bottom half'' of the wide value.

;We define functions for manipulating 64-bit wide values, for splitting them into two separate 32-bit values (their top and bottom ``halves'') and for combining the two halves back into the single wide-value.

;Future Extensions: The dJVM 0.5 model only supports 64-bit wide integers (i.e., the long data type). A future extension could support additional 64-bit types (e.g., double.) We would then define a general notion of wide values, that would include all 64-bit field values.

(defun tv-top-half-p (x)
  (declare (xargs :guard t))
  (tv-long-top-half-p x))

(defun tv-bot-half-p (x)
  (declare (xargs :guard t))
  (tv-long-bot-half-p x))

(defn tv-wide-p (x)
  (tv-long-p x))

(defun parts-of-same-wide-type (top-half bot-half)
  (declare (xargs :guard (and (sv-p top-half)
                              (sv-p bot-half))))
  (case (tv-tag top-half)
    (:long-top-half (equal (tv-tag bot-half) ':long-bot-half))
    ))

(defun tv-long-top-half (x)
  (declare (xargs :guard (tv-long-p x)))
  (make-tv ':long-top-half (long-top-half (tv-val x))))

(defun tv-long-bot-half (x)
  (declare (xargs :guard (tv-long-p x)))
  (make-tv ':long-bot-half (long-bot-half (tv-val x))))

(defthm sv-p-tv-long-top-half
  (sv-p (tv-long-top-half x))
  :hints (("Goal" :in-theory (enable  sv-p
                                      tv-long-top-half
                                      value-of-type?))))

(defthm sv-p-tv-long-bot-half
  (sv-p (tv-long-bot-half x))
  :hints (("Goal" :in-theory (enable  sv-p
                                      tv-long-bot-half
                                      value-of-type?))))

(defun tv-wide-top-half (x)
  (declare (xargs :guard (and (fv-p x)
                              (tv-wide-p x))))
  (case (tv-tag x)
    (:long (tv-long-top-half x))))

(defun tv-wide-bot-half (x)
  (declare (xargs :guard (and (fv-p x)
                              (tv-wide-p x))))
  (case (tv-tag x)
    (:long (tv-long-bot-half x))))

(defthm tv-wide-half-type-prescription
  (implies (tv-wide-p x)
           (and (sv-p (tv-wide-top-half x))
                (sv-p (tv-wide-bot-half x)))))

(defun make-tv-wide-value (top-half bot-half)
  (declare (xargs :guard (and (tv-top-half-p top-half)
                              (tv-bot-half-p bot-half)
                              (parts-of-same-wide-type top-half bot-half))))
  (case (tv-tag top-half)
    (:long-top-half (make-tv ':long
                             (make-long (tv-val top-half) (tv-val bot-half))))
    ))

(defthm make-tv-wide-value-type-prescription
  (implies (and (tv-top-half-p x)
                (tv-bot-half-p y)
                (parts-of-same-wide-type x y))
           (tv-wide-p (make-tv-wide-value x y))))

;Below are a few general recognizers for properly-typed tagged-values, for lists of tagged-values, and for lists of reference values.

(defun tv-wide-value-p (x)
  (tv-long-p x))

(defthm tv-long-half-facts
 (implies (tv-long-p x)
          (and (tv-long-top-half-p           (tv-long-top-half x))
               (tv-top-half-p                (tv-long-top-half x))
               (sv-p                (tv-long-top-half x))
               (equal               (tv-tag (tv-long-top-half x)) ':long-top-half)
               (sv-p                         (tv-long-top-half x))
               (unsigned-int-value-p (tv-val (tv-long-top-half x)))
               (tv-long-bot-half-p           (tv-long-bot-half x))
               (tv-bot-half-p                (tv-long-bot-half x))
               (sv-p                (tv-long-bot-half x))
               (equal                (tv-tag (tv-long-bot-half x)) ':long-bot-half)
               (sv-p                         (tv-long-bot-half x))
               (unsigned-int-value-p (tv-val (tv-long-bot-half x)))))
 :hints (("Goal" :in-theory (enable make-tv
                                    sv-p
                                    tv-tag
                                    tv-val
                                    ))))

(in-theory (disable tv-long-top-half tv-long-bot-half))

(defthm weak-tv-p-tv-long-top-half
  (weak-tv-p (tv-long-top-half x))
  :hints (("Goal" :in-theory (enable tv-long-top-half))))

(defthm weak-tv-p-tv-long-bot-half
  (weak-tv-p (tv-long-bot-half x))
  :hints (("Goal" :in-theory (enable tv-long-bot-half))))

(defthm wide-half-facts
  (implies (and (sv-p x)
                (tv-wide-value-p x))
           (and (sv-p (tv-wide-top-half x))
                (sv-p (tv-wide-bot-half x)))))

(defn jvm-type-tags ()
 '(:int :long :long-top-half :long-bot-half :ref))

(defn jvm-type-tag? (x)
 (memberp x (jvm-type-tags)))

(defthm jvm-type-tag-if-tv-p
  (implies (or (sv-p x)
               (fv-p x))
           (jvm-type-tag? (tv-tag x))))

(deflist weak-tv-listp (l)
  weak-tv-p)

(defthm weak-tv-listp-is-true-listp-forward
  (implies (weak-tv-listp x)
           (true-listp x))
  :rule-classes (:forward-chaining))

(in-theory (disable weak-tv-listp-true-listp))

(defthm naturalp-listp-is-true-listp-forward
  (implies (naturalp-listp x)
           (true-listp x))
  :hints (("Goal" :in-theory (enable naturalp-listp)))
  :rule-classes :forward-chaining)

;We often have to reason about values satisfying tv-p and weak-tv-p. To avoid additional clutter in our proofs, we disable those definitions. So, we must define rules for how those concepts should relate in proofs. Any value that satisfies tv-p must also satisfy weak-tv-p. So we define a forward-chaining rule that says ``whenever a value is known to satisfy tv-p, assert that it also satisfies weak-tv-p.'' We state a similar rule relating weak-tv-listp to tv-listp.

(defthm weak-tv-p-if-sv-p-forward
  (implies (sv-p x)
           (weak-tv-p x))
  :rule-classes (:forward-chaining))

(defthm weak-tv-p-if-fv-p-forward
  (implies (fv-p x)
           (weak-tv-p x))
  :rule-classes (:forward-chaining))

(deflist weak-tv-listp (l)
  weak-tv-p)

(defthm weak-tv-listp-if-sv-list-p-forward
  (implies (sv-listp x)
           (weak-tv-listp x))
  :rule-classes (:forward-chaining))

(defthm weak-tv-listp-if-fv-list-p-forward
  (implies (fv-listp x)
           (weak-tv-listp x))
  :rule-classes (:forward-chaining))

; Extended Type Tags

; So far we have used tags to mark data values used in the stack and in object fields. Now we extend the notion of tags to include abstract tags that allow specification of larger sets of data values. These extended tags will be used to describe constraints on part of the dJVM state. For example, the extended tag :one-word-type will be used to indicate that a tagged value must be of a one-word data type (i.e., anything but a two-word data type). These extended type tags will be used as part of the pattern language we use to define the ``simple'' dJVM instructions later on.

(deflist jvm-type-tag-listp (l)
  jvm-type-tag?)

(in-theory (disable jvm-type-tag-listp-true-listp))

(defn extended-type-tags ()
  '(:same
    :one-word-type
    :not-top-half
    :not-bot-half
    ))

(defn extended-type-tag? (x)
  (or (jvm-type-tag? x)
      (memberp x (extended-type-tags))))

(deflist extended-type-tag-listp (l)
  extended-type-tag?)

;The tags used in primitive tagged values can be used as type specifications. The use of a particular type in a type specification indicates that the corresponding tagged value should be of the indicated type. This is sufficient to discuss the primitive types, but is not adequate to specify reference types --- that is, values that refer to instances in the heap. The function extended-jvm-type? extends the standard type tags to allow the type-tag :ref to be paired with a string. (In our use later, the string will be required to be a class name, but for the moment we only impose the syntactic requirement.)

(defn extended-jvm-type? (x)
  (if (weak-tv-p x)
      (and (equal (tv-tag x) ':ref)
           (stringp (tv-val x)))
    (jvm-type-tag? x)))

(deflist extended-jvm-type-listp (l)
  extended-jvm-type?)

(in-theory (disable extended-jvm-type-listp-true-listp))

(in-theory (disable extended-type-tag-listp-true-listp))

(in-theory (disable value-of-type?))

; Well-formed operand stacks.
; A well-formed operand stack is a sequence of stack values with the added constraint that every long-top-half value must immediately precede a long-bot-half value, and every long-bot-half value must immediately follow a long-top-half value. All well-formed JVM states will satisfy this predicate. Since the dJVM relies on run-time tests to validate the well-formedness of the JVM state, we will not rely on states being well formed. Each operation that alters the operand stack will check that it is not given an ill-formed stack and that its stack manipulations do not leave an ill-formed stack.

; Future Extensions: This is the sort of global state-invariant we expect the JVM to preserve during execution. Such properties are proven inductively; if an initial state satisfies the property and every step (executing a single instruction) preserves the property, then the property is invariant during execution.

; The dJVM 0.5 model has not been proven to preserve this global invariant. After such a proof is done, some of the run-time defensive checks could be elided.

(verify-guards sv-listp)

(defun valid-stack? (stk)
  (declare (xargs :guard (sv-listp stk)
                  :guard-hints (("Goal" :in-theory (disable weak-tv-p)))))
  (if (endp stk)
      t
    (if (tv-one-word-p (car stk))
        (valid-stack? (cdr stk))
      ;; It's part of a two-word type...
      (and (tv-long-top-half-p (car stk))
           (consp (cdr stk))
           (tv-long-bot-half-p (cadr stk))
           (valid-stack? (cddr stk))))))
