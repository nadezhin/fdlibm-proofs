; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslitN$Tanh*
    (make-class-decl
     "FdlibmTranslitN$Tanh"
     '("java/lang/Object")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 1
       (methodref "FdlibmTranslitN" "access$000:(D)I" 2)        ; 2
       (integer 2147483647)                                     ; 3
       (integer 2146435072)                                     ; 4
       (class (ref -1) "FdlibmTranslitN$Tanh")                  ; 5
       (integer 1077280768)                                     ; 6
       (integer 1015021568)                                     ; 7
       (integer 1072693248)                                     ; 8
       (double #x4000000000000000) ; 0x1.0p1 2.0                ; 9
       nil
       (methodref "FdlibmTranslitN$Fabs" "compute:(D)D" 2)      ; 11
       (methodref "FdlibmTranslitN" "expm1:(D)D" 2)             ; 12
       (double #xc000000000000000) ; -0x1.0p1 -2.0              ; 13
       nil
       (class (ref -1) "java/lang/Object")                      ; 15
       (utf8)                                                   ; 16
       (utf8)                                                   ; 17
       (utf8)                                                   ; 18
       (double #x3ff0000000000000) ; 0x1.0p0 1.0                ; 19
       nil
       (utf8)                                                   ; 21
       (utf8)                                                   ; 22
       (double #x01a56e1fc2f8f359) ; 0x1.56e1fc2f8f359p-997 1.0E-300    ; 23
       nil
       (utf8)                                                   ; 25
       (utf8)                                                   ; 26
       (utf8)                                                   ; 27
       (utf8)                                                   ; 28
       (utf8)                                                   ; 29
       (utf8)                                                   ; 30
       (utf8)                                                   ; 31
       (utf8)                                                   ; 32
       (utf8)                                                   ; 33
       (name-and-type "<init>:()V")                             ; 34
       (class (ref -1) "FdlibmTranslitN")                       ; 35
       (name-and-type "access$000:(D)I")                        ; 36
       (utf8)                                                   ; 37
       (utf8)                                                   ; 38
       (utf8)                                                   ; 39
       (class (ref -1) "FdlibmTranslitN$Fabs")                  ; 40
       (name-and-type "compute:(D)D")                           ; 41
       (name-and-type "expm1:(D)D")                             ; 42
       (utf8)                                                   ; 43
       (utf8)                                                   ; 44
       (utf8)                                                   ; 45
       (utf8)                                                   ; 46
       (utf8)                                                   ; 47
       (utf8)                                                   ; 48
       (utf8)                                                   ; 49
      )
     #x00000020                                                 ; SUPER
     '(
       ("one:D" #x00000018)                                     ; STATIC FINAL
       ("two:D" #x00000018)                                     ; STATIC FINAL
       ("tiny:D" #x00000018)                                    ; STATIC FINAL
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #3692
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" #x00000808                               ; STATIC STRICT
        ; line_number #3706
        (dload_0)                                               ; 0
        (invokestatic 2)                                        ; 1 FdlibmTranslitN.access$000:(D)I
        (istore 6)                                              ; 4
        ; line_number #3707
        (iload 6)                                               ; 6
        (ldc 3)                                                 ; 8 2147483647
        (iand)                                                  ; 10
        (istore 7)                                              ; 11
        ; line_number #3710
        (iload 7)                                               ; 13
        (ldc 4)                                                 ; 15 2146435072
        (if_icmplt 20)                                          ; 17
        ; line_number #3711
        (iload 6)                                               ; 20
        (iflt 9)                                                ; 22
        (dconst_1)                                              ; 25
        (dload_0)                                               ; 26
        (ddiv)                                                  ; 27
        (dconst_1)                                              ; 28
        (dadd)                                                  ; 29
        (dreturn)                                               ; 30
        ; line_number #3712
        (dconst_1)                                              ; 31
        (dload_0)                                               ; 32
        (ddiv)                                                  ; 33
        (dconst_1)                                              ; 34
        (dsub)                                                  ; 35
        (dreturn)                                               ; 36
        ; line_number #3716
        (iload 7)                                               ; 37
        (ldc 6)                                                 ; 39 1077280768
        (if_icmpge 76)                                          ; 41
        ; line_number #3717
        (iload 7)                                               ; 44
        (ldc 7)                                                 ; 46 1015021568
        (if_icmpge 9)                                           ; 48
        ; line_number #3718
        (dload_0)                                               ; 51
        (dconst_1)                                              ; 52
        (dload_0)                                               ; 53
        (dadd)                                                  ; 54
        (dmul)                                                  ; 55
        (dreturn)                                               ; 56
        ; line_number #3719
        (iload 7)                                               ; 57
        (ldc 8)                                                 ; 59 1072693248
        (if_icmplt 31)                                          ; 61
        ; line_number #3720
        (ldc2_w 9)                                              ; 64 2.0d
        (dload_0)                                               ; 67
        (invokestatic 11)                                       ; 68 FdlibmTranslitN$Fabs.compute:(D)D
        (dmul)                                                  ; 71
        (invokestatic 12)                                       ; 72 FdlibmTranslitN.expm1:(D)D
        (dstore_2)                                              ; 75
        ; line_number #3721
        (dconst_1)                                              ; 76
        (ldc2_w 9)                                              ; 77 2.0d
        (dload_2)                                               ; 80
        (ldc2_w 9)                                              ; 81 2.0d
        (dadd)                                                  ; 84
        (ddiv)                                                  ; 85
        (dsub)                                                  ; 86
        (dstore 4)                                              ; 87
        (goto 31)                                               ; 89
        ; line_number #3723
        (ldc2_w 13)                                             ; 92 -2.0d
        (dload_0)                                               ; 95
        (invokestatic 11)                                       ; 96 FdlibmTranslitN$Fabs.compute:(D)D
        (dmul)                                                  ; 99
        (invokestatic 12)                                       ; 100 FdlibmTranslitN.expm1:(D)D
        (dstore_2)                                              ; 103
        ; line_number #3724
        (dload_2)                                               ; 104
        (dneg)                                                  ; 105
        (dload_2)                                               ; 106
        (ldc2_w 9)                                              ; 107 2.0d
        (dadd)                                                  ; 110
        (ddiv)                                                  ; 111
        (dstore 4)                                              ; 112
        (goto 6)                                                ; 114
        ; line_number #3728
        (dconst_1)                                              ; 117
        (dstore 4)                                              ; 118
        ; line_number #3730
        (iload 6)                                               ; 120
        (iflt 8)                                                ; 122
        (dload 4)                                               ; 125
        (goto 6)                                                ; 127
        (dload 4)                                               ; 130
        (dneg)                                                  ; 132
        (dreturn)                                               ; 133
       ))
     '(ref -1)))