; http://www.computationallogic.com/software/djvm/html-0.5/run-djvm.html

(in-package "ACL2")
(include-book "getstatic")
(include-book "invokespecial")
(include-book "invokestatic")
(include-book "method-returns")
(include-book "simple-instructions-a-h")
(include-book "simple-instructions-h-i")
(include-book "simple-instructions-j-z")
(include-book "tableswitch")

; Top-level Interpreter \& Initial dJVM States

; We are now ready to define the top-level of the dJVM interpreter. First we define djvm-do-inst, which dispatches an instruction based on its opcode. Then we define djvm-step, which fetches the instruction referenced by the pc and invokes djvm-do-inst. Finally we define djvm-run, which repeatedly calls djvm-step until the computation halts or runs out of time.

(defun djvm-do-inst (inst djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (instruction-p inst)
                              (java-bytecode-method-p
                               (frame-method (car (djvm-stack djvm)))))))
  (case (op-code inst)



    (aconst_null        (djvm-execute-aconst_null inst djvm))
    (aload              (djvm-execute-aload       inst djvm))
    (aload_0            (djvm-execute-aload_0     inst djvm))
    (aload_1            (djvm-execute-aload_1     inst djvm))
    (aload_2            (djvm-execute-aload_2     inst djvm))
    (aload_3            (djvm-execute-aload_3     inst djvm))
    (aload_wide         (djvm-execute-aload_wide  inst djvm))
    (areturn            (djvm-execute-areturn     inst djvm))
    (astore             (djvm-execute-astore      inst djvm))
    (astore_0           (djvm-execute-astore_0    inst djvm))
    (astore_1           (djvm-execute-astore_1    inst djvm))
    (astore_2           (djvm-execute-astore_2    inst djvm))
    (astore_3           (djvm-execute-astore_3    inst djvm))
    (astore_wide        (djvm-execute-astore_wide inst djvm))
    (bipush             (djvm-execute-bipush      inst djvm))
    (dup                (djvm-execute-dup         inst djvm))
    (dup2               (djvm-execute-dup2        inst djvm))
    (dup2_x1            (djvm-execute-dup2_x1     inst djvm))
    #+NOT-YET-INCLUDED
    (dup2_x2            (djvm-execute-dup2_x2     inst djvm))
    (dup_x1             (djvm-execute-dup_x1      inst djvm))
    (dup_x2             (djvm-execute-dup_x2      inst djvm))


    (getfield           (djvm-execute-getfield    inst djvm))
    (getstatic          (djvm-execute-getstatic   inst djvm))
    (goto               (djvm-execute-goto        inst djvm))
    (goto_w             (djvm-execute-goto_w      inst djvm))


    (i2l                (djvm-execute-i2l         inst djvm))
    (i2s                (djvm-execute-i2s         inst djvm))
    (iadd               (djvm-execute-iadd        inst djvm))
    (iand               (djvm-execute-iand        inst djvm))
    (iconst_0           (djvm-execute-iconst_0    inst djvm))
    (iconst_1           (djvm-execute-iconst_1    inst djvm))
    (iconst_2           (djvm-execute-iconst_2    inst djvm))
    (iconst_3           (djvm-execute-iconst_3    inst djvm))
    (iconst_4           (djvm-execute-iconst_4    inst djvm))
    (iconst_5           (djvm-execute-iconst_5    inst djvm))
    (iconst_m1          (djvm-execute-iconst_m1   inst djvm))
    (idiv               (djvm-execute-idiv        inst djvm))


    (if_acmpeq          (djvm-execute-if_acmpeq   inst djvm))
    (if_acmpne          (djvm-execute-if_acmpne   inst djvm))
    (if_icmpeq          (djvm-execute-if_icmpeq   inst djvm))
    (if_icmpge          (djvm-execute-if_icmpge   inst djvm))
    (if_icmpgt          (djvm-execute-if_icmpgt   inst djvm))
    (if_icmple          (djvm-execute-if_icmple   inst djvm))
    (if_icmplt          (djvm-execute-if_icmplt   inst djvm))
    (if_icmpne          (djvm-execute-if_icmpne   inst djvm))
    (ifeq               (djvm-execute-ifeq        inst djvm))
    (ifge               (djvm-execute-ifge        inst djvm))
    (ifgt               (djvm-execute-ifgt        inst djvm))
    (ifle               (djvm-execute-ifle        inst djvm))
    (iflt               (djvm-execute-iflt        inst djvm))
    (ifne               (djvm-execute-ifne        inst djvm))
    (ifnonnull          (djvm-execute-ifnonnull   inst djvm))
    (ifnull             (djvm-execute-ifnull      inst djvm))


    (iinc               (djvm-execute-iinc        inst djvm))
    (iload              (djvm-execute-iload       inst djvm))
    (iload_0            (djvm-execute-iload_0     inst djvm))
    (iload_1            (djvm-execute-iload_1     inst djvm))
    (iload_2            (djvm-execute-iload_2     inst djvm))
    (iload_3            (djvm-execute-iload_3     inst djvm))
    (iload_wide         (djvm-execute-iload_wide  inst djvm))
    (imul               (djvm-execute-imul        inst djvm))
    (ineg               (djvm-execute-ineg        inst djvm))


    (invokespecial      (djvm-execute-invokespecial inst djvm))
    (invokestatic       (djvm-execute-invokestatic  inst djvm))
    (invokevirtual      (djvm-execute-invokevirtual inst djvm))


    (ior                (djvm-execute-ior         inst djvm))
    (ireturn            (djvm-execute-ireturn     inst djvm))
    (istore             (djvm-execute-istore      inst djvm))
    (istore_0           (djvm-execute-istore_0    inst djvm))
    (istore_1           (djvm-execute-istore_1    inst djvm))
    (istore_2           (djvm-execute-istore_2    inst djvm))
    (istore_3           (djvm-execute-istore_3    inst djvm))
    (isub               (djvm-execute-isub        inst djvm))


    (l2i                (djvm-execute-l2i         inst djvm))
    (ladd               (djvm-execute-ladd        inst djvm))
    (land               (djvm-execute-land        inst djvm))
    (lcmp               (djvm-execute-lcmp        inst djvm))
    (lconst_0           (djvm-execute-lconst_0    inst djvm))
    (lconst_1           (djvm-execute-lconst_1    inst djvm))
    (ldiv               (djvm-execute-ldiv        inst djvm))
    (lload              (djvm-execute-lload       inst djvm))
    (lload_0            (djvm-execute-lload_0     inst djvm))
    (lload_1            (djvm-execute-lload_1     inst djvm))
    (lload_2            (djvm-execute-lload_2     inst djvm))
    (lload_3            (djvm-execute-lload_3     inst djvm))
    (lload_wide         (djvm-execute-lload_wide  inst djvm))
    (lookupswitch       (djvm-execute-lookupswitch inst djvm))
    (lstore             (djvm-execute-lstore      inst djvm))
    (lstore_0           (djvm-execute-lstore_0    inst djvm))
    (lstore_1           (djvm-execute-lstore_1    inst djvm))
    (lstore_2           (djvm-execute-lstore_2    inst djvm))
    (lstore_3           (djvm-execute-lstore_3    inst djvm))
    (lstore_wide        (djvm-execute-lstore_wide inst djvm))


    (new                (djvm-execute-new         inst djvm))
    (nop                (djvm-execute-nop         inst djvm))
    (pop                (djvm-execute-pop         inst djvm))
    (pop2               (djvm-execute-pop2        inst djvm))
    (putfield           (djvm-execute-putfield    inst djvm))
    (putstatic          (djvm-execute-putstatic    inst djvm))
    (return             (djvm-execute-return      inst djvm))
    (sipush             (djvm-execute-sipush      inst djvm))
    (swap               (djvm-execute-swap        inst djvm))
    (tableswitch        (djvm-execute-tableswitch inst djvm))



    ;; Add more instructions here...



    (otherwise (djvm-error "Unrecognized instruction" inst djvm))))

(defthm djvm-p-djvm-do-inst
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm))
                (instruction-p inst)
                (java-bytecode-method-p
                 (frame-method (car (djvm-stack djvm)))))
           (djvm-p (djvm-do-inst inst djvm))))

(in-theory (disable djvm-do-inst))

(defun fetch-method-instruction (frame)
  "Fetch the next instruction to be executed the call-frame FRAME."
  (declare (xargs :guard (and (frame-p frame)
                              (java-bytecode-method-p (frame-method frame)))))
  (let ((pc (frame-pc frame))
        (body (java-method-body (frame-method frame))))
    (if (and (bytecode-body-p body)
             (bound? pc body))
        (binding pc body)
      `(halt "Invalid PC encountered" ,pc))))

(defun djvm-next-instruction (djvm)
  "Fetch the next instruction to be executed in state DJVM."
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (java-bytecode-method-p
                               (frame-method (current-frame djvm))))))
  (fetch-method-instruction (current-frame djvm)))

; The cia register holds the ``current instruction address.'' This is updated just before each instruction is executed.

(defun frame-update-cia (frame)
  (declare (xargs :guard (frame-p frame)))
  (set-frame-cia (frame-pc frame) frame))

(defmacro  djvm-set-current-frame (new-frame djvm)
  `(set-djvm-stack (cons ,new-frame
                        (cdr (djvm-stack djvm)))
                   ,djvm))

(defun djvm-update-cia (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm)))))
  (djvm-set-current-frame (frame-update-cia (current-frame djvm))
                          djvm))

(defun djvm-running-p (djvm-status)
  (declare (xargs :guard t))
  (equal djvm-status ':running))

(defun djvm-step (djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (non-empty (djvm-stack djvm))
                              (java-bytecode-method-p
                               (frame-method (car (djvm-stack djvm)))))))
  (if (djvm-running-p (djvm-status djvm))
      (if (djvm-valid-pc? (djvm-pc djvm) djvm)
          (let ((inst (djvm-next-instruction djvm)))
            (if (instruction-p inst)
                ;; Update the current instruction address before executing the instruction.
                (djvm-do-inst inst (djvm-update-cia djvm))
              (set-djvm-status "Attempt to execute an undefined instruction." djvm)))
        (set-djvm-status "PC is not a valid instruction address." djvm))
    djvm))

(defthm djvm-p-djvm-step
  (implies (and (djvm-p djvm)
                (non-empty (djvm-stack djvm)))
           (djvm-p (djvm-step djvm))))

(in-theory (disable djvm-p-djvm-step))


;The function djvm-run is the top-level interpreter for the dJVM. Given a dJVM state, it will sequentially execute the next n instructions. ACL2 requires that all of our function definitions yield functions that terminate for every function call. ACL2 does not admit functions that are infinitely recursive. The function djvm-run step-counter takes the parameter n as a ``step counter.'' djvm-run is guaranteed to terminate within n steps, sooner if the computation halts. Since n may be arbitrarily large, we can still perform any finite computation.

(defun djvm-run (n djvm)
  (declare (xargs :guard (and (djvm-p djvm)
                              (naturalp n))))
  (if (zp n)
      djvm
    (if (and (non-empty (djvm-stack djvm))
             (equal ':running (djvm-status djvm)))
        (if (java-bytecode-method-p (frame-method (car (djvm-stack djvm))))
            (djvm-run (1- n) (djvm-step djvm))
          (set-djvm-status "Attempt to execute an unimplemented native method." djvm))
      djvm)))

(defthm djvm-p-djvm-run
  (implies (djvm-p djvm)
           (djvm-p (djvm-run n djvm))))
