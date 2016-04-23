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
  :expand (update-nth 1 (get-lo-i32 i) (cdr (assoc-equal lv mem))))

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

(defnd @cbrt-mem-p (mem)
  (and (true-listp mem)
       (equal (len mem) 8)
       (true-listp (nth 0 mem))
       (equal (len (nth 0 mem)) 3)
       (equal (car (nth 0 mem)) 'ret)
       (true-listp (nth 1 mem))
       (equal (len (nth 1 mem)) 3)
       (equal (car (nth 1 mem)) 'x)
       (true-listp (nth 2 mem))
       (equal (len (nth 2 mem)) 2)
       (equal (car (nth 2 mem)) 'hx)
       (true-listp (nth 3 mem))
       (equal (len (nth 3 mem)) 3)
       (equal (car (nth 3 mem)) 'r)
       (true-listp (nth 4 mem))
       (equal (len (nth 4 mem)) 3)
       (equal (car (nth 4 mem)) 's)
       (true-listp (nth 5 mem))
       (equal (len (nth 5 mem)) 3)
       (equal (car (nth 5 mem)) 't)
       (true-listp (nth 6 mem))
       (equal (len (nth 6 mem)) 3)
       (equal (car (nth 6 mem)) 'w)
       (true-listp (nth 7 mem))
       (equal (len (nth 7 mem)) 2)
       (equal (car (nth 7 mem)) 'sign)))

(defrule @cbrt-mem-p-store-double-ret
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-double v '(ret . 0) mem)))
 :enable (@cbrt-mem-p store-double))

(defrule @cbrt-mem-p-store-double-x
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-double v '(x . 0) mem)))
 :enable (@cbrt-mem-p store-double))

(defrule @cbrt-mem-p-store-i32-hx
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-i32 v '(hx . 0) mem)))
 :enable (@cbrt-mem-p store-i32))

(defrule @cbrt-mem-p-store-double-r
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-double v '(r . 0) mem)))
 :enable (@cbrt-mem-p store-double))

(defrule @cbrt-mem-p-store-double-s
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-double v '(s . 0) mem)))
 :enable (@cbrt-mem-p store-double))

(defrule @cbrt-mem-p-store-double-t
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-double v '(t . 0) mem)))
 :enable (@cbrt-mem-p store-double))

(defrule @cbrt-mem-p-store-double-w
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-double v '(w . 0) mem)))
 :enable (@cbrt-mem-p store-double))

(defrule @cbrt-mem-p-store-i32-sign
 (implies (@cbrt-mem-p mem)
          (@cbrt-mem-p (store-i32 v '(sign . 0) mem)))
 :enable (@cbrt-mem-p store-i32))

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

(defrule index-into-cbrt-compute-progam
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
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
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
;                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslitN$Cbrt")
                (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s))))))
           (poised-to-invoke-get-hi-p th s))
  :enable poised-to-invoke-get-hi-p
  :disable m5::bound?)

(defruled poised-to-invoke-set-lo-thm
  (implies (and (class-table-assumptions (m5::class-table s))
                (equal (m5::status th s) 'm5::scheduled)
                (member (m5::pc (m5::top-frame th s)) '(147))
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
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
                (equal (m5::program (m5::top-frame th s)) *cbrt-compute-program*)
                (equal (m5::cur-class (m5::top-frame th s)) "FdlibmTranslitN$Cbrt")
                (doublep (m5::top (m5::pop (m5::pop (m5::stack (m5::top-frame th s))))))
                (i32p (m5::top (m5::stack (m5::top-frame th s)))))
           (poised-to-invoke-set-hi-p th s))
  :enable poised-to-invoke-set-hi-p
  :disable m5::bound?)

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

(defrule class-table-of-initial-s
  (equal (m5::class-table (initial-s sb th x))
         (m5::class-table sb))
  :enable initial-s)

(defrule status-of-initial-s
  (equal (m5::status th (initial-s sb th x))
         'jvm::scheduled)
  :enable initial-s)

(defrule pc-of-initial-s
  (equal (m5::pc (m5::top-frame th (initial-s sb th x)))
         0)
  :enable initial-s)

(defrule pc-of-initial-s_1
  (equal (m5::pc (m5::top (m5::call-stack th (initial-s sb th x))))
         0)
  :enable initial-s)

(defrule locals-of-initial-s
  (equal (m5::locals (m5::top-frame th (initial-s sb th x)))
         (list x nil))
  :enable initial-s)

(defrule stack-of-initial-s
  (equal (m5::stack (m5::top-frame th (initial-s sb th x)))
         ())
  :enable initial-s)

(defrule program-of-initial-s
  (cbrt-compute-program-p (m5::program (m5::top-frame th (initial-s sb th s))))
  :enable initial-s)

(defrule program-of-initial-s_1
  (cbrt-compute-program-p (m5::program (m5::top (m5::call-stack th (initial-s sb th s)))))
  :enable initial-s)

(defrule sync-flg-of-initial-s
  (equal (m5::sync-flg (m5::top-frame th (initial-s sb th x)))
         'm5::unlocked)
  :enable initial-s)

(defrule cur-class-of-initial-s
  (equal (m5::cur-class (m5::top-frame th (initial-s sb th x)))
         "FdlibmTranslitN$Cbrt")
  :enable initial-s)

(defruled ttt-%0-m0.1
  (b* (
    (loc (@cbrt-%sign-loc (initial-s0 x)))
    (mem (@cbrt-m0.1-mem (initial-s0 x)))
    (s (initial-s sb th x))
    (frame (m5::top-frame th s)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (@cbrt-local-vars-p loc)
          (@cbrt-mem-p mem)
          (pair-p mem (m5::locals frame))
          (class-table-assumptions (m5::class-table s))
          (equal (m5::status th s) 'm5::scheduled)
          (equal (m5::pc frame) 0)
          (cbrt-compute-program-p (m5::program frame))
          (equal (m5::cur-class frame) "FdlibmTranslitN$Cbrt")
          (doublep (load-double '(x . 0) mem))
;          (equal (nth 0 (m5::locals frame)) (load-double '(x . 0)))
;          (equal mem
;                 `((ret nil nil)
;                   (x ,(get-lo-double x) ,(get-hi-double x))
;                   (hx nil)
;                   (r nil nil)
;                   (s nil nil)
;                   (t nil nil)
;                   (w nil nil)
;                   (sign nil)))
          )))
  :enable (initial-s0 pair-p
           pair-double-p store-double load-double
           pair-i32-p load-i32
           @cbrt-local-vars-p
           @cbrt-mem-p
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
           @cbrt-m0.1-mem)
  :disable m5::top-frame)

(defund sched-m0.2 (th)
  (m5::repeat th 2))

(defruled ttt-%0-m0.2
  (b* (
    (loc (@cbrt-%sign-loc (initial-s0 x)))
    (mem (@cbrt-m0.2-mem (initial-s0 x)))
    (s (m5::run (sched-m0.2 th) (initial-s sb th x)))
    (frame (m5::top-frame th s)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (@cbrt-local-vars-p loc)
          (@cbrt-mem-p mem)
          (pair-p mem (m5::locals frame))
          (class-table-assumptions (m5::class-table s))
          (equal (m5::status th s) 'm5::scheduled)
          (equal (m5::pc frame) 3)
          (cbrt-compute-program-p (m5::program frame))
          (equal (m5::cur-class frame) "FdlibmTranslitN$Cbrt")
          (doublep (load-double '(x . 0) mem))
          (doublep (load-double '(t . 0) mem)))))
  :enable (@cbrt-m0.2-mem sched-m0.2)
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
    (frame (m5::top-frame th s)))
    (implies
     (and (doublep x)
          (class-table-assumptions (m5::class-table sb)))
     (and (@cbrt-local-vars-p loc)
          (@cbrt-mem-p mem)
          (pair-p mem (m5::locals frame))
          (class-table-assumptions (m5::class-table s))
          (equal (m5::status th s) 'm5::scheduled)
          (equal (m5::pc frame) 8)
          (cbrt-compute-program-p (m5::program frame))
          (equal (m5::cur-class frame) "FdlibmTranslitN$Cbrt")
          (doublep (load-double '(x . 0) mem))
          (i32p (load-i32 '(hx . 0) mem))
          (doublep (load-double '(t . 0) mem)))))
  :enable (sched-m0.3 poised-to-invoke-get-hi-thm
    @cbrt-%3-loc @cbrt-%3-val
    @cbrt-%4-loc @cbrt-%4-val
    @cbrt-%5-loc @cbrt-%5-val
    @cbrt-m0.3-mem)
  :use ttt-%0-m0.2)
