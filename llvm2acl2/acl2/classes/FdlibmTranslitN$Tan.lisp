; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslitN$Tan*
    (make-class-decl
     "FdlibmTranslitN$Tan"
     '("java/lang/Object")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 1
       (methodref "FdlibmTranslitN" "access$000:(D)I" 2)        ; 2
       (integer 2147483647)                                     ; 3
       (integer 1072243195)                                     ; 4
       (methodref "FdlibmTranslitN$KernelTan" "compute:(DDI)D" 5)       ; 5
       (integer 2146435072)                                     ; 6
       (methodref "FdlibmTranslitN$RemPio2" "compute:(D[D)I" 3) ; 7
       (class (ref -1) "FdlibmTranslitN$Tan")                   ; 8
       (class (ref -1) "java/lang/Object")                      ; 9
       (utf8)                                                   ; 10
       (utf8)                                                   ; 11
       (utf8)                                                   ; 12
       (utf8)                                                   ; 13
       (utf8)                                                   ; 14
       (utf8)                                                   ; 15
       (utf8)                                                   ; 16
       (class (ref -1) "[D")                                    ; 17
       (utf8)                                                   ; 18
       (utf8)                                                   ; 19
       (name-and-type "<init>:()V")                             ; 20
       (class (ref -1) "FdlibmTranslitN")                       ; 21
       (name-and-type "access$000:(D)I")                        ; 22
       (class (ref -1) "FdlibmTranslitN$KernelTan")             ; 23
       (name-and-type "compute:(DDI)D")                         ; 24
       (class (ref -1) "FdlibmTranslitN$RemPio2")               ; 25
       (name-and-type "compute:(D[D)I")                         ; 26
       (utf8)                                                   ; 27
       (utf8)                                                   ; 28
       (utf8)                                                   ; 29
       (utf8)                                                   ; 30
       (utf8)                                                   ; 31
       (utf8)                                                   ; 32
       (utf8)                                                   ; 33
       (utf8)                                                   ; 34
       (utf8)                                                   ; 35
       (utf8)                                                   ; 36
       (utf8)                                                   ; 37
       (utf8)                                                   ; 38
       (utf8)                                                   ; 39
       (utf8)                                                   ; 40
      )
     #x00000020                                                 ; SUPER
     '(
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #3479
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" #x00000808                               ; STATIC STRICT
        ; line_number #3485
        (iconst_2)                                              ; 0
        (newarray T_DOUBLE)                                     ; 1
        (astore_2)                                              ; 3
        (dconst_0)                                              ; 4
        (dstore_3)                                              ; 5
        ; line_number #3489
        (dload_0)                                               ; 6
        (invokestatic 2)                                        ; 7 FdlibmTranslitN.access$000:(D)I
        (istore 6)                                              ; 10
        ; line_number #3492
        (iload 6)                                               ; 12
        (ldc 3)                                                 ; 14 2147483647
        (iand)                                                  ; 16
        (istore 6)                                              ; 17
        ; line_number #3493
        (iload 6)                                               ; 19
        (ldc 4)                                                 ; 21 1072243195
        (if_icmpgt 10)                                          ; 23
        (dload_0)                                               ; 26
        (dload_3)                                               ; 27
        (iconst_1)                                              ; 28
        (invokestatic 5)                                        ; 29 FdlibmTranslitN$KernelTan.compute:(DDI)D
        (dreturn)                                               ; 32
        ; line_number #3496
        (iload 6)                                               ; 33
        (ldc 6)                                                 ; 35 2146435072
        (if_icmplt 7)                                           ; 37
        (dload_0)                                               ; 40
        (dload_0)                                               ; 41
        (dsub)                                                  ; 42
        (dreturn)                                               ; 43
        ; line_number #3500
        (dload_0)                                               ; 44
        (aload_2)                                               ; 45
        (invokestatic 7)                                        ; 46 FdlibmTranslitN$RemPio2.compute:(D[D)I
        (istore 5)                                              ; 49
        ; line_number #3501
        (aload_2)                                               ; 51
        (iconst_0)                                              ; 52
        (daload)                                                ; 53
        (aload_2)                                               ; 54
        (iconst_1)                                              ; 55
        (daload)                                                ; 56
        (iconst_1)                                              ; 57
        (iload 5)                                               ; 58
        (iconst_1)                                              ; 60
        (iand)                                                  ; 61
        (iconst_1)                                              ; 62
        (ishl)                                                  ; 63
        (isub)                                                  ; 64
        (invokestatic 5)                                        ; 65 FdlibmTranslitN$KernelTan.compute:(DDI)D
        (dreturn)                                               ; 68
       ))
     '(ref -1)))