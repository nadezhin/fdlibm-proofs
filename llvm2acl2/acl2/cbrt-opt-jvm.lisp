(in-package "ACL2")
(include-book "fdlibm-translit")
(include-book "llvm-lemmas")
(include-book "cbrt")

(defruled logand-thm
  (implies (and (i32p x)
                (i32p y))
           (equal (logand x y)
                  (and-i32 x y)))
  :enable and-i32
  :disable logand)

(defruled logior-thm
  (implies (and (i32p x)
                (i32p y))
           (equal (logior x y)
                  (or-i32 x y)))
  :enable or-i32
  :disable logior)

(defruled logxor-thm
  (implies (and (i32p x)
                (i32p y))
           (equal (logxor x y)
                  (xor-i32 x y)))
  :enable xor-i32
  :disable logxor)

(defruled add-thm
  (implies (and (i32p x)
                (i32p y))
           (equal (m5::int-fix (+ x y))
                  (add-i32 x y)))
  :enable add-i32)

(defruled sdiv-thm
  (implies (and (i32p x)
                (i32p y)
                (not (= y 0)))
           (equal (m5::int-fix (truncate x y))
                  (sdiv-i32 x y)))
  :enable sdiv-i32
  :disable truncate)

(defruled fpadd-thm
  (implies (and (doublep x)
                (doublep y))
           (equal (m5::fpadd x y (rtl::dp))
                  (fadd-double x y)))
  :enable fadd-double
  :disable m5::fpadd)

(defruled fpsub-thm
  (implies (and (doublep x)
                (doublep y))
           (equal (m5::fpsub x y (rtl::dp))
                  (fsub-double x y)))
  :enable fsub-double
  :disable m5::fpsub)

(defruled fpmul-thm
  (implies (and (doublep x)
                (doublep y))
           (equal (m5::fpmul x y (rtl::dp))
                  (fmul-double x y)))
  :enable fmul-double
  :disable m5::fpmul)

(defruled fpdiv-thm
  (implies (and (doublep x)
                (doublep y))
           (equal (m5::fpdiv x y (rtl::dp))
                  (fdiv-double x y)))
  :enable fdiv-double
  :disable m5::fpdiv)

(defconst *cbrt-compute-program*
  (m5::method-program
   (m5::bound? "compute:(D)D"
               (m5::class-decl-methods
                (m5::bound? "FdlibmTranslit$Cbrt"
                            (m5::class-table *FdlibmTranslit-initial-state*))))))

(defund class-table-assumptions (ct)
   (and (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit$Cbrt" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit$Cbrt" (m5::class-table
                                                     *FdlibmTranslit-initial-state*))))
        (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit" (m5::class-table
                                              *FdlibmTranslit-initial-state*))))
        (equal (m5::class-decl-methods
                (m5::bound? "FdlibmTranslit" ct))
               (m5::class-decl-methods
                (m5::bound? "FdlibmTranslit" (m5::class-table
                                              *FdlibmTranslit-initial-state*))))
        (equal (m5::bound? "doubleToRawLongBits:(D)J"
                           (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" ct)))
               *doubleToRawLongBits-def*)
        (equal (m5::bound? "longBitsToDouble:(J)D"
                           (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" ct)))
               *longBitsToDouble-def*)))

(defrule class-table-opener
  (implies
   (class-table-assumptions ct)
   (and (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit$Cbrt" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit$Cbrt" (m5::class-table
                                                     *FdlibmTranslit-initial-state*))))
        (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslit" (m5::class-table
                                              *FdlibmTranslit-initial-state*))))
        (equal (m5::class-decl-methods
                (m5::bound? "FdlibmTranslit" ct))
               (m5::class-decl-methods
                (m5::bound? "FdlibmTranslit" (m5::class-table
                                              *FdlibmTranslit-initial-state*))))
        (equal (m5::bound? "doubleToRawLongBits:(D)J"
                           (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" ct)))
               *doubleToRawLongBits-def*)
        (equal (m5::bound? "longBitsToDouble:(J)D"
                           (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" ct)))
               *longBitsToDouble-def*)))
  :enable class-table-assumptions)

(defruled poised-to-invoke-get-lo-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(31))
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslit$Cbrt")
                (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s))))))
           (poised-to-invoke-get-lo-p th s))
  :enable poised-to-invoke-get-lo-p
  :disable m5::bound?)

(defruled poised-to-invoke-get-hi-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(4 71 156 208))
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslit$Cbrt")
                (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s))))))
           (poised-to-invoke-get-hi-p th s))
  :enable poised-to-invoke-get-hi-p
  :disable m5::bound?)

(defruled poised-to-invoke-set-lo-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(147))
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslit$Cbrt")
                (doublep (m5::top (m5::pop (m5::pop (m5::stack (m5::top-frame th s))))))
                (i32p (m5::top (m5::stack (m5::top-frame th s)))))
           (poised-to-invoke-set-lo-p th s))
  :enable poised-to-invoke-set-lo-p
  :disable m5::bound?)

(defruled poised-to-invoke-set-hi-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(42 56 79 95 161 214))
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslit$Cbrt")
                (doublep (m5::top (m5::pop (m5::pop (m5::stack (m5::top-frame th s))))))
                (i32p (m5::top (m5::stack (m5::top-frame th s)))))
           (poised-to-invoke-set-hi-p th s))
  :enable poised-to-invoke-set-hi-p
  :disable m5::bound?)

(defund ret-double (th s d)
  (m5::modify
   th s
   :stack (m5::push 0 (m5::push d (m5::stack (m5::top-frame th s))))))

(defruled ret-thm
  (implies
   (and (equal (m5::index-into-program (m5::pc frame) (m5::program frame))
               '(jvm::dreturn))
        (equal (m5::sync-flg frame) 'jvm::unlocked)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::step th
              (m5::modify
               th s
               :status 'jvm::scheduled
               :call-stack (m5::push frame (m5::call-stack th s))))
    (ret-double th s (m5::top (m5::pop (m5::stack frame))))))
  :enable ret-double
  :disable m5::bound?)

(defund sched_50 (th)
  (append
   (m5::repeat th 28)
   (set-lo-schedule th)
   (m5::repeat th 3)
   (get-hi-schedule th)
   (m5::repeat th 2)
   (set-hi-schedule th)
   (m5::repeat th 29)
   (get-hi-schedule th)
   (m5::repeat th 2)
   (set-hi-schedule th)
   (m5::repeat th 3)))

(defruled thm-50
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (i32p %sign.0)
        (doublep %t.5)
        (doublep %x.1)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_50 th)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    100
                    (list %x.1 nil %hx.1 nil nil nil nil %t.5 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%50-opt %sign.0 %t.5 %x.1))))
  :enable (sched_50 @cbrt-%50-opt
           poised-to-invoke-get-hi-thm
           poised-to-invoke-set-lo-thm
           poised-to-invoke-set-hi-thm
           logior-thm
           add-thm
           fpadd-thm
           fpsub-thm
           fpmul-thm
           fpdiv-thm
           ret-thm)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+))

(defund sched_44 (th)
  (append
   (m5::repeat th 6)
   (set-hi-schedule th)
   (m5::repeat th 1)
   (sched_50 th)))

(defruled thm-44
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (i32p %hx.1)
        (i32p %sign.0)
        (doublep %t.0)
        (doublep %x.1)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_44 th)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    87
                    (list %x.1 nil %hx.1 nil nil nil nil %t.0 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%44-opt %hx.1 %sign.0 %t.0 %x.1))))
  :enable (sched_44 @cbrt-%44-opt thm-50
           poised-to-invoke-set-hi-thm
           add-thm
           sdiv-thm)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund sched_31 (th)
  (append
   (m5::repeat th 2)
   (set-hi-schedule th)
   (m5::repeat th 7)
   (get-hi-schedule th)
   (m5::repeat th 4)
   (set-hi-schedule th)
   (m5::repeat th 2)
   (sched_50 th)))

(defruled thm-31
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (i32p %sign.0)
        (doublep %t.0)
        (doublep %x.1)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_31 th)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    52
                    (list %x.1 nil %hx.1 nil nil nil nil %t.0 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%31-opt %sign.0 %t.0 %x.1))))
  :enable (sched_31 @cbrt-%31-opt thm-50
           poised-to-invoke-get-hi-thm
           poised-to-invoke-set-hi-thm
           add-thm
           sdiv-thm
           fpmul-thm)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund sched_25 (th %hx.1)
  (append
   (m5::repeat th 2)
   (set-hi-schedule th)
   (m5::repeat th 4)
   (if (not (= (@cbrt-%25-cond %hx.1) 0))
       (sched_31 th)
     (sched_44 th))))

(defruled thm-25
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (i32p %hx.1)
        (i32p %sign.0)
        (doublep %t.0)
        (doublep %x.0)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_25 th %hx.1)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    40
                    (list %x.0 nil %hx.1 nil nil nil nil %t.0 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%25-opt %hx.1 %sign.0 %t.0 %x.0))))
  :enable (sched_25 @cbrt-%25-opt @cbrt-%25-cond thm-31 thm-44
                    poised-to-invoke-set-hi-thm icmp-slt-i32)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund sched_23 (th)
  (append
   (m5::repeat th 2)))

(defruled thm-23
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (doublep %x.0)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_23 th)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    38
                    (list %x.0 nil %hx.1 nil nil nil nil %t.0 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%23-opt %x.0))))
  :enable (sched_23 @cbrt-%23-opt ret-thm)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund sched_17 (th %hx.1 %x.0)
  (append
   (m5::repeat th 2)
   (get-lo-schedule th)
   (m5::repeat th 2)
   (if (not (= (@cbrt-%17-cond %hx.1 %x.0) 0))
       (sched_23 th)
     (sched_25 th %hx.1))))

(defruled thm-17
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (i32p %hx.1)
        (i32p %sign.0)
        (doublep %t.0)
        (doublep %x.0)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_17 th %hx.1 %x.0)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    29
                    (list %x.0 nil %hx.1 nil nil nil nil %t.0 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%17-opt %hx.1 %sign.0 %t.0 %x.0))))
  :enable (sched_17 @cbrt-%17-opt @cbrt-%17-cond thm-23 thm-25
                    poised-to-invoke-get-lo-thm
                    logior-thm icmp-eq-i32)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund sched_13 (th)
  (append
   (m5::repeat th 4)))

(defruled thm-13
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (doublep %x.0)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_13 th)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    25
                    (list %x.0 nil %hx.1 nil nil nil nil %t.0 nil nil nil %sign.0)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%13-opt %x.0))))
  :enable (sched_13 @cbrt-%13-opt fpadd-thm ret-thm)
  :disable (logior m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund sched_0 (th %x.0)
  (append
   (m5::repeat th 3)
   (get-hi-schedule th)
   (m5::repeat th 12)
   (if (not (= (@cbrt-%0-cond %x.0) 0))
       (sched_13 th)
     (sched_17 th (@cbrt-%0-hx1 %x.0) %x.0))))

(defrule update-nth-nil
  (implies (syntaxp (quotep n))
           (equal (update-nth n val nil)
                  (if (zp n)
                      (list val)
                    (cons nil (update-nth (1- n) val nil))))))

(defruled thm-0
  (implies
   (and (class-table-assumptions (m5::class-table s))
        (equal program *cbrt-compute-program*)
        (doublep %x.0)
        (equal (m5::status th s) 'jvm::scheduled))
   (equal
    (m5::run
     (sched_0 th %x.0)
     (m5::modify
      th s
      :status 'jvm::scheduled
      :call-stack (m5::push
                   (m5::make-frame
                    0
                    (list %x.0 nil)
                    ()
                    program
                    'm5::unlocked
                    "FdlibmTranslit$Cbrt")
                   (m5::call-stack th s))))
    (ret-double th s (@cbrt-%0-opt %x.0))))
  :enable (sched_0 @cbrt-%0-opt @cbrt-%0-cond @cbrt-%0-hx1 thm-13 thm-17
                    poised-to-invoke-get-hi-thm
                    logand-thm logxor-thm icmp-sge-i32)
  :disable (logior logxor m5::fpadd m5::fpsub m5::fpmul m5::fpdiv
                   m5::bound? commutativity-of-+ truncate))

(defund poised-to-invoke-cbrt-compute (th s)
  (and (m5::poised-to-invokestatic th s "FdlibmTranslit$Cbrt" "compute:(D)D" 2)
       (class-table-assumptions (m5::class-table s))
       (equal
        (m5::bound? "compute:(D)D"
                    (m5::class-decl-methods
                     (m5::bound? "FdlibmTranslit$Cbrt"
                                 (m5::class-table s))))
        (m5::bound? "compute:(D)D"
                    (m5::class-decl-methods
                     (m5::bound? "FdlibmTranslit$Cbrt"
                                 (m5::class-table *FdlibmTranslit-initial-state*)))))
       (null (m5::top (m5::stack (m5::top-frame th s))))
       (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s)))))))

(defund sched_cbrt (th s)
  (append
   (m5::repeat th 1)
   (sched_0 th (m5::top (m5::pop (m5::stack (m5::top-frame th s)))))))

(defrule cbrt-compute-thm
  (implies
   (poised-to-invoke-cbrt-compute th s)
   (equal
    (m5::run (sched_cbrt th s) s)
    (m5::modify
     th s
     :pc (+ 3 (m5::pc (m5::top-frame th s)))
     :stack (m5::push
             0
             (m5::push
              (@cbrt-opt (m5::top (m5::pop (m5::stack (m5::top-frame th s)))))
              (m5::pop (m5::pop (m5::stack (m5::top-frame th s)))))))))
  :enable (sched_cbrt poised-to-invoke-cbrt-compute ret-double @cbrt-opt)
  :disable m5::bound?
  :use (:instance thm-0
         (%x.0 (m5::top (m5::pop (m5::stack (m5::top-frame th s)))))
         (s (m5::modify
             th s
             :pc (+ 3 (m5::pc (m5::top-frame th s)))
             :stack (m5::pop (m5::pop (m5::stack (m5::top-frame th s))))))
         (program *cbrt-compute-program*)))

#|
(defund poised-inside-cbrt (th s)
  (and (m5::poised-to-invokestatic th s "FdlibmTranslit" "access$100:(D)I" 2)
       (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s)))))
       (equal (m5::class-decl-methods
               (m5::bound? "FdlibmTranslit"
                           (m5::class-table s)))
              (m5::class-decl-methods
               (m5::bound? "FdlibmTranslit"
                           (m5::class-table *FdlibmTranslit-initial-state*))))
       (equal (m5::retrieve-cp-entry "FdlibmTranslit" 5 (m5::class-table s))
              '(m5::methodref "FdlibmTranslit" "__LO:(D)I" 2))
       (equal (m5::retrieve-cp-entry "FdlibmTranslit" 29 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "doubleToRawLongBits:(D)J" 2))
       (equal (m5::bound? "doubleToRawLongBits:(D)J"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *doubleToRawLongBits-def*)))
|#
