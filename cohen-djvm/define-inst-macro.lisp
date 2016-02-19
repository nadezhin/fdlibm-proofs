; http://www.computationallogic.com/software/djvm/html-0.5/define-inst-macro.html

(in-package "ACL2")
(include-book "ordinals/e0-ordinal" :dir :system)
(include-book "internal-operations")
(local (include-book "data-structures/alist-defthms" :dir :system))

;The Define-JVM-Instruction Macro

;We define the macro Define-DJVM-Operation, that generates the ACL2 definitions for the ``simple'' JVM instructions. It supplies an easy interface to the more powerful Define-Defensive-Instruction macro defined earlier. It provides defaults for some of the options, and generates some simple type-checkers automatically.

;The define-jvm-operation macro always generates the functions defining the behavior of the instruction. Optionally it can also generate rewrite rules describing the instruction's effect on the dJVM state. If the rewrite rules are generated, it takes longer to process this file, because those rules will have to be justified by proofs. The function include-rewrite-rules-for-operations determines whether or not the rewrite rules are generated. If the function returns t, then the rules will be generated. If it returns nil, they will not.

(defn include-rewrite-rules-for-operations ()
  t)

(defun identity-2 (x y)
  (declare (ignore x)
           (xargs :guard t))
  y)

;When writing macros to generate code, it is often useful to generate a fixed form, even when portions of the form degenerate. For example, a macro may expand to include a let form to bind local variables, even though sometimes no local bindings are required. Macro definitions can use remove empty-lets to elide these degenerate let forms.

(defn remove-empty-lets (term)
  (if (and (true-listp term)
           (= (len term) 3)
           (equal (car term) 'let)
           (equal (cadr term) nil))
      (caddr term)
    term))

;The function parse-dso-args translates the surface syntax used for simple stack instructions into a list of keyword-value pairs. The keyword pairs include:
;
;    :assert predicate
;    :exceptions (( predicate_i condition_i) )
;    :instruction-length small-integer

(defun exception-spec-p (args)
  (declare (xargs :guard t))
  (and (true-listp args)
       (evenp (len args))))

(defun proper-dso-keyword-args-p (args)
  (declare (xargs :guard (true-listp args)))
  (if (endp args)
      t
    (case (car args)
      (:assert (if (consp (cdr args))
                   (proper-dso-keyword-args-p (cddr args))
                 '(:bad-assert-arg)))
      (:exceptions (if (and (consp (cdr args))
                            (exception-spec-p (cadr args)))
                       (proper-dso-keyword-args-p (cddr args))
                     '(:bad-exceptions-arg)))



      (:branch-if (if (and (consp (cdr args))
                           (exception-spec-p (cadr args)))
                      (proper-dso-keyword-args-p (cddr args))
                    '(:bad-branch-if-arg)))
      (:branch-target (if (and (consp (cdr args))
                               (exception-spec-p (cadr args)))
                          (proper-dso-keyword-args-p (cddr args))
                        '(:bad-branch-target-arg)))
      (:instruction-length (if (and (consp (cdr args))
                                    (integerp (cadr args))
                                    (< 0 (cadr args))
                                    (< (cadr args) 5))
                               (proper-dso-keyword-args-p (cddr args))
                             '(:bad-instruction-length-arg)))
      (otherwise `(:bad-keyword-arg ,(car args))))))

(defthm cddr-reduces-acl2-count
  (implies (and (consp x)
                (consp (cdr x)))
           (< (acl2-count (cddr x))
              (acl2-count x)))
  :rule-classes :linear)

(defun parse-dso-keyword-args (args)
  (declare (xargs :guard (and (true-listp args)
                              (proper-dso-keyword-args-p args))
                  :verify-guards nil))
  (if (or (endp args)
          (not (proper-dso-keyword-args-p args)))
      nil
    (case (car args)
      (:assert (if (consp (cdr args))
                   (acons ':assert
                          (cadr args)
                          (parse-dso-keyword-args (cddr args)))
                 '((:error ":assert keyword not followed by an expression."))))
      (:exceptions (if (consp (cdr args))
                       (acons ':exceptions
                              (cadr args)
                              (parse-dso-keyword-args (cddr args)))
                 '((:error ":exceptions keyword not followed by an exception spec."))))
      (:branch-if (if (consp (cdr args))
                       (acons ':branch-if
                              (cadr args)
                              (parse-dso-keyword-args (cddr args)))
                    '((:error
                       ":branch-if keyword not followed by an argument."))))
      (:branch-target (if (consp (cdr args))
                          (acons ':branch-target
                                 (cadr args)
                                 (parse-dso-keyword-args (cddr args)))
                        '((:error
                           ":branch-target keyword not followed by an argument."))))
      (:instruction-length (if (consp (cdr args))
                               (acons ':instruction-length
                                      (cadr args)
                                      (parse-dso-keyword-args (cddr args)))
                             '((:error
                                ":instruction-length keyword requires an argument.")))))))

(defthm proper-dso-keyword-args-p-cddr
  (implies (and (proper-dso-keyword-args-p args)
                (true-listp args))
           (proper-dso-keyword-args-p (cddr args))))

(defthm alistp-parse-dso-keyword-args
  (implies (or (true-listp args)
               (proper-dso-keyword-args-p args))
           (and (symbol-alistp (parse-dso-keyword-args args))
                (alistp (parse-dso-keyword-args args))))
  :rule-classes :rewrite)

(verify-guards parse-dso-keyword-args
 :hints (("Goal" :in-theory
          '((:DEFINITION EQL)
           (:DEFINITION NOT)
           (:DEFINITION TRUE-LISTP)
           (:EXECUTABLE-COUNTERPART CDR)
           (:EXECUTABLE-COUNTERPART PARSE-DSO-KEYWORD-ARGS)
           (:EXECUTABLE-COUNTERPART ALISTP)
           (:EXECUTABLE-COUNTERPART CONSP)
           (:EXECUTABLE-COUNTERPART NOT)
           (:EXECUTABLE-COUNTERPART CAR)
           (:EXECUTABLE-COUNTERPART EQUAL)
           (:EXECUTABLE-COUNTERPART ENDP)
           (:EXECUTABLE-COUNTERPART PROPER-DSO-KEYWORD-ARGS-P)
           (:REWRITE ALISTP-PARSE-DSO-KEYWORD-ARGS)
           (:COMPOUND-RECOGNIZER EQLABLEP-RECOG)
           (:TYPE-PRESCRIPTION PROPER-DSO-KEYWORD-ARGS-P)))))

(in-theory (disable alistp-parse-dso-keyword-args))

(defun revappend-1 (x y)
  (declare (xargs :guard t))
  (if (atom x)
      y
      (revappend-1 (cdr x) (cons (car x) y))))

(defun reverse-1 (x)
  (declare (xargs :guard t))
  (revappend-1 x nil))

(defun reverse-lists (x)
  (declare (xargs :guard (true-listp x)))
  (if (endp x)
      nil
    (if (consp (car x))
        (cons (reverse-1 (car x))
              (reverse-lists (cdr x)))
      (cons (car x)
            (reverse-lists (cdr x))))))

(defun parse-dso-args (args partial-result)
  (declare (xargs :guard (and (true-listp args)
                              (true-listp partial-result))))
  (if (endp args)
      (cons nil (reverse (reverse-lists partial-result)))
    (cond ((equal (car args) '==>)
           (parse-dso-args (cdr args)
                           (list* nil '==> partial-result)))
          ((null (car args))
           (parse-dso-args (cdr args)
                           partial-result
                           ))
          ((atom (car args))
           ;; Must have hit a keyword...
           (cons (parse-dso-keyword-args args)
                 (reverse (reverse-lists partial-result))))
          (t (parse-dso-args (cdr args)
                             (cons (cons (car args) (car partial-result))
                                   (cdr partial-result))
                             )))))

(defun get-next-djo-spec (args)
  (declare (xargs :guard (true-listp args)))
  (if (endp args)
      nil
    (if (member (car args) '(---STACK--- ---LOCALS--- ---OTHER-PROPERTIES---))
        nil
      ;; We just leave out these "place holders" as they don't
      ;; generate any assertions about the DJVM state.  They're just
      ;; there to make the DJO macro forms more readable.
      (if (member (car args) '(<rest-of-stack>
                               <no-constraints>
                               <unchanged>))
          (get-next-djo-spec (cdr args))
        (cons (car args)
              (get-next-djo-spec (cdr args)))))))

(defun skip-to-next-djo-spec (args)
  (declare (xargs :guard (true-listp args)))
  (if (endp args)
      nil
    (if (member (car args) '(---STACK--- ---LOCALS--- ---OTHER-PROPERTIES---))
        args
      (skip-to-next-djo-spec (cdr args)))))

(defun djo-pre-condition (spec)
  (declare (xargs :guard (true-listp spec)))
  (if (endp spec)
      nil
    (if (member (car spec) '(---STACK--- ---LOCALS--- ---OTHER-PROPERTIES---))
        nil
      (case (car spec)
        (==> nil)
        (otherwise (cons (car spec)
                         (djo-pre-condition (cdr spec))))))))

(defun djo-post-condition (spec)
  (declare (xargs :guard (true-listp spec)))
  (if (endp spec)
      nil
    (if (member (car spec) '(---STACK--- ---LOCALS--- ---OTHER-PROPERTIES---))
        nil
      (cons (car spec)
            (djo-post-condition (cdr spec))))))

(defun segmentize-djo-spec (spec)
  (declare (xargs :guard (true-listp spec)))
  (list (djo-pre-condition spec)
        '==>
        (djo-post-condition (cdr (member '==> spec)))))

(defthm parse-djo-args-termination-hint
  (implies (and (true-listp x)
                (consp x))
           (< (acl2-count (nthcdr i (cdr x)))
              (acl2-count x)))
  :hints (("Goal" :induct (nthcdr i list)))
  :rule-classes :linear)

(defthm parse-djo-args-termination-hint-2
  (implies (consp x)
           (E0-ORD-< (acl2-count (nthcdr i (cdr x)))
                     (acl2-count x)))
  :hints (("Goal" :induct (nthcdr i list)))
  :rule-classes (:rewrite))

(defthm parse-djo-args-termination-helper-3
  (and
   (IMPLIES (NOT (ENDP ARGS))
            (E0-ORD-< (ACL2-COUNT (NTHCDR i (CDR ARGS)))
                      (ACL2-COUNT ARGS)))
   (IMPLIES (NOT (ENDP ARGS))
            (E0-ORD-< (ACL2-COUNT (NTHCDR i (CDR ARGS)))
                      (ACL2-COUNT ARGS)))))

(defthm parse-djo-args-termination-helper-4
  (implies (consp x)
           (< (acl2-count (skip-to-next-djo-spec (cdr x)))
              (acl2-count x)))
  :rule-classes (:rewrite :linear))

(defthm parse-djo-args-termination-helper-5
  (equal (e0-ord-< (acl2-count x) (acl2-count y))
         (< (acl2-count x) (acl2-count y))))

(defun parse-djo-args (args)
  (declare (xargs :guard (true-listp args)
                  :verify-guards nil))
  (if (or (endp args)
          (not (true-listp args)))
      nil
    (case (car args)
      (---STACK---
       (let* ((stack-spec (get-next-djo-spec (cdr args)))
              (remaining-args (skip-to-next-djo-spec (cdr args))))
         (acons :stack-spec (segmentize-djo-spec stack-spec)
                (parse-djo-args remaining-args))))
      (---LOCALS---
       (let* ((locals-spec (get-next-djo-spec (cdr args)))
              (remaining-args (skip-to-next-djo-spec (cdr args))))
         (acons :locals-spec (segmentize-djo-spec locals-spec)
                (parse-djo-args remaining-args))))
      (---OTHER-PROPERTIES---
       (parse-dso-keyword-args (cdr args)))
      (otherwise
       `((:unknown-section-delimiter-in-djo-args ,(car args)))))))

;Remark: We've ignored exceptions up until now. However, we will specify them in the define-DJVM-operation macro.

;It's important that we use the exception test, as that's how we recognize division by zero (which is the only exception case among the stack instructions.)

;We will also define some exception cases for the branch instructions when the branch target is not a valid pc value in the current method.

(defun let-bind-elements (names term n)
  (declare (xargs :guard (and (symbol-listp names)
                              (naturalp n))))
  (if (endp names)
      nil
    (let ((accessor (binding-equal n '((1 . first)
                                 (2 . second)
                                 (3 . third)
                                 (4 . fourth)
                                 (5 . fifth)
                                 (6 . sixth)))))
      (if (null accessor)
          `((:let-list-elements-bindings too-many-names names= ,names))
        (if (equal (car names) nil)
            (let-bind-elements (cdr names)
                               term
                               (1+ n))
          (list* (list (car names)
                       `(,accessor ,term))
                 (let-bind-elements (cdr names)
                                    term
                                    (1+ n))))))))

(defun bind-instruction-args (instruction-pattern)
  (declare (xargs :guard (symbol-listp instruction-pattern)))
  (let-bind-elements (cdr instruction-pattern) 'instruction 2))

(defun bind-stk-vars (input-names stk-exp)
  (declare (xargs :guard (symbol-listp input-names)))
  (if (endp input-names)
      nil
    (let ((tv-name (make-a-symbol (list (car input-names) 'tv))))
      (list* `(,tv-name (car ,stk-exp))
             `(,(car input-names) (tv-val ,tv-name))
             `(,(make-a-symbol (list (car input-names) 'type)) (tv-tag ,tv-name))
             (bind-stk-vars (cdr input-names) `(cdr ,stk-exp))))))

(defun bind-local-var-refs (locals-spec frame-locals-term)
  (declare (xargs :guard (true-listp locals-spec)))
  (if (endp locals-spec)
      nil
    (let ((local-var-spec (car locals-spec)))
      (case-match local-var-spec
                  ((':local-var index (tv-tag tv-var))
                   (declare (ignore tv-tag))
                   (if (symbolp tv-var)
                       (let ((tv-name (make-a-symbol (list tv-var 'tv))))
                         (list* `(,tv-name (binding-equal ,index ,frame-locals-term))
                                `(,tv-var (tv-val ,tv-name))
                                `(,(make-a-symbol (list tv-var 'type))
                                  (tv-tag ,tv-name))
                                (bind-local-var-refs (cdr locals-spec)
                                                     frame-locals-term)))
                     `((:ill-formed-local-var-spec
                        detected-in-function bind-local-var-refs
                        ,@local-var-spec))))
                  (\& `((:ill-formed-local-var-specs ,@locals-spec)))))))

(defun list-of-stk-vars-names (input-names)
  "List of all the symbol names bound by BIND-STK-VARS."
  (declare (xargs :guard (symbol-listp input-names)))
  (if (endp input-names)
      nil
    (list* `,(car input-names)
           `,(make-a-symbol (list (car input-names) 'type))
           `,(make-a-symbol (list (car input-names) 'tv))
           (list-of-stk-vars-names (cdr input-names)))))

(defun list-of-local-vars-names (locals-spec)
  "List of all the symbol names bound by BIND-LOCAL-VAR-REFS."
  (declare (xargs :guard (true-listp locals-spec)
                  :verify-guards nil))
  (if (endp locals-spec)
      nil
    (let ((local-var-spec (car locals-spec)))
      (case-match local-var-spec
                  ((':local-var index (tv-tag tv-var))
                   (declare (ignore index tv-tag))
                   (let ((tv-name (make-a-symbol (list tv-var 'tv))))
                     (list* `,tv-name
                            `,tv-var
                            `,(make-a-symbol (list tv-var 'type))
                            (list-of-local-vars-names (cdr locals-spec)))))
                  (\& `(:ill-formed-local-var-specs ,@locals-spec))))))

(defun pop-em (n djvm-exp)
  (declare (xargs :guard (naturalp n)))
  (if (zp n)
      djvm-exp
    `(djvm-pop-operand ,(pop-em (1- n) djvm-exp))))

(defun extended-tv-p (x)
  (and (true-listp x)
       (consp x)
       (extended-type-tag? (car x))
       (consp (cdr x))))

(deflist extended-tv-listp (l)
  extended-tv-p)

(verify-guards extended-tv-p)
(verify-guards extended-tv-listp)

(defn input-stack-element-spec-p (x)
  (and (true-listp x)
       (consp x)
       (extended-type-tag? (car x))
       (consp (cdr x))
       (symbolp (cadr x))))

(deflist input-stack-spec-p (l)
  input-stack-element-spec-p)

(verify-guards input-stack-spec-p)

(defn output-stack-element-spec-p (x)
  (and (true-listp x)
       (consp x)
       (extended-type-tag? (car x))
       (consp (cdr x))
       (if (equal (car x) ':same)
           (symbolp (cadr x))
         t)))

(deflist output-stack-spec-p (l)
  output-stack-element-spec-p)

(verify-guards output-stack-spec-p)

; Altering the State

(defun push-em (output-spec djvm-exp)
  (declare (xargs :guard (output-stack-spec-p output-spec)))
  (if (endp output-spec)
      djvm-exp
    ;; If (CAR OUTPUT-SPEC) is of the form (:TYPE ID),
    ;; then the term to push is (MAKE-TV :TYPE  ID).
    ;; Otherwise the variable ID-TV is bound to the
    ;; tagged-value ID matched from the input stack.
    (let ((new-top (case (first (car output-spec))
                     (:same (make-a-symbol (list (second (car output-spec)) 'tv)))
                     (otherwise `(make-tv ,(first (car output-spec))
                                          ,(second (car output-spec)))))))
      `(djvm-push-operand ,new-top
                          ,(push-em (cdr output-spec) djvm-exp)))))

(defun construct-value-to-store (tv-spec)
  (declare (xargs :guard (true-listp tv-spec)))
  (let ((tv-tag (first tv-spec))
        (tv-var (second tv-spec)))
    (if (equal tv-tag ':same)
        (if (symbolp tv-var)
            (make-a-symbol (list tv-var 'tv))
          `(:error-in-tv-spec detected-in construct-value-to-store
                              ,tv-spec))
      `(make-tv ,tv-tag ,tv-var))))

(deflist true-list-of-true-listp (l)
  true-listp)

(verify-guards true-list-of-true-listp)

(defun construct-values-to-store (tv-specs)
  (declare (xargs :guard (true-list-of-true-listp tv-specs)
                  :guard-hints (("Subgoal 1"
                                 :by (:instance TRUE-LIST-OF-TRUE-LISTP-CDR
                                                (l tv-specs))))))



  (if (endp tv-specs)
      nil
    (cons (construct-value-to-store (car tv-specs))
          (construct-values-to-store (cdr tv-specs)))))

(in-theory (disable TRUE-LIST-OF-TRUE-LISTP-THEORY))

(defun store-em (locals-spec djvm-term)
  (declare (xargs :guard (true-listp locals-spec)
                  :verify-guards nil))
  (if (endp locals-spec)
      djvm-term
    ;; If (CAR LOCALS-SPEC) is of the form (:local-var index (:TYPE ID)),
    ;; then the term to store is (MAKE-TV :TYPE ID).
    ;; Otherwise the variable ID-TV is bound to the
    ;; tagged-value ID matched from the input stack.
    (if (= 1 (len locals-spec))
        (let ((index   (second (car locals-spec)))
              (tv-spec (third  (car locals-spec))))
          `(djvm-store-local ,index
                             ,(construct-value-to-store tv-spec)
                             ,djvm-term))
      (let ((indices (strip-cadrs* locals-spec))
            (values  (construct-values-to-store (strip-caddrs* locals-spec))))
        (if (= (len indices) 2)
            `(djvm-store-local ,(second indices)
                               ,(second values)
                               (djvm-store-local ,(first indices)
                                                 ,(first values)
                                                 ,djvm-term))
          `(djvm-store-locals ,@indices
                              ,values
                              ,djvm-term))))))

; Generating Guard Conditions

; These functions generate the guard-conditions for the functions generated by the define-djvm-operation macro.

(defthm e0-ord-<-cdr
  (implies (consp x)
           (E0-ORD-< (acl2-count (cdr x))
                     (acl2-count x)))
  :rule-classes (:rewrite))

(defun stack-spec-list-p (x)
  (declare (xargs :guard t
                  :hints (("Goal" :use (:instance e0-ord-<-cdr)))))
  (if (and (consp x)
           (true-listp x))
      (if (atom (car x))
          (and (equal (car x) '<rest-of-stack>)
               (null (cdr x)))
        (and (true-listp (car x))
             (= 2 (len (car x)))
             (extended-type-tag? (first (car x)))
             (stack-spec-list-p (cdr x))))
    (equal x nil)))

(defun stack-spec-var-names (spec)
  (declare (xargs :guard (stack-spec-list-p spec)))
  (strip-cadrs* spec))

(defun stack-spec-type-tags (spec)
  (declare (xargs :guard (stack-spec-list-p spec)))
  (strip-cars* spec))

(defun local-vars-spec-list-p (x)
  (declare (xargs :guard t))
  (if (and (consp x)
           (true-listp x))
      (if (atom (car x))
          (and (member (car x) '(<no-changes> <no-constraints>))
               (null (cdr x)))
        (and (true-listp (car x))
             (= 2 (len (car x)))
             (extended-type-tag? (first (car x)))
             (symbolp (second (car x)))
             (stack-spec-list-p (cdr x))))
    (equal x nil)))

(defun local-vars-spec-var-names (spec)
  (declare (xargs :guard (local-vars-spec-list-p spec)))
  (strip-cadrs* (strip-cadrs* spec)))

(defn djo-args-p (x)
  (and (symbol-alistp x)
       (symbol-listp (binding-equal ':instruction x))
       (stack-spec-list-p (binding-equal 'stack-spec x))
       (local-vars-spec-list-p (binding-equal 'locals-spec x))
       (exception-spec-p (binding-equal ':execptions x))))

(defun expand-local-var-sigs? (frame-term local-var-specs)
  (declare (xargs :guard (true-listp local-var-specs)))
  (if (endp local-var-specs)
      nil
    (let ((local-var-spec (car local-var-specs)))
      (case-match local-var-spec
                  ((':local-var index (tv-tag tv-var))
                   (declare (ignore tv-var))
                   (append `((< ,index (frame-max-locals ,frame-term))
                             (bound?-equal ,index (frame-locals ,frame-term))
                             ,(if (EXTENDED-TYPE-TAG? tv-tag)
                                  (assert-value-typed-properly
                                   tv-tag
                                   `(binding-equal ,index (frame-locals ,frame-term)))
                                `(bad-type-spec-in-local-vars-spec ,tv-tag)))
                           (expand-local-var-sigs? frame-term
                                                   (cdr local-var-specs))))
                  (\& `(:ill-formed-local-var-specs ,@local-var-specs))))))

(defmacro  local-var-sigs? (frame \&rest local-var-specs)
  `(and ,@(expand-local-var-sigs? frame local-var-specs)))

(defun expand-local-var-index-check (frame-term local-var-specs)
  "Generate guard conjuncts that indices in LOCAL-VAR-SPECS are
   all valid indices for local variables in the frame FRAME-TERM."
  (declare (xargs :guard (true-listp local-var-specs)))
  (if (endp local-var-specs)
      nil
    (let ((local-var-spec (car local-var-specs)))
      (case-match local-var-spec
                  ((':local-var index (tv-tag tv-var))
                   (declare (ignore tv-tag tv-var))
                   (append `((naturalp ,index)
                             (< ,index (frame-max-locals ,frame-term)))
                           (expand-local-var-index-check frame-term
                                                         (cdr local-var-specs))))
                  (\& `((:ill-formed-local-var-specs ,@local-var-specs)))))))

(defun djo-stack-input-type-tags (djo-args)
  (declare (xargs :guard (symbol-alistp djo-args)))
  (binding-equal ':stack-spec djo-args))

(defun let-list-element-bindings (names term n)
  (declare (xargs :guard (and (symbol-listp names)
                              (naturalp n))))
  (if (endp names)
      nil
    (let ((accessor (binding-equal n '((1 . first)
                                 (2 . second)
                                 (3 . third)
                                 (4 . fourth)
                                 (5 . fifth)
                                 (6 . sixth)))))
      (if (null accessor)
          `((:let-list-elements-bindings too-many-names))
        (if (equal (car names) nil)
            (let-list-element-bindings (cdr names)
                                       term
                                       (1+ n))
          (list* (car names)
                 `(,accessor ,term)
                 (let-list-element-bindings (cdr names)
                                            term
                                            (1+ n))))))))

;We know that all the dJVM instructions that store into local variables take the local variable index as an immediate argument to the instruction (i.e., the local variable index is a constant value included as part of the instruction). So we generate the guard conjuncts that check that these indices are less than max-locals within the scope of the let bindings of the instruction arguments.

(defun make-instruction-operand-assertion (djo-args strength)
  (declare (xargs :guard (and (djo-args-p djo-args)
                              (member strength '(0 1 2)))
                  :verify-guards nil))
  (let* ((instruction (binding-equal ':instruction djo-args))
         (args-assertion (binding-equal ':assert djo-args))
         (local-var-specs (binding-equal ':locals-spec djo-args))
         (local-var-input-spec (first local-var-specs))
         (local-var-output-spec (third local-var-specs)))
    (if (and (null (cdr instruction))
             (null args-assertion)
             (null local-var-input-spec)
             (null local-var-output-spec))
        `((true-listp instruction)
          (equal (car instruction) ',(car instruction))
          (= (len instruction) ,(len instruction)))
      `((true-listp instruction)
        (equal (car instruction) ',(car instruction))
        (= (len instruction) ,(len instruction))
        ,(remove-empty-lets
          `(let ,(bind-instruction-args instruction)
            (and ,@(if args-assertion
                       (list args-assertion)
                     nil)
                 ,@(case strength
                     (2 (expand-local-var-sigs? '(car (djvm-stack djvm))
                                                local-var-input-spec))
                     (1 (expand-local-var-index-check '(car (djvm-stack djvm))
                                                      local-var-input-spec)))
                 ,@(if (and (> strength 0)
                            (true-listp local-var-output-spec))
                       (expand-local-var-index-check '(car (djvm-stack djvm))
                                                     local-var-output-spec)
                     nil)
                 )))))))

(defun make-safe-stack-execution-guard (djo-args)
  (declare (xargs :guard (symbol-alistp djo-args)
                  :verify-guards nil))
  (let* ((stack-spec (binding-equal ':stack-spec djo-args))
         (input-spec (first stack-spec))
         (input-type-tags (stack-spec-type-tags input-spec)))
    `(and (djvm-p djvm)
          (non-empty (djvm-stack djvm))
          (STK-SIG-TOP? (frame-stack (car (djvm-stack djvm)))
                        ,@input-type-tags)
          ,@(make-instruction-operand-assertion djo-args 2))))

(defun make-safe-stack-execution-guard-declaration (djo-args)
  (declare (xargs :guard (symbol-alistp djo-args)
                  :verify-guards nil))
  `(declare (xargs :guard ,(make-safe-stack-execution-guard djo-args)
                   :guard-hints (("Goal"
                                  :do-not-induct t))
                   )))

; Generating Function Definitions

(defthm helper-23
  (implies (INPUT-STACK-ELEMENT-SPEC-P x)
           (consp x))
  :rule-classes :forward-chaining)

(defthm alistp-if-input-stack-spec-p
  (IMPLIES (INPUT-STACK-SPEC-P INPUT-SPEC)
           (and (ALISTP INPUT-SPEC)
                (true-listp input-spec)))
  :hints (("goal"
           :in-theory (disable output-stack-spec-p
                               output-stack-element-spec-p
                               OUTPUT-STACK-SPEC-P-TRUE-LISTP
                               EXTENDED-TV-LISTP
                               )
           ))
  :rule-classes :forward-chaining)

(in-theory (disable input-stack-spec-p
                    output-stack-spec-p))

(in-theory (disable extended-tv-listp-theory))

(defun exception-case-wrapper (exceptions djvm changed-djvm)
  (declare (xargs :guard (exception-spec-p exceptions)
                  :verify-guards nil))
  (if (or (atom exceptions)
          (atom (cdr exceptions)))
      changed-djvm
    (let ((test (car exceptions))
          (error (cadr exceptions)))
      `(if ,test
           (set-djvm-status ',error ,djvm)
         ,(exception-case-wrapper (cddr exceptions) djvm changed-djvm)))))

;This code builds the portion of the optimized instruction definition for a conditional branch. This degenerates to nothing for instructions other than conditional branches.

;The optimized instruction function is called with the pc already incremented to point to the next sequential instruction. Thus, if the branch is not taken, nothing need be done to the pc. All the conditional branch instructions are relative branches, and that the first argument of the instruction is the signed offset. If the branch is taken, the offset is applied relative to the current instruction address (i.e., the cia register).

(defun expand-branch-if (djo-args djvm-exp)
  (declare (xargs :guard (djo-args-p djo-args)))
  (let ((ins-len     (binding-equal ':instruction-length djo-args))
        (branch-test (binding-equal ':branch-if djo-args))
        (branch-target (subst '(djvm-cia djvm)
                              'current-instruction-address
                              (binding-equal ':branch-target djo-args)))
        (instruction (binding-equal ':instruction djo-args)))
    (if (null branch-test)
        djvm-exp
      (if (instruction-p instruction)
          (if (consp (op-args instruction))
              (let ((offset (arg1 instruction)))
                (declare (ignore offset))
                (if (and (naturalp ins-len)
                         (or (equal ins-len 3)
                             (equal ins-len 5)))
                    `(if ,branch-test
                         (djvm-set-pc ,branch-target ,djvm-exp)
                       ,djvm-exp)
                  `(error 'branch-instruction-len 'is 'not '3 'or 5)))
            `(error 'branch-instruction-pattern 'has 'no 'offset 'argument))
        `(error instruction 'is 'not 'a 'legal 'instruction 'form)
        ))))

(defun build-execute-safe-stack-fn (fname inst-args djo-args)
  (declare (xargs :guard (and (symbolp fname)
                              (symbol-listp inst-args)
                              (djo-args-p djo-args))
                  :verify-guards nil)
           (ignore inst-args))
  (let* (;;(inst-args-assertion (binding-equal ':assert keywords))
         (exceptions (subst '(djvm-cia djvm)
                              'current-instruction-address
                              (binding-equal ':exceptions djo-args)))
         (stack-spec (binding-equal ':stack-spec djo-args))
         (input-spec (first stack-spec))
         (output-spec (third stack-spec))
         (input-names (stack-spec-var-names input-spec))
         (locals-spec (binding-equal ':locals-spec djo-args))
         ;;(locals-input-spec  (first locals-spec))
         (locals-output-spec (third locals-spec))
         (guard (make-safe-stack-execution-guard djo-args)))
    `(defun ,fname (instruction djvm)
       (declare (xargs :guard ,guard
                       :guard-hints (("Goal" :do-not-induct t))))
       (let* (,@(bind-instruction-args (binding-equal ':instruction djo-args))
              ,@(bind-stk-vars input-names `(frame-stack (car (djvm-stack djvm))))
              ,@(bind-local-var-refs (first (binding-equal ':locals-spec djo-args))
                                     `(frame-locals (car (djvm-stack djvm)))))
           ,(exception-case-wrapper
             exceptions
             'djvm
             (store-em locals-output-spec
                       (push-em output-spec
                                (expand-branch-if djo-args
                                                  (pop-em (length input-spec)
                                                          `djvm)))))))))

(defun expand-op-arg-predicates-and-fns (op-arg-predicates op-arg-fns)
  (declare (xargs :guard (and (true-listp op-arg-predicates)
                              (true-listp op-arg-fns))))
  (if (or (endp op-arg-predicates)
          (endp op-arg-fns))
      nil
    (cons `(,(car op-arg-predicates) (,(car op-arg-fns) instruction))
          (expand-op-arg-predicates-and-fns (cdr op-arg-predicates)
                                            (cdr op-arg-fns)))))

(defun expand-op-arg-predicates (op-arg-predicates)
  (declare (xargs :guard (and (true-listp op-arg-predicates)
                              (<= (length op-arg-predicates) 3))))
  `(and ,@(expand-op-arg-predicates-and-fns op-arg-predicates
                                            '(arg1 arg2 arg3))))

(defn conjunct-p (x)
  (or (equal x nil)
      (equal x 't)
      (true-listp x)))

(defun flatten-conjunctions (c1 c2)
  "Given two conjunctions C1 and C2, combine their terms
   and remove any terms that are identically T.  Redundant
   terms are not eliminated."
  (declare (xargs :guard (and (conjunct-p c1) (conjunct-p c2))))
  (let* ((c1-part (if (and (consp c1)
                           (equal (car c1) 'and))
                      (cdr c1)
                    (if (null c1)
                        nil
                      (list c1))))
         (c2-part (if (and (consp c2)
                           (equal (car c2) 'and))
                      (cdr c2)
                    (if (null c2)
                        nil
                      (list c2))))
         (conjuncts (remove 't (append c1-part c2-part))))
    (if (null conjuncts)
        t
      (if (null (cdr conjuncts))
          (car conjuncts)
        (cons 'and conjuncts)))))

(defun expand-define-stack-op (step-fn
                               execute-fn
                               djo-args
                               guard-eagerness)
  (declare (xargs :guard (and (symbolp step-fn)
                              (djo-args-p djo-args)
                              (symbolp execute-fn)
                              (naturalp guard-eagerness))
                  :verify-guards nil)
           (ignore guard-eagerness))
  (let* ((inst-pat (binding-equal ':instruction djo-args))
         (op-code (car inst-pat))
         (op-arg-predicates (binding-equal ':assert djo-args))
         (stack-spec (binding-equal ':stack-spec djo-args))
         (pre-stack-types  (stack-spec-type-tags (first stack-spec)))
         (post-stack-types (stack-spec-type-tags (third stack-spec)))
         (local-spec (binding-equal ':locals-spec djo-args))
         (inst-length (or (binding-equal ':instruction-length djo-args) 1))
         (guard-hints  (binding-equal ':guard-hints djo-args))
         (wff-fn (make-a-symbol (list op-code 'wff-inst-p)))
         (proper-arg-types-fn (make-a-symbol (list op-code 'proper-arg-types-p)))
         (proper-arg-values-fn (make-a-symbol (list op-code 'proper-arg-values-p)))
         (proper-result-type-fn (make-a-symbol (list op-code 'proper-result-type-p))))
    `(encapsulate ()



     (defun ,wff-fn (instruction)
       (declare (xargs :guard t))
       ,(flatten-conjunctions
         `(and (instruction-p instruction)
               (equal (op-code instruction) ',op-code))
         (if (null op-arg-predicates)
              `(and (null (op-args instruction)))
           `(and ,@(make-instruction-operand-assertion djo-args 0)))))



     (defun ,proper-arg-types-fn (instruction frame)
       (declare (xargs :guard (and (instruction-p instruction)
                                   (,wff-fn instruction)
                                   (frame-p frame))))
       ,(flatten-conjunctions
         (if pre-stack-types
              `(and (not (null (frame-stack frame)))
                    (stk-sig-top? (frame-stack frame)
                                  ,@pre-stack-types))
            t)
         (if local-spec
             `(let ,(bind-instruction-args inst-pat)
                (and ,@(expand-local-var-index-check 'frame
                                                     (first local-spec))
                     ,@(expand-local-var-index-check 'frame
                                                     (third local-spec))))
           t)))



     (defun ,proper-arg-values-fn (instruction djvm)
       (declare (xargs :guard (and (djvm-p djvm)
                                   (instruction-p instruction)
                                   (,wff-fn instruction)
                                   (frame-p (car (djvm-stack djvm)))
                                   (,proper-arg-types-fn instruction
                                                         (car (djvm-stack djvm))))))
       ,(flatten-conjunctions
        (if pre-stack-types
            `(and
              ,@(assert-args-typed-value-properly
                 `,pre-stack-types
                 '(frame-stack (car (djvm-stack djvm)))))
          t)
        (if (and (null op-arg-predicates)
                 (null (first local-spec)))
            `(and (null (op-args instruction)))
          `(and ,@(make-instruction-operand-assertion djo-args 2)))))



     (defun ,proper-result-type-fn (instruction djvm)
       (declare (xargs :guard (and (instruction-p instruction)
                                   (,wff-fn instruction)
                                   (djvm-p djvm)
                                   (non-empty (djvm-stack djvm)))))
       ,(flatten-conjunctions
         (if post-stack-types
             `(and (non-empty (djvm-stack djvm))
                   (non-empty (frame-stack (car (djvm-stack djvm))))
                   (stk-sig-top? (frame-stack (car (djvm-stack djvm)))
                                 ,@post-stack-types))
           t)
         (if local-spec
             `(let ,(bind-instruction-args inst-pat)
                (and ,@(expand-local-var-sigs? '(car (djvm-stack djvm))
                                               (third local-spec))))
           t)))



     (in-theory (disable ,execute-fn))



     (define-defensive-instruction ,step-fn
       ,wff-fn
       ,proper-arg-types-fn
       identity-2                       ;nothing to resolve!
       ,proper-arg-values-fn            ;tagged-values should be good enough
       ,execute-fn
       ,proper-result-type-fn
       :instruction-length ,inst-length
       :guard-hints ,guard-hints)



     ;; This is new as of 1/21/97



     (defthm ,(make-a-symbol (list 'djvm-p step-fn))
       (implies (and (djvm-p djvm)
                     (non-empty (djvm-stack djvm))
                     (java-bytecode-method-p (frame-method (car (djvm-stack djvm)))))
                (djvm-p (,step-fn inst djvm))))
     )))

;Here are some standard facts we want to know about each stack instruction. (We'll want to know analogous facts about other instructions, as well, but the statement of those facts may be slightly different.)

;Remark: Where should this get instantiated?


(defun stack-instruction-preservation-thms (instruction-fn guard)
  (declare (xargs :verify-guards nil))
  (let ((weak-frame-p-event (make-a-symbol (list 'weak-frame-p-after
                                                 instruction-fn)))
        (good-pc-event (make-a-symbol  (list 'good-pc-after instruction-fn)))
        (consp-call-stack-event (make-a-symbol (list 'non-empty-call-stack-after
                                                     instruction-fn)))
        (weak-djvm-p-event (make-a-symbol (list 'weak-djvm-p instruction-fn)))
        (djvm-p-event      (make-a-symbol (list 'djvm-p      instruction-fn)))
        (preserves-method  (make-a-symbol (list instruction-fn
                                                'preserves-current-method))))
    (declare (ignore weak-frame-p-event
                     good-pc-event
                     consp-call-stack-event))
    `(
      #+SKIP
      (defthm ,weak-frame-p-event
        (implies (and (djvm-p djvm)
                      (consp (djvm-stack djvm))
                      ,guard)
                 (weak-frame-p
                  (car (djvm-stack (,instruction-fn instruction djvm)))))
        :hints (("Goal" :in-theory (enable ,instruction-fn
                                           ))))
      #+SKIP
      (defthm ,good-pc-event
        (implies (and (djvm-p djvm)
                      (non-empty (djvm-stack djvm))
                      ,guard)
                 (naturalp (frame-pc
                            (car (djvm-stack (,instruction-fn instruction djvm))))))
        :hints (("Goal" :in-theory (enable ,instruction-fn
                                           ))))



      #+SKIP
      (defthm ,consp-call-stack-event
        (implies (and (djvm-p djvm)
                      (non-empty (djvm-stack djvm))
                      ,guard)
                 (consp (djvm-stack
                         (,instruction-fn instruction djvm))))
        :hints (("Goal" :in-theory (enable ,instruction-fn
                                           ))))



      (defthm ,weak-djvm-p-event
        (implies (and (weak-djvm-p djvm)
                      (non-empty (djvm-stack djvm))
                      ,guard)
                 (weak-djvm-p (,instruction-fn instruction djvm)))
        :hints (("Goal" :in-theory (enable ,instruction-fn
                                           ))))



      (defthm ,djvm-p-event
        (implies (and (djvm-p djvm)
                      (non-empty (djvm-stack djvm))
                      ,guard)
                 (djvm-p (,instruction-fn instruction djvm)))
        :hints (("Goal" :in-theory (enable ,instruction-fn
                                           ))))
      (defthm ,preserves-method
        (implies (and (djvm-p djvm)
                      (consp (djvm-stack djvm))
                      ,guard)
                 (equal (frame-method
                          (car (djvm-stack (,instruction-fn instruction djvm))))
                        (frame-method (car (djvm-stack djvm)))))
        :hints (("Goal" :in-theory (enable ,instruction-fn
                                           ))))
      )))


;Remark: The assertion concerning the instruction argument is not handled here. We use symbolic names in the INSTRUCTION-PATTERN, and then expect them to be bound appropriately in the ASSERTION. So we must either substitute into the assertion or wrap a LET around the assertion.

;At the moment this only applies to the bipush and sipush instructions, but it will also apply to all of the branch instructions.

(defun define-stack-operation-expander (instruction-pattern args)
  (declare (xargs :verify-guards nil))
  (let* ((djo-args (acons ':instruction instruction-pattern
                          (parse-djo-args args)))
         ;;(stack-inputs (first (binding-equal ':stack-spec djo-args)))
         ;;(stack-outputs (third (binding-equal ':stack-spec djo-args)))
         (op-code (car instruction-pattern))
         (verify-guards t)
         (fname  (make-a-symbol (list 'djvm-execute op-code 'optimized)))
         (fname2 (make-a-symbol (list 'djvm-execute op-code)))
         (label  (make-a-symbol (list 'djvm op-code)))
         (guard (make-safe-stack-execution-guard djo-args))
         )
    (if (djo-args-p djo-args)
        `(encapsulate ()
             (defstub ,label () t)
           (set-ignore-ok t)
           ,(build-execute-safe-stack-fn fname
                                         (cdr instruction-pattern)
                                         djo-args)
           ,@(if t ;; include-rewrite-rules-for-operations
                 (stack-instruction-preservation-thms fname guard)
               nil)
           ,(expand-define-stack-op fname2
                                    fname
                                    djo-args
                                    (if verify-guards 2 0))
           (in-theory (disable ,fname2))
           )
      (if (and (null (binding-equal ':stack-spec djo-args))
               (null (binding-equal ':locals-spec djo-args)))
          '(:error-in-djo-specification neither ---stack--- nor
                                        ---locals--- specified)
        `'(:error-in-djo-specification ,@djo-args)))))

(defmacro  define-djvm-operation (instruction-pattern \&rest args)
  (define-stack-operation-expander instruction-pattern args))


;We restate this rewrite rule so that it will be most-recent, and hence tried first.

(defthm sv-p-recomposed-tv-anew
  (and (implies (sv-p x)
                (sv-p (make-tv (tv-tag x) (tv-val x))))
       (implies (and (sv-p tv)
                     (equal tag (tv-tag tv))
                     (equal val (tv-val tv)))
                (sv-p (make-tv tag val)))))


;DEFINE-STACK-OPERATION is intended to allow easy specification of operations that manipulate the stack. It does not support operations that also access or alter the heap or local variables, nor the method call/method return instructions.

;The general format is
;
;(define-stack-operation (opcode args) {operand_0} operand_1 ... operand_n ==> result_0 result_1 ... result_k)
;
;In this description operand_0 through operand_n are the operands required by the instruction with operand_0 being the topmost element of the operand stack. The operator pops these topmost n elements from the operand stack. If the instruction completes normally, the elements result_0 result_n will be the top k elements of the operand stack with result_0 being the topmost element.

;Examples of Simple Instruction Definitions

;This section contains examples for all of the forms of the define-djvm-operation macro. Different forms can vary in
;
;    The instruction prototype, which indicates the instruction's opcode and any instruction arguments
;    The patterns describing the type constraints on the initial operand stack and type and value constaints on the final operand stack
;    Exceptional conditions, which cause the dJVM to halt with an error status
;    Whether or not a branch-target and branch-condition are specified
;    The patterns describing the type constraints on the initial local variables and type and value constraints on the final local variables.

;Remark: Fill in the expanations to go with these examples!

;These examples should move to section [sec:expand-define-djvm-inst], page [sec:expand-define-djvm-inst].
;
;
;
;  (define-djvm-operation (instruction . args)
;
;
;
;    ---STACK---
;
;
;
;    ...
;    <rest-of-stack>
;    ==>
;    ...
;    <rest-of-stack>
;
;
;
;    ---LOCALS---
;    ...
;    ==>
;    ...
;    ---OTHER-PROPERTIES---
;
;
;
;    )
;
;
;
;  ;; Simple stack instruction
;
;
;
;  (define-djvm-operation (iadd)
;    ---STACK---
;    (:int x)
;    (:int y)
;    <rest-of-stack>
;    ==>
;    (:int (int-add x y))
;    <rest-of-stack>)
;
;
;
;  ;; Introduce an exception
;
;
;
;  (define-djvm-operation (idiv)
;    ---STACK---
;    (:int denom)
;    (:int num)
;    <rest-of-stack>
;    ==>
;    (:int (narrow-to-int (integer-div num denom)))
;    <rest-of-stack>
;
;
;
;    ---OTHER-PROPERTIES---
;    :exceptions ((equal denom 0) "ArithmeticException")
;    :length 1)
;
;
;
;  ;; A simple branch
;
;
;
;  (define-djvm-operation (GOTO offset)
;    ---OTHER-PROPERTIES---
;    :assert (unsigned-short-value-p offset)
;    :branch-if t
;    :branch-target (+ offset Current-Instruction-Address)
;    :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
;                  "Invalid branch target")
;    :instruction-length 3)
;
;
;
;  ;; A conditional branch
;
;
;
;  (define-djvm-operation (IF_ACMPEQ offset)
;    ---STACK---
;    (:ref x)
;    (:ref y)
;    <rest-of-stack>
;    ==>
;    <rest-of-stack>
;    ---OTHER-PROPERTIES---
;    :assert (short-value-p offset)
;    :branch-if (= x y)
;    :branch-target (+ offset Current-Instruction-Address)
;    :instruction-length 3
;    :exceptions ( (not (djvm-valid-pc? (+ offset Current-Instruction-Address) djvm))
;                  "Invalid branch target"))
;
;
;
;  ;; A load
;
;
;
;  (define-djvm-operation (aload_0)
;    ---STACK---
;    <rest-of-stack>
;    ==>
;    (:ref x)
;    <rest-of-stack>
;
;
;
;    ---LOCALS---
;    (:local-var 0 (:ref x))
;    ==>
;    <unchanged>
;
;
;
;    ---OTHER-PROPERTIES---
;    :instruction-length 1)
;
;
;
;  ;; A store
;
;
;
;  (define-djvm-operation (astore index)
;    ---STACK---
;    (:ref x)
;    <rest-of-stack>
;    ==>
;    <rest-of-stack>
;
;
;
;    ---LOCALS---
;    <no-constraints>
;    ==>
;    (:local-var index (:ref x))
;
;
;
;    ---OTHER-PROPERTIES---
;    :assert (unsigned-byte-value-p index)
;    :instruction-length 2)
;
;
;
;  ;; More complex input/output patterns for the operand stack.
;
;
;
;  (define-djvm-operation (swap)
;    ---STACK---
;    (:one-word-type x)
;    (:one-word-type y)
;    <rest-of-stack>
;    ==>
;    (:same y)
;    (:same x)
;    <rest-of-stack>
;
;
;
;    ---OTHER-PROPERTIES---
;    :instruction-length 1)
;
;
;
;  (define-djvm-operation (dup)
;    ---STACK---
;    (:one-word-type x)
;    <rest-of-stack>
;    ==>
;    (:same x)
;    (:same x)
;    <rest-of-stack>
;
;
;
;    ---OTHER-PROPERTIES---
;    :instruction-length 1)
;
;
;
;  (define-djvm-operation (dup_x1)
;    ---STACK---
;    (:one-word-type x)                  ;TOP OF STACK
;    (:one-word-type y)
;    <rest-of-stack>
;    ==>
;    (:same x)                           ;TOP OF STACK
;    (:same y)
;    (:same x)
;    <rest-of-stack>
;
;
;
;    ---OTHER-PROPERTIES---
;    :instruction-length 1)
;
;
;
;  (define-djvm-operation (dup_x2)
;    ---STACK---
;    (:one-word-type x)
;    (:not-bot-half y)
;    (:not-top-half z)
;    <rest-of-stack>
;    ==>
;    (:same x)
;    (:same y)
;    (:same z)
;    (:same x)
;    <rest-of-stack>
;
;
;
;    ---OTHER-PROPERTIES---
;    :instruction-length 1)
