; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslit$Copysign*
    (make-class-decl
     "FdlibmTranslit$Copysign"
     '("java/lang/Object")
     '()
     '()
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)           ; 1
       (methodref "FdlibmTranslit" "access$000:(D)I" 2)        ; 2
       (integer 2147483647)                                    ; 3
       (integer -2147483648)                                   ; 4
       (methodref "FdlibmTranslit" "access$400:(DI)D" 3)       ; 5
       (class (ref -1) "FdlibmTranslit$Copysign")              ; 6
       (class (ref -1) "java/lang/Object")                     ; 7
       (utf8)                                                  ; 8
       (utf8)                                                  ; 9
       (utf8)                                                  ; 10
       (utf8)                                                  ; 11
       (utf8)                                                  ; 12
       (utf8)                                                  ; 13
       (utf8)                                                  ; 14
       (utf8)                                                  ; 15
       (name-and-type "<init>:()V")                            ; 16
       (class (ref -1) "FdlibmTranslit")                       ; 17
       (name-and-type "access$000:(D)I")                       ; 18
       (name-and-type "access$400:(DI)D")                      ; 19
       (utf8)                                                  ; 20
       (utf8)                                                  ; 21
       (utf8)                                                  ; 22
       (utf8)                                                  ; 23
       (utf8)                                                  ; 24
       (utf8)                                                  ; 25
       (utf8)                                                  ; 26
       (utf8)                                                  ; 27
       (utf8)                                                  ; 28
      )
     (list
      '("<init>:()V" nil
        ; line_number #650
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(DD)D" nil
        ; line_number #653
        (dload_0)                                               ; 0
        (dload_0)                                               ; 1
        (invokestatic 2)                                        ; 2 FdlibmTranslit.access$000:(D)I
        (ldc 3)                                                 ; 5 2147483647
        (iand)                                                  ; 7
        (dload_2)                                               ; 8
        (invokestatic 2)                                        ; 9 FdlibmTranslit.access$000:(D)I
        (ldc 4)                                                 ; 12 -2147483648
        (iand)                                                  ; 14
        (ior)                                                   ; 15
        (invokestatic 5)                                        ; 16 FdlibmTranslit.access$400:(DI)D
        (dstore_0)                                              ; 19
        ; line_number #654
        (dload_0)                                               ; 20
        (dreturn)                                               ; 21
       ))
     '(ref -1)))