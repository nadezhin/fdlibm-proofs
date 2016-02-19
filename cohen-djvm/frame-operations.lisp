; http://www.computationallogic.com/software/djvm/html-0.5/frame-operation-macro.html

(in-package "ACL2")
(include-book "data-structures/defalist" :dir :system)
(include-book "data-structures/deflist" :dir :system)
(include-book "data-structures/structures" :dir :system)
(include-book "ordinals/e0-ordinal" :dir :system)
(include-book "minor-utilities")

;Macros for Defining Frame Operations

;This appendix defines the macros used to define internal operations that alter call frames on the dJVM call stack. The macros are used in Chapter [ch:internal-operations] (Manipulating the dJVM State) to define the basic state-manipulation operations used to define the dJVM instructions.

;All of this mechanism defines two user-level macros: define-frame-operation and define-djvm-frame-operation. These macro definitions expand to define the functions that perform the manipulations, the guards for the functions, and rewrite rules so that the ACL2 theorem prover can reason about these operations.

;The expansion of these macros depends on the names of the slots in the call-frame and djvm structures. Those names are given in the definitions of frame-slot-table and djvm-slot-table.

(defstructure  slot-descriptor
  (getter)
  (setter)
  (:options :guards
            (:verify-guards t)
            ))

(deflist slot-descriptor-listp (l)
  slot-descriptor-p)

(defalist slot-table-p (l)
  (symbolp . slot-descriptor-p)
  (:options (:domain-type symbol-listp)
            (:range-type slot-descriptor-listp)))

(verify-guards   slot-table-p)

(defthm weak-slot-descriptor-p-binding
  (implies (slot-descriptor-p (binding-equal name slot-table))
           (weak-slot-descriptor-p (binding-equal name slot-table))))

(defun slot-table-slot-names  (slot-table)
  (declare (xargs :guard (slot-table-p slot-table)))
  (domain slot-table))

; These two functions violate the slot-descriptor abstraction.

(defun slot-table-getters (slot-table)
  (declare (xargs :guard (slot-table-p slot-table)))
  (strip-cadrs* (range slot-table)))

; Note that slot-descriptor-setter is permitted to return nil if the slot cannot be altered. We first extract the appropriate column of the table and then remove all occurrences of nil before returning it.

(defun slot-table-setters (slot-table)
  (declare (xargs :guard (slot-table-p slot-table)))
  (remove nil (strip-caddrs* (range slot-table))))

(defun slot-getter  (slot-name slot-table)
  (declare (xargs :guard (and (slot-table-p slot-table)
                              (bound?-equal slot-name slot-table))))
  (slot-descriptor-getter (binding-equal slot-name slot-table)))

(defun slot-setter  (slot-name slot-table)
  (declare (xargs :guard (and (slot-table-p slot-table)
                              (bound?-equal slot-name slot-table))))
  (slot-descriptor-setter (binding-equal slot-name slot-table)))

; Note that max-locals is not a frame slot. The function frame-max-locals is defined to return the max-locals slot of a frame's method, but just as a convenience. The frame-slot-table includes max-locals, so that the frame-operation macros generate rewrite-rules indicating that the value of the accessor frame-max-locals does not change under any of these frame-slot operations.

(defmacro  frame-slot-table ()
  '(list (list* 'class      (slot-descriptor 'frame-class      'nil))
         (list* 'method     (slot-descriptor 'frame-method     'nil))
         (list* 'pc         (slot-descriptor 'frame-pc         'set-frame-pc))
         (list* 'cia        (slot-descriptor 'frame-cia        'set-frame-cia))
         (list* 'locals     (slot-descriptor 'frame-locals     'set-frame-locals))
         (list* 'stack      (slot-descriptor 'frame-stack      'set-frame-stack))
         (list* 'new-refs   (slot-descriptor 'frame-new-refs   'set-frame-new-refs))
         (list* 'object-ref (slot-descriptor 'frame-object-ref 'nil))
         (list* 'max-locals (slot-descriptor 'frame-max-locals 'nil))))

(defmacro  djvm-slot-table ()
  '(list (list* 'stack      (slot-descriptor 'djvm-stack       'set-djvm-stack))
         (list* 'heap       (slot-descriptor 'djvm-heap        'set-djvm-heap))
         (list* 'class-table (slot-descriptor 'djvm-class-table 'set-djvm-class-table))
         (list* 'status     (slot-descriptor 'djvm-status      'set-djvm-status))))

(defun djvm-slots ()
  (declare (xargs :guard t))
  (slot-table-slot-names (djvm-slot-table)))

(defun djvm-getters ()
  (declare (xargs :guard t))
  (strip-cadrs* (djvm-slot-table)))

(defun frame-slots ()
  (declare (xargs :guard t))
  (slot-table-slot-names (frame-slot-table)))

(defun frame-getters ()
  (declare (xargs :guard t))
  (slot-table-getters (frame-slot-table)))

; Define a macro to build the n^2 rules for rewriting all combinations of a structure's getter and setter functions.

; First we must prove a theorem stating that all elements of the domain of an alist are bound in the alist. This is necessary to prove the guard conditions for the recursive functions expand-getter-rules and expand-getter-setter-rules.

(defthm all-bound-cdr-mapping
  (implies (and (alistp mapping)
                (all-bound?-equal keys (cdr mapping)))
           (all-bound?-equal keys mapping))
  :hints (("Goal" :in-theory (enable  all-bound?-equal bound?))))

(defthm all-bound?-domain
  (implies (alistp mapping)
           (all-bound?-equal (domain mapping) mapping))
  :hints (("Goal" :in-theory (enable  all-bound?-equal bound?-equal domain))))

(defthm all-bound-slot-table-slot-names
  (IMPLIES (slot-table-p slot-table)
           (ALL-BOUND?-equal (SLOT-TABLE-SLOT-NAMES SLOT-TABLE)
                       SLOT-TABLE)))

(defthm e0-ord-<-cdr
  (implies (consp x)
           (E0-ORD-< (acl2-count (cdr x))
                     (acl2-count x)))
  :rule-classes (:rewrite))

; Now back to the work at hand.

(defun expand-1-getter-rule (name altered-slot new-var old-var new-value slot-table)
  (declare (xargs :guard (and (slot-table-p slot-table)
                              (bound?-equal name slot-table)
                              (bound?-equal altered-slot slot-table))))
  (let ((getter (slot-getter name         slot-table))
        (setter (slot-setter altered-slot slot-table)))
    (declare (ignore  setter))
    (if (equal name  altered-slot)
        `(equal (,getter ,new-var)
                ,new-value)
      `(equal (,getter ,new-var)
              (,getter ,old-var)))))

(defun expand-getter-rules (names altered-slot
                                  new-var old-var
                                  new-value slot-table)
  (declare (xargs :guard (and (slot-table-p slot-table)
                              (bound?-equal altered-slot slot-table)
                              (true-listp names)
                              (all-bound?-equal names slot-table))))
  (if (endp names)
      nil
    (cons ;;                    (name altered-slot new-var old-var new-value slot-table)
          (expand-1-getter-rule (car names) altered-slot
                                new-var
                                old-var
                                new-value slot-table)
          (expand-getter-rules  (cdr names) altered-slot
                                new-var old-var
                                new-value slot-table))))

(defun expand-setter-rules (names var-name slot-table)
  (declare (xargs :guard (and (true-listp names)
                              (symbolp var-name)
                              (slot-table-p slot-table)
                              (all-bound?-equal names slot-table))
                  :guard-hints (("Goal" :hands-off true-listp))))
  (if (endp names)
      nil
    (let ((new-var-name (make-a-symbol (list 'new var-name)))
          (new-value    (make-a-symbol (list 'new (car names))))
          (setter (slot-setter (car names) slot-table)))
      (if (null setter)
          ;; This is a read-only slot.
          (expand-setter-rules (cdr names) var-name slot-table)
        (cons `(let ((,new-var-name (,setter ,new-value ,var-name)))
                 (and ,@(expand-getter-rules (slot-table-slot-names slot-table)
                                             (car names)
                                             new-var-name
                                             var-name
                                             new-value
                                             slot-table)))
              (expand-setter-rules (cdr names) var-name slot-table))))))

(defun expand-define-getter-setter-rules (var-name slot-table)
  (declare (xargs :guard (and (symbolp var-name)
                              (slot-table-p slot-table)
                              )
                  :verify-guards nil))
  (let ((rule-name (make-a-symbol (list var-name 'getter-setter))))
    `(encapsulate nil
         (defthm ,rule-name
           (and ,@(expand-setter-rules (slot-table-slot-names slot-table)
                                       var-name
                                       slot-table))))))

(defmacro  define-getter-setter-rules (structure-name slot-table)
  (expand-define-getter-setter-rules structure-name slot-table))

(defmacro  define-a-getter-setter-rules-macro (structure-name slot-table-name)
  (let ((macro-name (make-a-symbol (list 'define structure-name 'getter-setter-rules))))
  `(defmacro ,macro-name ()
     (expand-define-getter-setter-rules ',structure-name (,slot-table-name)))))

(define-a-getter-setter-rules-macro  djvm djvm-slot-table)

(defun slot-operation-slot-equality (slot-getter old new altered-slot-getter new-value)
  (declare (xargs :guard t))
  `(equal (,slot-getter ,new)
          ,(if (equal slot-getter altered-slot-getter)
               new-value
             `(,slot-getter ,old))))

(defun slot-operation-equalities-1 (getters old new altered-slot new-value)
  (declare (xargs :guard (true-listp getters)))
  (if (endp getters)
      nil
    (cons (slot-operation-slot-equality (car getters) old new altered-slot new-value)
          (slot-operation-equalities-1  (cdr getters) old new altered-slot new-value))))

(defun slot-operation-equalities (old new altered-slot new-value slot-table except-slots)
  (declare (xargs :guard (and (slot-table-p slot-table)
                              (true-listp except-slots)
                              (bound?-equal altered-slot slot-table)
                              (all-bound?-equal except-slots slot-table))
                  :guard-hints (("Goal" :hands-off (true-listp)))))
  (let ((getters-to-do (set-difference-equal (slot-table-getters slot-table)
                                             except-slots))
        (altered-getter (slot-getter altered-slot slot-table)))
    (slot-operation-equalities-1 getters-to-do old new altered-getter new-value)))

(defun frame-operation-equalities (old new altered-slot new-value except-slots)
  (declare (xargs :guard (and (bound?-equal altered-slot (frame-slot-table))
                              (true-listp except-slots)
                              (all-bound?-equal except-slots (frame-slot-table)))))
  (slot-operation-equalities old new altered-slot new-value
                             (FRAME-SLOT-TABLE)
                             except-slots))

(defun listify-conjunction (term)
  (declare (xargs :guard (true-listp term)))
  (if (and (consp term)
           (equal (car term) 'and))
      (cdr term)
    (list term)))

(defthm true-listp-listify-conjunction
  (implies (true-listp term)
           (true-listp (listify-conjunction term)))
  :rule-classes (:type-prescription))

(defun add-to-guard (new-conjunct guard)
  (declare (xargs :guard (and (true-listp new-conjunct)
                              (true-listp guard))))
  (if (and (consp new-conjunct)
           (consp guard))
      `(and ,@(listify-conjunction new-conjunct)
            ,@(listify-conjunction guard))
    (if (and (null guard)
             (null new-conjunct))
        't
      (if (null new-conjunct)
          guard
        new-conjunct))))

; The weak-guard is intended to assure the structural requirements for the frame operation. The guard should be strong enough to assure both the structural requirements and the slot assertion (from the structure definition) for the altered slot. The local variables full-weak-guard and full-guard augment values of these formal parameters with the standard weak or strong predicates for frame structures (i.e., weak-frame-p or frame-p). Thus when using the DEFINE-FRAME-OPERATION macro, these standard predicates are implicitly added to any guard explicitly given.

(defun expand-define-frame-operation (name args slot new-value
                                           guard weak-guard except-slots)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp args)
                              (member 'frame args)
                              (bound?-equal slot (frame-slot-table))
                              (true-listp guard)
                              (true-listp weak-guard)
                              (true-listp except-slots)
                              (all-bound?-equal except-slots (frame-slot-table)))
                  :guard-hints (("Goal"
                                 :in-theory (enable SYMBOL-LISTP-FORWARD-TO-TRUE-LISTP)
                                 :hands-off true-listp))))
  (let ((defn-rule-name         (make-a-symbol (list name 'defn)))
        (frame-p-rule-name      (make-a-symbol (list 'frame-p name)))
        (weak-frame-p-rule-name (make-a-symbol (list 'weak-frame-p name)))
        (slot-setter  (slot-setter slot (frame-slot-table)))
        (full-guard      (add-to-guard '(frame-p frame) guard))
        (full-weak-guard (add-to-guard '(weak-frame-p frame) weak-guard)))
    `(encapsulate ()
         (defun ,name ,args
           ;; This should be the WEAK-GUARD, so that the rewrite-rule
           ;; for the function definition only has the weak-guard as
           ;; its precondition.
           (declare (xargs  :guard ,full-weak-guard))
           (,slot-setter ,new-value frame))



       (defthm ,defn-rule-name
         (implies (force (weak-frame-p frame))
                  (let ((new-frame (,name ,@args)))
                    (and ,@(frame-operation-equalities 'frame 'new-frame
                                                       slot
                                                       new-value
                                                       except-slots))))
         :hints (("Goal" :in-theory (enable frame-max-locals))))



       (defthm ,frame-p-rule-name
         (implies (force ,full-guard)
                  (frame-p (,name ,@args))))



       (defthm ,weak-frame-p-rule-name
         (implies (force ,full-weak-guard)
                  (weak-frame-p (,name ,@args))))



       (in-theory (disable ,name))



       )))

(defmacro  define-frame-operation (name
                                  args
                                  \&key slot new-value guard weak-guard
                                  except-slots)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp args)
                              (member 'frame args)
                              (member slot (frame-slots)))))
  (expand-define-frame-operation name args slot new-value guard weak-guard except-slots))

; Here's an example definition. This generates the function frame-push-operand, and the rewrite rules about it.
;
;
; (define-frame-operation frame-push-operand (value frame)
;   :slot stack
;   :new-value (cons value (frame-stack  frame))
;   :guard (sv-p value))
;
;
; (encapsulate nil
;
;
;
;     (defun frame-push-operand (value frame)
;       (declare (xargs :guard (and (frame-p frame)
;                                   (sv-p value))))
;       (set-frame-stack (cons value
;                              (frame-stack frame))
;                        frame))
;
;
;
;   (defthm frame-push-operand-defn
;     (implies
;      (and (frame-p frame)
;           (sv-p value))
;      (let ((new-frame (frame-push-operand value frame)))
;        (and (equal (frame-class new-frame)      (frame-class frame))
;             (equal (frame-method new-frame)     (frame-method frame))
;             (equal (frame-pc new-frame)         (frame-pc frame))
;             (equal (frame-locals new-frame)     (frame-locals frame))
;             (equal (frame-stack new-frame)      (cons value (frame-stack frame)))
;             (equal (frame-new-refs new-frame)   (frame-new-refs frame))
;             (equal (frame-object-ref new-frame) (frame-object-ref frame))
;             (equal (frame-max-locals new-frame) (frame-max-locals frame))))))
;
;
;
;   (defthm frame-p-frame-push-operand
;     (implies (and (frame-p frame)
;                   (sv-p value))
;              (frame-p (frame-push-operand value frame))))
;
;
;
;   (defthm weak-frame-p-frame-push-operand
;     (implies (weak-frame-p frame)
;              (weak-frame-p (frame-push-operand value frame))))
;
;
;
;   (in-theory (disable frame-push-operand))
; )



;Defining Frame Operations at the dJVM Level

(defun djvm-operation-equalities (old new altered-slot new-value except-slots)
  (declare (xargs :guard (and (bound?-equal altered-slot (DJVM-SLOT-TABLE))
                              (true-listp except-slots)
                              (all-bound?-equal except-slots (DJVM-SLOT-TABLE)))))
  (slot-operation-equalities old new altered-slot new-value
                             (DJVM-SLOT-TABLE)
                             except-slots))



(defun expand-define-djvm-frame-operation (name args slot new-frame
                                           guard weak-guard except-slots)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp args)
                              (member 'djvm args)
                              (bound?-equal slot (frame-slot-table))
                              (true-listp guard)
                              (true-listp weak-guard)
                              (true-listp except-slots)
                              (all-bound?-equal except-slots (frame-slot-table)))
                  :guard-hints (("Goal"
                                 :in-theory (enable SYMBOL-LISTP-FORWARD-TO-TRUE-LISTP
                                                    bound?-equal)
                                 :hands-off (true-listp)))))
  (let ((defn-rule-name (make-a-symbol (list name 'defn)))
        (djvm-p-rule-name      (make-a-symbol (list 'djvm-p name)))
        (weak-djvm-p-rule-name (make-a-symbol (list 'weak-djvm-p name)))
        (full-weak-guard (add-to-guard '(and (weak-djvm-p djvm)
                                             (non-empty (djvm-stack djvm)))
                                        weak-guard))
        (strong-rewrite-guard   (add-to-guard '(djvm-p djvm) guard))
        (weak-rewrite-guard     (add-to-guard '(weak-djvm-p djvm) weak-guard))
        (frame-slot-getter  (slot-getter slot (frame-slot-table)))
        ;;(frame-slot-setter  (slot-setter slot (frame-slot-table)))
        )
    `(encapsulate ()



         (defun ,name ,args
           (declare (xargs  :guard ,full-weak-guard))
           (if (non-empty (djvm-stack djvm))
               (let  ((call-stack (djvm-stack djvm)))
                 (set-djvm-stack (cons ,new-frame
                                       (cdr call-stack))
                                 djvm))
             djvm))

       (defthm ,defn-rule-name
         (implies (force (and (weak-djvm-p djvm)
                              (non-empty (djvm-stack djvm))))
                  (let ((new-djvm (,name ,@args)))
                    (and ,@(djvm-operation-equalities
                            'djvm 'new-djvm
                            'stack
                            `(cons ,new-frame
                                   (cdr (djvm-stack djvm)))
                            nil)
                         (let ((frame (car (djvm-stack djvm)))
                               (new-frame (car (djvm-stack new-djvm))))
                           (and ,@(frame-operation-equalities 'frame 'new-frame
                                                              slot
                                        ; changed `(,frame-slot-getter ,slot ,new-value)
                                        ; to just new-value.
                                                              ;;new-value
                                                              `(,frame-slot-getter
                                                                ,new-frame)
                                                              except-slots))))))
         :hints (("Goal" :in-theory (enable set-frame-stack))))



       (defthm ,djvm-p-rule-name
         (implies (force ,strong-rewrite-guard)
                  (djvm-p (,name ,@args))))



       (defthm ,weak-djvm-p-rule-name
         (implies (force ,weak-rewrite-guard)
                  (weak-djvm-p (,name ,@args))))

       (in-theory (disable ,name))



       )))




;Here's an example form defining a frame operation at the dJVM level. It define the function djvm-set-pc to alter the pc slot of the current frame. The new pc value is required to be a natural number.
;
;
; (expand-define-djvm-frame-operation  'djvm-set-pc '(new-pc djvm)
;                                      'pc 'new-pc
;                                      '(naturalp new-pc)
;                                      '(naturalp new-pc)
;                                      nil)


(defmacro  define-djvm-frame-operation (name
                                       args
                                       \&key frame-slot new-frame
                                       guard weak-guard
                                       except-slots)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp args)
                              (member 'djvm args)
                              (member frame-slot (frame-slots)))))
  (expand-define-djvm-frame-operation name args
                                      frame-slot
                                      new-frame
                                      guard weak-guard except-slots))




; Defining dJVM slot operations

; The dJVM state is defined as a structure with four slots (status, stack, class-table, and heap). Just as we use a macro to define operations on the frame structure, we use a macro to define operations on the dJVM structure. This macro is named define-djvm-slot-operation.


(defun expand-define-djvm-slot-operation (name args slot new-value
                                           guard weak-guard except-slots)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp args)
                              (member 'djvm args)
                              (bound?-equal slot (djvm-slot-table))
                              (true-listp guard)
                              (true-listp weak-guard)
                              (true-listp except-slots)
                              (all-bound?-equal except-slots (djvm-slot-table)))
                  :guard-hints (("Goal"
                                 :in-theory (enable SYMBOL-LISTP-FORWARD-TO-TRUE-LISTP)
                                 :hands-off true-listp))))
  (let ((defn-rule-name         (make-a-symbol (list name 'defn)))
        (djvm-p-rule-name      (make-a-symbol (list 'djvm-p name)))
        (weak-djvm-p-rule-name (make-a-symbol (list 'weak-djvm-p name)))
        (slot-setter  (slot-setter slot (djvm-slot-table)))
        (full-guard      (add-to-guard '(djvm-p djvm) guard))
        (full-weak-guard (add-to-guard '(weak-djvm-p djvm) weak-guard)))
    `(encapsulate ()
         (defun ,name ,args
           ;; This should be the WEAK-GUARD, so that the rewrite-rule
           ;; for the function definition only has the weak-guard as
           ;; its precondition.
           (declare (xargs  :guard ,full-weak-guard))
           (,slot-setter ,new-value djvm))



       (defthm ,defn-rule-name
         (implies ,(if weak-guard
                       full-weak-guard
                       full-guard)
                  (let ((new-djvm (,name ,@args)))
                    (and ,@(djvm-operation-equalities 'djvm 'new-djvm
                                                       slot
                                                       new-value
                                                       except-slots)))))



       (defthm ,djvm-p-rule-name
         (implies ,full-guard
                  (djvm-p (,name ,@args))))



       (defthm ,weak-djvm-p-rule-name
         (implies ,full-weak-guard
                  (weak-djvm-p (,name ,@args))))



       (in-theory (disable ,name))



       )))



(defmacro  define-djvm-slot-operation (name
                                  args
                                  \&key slot new-value guard weak-guard
                                  except-slots)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp args)
                              (member 'djvm args)
                              (member slot (djvm-slots)))))
  (expand-define-djvm-slot-operation name args
                                     slot new-value
                                     guard weak-guard
                                     except-slots))
