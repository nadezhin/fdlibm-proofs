(in-package "ACL2")
(include-book "utils")
(include-book "models/jvm/m5/utilities" :dir :system)
(local (include-book "rtl/rel11/lib/top" :dir :system))

(include-book "classes/java.lang.Class")
(include-book "classes/java.lang.Double")
(include-book "classes/java.lang.Math")
(include-book "classes/java.lang.Number")
(include-book "classes/java.lang.Object")
(include-book "classes/java.lang.StrictMath")
(include-book "classes/java.lang.String")
(include-book "classes/FdlibmTranslitN")
(include-book "classes/FdlibmTranslitN$Cbrt")

;; Prepare inital state

(defconst *FdlibmTranslitN-initial-state*
  (m5::load_class_library
   (m5::make-state
    (m5::make-tt nil)
    nil
    (m5::link-class-table
     (list
      m5::*java.lang.Object*
      m5::*java.lang.Class*
      m5::*java.lang.String*
      m5::*java.lang.StrictMath*
      m5::*java.lang.Math*
      m5::*java.lang.Number*
      m5::*java.lang.Double*
      m5::*FdlibmTranslitN*
      m5::*FdlibmTranslitN$Cbrt*))
    'm5::utf16-little-endian)))

;; Prepare test state

(defun with-test (s class method args)
  (m5::modify
   0
   s
   :call-stack
   (m5::push
    (m5::make-frame 0 () args '((JVM::invokestatic 1)) 'm5::unlocked "Test")
    (m5::call-stack 0 s))
   :class-table
   (cons (m5::make-class-decl
          "Test"
          '("java/lang/Object")
          `(nil (m5::methodref ,class ,method ,(len args)))
          #x00000020                                                 ; SUPER
          ()
          ()
          '(m5::ref -1))
         (m5::class-table s))))

(defconst *doubleToRawLongBits-def*
  '#!jvm("doubleToRawLongBits:(D)J" #x00000109)) ; PUBLIC STATIC NATIVE

(defconst *longBitsToDouble-def*
  '#!jvm("longBitsToDouble:(J)D" #x00000109)) ; PUBLIC STATIC NATIVE

(defruled shr-for-gl1
  (equal (m5::shr x n)
         (if (integerp x)
             (ash x (- n))
           (m5::shr x n))))

; get-lo

(defund get-lo-schedule (th)
  (m5::repeat th 10))

(defund poised-to-invoke-get-lo-p (th s)
  (and (m5::poised-to-invokestatic th s "FdlibmTranslitN" "access$100:(D)I" 2)
       (doublep (m5::top2 (m5::stack (m5::top-frame th s))))
       (equal (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table s)))
              (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table *FdlibmTranslitN-initial-state*))))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 4 (m5::class-table s))
              '(m5::methodref "FdlibmTranslitN" "__LO:(D)I" 2))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 28 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "doubleToRawLongBits:(D)J" 2))
       (equal (m5::bound? "doubleToRawLongBits:(D)J"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *doubleToRawLongBits-def*)))
#|
(defun test-get-lo (x)
  (with-test
   *FdlibmTranslitN-initial-state*
   "FdlibmTranslitN"
   "access$100:(D)I"
   (m5::push2 x ())))

(defrule |poised-to-invoke-get-lo-p test-get-lo|
  (implies (doublep x)
           (poised-to-invoke-get-lo-p 0 (test-get-lo x)))
  :enable (poised-to-invoke-get-lo-p
           m5::make-thread m5::call-stack m5::status))
 |#
(defrule thm-get-lo
  (implies (poised-to-invoke-get-lo-p th s)
           (equal (m5::run (get-lo-schedule th) s)
                  (m5::modify
                   th s
                   :pc (+ 3 (m5::pc (m5::top-frame th s)))
                   :stack (m5::push (get-lo (m5::top2 (m5::stack (m5::top-frame th s))))
                                    (m5::pop2 (m5::stack (m5::top-frame th s)))))))
  :prep-lemmas (
    (defrule lemma
      (implies (doublep x)
               (equal (m5::int-fix (m5::long-fix x))
                      (get-lo x)))
      :enable (get-lo make-i32 get-lo-double m5::int-fix s-fix-u-fix wordp)
      :disable (m5::s-fix m5::u-fix mod)))
  :enable (get-lo-schedule poised-to-invoke-get-lo-p)
  :disable (m5::long-fix
            m5::deref
            m5::bind-formals))

(defund get-hi-schedule (th)
  (m5::repeat th 12))

(defund poised-to-invoke-get-hi-p (th s)
  (and (m5::poised-to-invokestatic th s "FdlibmTranslitN" "access$000:(D)I" 2)
       (doublep (m5::top (m5::pop (m5::stack (m5::top-frame th s)))))
       (equal (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table s)))
              (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table *FdlibmTranslitN-initial-state*))))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 5 (m5::class-table s))
              '(m5::methodref "FdlibmTranslitN" "__HI:(D)I" 2))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 28 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "doubleToRawLongBits:(D)J" 2))
       (equal (m5::bound? "doubleToRawLongBits:(D)J"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *doubleToRawLongBits-def*)))

(defrule thm-get-hi
  (implies (poised-to-invoke-get-hi-p th s)
           (equal (m5::run (get-hi-schedule th) s)
                  (m5::modify
                   th s
                   :pc (+ 3 (m5::pc (m5::top-frame th s)))
                   :stack (m5::push (get-hi (m5::top2 (m5::stack (m5::top-frame th s))))
                                    (m5::pop2 (m5::stack (m5::top-frame th s)))))))
  :prep-lemmas (
    (gl::set-preferred-def m5::shr shr-for-gl1)
    (gl::def-gl-rule lemma
      :hyp (rtl::bvecp x 64)
      :concl (equal (m5::int-fix (m5::long-fix (m5::shr (m5::long-fix x) 32)))
                    (get-hi x))
      :g-bindings `((x ,(gl::g-int 1 1 65)))))
  :enable (get-hi-schedule poised-to-invoke-get-hi-p doublep rtl::encodingp rtl::dp)
  :disable (m5::long-fix
            m5::deref
            m5::shr
            m5::bind-formals))

(defund set-lo-schedule (th)
  (m5::repeat th 18))

(defund poised-to-invoke-set-lo-p (th s)
  (and (m5::poised-to-invokestatic th s "FdlibmTranslitN" "access$200:(DI)D" 3)
       (doublep (m5::top2 (m5::pop (m5::stack (m5::top-frame th s)))))
       (i32p (m5::top (m5::stack (m5::top-frame th s))))
       (equal (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table s)))
              (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table *FdlibmTranslitN-initial-state*))))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 3 (m5::class-table s))
              '(m5::methodref "FdlibmTranslitN" "__LO:(DI)D" 3))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 28 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "doubleToRawLongBits:(D)J" 2))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 29 (m5::class-table s))
              '(m5::long #x-100000000))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 31 (m5::class-table s))
              '(m5::long #xffffffff))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 33 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "longBitsToDouble:(J)D" 2))
       (equal (m5::bound? "doubleToRawLongBits:(D)J"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *doubleToRawLongBits-def*)
       (equal (m5::bound? "longBitsToDouble:(J)D"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *longBitsToDouble-def*)))

(defrule thm-set-lo
  (implies (poised-to-invoke-set-lo-p th s)
           (equal (m5::run (set-lo-schedule th) s)
                  (m5::modify
                   th s
                   :pc (+ 3 (m5::pc (m5::top-frame th s)))
                   :stack (m5::push2
                            (set-lo (m5::top2 (m5::pop (m5::stack (m5::top-frame th s))))
                                    (m5::top (m5::stack (m5::top-frame th s))))
                            (m5::pop2 (m5::pop (m5::stack (m5::top-frame th s))))))))
  :prep-lemmas (
    (gl::set-preferred-def m5::shr shr-for-gl1)
    (gl::def-gl-rule lemma
      :hyp (and (rtl::bvecp d 64)
                (i32p lo))
      :concl (equal
              (m5::double-fix
               (logior
                (logand 4294967295 (m5::long-fix lo))
                (logand -4294967296 (m5::long-fix d))))
              (set-lo d lo))
      :g-bindings `((d ,(gl::g-int 1 2 65))
                    (lo ,(gl::g-int 2 2 33)))))
  :enable (set-lo-schedule poised-to-invoke-set-lo-p doublep rtl::encodingp rtl::dp)
  :disable (m5::long-fix
            m5::deref
            m5::shr
            m5::double-fix
            logand
            logior
            m5::bind-formals))

(defund set-hi-schedule (th)
  (m5::repeat th 18))

(defund poised-to-invoke-set-hi-p (th s)
  (and (m5::poised-to-invokestatic th s "FdlibmTranslitN" "access$300:(DI)D" 3)
       (doublep (m5::top2 (m5::pop (m5::stack (m5::top-frame th s)))))
       (i32p (m5::top (m5::stack (m5::top-frame th s))))
       (equal (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table s)))
              (m5::class-decl-methods
               (m5::bound? "FdlibmTranslitN"
                           (m5::class-table *FdlibmTranslitN-initial-state*))))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 2 (m5::class-table s))
              '(m5::methodref "FdlibmTranslitN" "__HI:(DI)D" 3))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 28 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "doubleToRawLongBits:(D)J" 2))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 29 (m5::class-table s))
              '(m5::long #x-100000000))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 31 (m5::class-table s))
              '(m5::long #xffffffff))
       (equal (m5::retrieve-cp-entry "FdlibmTranslitN" 33 (m5::class-table s))
              '(m5::methodref "java/lang/Double" "longBitsToDouble:(J)D" 2))
       (equal (m5::bound? "doubleToRawLongBits:(D)J"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *doubleToRawLongBits-def*)
       (equal (m5::bound? "longBitsToDouble:(J)D"
                          (m5::class-decl-methods
                            (m5::bound? "java/lang/Double" (m5::class-table s))))
              *longBitsToDouble-def*)))

(defrule thm-set-hi
  (implies (poised-to-invoke-set-hi-p th s)
           (equal (m5::run (set-hi-schedule th) s)
                  (m5::modify
                   th s
                   :pc (+ 3 (m5::pc (m5::top-frame th s)))
                   :stack (m5::push2
                           (set-hi (m5::top2 (m5::pop (m5::stack (m5::top-frame th s))))
                                   (m5::top (m5::stack (m5::top-frame th s))))
                           (m5::pop2 (m5::pop (m5::stack (m5::top-frame th s))))))))
  :prep-lemmas (
    (gl::set-preferred-def m5::shr shr-for-gl1)
    (gl::def-gl-rule lemma
      :hyp (and (rtl::bvecp d 64)
                (i32p hi))
      :concl (equal
              (m5::double-fix
               (logior
                (m5::long-fix (m5::shl (m5::long-fix hi) 32))
                (logand 4294967295 (m5::long-fix d))))
              (set-hi d hi))
      :g-bindings `((d ,(gl::g-int 1 2 65))
                    (hi ,(gl::g-int 34 2 33)))))
  :enable (set-hi set-hi-schedule poised-to-invoke-set-hi-p doublep rtl::encodingp rtl::dp)
  :disable (m5::long-fix
            m5::deref
            m5::shl
            m5::double-fix
            logand
            logior
            m5::bind-formals))
