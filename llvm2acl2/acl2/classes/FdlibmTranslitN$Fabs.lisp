; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslitN$Fabs*
    (make-class-decl
     "FdlibmTranslitN$Fabs"
     '("java/lang/Object")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 1
       (methodref "FdlibmTranslitN" "access$000:(D)I" 2)        ; 2
       (integer 2147483647)                                     ; 3
       (methodref "FdlibmTranslitN" "access$300:(DI)D" 3)       ; 4
       (class (ref -1) "FdlibmTranslitN$Fabs")                  ; 5
       (class (ref -1) "java/lang/Object")                      ; 6
       (utf8)                                                   ; 7
       (utf8)                                                   ; 8
       (utf8)                                                   ; 9
       (utf8)                                                   ; 10
       (utf8)                                                   ; 11
       (utf8)                                                   ; 12
       (utf8)                                                   ; 13
       (utf8)                                                   ; 14
       (name-and-type "<init>:()V")                             ; 15
       (class (ref -1) "FdlibmTranslitN")                       ; 16
       (name-and-type "access$000:(D)I")                        ; 17
       (name-and-type "access$300:(DI)D")                       ; 18
       (utf8)                                                   ; 19
       (utf8)                                                   ; 20
       (utf8)                                                   ; 21
       (utf8)                                                   ; 22
       (utf8)                                                   ; 23
       (utf8)                                                   ; 24
       (utf8)                                                   ; 25
       (utf8)                                                   ; 26
       (utf8)                                                   ; 27
      )
     #x00000020                                                 ; SUPER
     '(
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #1348
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" #x00000808                               ; STATIC STRICT
        ; line_number #1354
        (dload_0)                                               ; 0
        (dload_0)                                               ; 1
        (invokestatic 2)                                        ; 2 FdlibmTranslitN.access$000:(D)I
        (ldc 3)                                                 ; 5 2147483647
        (iand)                                                  ; 7
        (invokestatic 4)                                        ; 8 FdlibmTranslitN.access$300:(DI)D
        (dstore_0)                                              ; 11
        ; line_number #1355
        (dload_0)                                               ; 12
        (dreturn)                                               ; 13
       ))
     '(ref -1)))