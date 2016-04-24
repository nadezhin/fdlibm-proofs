(in-package "ACL2")
(include-book "fdlibm-translitN")
(include-book "llvm-lemmas")
(include-book "llvms/s_cbrt")

(defrule update-nth-nil
  (implies (syntaxp (quotep n))
           (equal (update-nth n val nil)
                  (if (zp n)
                      (list val)
                    (cons nil (update-nth (1- n) val nil))))))

(defrule load-double-same-store-double
  (implies (doublep val)
           (equal (load-double (cons v 0) (store-double val (cons v 0) mem))
                  val))
  :enable (load-double store-double))

(defrule load-double-diff-store-double
  (implies (not (equal (car adr1) (car adr2)))
           (equal (load-double adr1 (store-double val adr2 mem))
                  (load-double adr1 mem)))
  :enable (load-double store-double))

(defrule load-double-diff-store-i32
  (implies (not (equal (car adr1) (car adr2)))
           (equal (load-double adr1 (store-i32 val adr2 mem))
                  (load-double adr1 mem)))
  :enable (load-double store-i32))

(defrule load-i32-same-store-i32
  (implies (i32p val)
           (equal (load-i32 (cons v 0) (store-i32 val (cons v 0) mem))
                  val))
  :enable (load-i32 store-i32))

(defrule load-i32-diff-store-i32
  (implies (not (equal (car adr1) (car adr2)))
           (equal (load-i32 adr1 (store-i32 val adr2 mem))
                  (load-i32 adr1 mem)))
  :enable (load-i32 store-i32))

(defrule load-i32-diff-store-double
  (implies (not (equal (car adr1) (car adr2)))
           (equal (load-i32 adr1 (store-double val adr2 mem))
                  (load-i32 adr1 mem)))
  :enable (load-i32 store-double))

(defrule load-i32-lv-0
  (implies (doublep (load-double (cons lv 0) mem))
           (equal (load-i32 (cons lv 0) mem)
                  (get-lo (load-double (cons lv 0) mem))))
  :enable (get-lo load-double load-i32))

(defrule load-i32-lv-1
  (implies (doublep (load-double (cons lv 0) mem))
           (equal (load-i32 (cons lv 1) mem)
                  (get-hi (load-double (cons lv 0) mem))))
  :enable (get-hi load-double load-i32))

(defrule store-i32-lv-0
  (implies (and (doublep (load-double (cons lv 0) mem))
                (i32p i))
           (equal (load-double (cons lv 0) (store-i32 i (cons lv 0) mem))
                  (set-lo (load-double (cons lv 0) mem) i)))
  :enable (set-lo load-double store-i32))

(defrule store-i32-lv-1
  (implies (and (doublep (load-double (cons lv 0) mem))
                (i32p i))
           (equal (load-double (cons lv 0) (store-i32 i (cons lv 1) mem))
                  (set-hi (load-double (cons lv 0) mem) i)))
  :enable (set-hi load-double store-i32)
  :expand (update-nth 1 (get-lo-i32 i) (load-var lv mem)))

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

(defruled fpadd-thm
  (implies (and (doublep x)
                (doublep y))
           (equal (m5::fpadd x y (rtl::dp))
                  (fadd-double x y)))
  :enable fadd-double
  :disable m5::fpadd)

;----------------------

(defnd @cbrt-local-vars-p (loc)
  (and (equal (g '%1 loc) '(ret . 0))
       (equal (g '%2 loc) '(x . 0))
       (equal (g '%hx loc) '(hx . 0))
       (equal (g '%r loc) '(r . 0))
       (equal (g '%s loc) '(s . 0))
       (equal (g '%t loc) '(t . 0))
       (equal (g '%w loc) '(w . 0))
       (equal (g '%sign loc) '(sign . 0))))

(defrule @cbrt-local-vars
  (implies (@cbrt-local-vars-p loc)
           (and (equal (g '%1 loc) '(ret . 0))
                (equal (g '%2 loc) '(x . 0))
                (equal (g '%hx loc) '(hx . 0))
                (equal (g '%r loc) '(r . 0))
                (equal (g '%s loc) '(s . 0))
                (equal (g '%t loc) '(t . 0))
                (equal (g '%w loc) '(w . 0))
                (equal (g '%sign loc) '(sign . 0))))
  :enable @cbrt-local-vars-p)

(defrule @cbrt-local-vars-s
  (implies (and (@cbrt-local-vars-p loc)
                (not (member key '(%1 %2 %hx %r %s %t %w %sign))))
           (@cbrt-local-vars-p (s key val loc)))
  :enable @cbrt-local-vars-p)

;--------------------

(defrule class-table-of-step
  (equal (m5::class-table (m5::step th s))
         (m5::class-table s))
  :enable m5::step)

(defconst *cbrt-compute-program*
  (m5::method-program
   (m5::bound? "compute:(D)D"
               (m5::class-decl-methods
                (m5::bound? "FdlibmTranslitN$Cbrt"
                            (m5::class-table *FdlibmTranslitN-initial-state*))))))

(defund cbrt-compute-program-p (program)
  (equal program *cbrt-compute-program*))

(defrule index-into-cbrt-compute-program
  (implies (cbrt-compute-program-p program)
           (equal (m5::index-into-program byte-offset program)
                  (m5::index-into-program byte-offset *cbrt-compute-program*)))
  :enable cbrt-compute-program-p)

(defund class-table-assumptions (ct)
   (and (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN$Cbrt" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN$Cbrt" (m5::class-table
                                                    *FdlibmTranslitN-initial-state*))))
        (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN" (m5::class-table
                                               *FdlibmTranslitN-initial-state*))))
        (equal (m5::class-decl-methods
                (m5::bound? "FdlibmTranslitN" ct))
               (m5::class-decl-methods
                (m5::bound? "FdlibmTranslitN" (m5::class-table
                                               *FdlibmTranslitN-initial-state*))))
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
                (m5::bound? "FdlibmTranslitN$Cbrt" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN$Cbrt" (m5::class-table
                                                    *FdlibmTranslitN-initial-state*))))
        (equal (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN" ct))
               (m5::class-decl-cp
                (m5::bound? "FdlibmTranslitN" (m5::class-table
                                               *FdlibmTranslitN-initial-state*))))
        (equal (m5::class-decl-methods
                (m5::bound? "FdlibmTranslitN" ct))
               (m5::class-decl-methods
                (m5::bound? "FdlibmTranslitN" (m5::class-table
                                               *FdlibmTranslitN-initial-state*))))
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
                (cbrt-compute-program-p (m5::program (m5::top-frame th s)))
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslitN$Cbrt")
                (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s))))))
           (poised-to-invoke-get-lo-p th s))
  :enable poised-to-invoke-get-lo-p
  :disable m5::bound?)

(defruled poised-to-invoke-get-hi-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(4 71 156 208))
                (cbrt-compute-program-p (m5::program (m5::top-frame th s)))
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslitN$Cbrt")
                (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s))))))
           (poised-to-invoke-get-hi-p th s))
  :enable poised-to-invoke-get-hi-p
  :disable m5::bound?)

(defruled poised-to-invoke-set-lo-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(147))
                (cbrt-compute-program-p (m5::program (m5::top-frame th s)))
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslitN$Cbrt")
                (doublep (m5::top (m5::pop (m5::pop (m5::stack (m5::top-frame th s))))))
                (i32p (m5::top (m5::stack (m5::top-frame th s)))))
           (poised-to-invoke-set-lo-p th s))
  :enable poised-to-invoke-set-lo-p
  :disable m5::bound?)

(defruled poised-to-invoke-set-hi-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(42 56 79 95 161 214))
                (cbrt-compute-program-p (m5::program (m5::top-frame th s)))
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslitN$Cbrt")
                (doublep (m5::top (m5::pop (m5::pop (m5::stack (m5::top-frame th s))))))
                (i32p (m5::top (m5::stack (m5::top-frame th s)))))
           (poised-to-invoke-set-hi-p th s))
  :enable poised-to-invoke-set-hi-p
  :disable m5::bound?)

(defund ret-double (th s d)
  (m5::modify
   th s
   :stack (m5::push2 d (m5::stack (m5::top-frame th s)))))

;-----------------------

(defund pair-double-p (mem lv locals jv)
  (let ((d (load-double (cons lv 0) mem)))
    (implies d
             (and (doublep d)
                  (equal (nth jv locals) d)))))

(defruled pair-double-thm
  (implies (and (pair-double-p mem lv locals jv)
                (doublep (load-double (cons lv 0) mem)))
           (equal (nth jv locals)
                  (load-double (cons lv 0) mem)))
  :enable pair-double-p)

(defruled pair-double-same-store-double
  (implies (pair-double-p mem lv locals jv)
           (pair-double-p (store-double d (cons lv 0) mem)
                          lv
                          (update-nth jv d locals)
                          jv))
  :enable (pair-double-p load-double store-double))

(defruled pair-double-diff-store-double
  (implies (and (pair-double-p mem lv locals jv)
                (natp jv)
                (natp jv1)
                (not (equal lv lv1))
                (not (equal jv jv1)))
           (pair-double-p (store-double d (cons lv1 0) mem)
                          lv
                          (update-nth jv1 d locals)
                          jv))
  :enable (pair-double-p load-double))

(defruled pair-double-diff-store-i32
  (implies (and (pair-double-p mem lv locals jv)
                (natp jv)
                (natp jv1)
                (not (equal lv lv1))
                (not (equal jv jv1)))
           (pair-double-p (store-i32 i (cons lv1 0) mem)
                          lv
                          (update-nth jv1 i locals)
                          jv))
  :enable (pair-double-p load-double store-i32))

(defund pair-i32-p (mem lv locals jv)
  (let ((i (load-i32 (cons lv 0) mem)))
    (implies i
             (and (i32p i)
                  (equal (nth jv locals) i)))))

(defruled pair-i32-thm
  (implies (and (pair-i32-p mem lv locals jv)
                (i32p (load-i32 (cons lv 0) mem)))
           (equal (nth jv locals)
                  (load-i32 (cons lv 0) mem)))
  :enable pair-i32-p)

(defruled pair-i32-same-store-i32
  (implies (pair-i32-p mem lv locals jv)
           (pair-i32-p (store-i32 i (cons lv 0) mem)
                       lv
                       (update-nth jv i locals)
                       jv))
  :enable (pair-i32-p load-i32 store-i32))

(defruled pair-i32-diff-store-i32
  (implies (and (pair-i32-p mem lv locals jv)
                (natp jv)
                (natp jv1)
                (not (equal lv lv1))
                (not (equal jv jv1)))
           (pair-i32-p (store-i32 i (cons lv1 0) mem)
                       lv
                       (update-nth jv1 i locals)
                       jv))
  :enable (pair-i32-p load-i32 store-i32))

(defruled pair-i32-diff-store-double
  (implies (and (pair-i32-p mem lv locals jv)
                (natp jv)
                (natp jv1)
                (not (equal lv lv1))
                (not (equal jv jv1)))
           (pair-i32-p (store-double d (cons lv1 0) mem)
                       lv
                       (update-nth jv1 d locals)
                       jv))
  :enable (pair-i32-p load-i32 store-double))

(defund pair-p (mem locals)
  (and (pair-double-p mem 'x locals 0)
       (pair-i32-p mem 'hx locals 2)
       (pair-double-p mem 'r locals 3)
       (pair-double-p mem 's locals 5)
       (pair-double-p mem 't locals 7)
       (pair-double-p mem 'w locals 9)
       (pair-i32-p mem 'sign locals 11)))

(defrule pair-store-double-ret
  (implies
   (pair-p mem locals)
   (pair-p (store-double d '(ret . 0) mem)
           locals))
  :enable (pair-p pair-double-p pair-i32-p))

(defrule pair-x
  (implies (and (pair-p mem locals)
                (doublep (load-double '(x . 0) mem)))
           (equal (nth 0 locals)
                  (load-double '(x . 0) mem)))
  :enable pair-p
  :use (:instance pair-double-thm (lv 'x) (jv 0)))

(defrule pair-store-double-x
  (implies
   (pair-p mem locals)
   (pair-p (store-double d '(x . 0) mem)
           (update-nth 0 d locals)))
  :enable (pair-p pair-double-same-store-double
                  pair-double-diff-store-double
                  pair-i32-diff-store-double)
  :disable update-nth)

(defrule pair-hx
  (implies (and (pair-p mem locals)
                (i32p (load-i32 '(hx . 0) mem)))
           (equal (nth 2 locals)
                  (load-i32 '(hx . 0) mem)))
  :enable pair-p
  :use (:instance pair-i32-thm (lv 'hx) (jv 2)))

(defrule pair-store-i32-hx
  (implies
   (pair-p mem locals)
   (pair-p (store-i32 i '(hx . 0) mem)
            (update-nth 2 i locals)))
  :enable (pair-p pair-i32-same-store-i32
                  pair-i32-diff-store-i32
                  pair-double-diff-store-i32))

(defrule pair-r
  (implies (and (pair-p mem locals)
                (doublep (load-double '(r . 0) mem)))
           (equal (nth 3 locals)
                  (load-double '(r . 0) mem)))
  :enable pair-p
  :use (:instance pair-double-thm (lv 'r) (jv 3)))

(defrule pair-store-double-r
  (implies
   (pair-p mem locals)
   (pair-p (store-double d '(r . 0) mem)
           (update-nth 3 d locals)))
  :enable (pair-p pair-double-same-store-double
                  pair-double-diff-store-double
                  pair-i32-diff-store-double)
  :disable update-nth)

(defrule pair-s
  (implies (and (pair-p mem locals)
                (doublep (load-double '(s . 0) mem)))
           (equal (nth 5 locals)
                  (load-double '(s . 0) mem)))
  :enable pair-p
  :use (:instance pair-double-thm (lv 's) (jv 5)))

(defrule pair-store-double-s
  (implies
   (pair-p mem locals)
   (pair-p (store-double d '(s . 0) mem)
           (update-nth 5 d locals)))
  :enable (pair-p pair-double-same-store-double
                  pair-double-diff-store-double
                  pair-i32-diff-store-double)
  :disable update-nth)

(defrule pair-t
  (implies (and (pair-p mem locals)
                (doublep (load-double '(t . 0) mem)))
           (equal (nth 7 locals)
                  (load-double '(t . 0) mem)))
  :enable pair-p
  :use (:instance pair-double-thm (lv 't) (jv 7)))

(defrule pair-store-double-t
  (implies
   (pair-p mem locals)
   (pair-p (store-double d '(t . 0) mem)
           (update-nth 7 d locals)))
  :enable (pair-p pair-double-same-store-double pair-double-diff-store-double pair-i32-diff-store-double))

(defrule pair-w
  (implies (and (pair-p mem locals)
                (doublep (load-double '(w . 0) mem)))
           (equal (nth 9 locals)
                  (load-double '(w . 0) mem)))
  :enable pair-p
  :use (:instance pair-double-thm (lv 'w) (jv 9)))

(defrule pair-store-double-w
  (implies
   (pair-p mem locals)
   (pair-p (store-double d '(w . 0) mem)
           (update-nth 9 d locals)))
  :enable (pair-p pair-double-same-store-double
                  pair-double-diff-store-double
                  pair-i32-diff-store-double)
  :disable update-nth)

(defrule pair-sign
  (implies (and (pair-p mem locals)
                (i32p (load-i32 '(sign . 0) mem)))
           (equal (nth 11 locals)
                  (load-i32 '(sign . 0) mem)))
  :enable pair-p
  :use (:instance pair-i32-thm (lv 'sign) (jv 11)))

(defrule pair-store-i32-sign
  (implies
   (pair-p mem locals)
   (pair-p (store-i32 i '(sign . 0) mem)
           (update-nth 11 i locals)))
  :enable (pair-p pair-i32-same-store-i32
                  pair-i32-diff-store-i32
                  pair-double-diff-store-i32))

;------------------

(defund initial-s0 (x)
  (list *cbrt-globals* (s '%x x ()) nil))

(defund initial-s (sb th x)
  (let* ((frame (m5::make-frame
                 0
                 (list x nil)
                 ()
                 *cbrt-compute-program*
                 'm5::unlocked
                 "FdlibmTranslitN$Cbrt")))
    (m5::modify
     th sb
     :status 'jvm::scheduled
     :call-stack (m5::push frame (m5::call-stack th sb)))))

(defund alpha (mem loc sb th s pc)
  (let ((frame (m5::top-frame th s)))
    (and (@cbrt-local-vars-p loc)
         (pair-p mem (m5::locals frame))
         (class-table-assumptions (m5::class-table s))
         (equal (m5::status th s) 'm5::scheduled)
         (equal (m5::modify th s :call-stack (m5::pop (m5::call-stack th s))) sb)
         (equal (m5::pc frame) pc)
         (cbrt-compute-program-p (m5::program frame))
         (equal (m5::sync-flg frame) 'jvm::unlocked)
         (equal (m5::cur-class frame) "FdlibmTranslitN$Cbrt"))))

(defrule class-table-of-sb-when-alpha
  (implies (alpha mem loc sb th s pc)
           (equal (m5::class-table s)
                  (m5::class-table sb)))
  :enable alpha)

(defrule status-of-sb-when-alpha
  (implies (alpha mem loc sb th s pc)
           (equal (m5::status th s)
                  (m5::status th sb)))
  :enable alpha)

(defruled ret-thm-when-alpha
  (implies
   (and (alpha mem loc sb th s pc)
        (member pc '(28 39 221)))
   (equal
    (m5::step th s)
    (ret-double th sb (m5::top2 (m5::stack (m5::top-frame th s))))))
  :enable (alpha ret-double)
  :disable m5::bound?)

(defrule g-1-when-alpha
  (implies (alpha mem loc sb th s pc)
           (equal (g '%1 loc) '(ret . 0)))
  :enable alpha)

(defruled ttt-%0-m0.1
  (b* (
    (loc (@cbrt-%sign-loc (initial-s0 x)))
    (mem (@cbrt-m0.1-mem (initial-s0 x)))
    (s (initial-s sb th x))
    (fixed-sb (m5::modify th sb :call-stack (m5::call-stack th sb) :status 'm5::scheduled)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (alpha mem loc fixed-sb th s 0)
          (doublep (load-double '(x . 0) mem)))))
  :enable (alpha initial-s0 initial-s pair-p
           pair-double-p store-double load-double
           pair-i32-p load-i32
           @cbrt-local-vars-p
           @cbrt-%0-mem
           @cbrt-%0-loc
           @cbrt-%1-mem
           @cbrt-%1-loc
           @cbrt-%2-mem
           @cbrt-%2-loc
           @cbrt-%hx-mem
           @cbrt-%hx-loc
           @cbrt-%r-mem
           @cbrt-%r-loc
           @cbrt-%s-mem
           @cbrt-%s-loc
           @cbrt-%t-mem
           @cbrt-%t-loc
           @cbrt-%w-mem
           @cbrt-%w-loc
           @cbrt-%sign-mem
           @cbrt-%sign-loc
           @cbrt-m0.1-mem))

(defund sched-m0.2 (th)
  (m5::repeat th 2))

(defruled ttt-%0-m0.2
  (b* (
    (loc (@cbrt-%sign-loc (initial-s0 x)))
    (mem (@cbrt-m0.2-mem (initial-s0 x)))
    (s (m5::run (sched-m0.2 th) (initial-s sb th x)))
    (fixed-sb (m5::modify th sb :call-stack (m5::call-stack th sb) :status 'm5::scheduled)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (alpha mem loc fixed-sb th s 3)
          (doublep (load-double '(x . 0) mem))
          (doublep (load-double '(t . 0) mem)))))
  :enable (alpha @cbrt-m0.2-mem sched-m0.2)
  :use ttt-%0-m0.1)

(defund sched-m0.3 (th)
  (append (sched-m0.2 th)
          (m5::repeat th 1)
          (get-hi-schedule th)
          (m5::repeat th 1)))

(defrule ttt-%0-m0.3
  (b* (
    (loc (@cbrt-%5-loc (initial-s0 x)))
    (mem (@cbrt-m0.3-mem (initial-s0 x)))
    (s (m5::run (sched-m0.3 th) (initial-s sb th x)))
    (fixed-sb (m5::modify th sb :call-stack (m5::call-stack th sb) :status 'm5::scheduled)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (alpha mem loc fixed-sb th s 8)
          (doublep (load-double '(x . 0) mem))
          (i32p (load-i32 '(hx . 0) mem))
          (doublep (load-double '(t . 0) mem)))))
  :enable (alpha sched-m0.3 poised-to-invoke-get-hi-thm
    @cbrt-%3-loc @cbrt-%3-val
    @cbrt-%4-loc @cbrt-%4-val
    @cbrt-%5-loc @cbrt-%5-val
    @cbrt-m0.3-mem)
  :use ttt-%0-m0.2)

(defund sched-m0.4 (th)
  (append (sched-m0.3 th)
          (m5::repeat th 4)))

(defrule ttt-%0-m0.4
  (b* (
    (loc (@cbrt-%7-loc (initial-s0 x)))
    (mem (@cbrt-m0.4-mem (initial-s0 x)))
    (s (m5::run (sched-m0.4 th) (initial-s sb th x)))
    (fixed-sb (m5::modify th sb :call-stack (m5::call-stack th sb) :status 'm5::scheduled)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (alpha mem loc fixed-sb th s 14)
          (doublep (load-double '(x . 0) mem))
          (i32p (load-i32 '(hx . 0) mem))
          (doublep (load-double '(t . 0) mem))
          (i32p (load-i32 '(sign . 0) mem)))))
  :enable (alpha sched-m0.4 logand-thm
    @cbrt-%6-loc @cbrt-%6-val
    @cbrt-%7-loc @cbrt-%7-val
    @cbrt-m0.4-mem)
  :disable m5::bound?
  :use ttt-%0-m0.3)

(defund sched-m0.5 (th)
  (append (sched-m0.4 th)
          (m5::repeat th 4)))

(defrule ttt-%0-m0.5
  (b* (
    (loc (@cbrt-%10-loc (initial-s0 x)))
    (mem (@cbrt-m0.5-mem (initial-s0 x)))
    (s (m5::run (sched-m0.5 th) (initial-s sb th x)))
    (fixed-sb (m5::modify th sb :call-stack (m5::call-stack th sb) :status 'm5::scheduled)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (alpha mem loc fixed-sb th s 19)
          (doublep (load-double '(x . 0) mem))
          (i32p (load-i32 '(hx . 0) mem))
          (doublep (load-double '(t . 0) mem))
          (i32p (load-i32 '(sign . 0) mem)))))
  :enable (alpha sched-m0.5 logxor-thm
    @cbrt-%8-loc @cbrt-%8-val
    @cbrt-%9-loc @cbrt-%9-val
    @cbrt-%10-loc @cbrt-%10-val
    @cbrt-m0.5-mem)
  :disable logxor
  :use ttt-%0-m0.4)

(defund sched-succ0 (th)
  (append (sched-m0.5 th)
          (m5::repeat th 3)))

(defrule ttt-%0-succ0
  (b* (
    (loc (@cbrt-%12-loc (initial-s0 x)))
    (mem (@cbrt-m0.5-mem (initial-s0 x)))
    (lab (@cbrt-succ0-lab (initial-s0 x)))
    (s (m5::run (sched-succ0 th) (initial-s sb th x)))
    (fixed-sb (m5::modify th sb :call-stack (m5::call-stack th sb) :status 'm5::scheduled)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (alpha mem loc fixed-sb th s (case lab (%13 25) (%17 29)))
          (member lab '(%13 %17))
          (doublep (load-double '(x . 0) mem))
          (i32p (load-i32 '(hx . 0) mem))
          (doublep (load-double '(t . 0) mem))
          (i32p (load-i32 '(sign . 0) mem)))))
  :enable (alpha sched-succ0 icmp-sge-i32
    @cbrt-%11-loc @cbrt-%11-val
    @cbrt-%12-loc @cbrt-%12-val
    @cbrt-succ0-lab)
  :disable m5::bound?
  :use ttt-%0-m0.5)

;----------------------------

(defund sched-m13.1 (th)
  (m5::repeat th 3))

(defrule ttt-%13-m13.1
  (b* (
    (s13 (list mem13 loc13 '%0))
    (loc (@cbrt-%16-loc s13))
    (mem (@cbrt-m13.1-mem s13))
    (s (m5::run (sched-m13.1 th) s-old)))
    (implies
     (and (alpha mem13 loc13 sb th s-old 25)
          (doublep (load-double '(x . 0) mem13)))
     (and (alpha mem loc sb th s 28)
          (doublep (load-double '(ret . 0) mem))
          (equal (m5::top2 (m5::stack (m5::top-frame th s)))
                 (load-double '(ret . 0) mem)))))
  :enable (alpha sched-m13.1 fpadd-thm
    @cbrt-%13-mem @cbrt-%13-loc
    @cbrt-%14-loc @cbrt-%14-val
    @cbrt-%15-loc @cbrt-%15-val
    @cbrt-%16-loc @cbrt-%16-val
    @cbrt-m13.1-mem)
  :disable m5::fpadd)

(defund sched-succ13 (th)
  (append (sched-m13.1 th)
          (m5::repeat th 1)))

(defrule ttt-%13-succ13
  (b* (
    (s13 (list mem13 loc13 '%0))
    (loc (@cbrt-%16-loc s13))
    (mem (@cbrt-m13.1-mem s13))
    (lab (@cbrt-succ13-lab s13))
    (s (m5::run (sched-succ13 th) s-old)))
    (implies
     (and (alpha mem13 loc13 sb th s-old 25)
          (doublep (load-double '(x . 0) mem13)))
     (and (equal lab '%101)
          (equal (g '%1 loc) '(ret . 0))
          (doublep (load-double '(ret . 0) mem))
          (equal s (ret-double th sb (load-double '(ret . 0) mem))))))
  :enable (sched-succ13 ret-thm-when-alpha
                 @cbrt-succ13-lab)
  :use ttt-%13-m13.1)

;--------------------------------

(defund sched-succ17 (th)
  (append (m5::repeat th 2)
          (get-lo-schedule th)
          (m5::repeat th 2)))

(defrule ttt-%17-succ17
  (b* (
    (s17 (list mem17 loc17 '%0))
    (loc (@cbrt-%22-loc s17))
    (mem (@cbrt-%17-mem s17))
    (lab (@cbrt-succ17-lab s17))
    (s (m5::run (sched-succ17 th) s-old)))
    (implies
     (and (alpha mem17 loc17 sb th s-old 29)
          (i32p (load-i32 '(hx . 0) mem17))
          (doublep (load-double '(t . 0) mem17))
          (i32p (load-i32 '(sign . 0) mem17))
          (doublep (load-double '(x . 0) mem17)))
     (and (alpha mem loc sb th s (case lab (%23 38) (%25 40)))
          (member lab '(%23 %25))
          (doublep (load-double '(x . 0) mem))
          (i32p (load-i32 '(hx . 0) mem))
          (doublep (load-double '(t . 0) mem))
          (i32p (load-i32 '(sign . 0) mem)))))
  :enable (alpha sched-succ17 poised-to-invoke-get-lo-thm logior-thm icmp-eq-i32
    @cbrt-%17-loc @cbrt-%17-mem
    @cbrt-%18-loc @cbrt-%18-val
    @cbrt-%19-loc @cbrt-%19-val
    @cbrt-%20-loc @cbrt-%20-val
    @cbrt-%21-loc @cbrt-%21-val
    @cbrt-%22-loc @cbrt-%22-val
    @cbrt-succ17-lab)
  :disable logior)

;--------------------------------

(defund sched-m23.1 (th)
  (m5::repeat th 1))

(defrule ttt-%23-m23.1
  (b* (
    (s23 (list mem23 loc23 '%0))
    (loc (@cbrt-%24-loc s23))
    (mem (@cbrt-m23.1-mem s23))
    (s (m5::run (sched-m23.1 th) s-old)))
    (implies
     (and (alpha mem23 loc23 sb th s-old 38)
          (doublep (load-double '(x . 0) mem23)))
     (and (alpha mem loc sb th s 39)
          (doublep (load-double '(ret . 0) mem))
          (equal (m5::top2 (m5::stack (m5::top-frame th s)))
                 (load-double '(ret . 0) mem)))))
  :enable (alpha sched-m23.1
    @cbrt-%23-mem @cbrt-%23-loc
    @cbrt-%24-loc @cbrt-%24-val
    @cbrt-m23.1-mem))

(defund sched-succ23 (th)
  (append (sched-m23.1 th)
          (m5::repeat th 1)))

(defrule ttt-%23-succ23
  (b* (
    (s23 (list mem23 loc23 '%0))
    (loc (@cbrt-%24-loc s23))
    (mem (@cbrt-m23.1-mem s23))
    (lab (@cbrt-succ23-lab s23))
    (s (m5::run (sched-succ23 th) s-old)))
    (implies
     (and (alpha mem23 loc23 sb th s-old 38)
          (doublep (load-double '(x . 0) mem23)))
     (and (equal lab '%101)
          (equal (g '%1 loc) '(ret . 0))
          (doublep (load-double '(ret . 0) mem))
          (equal s (ret-double th sb (load-double '(ret . 0) mem))))))
  :enable (sched-succ23 ret-thm-when-alpha
    @cbrt-succ23-lab)
  :use ttt-%23-m23.1)

;------------------------------

;--------------------------------

(defund sched-succ101 (th)
  (m5::repeat th 0))

(defrule ttt-%101-succ101
  (b* (
    (s101 (list mem101 loc101 pred))
    (mem (@cbrt-%101-mem s101))
    (loc (@cbrt-%102-loc s101))
    (lab (@cbrt-succ101-lab s101))
    (s (m5::run (sched-succ101 th) s-old)))
    (implies
     (and (equal (g '%1 loc) '(ret . 0))
          (doublep (load-double '(ret . 0) mem))
          (equal s (ret-double th sb (load-double '(ret . 0) mem))))
     (and (equal lab 'ret)
          (doublep (g '%102 loc))
          (equal s (ret-double th sb (g '%102 loc))))))
  :enable (sched-succ101
    @cbrt-%101-loc @cbrt-%101-mem
    @cbrt-%102-loc @cbrt-%102-val
    @cbrt-succ101-lab))
