; http://www.computationallogic.com/software/djvm/html-0.5/minor-utilities.html

(in-package "ACL2")

;Preliminary Definitions

;We define some simple, low-level functions and other preliminaries used in our other definitions.

;Guards

;ACL2 permits function definitions to have guards. The guards provide an assertion about the arguments of the function. In the logical ACL2 world we are obliged to prove that a function's guard is satisfied every time the function is called.

;The command (set-verify-guards-eagerness 2) instructs ACL2 to perform any required guard proofs as each function is defined. That is, each time a function is defined, each function call within the body of the definition is checked. If the called function has a guard, then a proof may be required to justify that the function call is proper. (Simple guards may not require a proof, but more complex guards generally do.)

;Extracting Slices of Lists

;These functions each extract a slice from a list of lists. strip-cars* extracts the first element of each sublist. strip-cadrs* extracts the second, and strip-caddrs* extracts the third.

(defun strip-cars* (x)
  (declare (xargs :guard (true-listp x)))
  (if (endp x)
      nil
    (if (consp (car x))
        (cons (caar x)
              (strip-cars* (cdr x)))
      (strip-cars* (cdr x)))))

(defun strip-cadrs* (x)
  (declare (xargs :guard (true-listp x)))
  (if (endp x)
      nil
    (if (and (consp (car x))
             (consp (cdar x)))
        (cons (cadar x)
              (strip-cadrs* (cdr x)))
      (strip-cadrs* (cdr x)))))

(defun strip-caddrs* (x)
  (declare (xargs :guard (true-listp x)))
  (if (endp x)
      nil
    (if (and (consp (car x))
             (consp (cdar x))
             (consp (cddar x)))
        (cons (caddar x)
              (strip-caddrs* (cdr x)))
      (strip-caddrs* (cdr x)))))

(defthm true-listp-string-listp
  (implies (string-listp x)
           (true-listp x)))

; Support functions for constructing new symbols

(defun flatten-to-symbols (arg)
  "An `improper' list flattener.  NIL is always flattened away."
  (declare (xargs :guard t))
  (cond ((atom arg) (cond ((null arg) nil)
                           ((symbolp arg) (list arg))
                           (t nil)))
        (t (append (flatten-to-symbols (car arg))
                   (flatten-to-symbols (cdr arg))))))

(defthm symbol-listp-flatten
  (symbol-listp (flatten-to-symbols x)))

(defthm true-listp-flatten
  (true-listp (flatten-to-symbols x)))

(defun string-append-list (flat-list)
  (declare (xargs :guard (symbol-listp flat-list)
                  :verify-guards t))
  (if (atom flat-list)
      "?atom?"
    (if (= 1 (len flat-list))
        (symbol-name (car flat-list))
      (string-append (string-append (symbol-name (car flat-list)) "-")
                     (string-append-list (cdr flat-list))))))

(defun flat-list-name (term)
  (declare (xargs :guard t))
  (string-append-list (flatten-to-symbols term)))

;When generating the ACL2 definitions, we need to create names for the new functions to be defined. In ACL2 functions take ``symbols'' as names. The ACL2 function intern-in-package-of-symbol creates a new symbol.Common Lisp has a mechanism of structured name-spaces, called ``packages.'' ACL2 shares a similar, but simplified notion. This definition of the dJVM does not use any features of the package mechanism. We presume that all symbols reside in ACL2's default package, named ACL2.

(defun make-a-symbol-internal (symbols symbol-in-package)
  (declare (xargs :guard (and (symbol-listp symbols)
                              (symbolp symbol-in-package))))
  (intern-in-package-of-symbol (flat-list-name symbols)
                               symbol-in-package))


(defmacro  make-a-symbol (symbols \&optional symbol-in-package)
  `(make-a-symbol-internal ,symbols ',(or symbol-in-package 'make-a-symbol)))

;Some General-Purpose Macros

;Def-Enumeration macro

;Given the form:
; (def-enumeration foo (bar baz :goo))
;this defines the encapsulation:
;
; (encapsulate ()
;   (defun foo-tags () '(bar baz :goo))
;
;   (defun foo-p (x) (not (null (member-equal x (foo-tags)))))
;
;   (defun bar (x) (equal x 'bar))
;
;   (defun baz (x) (equal x 'baz))
;
;   (defun goo (x) (equal x ':goo))
; )

(defun unkeyword (keyword non-keyword-symbol)
  "Intern the name of the symbol KEYWORD in the package
   of the symbol NON-KEYWORD-SYMBOL."
  (declare (xargs :guard (and (symbolp keyword)
                              (symbolp non-keyword-symbol))))
  (if (keywordp keyword)
      (intern-in-package-of-symbol (symbol-name keyword)
                                   non-keyword-symbol)
    keyword))

(defun expand-recognizers-list (name symbols-list)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp symbols-list))))
  (if (endp symbols-list)
      nil
    (let* ((tag (car symbols-list))
           (fn-name (unkeyword tag name)))
      (cons `(defun ,fn-name (x)
               (equal x (quote ,tag)))
            (expand-recognizers-list name (cdr symbols-list))))))

(defun expand-def-enumeration (name symbols-list)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp symbols-list))))
  (let ((list-name (intern-in-package-of-symbol
                    (flat-list-name (list name 'tags))
                    name))
        (recog-name (intern-in-package-of-symbol
                     (flat-list-name (list name 'p))
                     name)))
    (cons 'encapsulate
          (cons nil
                (cons `(defun ,list-name () (quote ,symbols-list))
                      (cons `(defun ,recog-name (x) (not (null (member-equal x ,(list list-name)))))
                            (expand-recognizers-list name symbols-list)))))))

(defmacro  def-enumeration (name arglist)
  (expand-def-enumeration name arglist))

;Given the form: (def-abstract-enumeration foo (bar baz goo)) this defines the encapsulation and defuns:
;
;  (encapsulate
;    ((bar () t)
;     (baz () t)
;     (goo () t))
;    (local (defun bar () 'bar))
;    (local (defun baz () 'baz))
;    (local (defun goo () 'goo))
;    (defthm foo-elements-unique
;      (and (not (equal (bar) (baz)))
;           (not (equal (bar) (goo)))
;           (not (equal (baz) (goo))))))
;
;  (defun foo? (x) (or (equal x (bar))
;                       (equal x (baz))
;                       (equal x (goo))))
;
;  (defun bar? (x) (equal x (bar)))
;  (defun baz? (x) (equal x (baz)))
;  (defun goo? (x) (equal x (goo)))

(defun make-name-question (term)
  (declare (xargs :guard t))
  (string-append (flat-list-name term) "?"))

(defun enumeration-signature-list (symbols-list)
  ;; Creates the signature list for the enumeration type elements.
  (declare (xargs :guard (symbol-listp symbols-list)))
  (if (endp symbols-list)
      nil
    (let ((name (car symbols-list)))
      (cons (list name nil t)
            (enumeration-signature-list (cdr symbols-list))))))

(defun elements-not-equal-listing (name lst)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp lst))))
  (if (endp lst)
      nil
    (cons `(not (equal (,name) (,(car lst))))
          (elements-not-equal-listing name (cdr lst)))))

(defun enumeration-elements-unique-list (symbols-list)
  (declare (xargs :guard (symbol-listp symbols-list)))
  (if (endp symbols-list)
      nil
    (if (endp (cdr symbols-list))
        nil
      (let ((name (car symbols-list)))
        (append (elements-not-equal-listing name (cdr symbols-list))
                (enumeration-elements-unique-list (cdr symbols-list)))))))

(defun enumeration-elements-unique-defthm (name symbols-list)
  ;; Creates the theorem saying that the elements of the enumeration
  ;; type are all distinct.
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp symbols-list))))
  (let ((thm-name (intern-in-package-of-symbol
                   (flat-list-name (list name 'elements-unique))
                   name)))
    (list 'defthm thm-name
          (cons 'and (enumeration-elements-unique-list symbols-list)))))

(defun expand-enumeration-local-defuns-list (symbols-list)
  ;; Create the list of local definitions of the elements of the
  ;; enumeration type.
  (declare (xargs :guard (symbol-listp symbols-list)))
  (if (endp symbols-list)
      nil
    (let ((name (car symbols-list)))
      (cons `(local (defun ,name () (quote ,name)))
            (expand-enumeration-local-defuns-list (cdr symbols-list))))))

(defun expand-def-enumeration-encapsulate (name symbols-list)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp symbols-list))))
  (cons 'encapsulate
        (cons (enumeration-signature-list symbols-list)
              (append (expand-enumeration-local-defuns-list symbols-list)
                      (list (enumeration-elements-unique-defthm name symbols-list))))))

(defun add-enumeration-recognizers (symbols-list)
  (declare (xargs :guard (symbol-listp symbols-list)))
  (if (endp symbols-list)
      nil
    (let* ((name (car symbols-list))
           (rec-name (intern-in-package-of-symbol
                      (make-name-question name) ;;(flat-list-name (list name 'p))
                      name)))
      (cons `(defun ,rec-name (x) (equal x (,name)))
            (add-enumeration-recognizers (cdr symbols-list))))))

(defun make-enumeration-type-recognizer-body (symbols-list)
  (declare (xargs :guard (symbol-listp symbols-list)))
  (if (endp symbols-list)
      nil
    (let ((name (car symbols-list)))
      (cons `(equal x (,name))
            (make-enumeration-type-recognizer-body (cdr symbols-list))))))

(defun make-enumeration-type-recognizer (rec-name symbols-list)
  (declare (xargs :guard (and (symbolp rec-name)
                              (symbol-listp symbols-list))))
  (list 'defun rec-name '(x)
        (cons 'or (make-enumeration-type-recognizer-body symbols-list))))

(defun expand-enumeration-with-recognizers (name symbols-list)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp symbols-list))))
  (let ((rec-name (intern-in-package-of-symbol
                   (make-name-question name)
                   name)))
    `(ld (quote ,(cons (expand-def-enumeration-encapsulate name symbols-list)
                       (cons (make-enumeration-type-recognizer rec-name symbols-list)
                             (add-enumeration-recognizers symbols-list)))))))

(defmacro  def-abstract-enumeration (name arglist)
  (expand-enumeration-with-recognizers name arglist))

; Def-Recognizer Macro

; The Def-Recognizer macro introduces an undefined predicate/recognizer into the logic, along with the single axiom that the predicate/recognizer is boolean-valued.
;
;First we define several support functions for constructing new symbols, and then the Def-Recognizer macro itself.

(defun flatten-to-symbols (arg)
  "An `improper' list flattener.  NIL is always flattened away."
  (declare (xargs :guard t))
  (cond ((atom arg) (cond ((null arg) nil)
                           ((symbolp arg) (list arg))
                           (t nil)))
        (t (append (flatten-to-symbols (car arg))
                   (flatten-to-symbols (cdr arg))))))

(defthm symbol-listp-flatten
  (symbol-listp (flatten-to-symbols x)))

(defthm true-listp-flatten
  (true-listp (flatten-to-symbols x)))

(defun string-append-list (flat-list)
  (declare (xargs :guard (symbol-listp flat-list)
                  :verify-guards t))
  (if (atom flat-list)
      "?atom?"
    (if (= 1 (len flat-list))
        (symbol-name (car flat-list))
      (string-append (string-append (symbol-name (car flat-list)) "-")
                     (string-append-list (cdr flat-list))))))

(defun flat-list-name (term)
  (declare (xargs :guard t))
  (string-append-list (flatten-to-symbols term)))

(defun expand-def-recognizer (name arglist)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp arglist))))
  (let ((thm-name (intern-in-package-of-symbol
                   (flat-list-name (list 'booleanp name))
                   name)))
    `(encapsulate ((,name ,arglist t))
                  (local (defun ,name ,arglist
                           (declare (ignore ,@arglist))
                           t))
                  (defthm ,thm-name
                    (or (equal (,name ,@arglist) t)
                        (equal (,name ,@arglist) nil))
                    :rule-classes :type-prescription))))

(defmacro  def-recognizer (name arglist)
  (expand-def-recognizer name arglist))

; Def-Recognizer-For-Non-Empty-Set macro

;The macro DEF-RECOGNIZER-FOR-NON-EMPTY-SET is just like DEF-RECOGNIZER except that it asserts the existence of at least one object satisfying the recognizer. This is useful if we wish to assert in later encapsulates some properties of these entities.
;
;For recognizer FOO?, we define the constant-function SOME-FOO to be recognized by FOO?.

(defun expand-def-recognizer-for-non-empty-set (name arglist)
  (declare (xargs :guard (and (symbolp name)
                              (symbol-listp arglist))))
  (let ((witness   (intern-in-package-of-symbol
                    (flat-list-name (list 'some name))
                    name))
        (thm-name1 (intern-in-package-of-symbol
                    (flat-list-name (list name 'booleanp))
                    name))
        (thm-name2 (intern-in-package-of-symbol
                    (flat-list-name (list 'some name name))
                    name)))
    `(encapsulate ((,name ,arglist t)
                   (,witness nil t))
                  (local (defun ,name ,arglist
                           (declare (ignore ,@arglist))
                           t))
                  (local (defun ,witness nil
                           0))
                  (defthm ,thm-name1
                    (or (equal (,name ,@arglist) t)
                        (equal (,name ,@arglist) nil))
                    :rule-classes :type-prescription)
                  (defthm ,thm-name2
                    (,name (,witness))))))

(defmacro  def-recognizer-for-non-empty-set (name arglist)
  (expand-def-recognizer-for-non-empty-set name arglist))

; Equal-Case macro

;Usage:
;
; (equal-case (Foo x)
;             (case (Selector x)
;               (a (Foo-A x))
;               (b (Foo-B x))
;               ...
;               (otherwise (Bad-Foo x))))
;
;expands to:
;
; (and (implies (equal (Selector x) 'a)
;               (equal (Foo x) (Foo-A x)))
;      (implies (equal (Selector x) 'b)
;               (equal (Foo x) (Foo-B x))))

(defun expand-thm-case-equal (lhs selector cases)
  (DECLARE (XARGS :GUARD (AND (true-listp cases)
                              (LEGAL-CASE-CLAUSESP cases))))
  (if (or (atom cases)
          (equal (car (car cases))
                 'otherwise))
      nil
    (cons `(implies (equal ,selector ',(car (car cases)))
                    (equal ,lhs
                           ,(cadr (car cases))))
          (expand-thm-case-equal lhs selector (cdr cases)))))

(defmacro  thm-case-equal (lhs selector \&rest cases)
  (DECLARE (XARGS :GUARD (AND (true-listp cases)
                              (LEGAL-CASE-CLAUSESP cases))))
  `(and ,@(expand-thm-case-equal lhs selector cases)))

(defun thm-case-p (form)
  (declare (xargs :guard t))
  (and (true-listp form)
       (or (equal 'thm-case (car form))
           (equal 'case (car form)))
       (legal-case-clausesp (cddr form))))

(defun embed-lhs-in-thm-case (lhs thm-case)
  (declare (xargs :guard (thm-case-p thm-case)))
  (let ((selector (cadr thm-case))
        (cases (cddr thm-case)))
    `(and ,@(expand-thm-case-equal lhs selector cases))))

(defmacro  equal-case (lhs thm-case)
  (DECLARE (XARGS :GUARD (thm-case-p thm-case)))
  (embed-lhs-in-thm-case lhs thm-case))

; Here's an example of an EASY OPENER lemma. Presume we have a definition such as the function djvm-do below, that contains a (possibly large) case statement.
;
; (defun djvm-do (instruction djvm)
;   "Handle instruction-dispatch for dJVM."
;   (declare (xargs :guard (and (dJVM-p dJVM)
;                               (instruction-p instruction))))
;   (case (opcode instruction)
;     (iadd     (dJVM-do-iadd     instruction   dJVM))
;     (fadd     (dJVM-do-fadd     instruction   dJVM))
;     (ladd     (dJVM-do-ladd     instruction   dJVM))
;     (pop      (dJVM-do-pop      instruction   dJVM))
;     (pop2     (dJVM-do-pop2     instruction   dJVM))
;     ;; ... more instructions ...
;     (halt     (dJVM-do-halt     instruction   dJVM))
;     (otherwise (dJVM-unknown-instruction dJVM instruction))))
;
;We don't want this function definition to be expanded in our proofs unless it's likely to be useful. We can define ``opener'' lemmas to control the expansion or ``opening'' of such definitions. If we define the lemma below and disable the definition of dJVM-do in the theorem prover, then the definition will only be opened in cases in which we know the opcode of the instruction being executed. (This behavior does depend on instruction-p and opcode being defined suitably.)
;
; (defthm dJVM-do-easy-opener
;   (implies (and (dJVM-p dJVM)
;                 (instruction-p instruction))
;            (equal-case (dJVM-do instruction dJVM)
;                        (case (opcode instruction)
;                          (iadd     (dJVM-do-iadd     instruction   dJVM))
;                          (fadd     (dJVM-do-fadd     instruction   dJVM))
;                          (ladd     (dJVM-do-ladd     instruction   dJVM))
;                          (pop      (dJVM-do-pop      instruction   dJVM))
;                          (pop2     (dJVM-do-pop2     instruction   dJVM))
;                          ;; ... more instructions ...
;                          (halt     (dJVM-do-halt     instruction   dJVM))
;                          (otherwise
;                                 (dJVM-unknown-instruction dJVM instruction))))))
;
;Here's what the opener lemma above would look like without equal-case:
;
; (defthm dJVM-do-opener
;  ;; When dJVM-do is disabled, this will only open it up
;  ;; when we have an explicit operation.
;   (implies (and (dJVM-p dJVM)
;                 (instruction-p instruction))
;            (and (implies (equal (opcode instruction) 'iadd)
;                          (equal (dJVM-do instruction dJVM)
;                                 (dJVM-do-iadd instruction dJVM)))
;                 (implies (equal (opcode instruction) 'fadd)
;                          (equal (dJVM-do instruction dJVM)
;                                 (dJVM-do-fadd instruction dJVM)))
;                 (implies (equal (opcode instruction) 'ladd)
;                          (equal (dJVM-do instruction dJVM)
;                                 (dJVM-do-ladd instruction dJVM)))
;                 (implies (equal (opcode instruction) 'pop)
;                          (equal (dJVM-do instruction dJVM)
;                                 (dJVM-do-pop instruction dJVM)))
;                 (implies (equal (opcode instruction) 'pop2)
;                          (equal (dJVM-do instruction dJVM)
;                                 (dJVM-do-pop2 instruction dJVM)))
;                 (implies (equal (opcode instruction) 'halt)
;                          (equal (dJVM-do instruction dJVM)
;                                 (dJVM-do-halt instruction dJVM))))))

; thm-case macro
;
;Here's an example of thm-case usage. The same lemma is stated twice below, once using thm-case and once without using it. The lemma new-stk-sig-opener is more concise and readable than old-stk-sig-opener without the use of thm-case.
;
; (defthm new-stk-sig-opener
;   ;; When dJVM-new-stk-sig is disabled, this will only open it
;   ;; up when we have an explicit opcode.
;   ;; Note:  We don't open this up for HALT?!
;   (implies (and (stk-sig? sig)
;                 (instruction-p instr))
;            (thm-case (opcode instr)
;              (iadd (equal (new-stk-sig instr sig)
;                           (dJVM-iadd-stk-sig  sig)))
;              (fadd (equal (new-stk-sig instr sig)
;                           (dJVM-fadd-stk-sig  sig)))
;              (ladd (equal (new-stk-sig instr sig)
;                           (dJVM-ladd-stk-sig  sig)))
;              (pop  (equal (new-stk-sig instr sig)
;                           (dJVM-pop-stk-sig   sig)))
;              (pop2 (equal (new-stk-sig instr sig)
;                           (dJVM-pop2-stk-sig  sig))))))
;
; (defthm old-stk-sig-opener
;   (implies (and (stk-sig? sig)
;                 (instruction-p instr))
;            (and (implies (equal (opcode instr) 'iadd)
;                          (equal (new-stk-sig  instr sig)
;                                 (dJVM-iadd-stk-sig sig)))
;                 (implies (equal (opcode instr) 'fadd)
;                          (equal (new-stk-sig  instr sig)
;                                 (dJVM-fadd-stk-sig sig)))
;                 (implies (equal (opcode instr) 'ladd)
;                          (equal (new-stk-sig  instr sig)
;                                 (dJVM-ladd-stk-sig sig)))
;                 (implies (equal (opcode instr) 'pop)
;                          (equal (new-stk-sig instr sig)
;                                 (dJVM-pop-stk-sig sig)))
;                 (implies (equal (opcode instr) 'pop2)
;                          (equal (new-stk-sig  instr sig)
;                                 (dJVM-pop2-stk-sig sig))))))

(defun expand-thm-case (selector cases)
  (DECLARE (XARGS :GUARD (AND (true-listp cases)
                              (LEGAL-CASE-CLAUSESP cases))))
  (if (atom cases)
      nil
    (cons `(implies (equal ,selector ',(car (car cases)))
                    ,(cadr (car cases)))
          (expand-thm-case selector (cdr cases)))))

(defmacro  thm-case (selector \&rest cases)
  (DECLARE (XARGS :GUARD (AND (true-listp cases)
                              (LEGAL-CASE-CLAUSESP cases))))
  `(and ,@(expand-thm-case selector cases)))



