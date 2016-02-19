; http://www.computationallogic.com/software/djvm/html-0.5/tableswitch.html

(in-package "ACL2")
(include-book "data-structures/deflist" :dir :system)
(include-book "define-inst-macro")

; tableswitch instruction

;The tableswitch and lookupswitch instructions are not simple enough to be defined using the define-djvm-instruction macro. However, they are still ``simple instructions'' in the sense that they do not depend on the heap. Hence, they are included in this chapter.

;The tableswitch instruction is a relative branch instruction that uses a branch table. The instruction takes four arguments:
;
;    Default branch offset (default)
;    Minimum index value (low)
;    Maximum index value (high)
;    A list of branch offsets

;The branch offsets and the high and low index values are all of type int. Branch offsets are all considered relative to the address of the tableswitch instruction. The list of branch offsets and the default branch offset must each identify the address of an instruction in the current method. Both high and low must be int values and low high. The list must contain high-low+1 entries.

;The top of the operand stack should contain an int value, called the index value. If the index value is within the (inclusive) range indicated by the instruction arguments, then the branch displacement is the index-low^{th} entry in the list of branch offsets (using 0-origin indexing). If either index<low or index>high, then the default branch offset is used.

;In the class file, a tableswitch instruction includes 0-3 bytes of ``padding,'' so that the instruction arguments begin at a byte address divisible by four. This padding is not represented in the dJVM instruction format.

;Form of tableswitch instruction:
;
;
;  (tableswitch default low high branch-offsets)

(deflist int-value-listp (l)
  int-value-p)

(verify-guards int-value-listp)

(in-theory (disable int-value-listp-true-listp))

(defun tableswitch-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (instruction-p inst)
       (equal (car inst) 'tableswitch)
       (true-listp inst)
       (equal (len inst) 5)
       (let ((default (second inst))
             (low     (third  inst))
             (high    (fourth inst))
             (targets (fifth  inst)))
         (and (int-value-p default)
              (int-value-p low)
              (int-value-p high)
              (<= low high)
              (true-listp targets)
              (= (length targets) (1+ (- high low)))
              (int-value-listp targets)))))

(defthm acl2-numberp-int-value-p
  (implies (int-value-p x)
           (acl2-numberp x)))

(defthm integerp-int-value-p
  (implies (int-value-p x)
           (integerp x)))

(defun impossible ()
  (declare (xargs :guard nil))
  nil)

(defun tableswitch-value (index low high default targets)
  (declare (xargs :guard (and (int-value-p index)
                              (int-value-p low)
                              (int-value-p high)
                              (int-value-p default)
                              (int-value-listp targets)
                              (<= low high)
                              (<= (1+ (- high low)) (len targets)))
                  :guard-hints (("Goal"
                                 :in-theory (enable int-value-listp-true-listp)))))
  (if (and (<= low index)
           (<= index high))
      (if (and (<= 0 (- index low))
               (< (- index low) (len targets)))
          (nth (- index low) targets)
        (impossible))
    default))

(defthm int-value-p-tableswitch-value
  (implies (and (int-value-p index)
                (int-value-p low)
                (int-value-p high)
                (int-value-p default)
                (int-value-listp targets)
                (<= low high)
                (= (length targets) (1+ (- high low))))
           (int-value-p (tableswitch-value index low high default targets))))

(in-theory (disable tableswitch-value))

(defun tableswitch-proper-arg-types? (inst frame)
  (declare (xargs :guard (and (instruction-p inst)
                              (frame-p frame)))
           (ignore inst))
  (and (non-empty (frame-stack frame))
       (tv-int-p (car (frame-stack frame)))))

(defun djvm-execute-tableswitch-optimized (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (tableswitch-wff-inst? inst)
                              (tableswitch-proper-arg-types? inst
                                                      (current-frame djvm)))))
  (if (non-empty (frame-stack (current-frame djvm)))
      (let ((default (second inst))
            (low     (third  inst))
            (high    (fourth inst))
            (targets (fifth  inst))
            (top-of-stack (tv-val (car (frame-stack (car (djvm-stack djvm)))))))
        (Let ((delta (tableswitch-value top-of-stack
                                        low
                                        high
                                        default
                                        targets)))
             (if (djvm-valid-pc? (+ delta (djvm-cia djvm)) djvm)
                 (djvm-set-pc (+ delta (djvm-cia djvm))
                              (djvm-pop-operand djvm))
               (djvm-error "Invalid target in tableswitch" 'tableswitch djvm))))
    (djvm-error "Empty operand stack" 'tableswitch djvm)))


(defthm djvm-p-execute-tableswitch-optimized
  (implies (force (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (tableswitch-wff-inst? inst)
                       (tableswitch-proper-arg-types? inst (current-frame djvm))))
           (djvm-p (djvm-execute-tableswitch-optimized inst djvm))))

(defthm weak-djvm-p-execute-tableswitch-optimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (tableswitch-wff-inst? inst)
                (tableswitch-proper-arg-types? inst (current-frame djvm)))
           (weak-djvm-p (djvm-execute-tableswitch-optimized inst djvm)))
  :hints (("Goal" :in-theory '((:type-prescription djvm-p)
                               (:type-prescription defs-djvm-assertions . 3)
                               (:type-prescription tableswitch-wff-inst?)
                               (:type-prescription weak-djvm-p)
                               (:rewrite weak-djvm-p-if-djvm-p)
                               (:rewrite djvm-p-execute-tableswitch-optimized)))))

(defthm tableswitch-optimized-preserves-current-method
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (equal (frame-method (car (djvm-stack
                                      (djvm-execute-tableswitch-optimized
                                                       instruction djvm))))
                  (frame-method (car (djvm-stack djvm))))))

(in-theory (disable djvm-execute-tableswitch-optimized))

(defun true-2 (x y)
  (declare (ignore x y)
           (xargs :guard t))
  t)

(defun identity-2 (x y)
  (declare (ignore x)
           (xargs :guard t))
  y)

(define-defensive-instruction  djvm-execute-tableswitch
  tableswitch-wff-inst?
  tableswitch-proper-arg-types?
  identity-2
  true-2
  djvm-execute-tableswitch-optimized
  true-2
  :instruction-length 0)

(defthm djvm-p-djvm-execute-tableswitch
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-tableswitch inst djvm))))

(in-theory (disable djvm-execute-tableswitch))

; lookupswitch instruction

; The instruction lookupswitch takes three arguments:
;
;    default, an int value
;    npairs, a non-negative int value
;    match-offset pairs, a list of int-value-pairs

; The match-offset pairs of a lookupswitch instruction must be sorted in increasing numerical order by match.

; Note on JVM Semantics: The JVMS does not specify the order of the int values in the match-offset pairs. Because they are referred to as ``match-offset pairs,'' we presume that pairs are ordered with the match value as the first component, and the offset value as the second component.
; (See [p. 300-301 in JVMS])

;The dJVM form of lookupswitch instruction is
;
;
;            (lookupswitch default npairs pairs)
;
;where default, npairs, and pairs are the arguments described above.

;We first define functions to recognize well-formed match-offset pairs, and then build the standard pieces of an instruction definition.

(defun int-value-pair? (x)
  (declare (xargs :guard t))
  (and (consp x)
       (int-value-p (car x))
       (consp (cdr x))
       (int-value-p (cadr x))
       (null (cddr x))))

(deflist int-value-pair-listp (l)
  int-value-pair?)

(verify-guards int-value-pair-listp)

(in-theory (disable int-value-pair-listp-true-listp))

(defun pair-match (x)
  (declare (xargs :guard (int-value-pair? x)))
  (first x))

(defun pair-offset (x)
  (declare (xargs :guard (int-value-pair? x)))
  (second x))

(defun sorted-int-value-pair-listp (x)
  (declare (xargs :guard t))
  (and (int-value-pair-listp x)
       (if (or (endp x)
               (endp (cdr x)))
           t
         (and (< (pair-match (car x))
                 (pair-match (cadr x)))
              (sorted-int-value-pair-listp (cdr x))))))

(defun lookupswitch-wff-inst? (inst)
  (declare (xargs :guard t))
  (and (instruction-p inst)
       (equal (car inst) 'lookupswitch)
       (true-listp inst)
       (equal (len inst) 4)
       (let ((default (second inst))
             (npairs  (third  inst))
             (pairs   (fourth inst)))
         (and (int-value-p default)
              (int-value-p npairs)
              (<= 0 npairs)
              (true-listp pairs)
              (= (len pairs) npairs)
              (sorted-int-value-pair-listp pairs)))))

(defun lookupswitch-value (key default pairs)
  (declare (xargs :guard (and (int-value-p key)
                              (int-value-p default)
                              (sorted-int-value-pair-listp pairs))))
  (if (endp pairs)
      default
    (if (equal key (pair-match (car pairs)))
        (pair-offset (car pairs))
      (lookupswitch-value key default (cdr pairs)))))

(defthm int-value-p-lookupswitch-value
  (implies (and (int-value-p key)
                (int-value-p default)
                (sorted-int-value-pair-listp pairs))
           (int-value-p (lookupswitch-value key default pairs))))

(in-theory (disable lookupswitch-value))

(defun lookupswitch-proper-arg-types? (inst frame)
  (declare (xargs :guard (and (instruction-p inst)
                              (frame-p frame)))
           (ignore inst))
  (and (non-empty (frame-stack frame))
       (tv-int-p (car (frame-stack frame)))))

(defun djvm-execute-lookupswitch-optimized (inst djvm)
  (declare (xargs :guard (and (instruction-p inst)
                              (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (lookupswitch-proper-arg-types? inst
                                                              (current-frame djvm))
                              (lookupswitch-wff-inst? inst)
                              )))
  (if (non-empty (frame-stack (current-frame djvm)))
      (let ((default (second inst))
            (npairs  (third  inst))
            (pairs   (fourth inst))
            (top-of-stack (tv-val (car (frame-stack (car (djvm-stack djvm)))))))
        (declare (ignore npairs))
        (Let ((delta (lookupswitch-value top-of-stack
                                         default
                                         pairs)))
             (if (djvm-valid-pc? (+ delta (djvm-pc djvm)) djvm)
                 (djvm-increment-pc delta
                                    (djvm-pop-operand djvm))
               (djvm-error "Invalid target in lookupswitch" 'lookupswitch djvm))))
    (djvm-error "Empty operand stack" 'lookupswitch djvm)))

(defthm djvm-p-execute-lookupswitch-optimized
  (implies (force (and (djvm-p djvm)
                       (non-empty (djvm-stack djvm))
                       (lookupswitch-wff-inst? inst)))
           (djvm-p (djvm-execute-lookupswitch-optimized inst djvm))))

(defthm lookupswitch-optimized-preserves-current-method
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (equal (frame-method (car (djvm-stack
                                      (djvm-execute-lookupswitch-optimized
                                                          instruction djvm))))
                  (frame-method (car (djvm-stack djvm))))))

(in-theory (disable djvm-execute-lookupswitch-optimized))

(defthm weak-djvm-p-execute-lookupswitch-optimized
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (lookupswitch-wff-inst? inst))
           (weak-djvm-p (djvm-execute-lookupswitch-optimized inst djvm)))
  :hints (("Goal" :use DJVM-P-EXECUTE-LOOKUPSWITCH-OPTIMIZED)))

(define-defensive-instruction  djvm-execute-lookupswitch
  lookupswitch-wff-inst?
  lookupswitch-proper-arg-types?
  identity-2
  identity-2
  djvm-execute-lookupswitch-optimized
  identity-2
  :instruction-length 0)

(defthm djvm-p-execute-lookupswitch-2
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-execute-lookupswitch inst djvm)))
  :hints (("Goal" :in-theory (enable djvm-execute-lookupswitch))))

(include-book "data-structures/defalist" :dir :system)
(in-theory (disable djvm-execute-lookupswitch))
