; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslitN$Cosh*
    (make-class-decl
     "FdlibmTranslitN$Cosh"
     '("java/lang/Object")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 1
       (methodref "FdlibmTranslitN" "access$000:(D)I" 2)        ; 2
       (integer 2147483647)                                     ; 3
       (integer 2146435072)                                     ; 4
       (integer 1071001155)                                     ; 5
       (methodref "FdlibmTranslitN$Fabs" "compute:(D)D" 2)      ; 6
       (methodref "FdlibmTranslitN" "expm1:(D)D" 2)             ; 7
       (class (ref -1) "FdlibmTranslitN$Cosh")                  ; 8
       (integer 1015021568)                                     ; 9
       (integer 1077280768)                                     ; 10
       (methodref "FdlibmTranslitN$Exp" "compute:(D)D" 2)       ; 11
       (double #x3fe0000000000000) ; 0x1.0p-1 0.5               ; 12
       nil
       (integer 1082535490)                                     ; 14
       (methodref "FdlibmTranslitN" "access$400:(D)[I" 2)       ; 15
       (integer 1082536910)                                     ; 16
       (integer -1883637635)                                    ; 17
       (methodref "java/lang/Integer" "compareUnsigned:(II)I" 2)        ; 18
       (double #x7ff0000000000000) ; Infinity Infinity          ; 19
       nil
       (class (ref -1) "java/lang/Object")                      ; 21
       (utf8)                                                   ; 22
       (utf8)                                                   ; 23
       (utf8)                                                   ; 24
       (double #x3ff0000000000000) ; 0x1.0p0 1.0                ; 25
       nil
       (utf8)                                                   ; 27
       (utf8)                                                   ; 28
       (double #x7e37e43c8800759c) ; 0x1.7e43c8800759cp996 1.0E300      ; 29
       nil
       (utf8)                                                   ; 31
       (utf8)                                                   ; 32
       (utf8)                                                   ; 33
       (utf8)                                                   ; 34
       (utf8)                                                   ; 35
       (utf8)                                                   ; 36
       (utf8)                                                   ; 37
       (utf8)                                                   ; 38
       (utf8)                                                   ; 39
       (name-and-type "<init>:()V")                             ; 40
       (class (ref -1) "FdlibmTranslitN")                       ; 41
       (name-and-type "access$000:(D)I")                        ; 42
       (class (ref -1) "FdlibmTranslitN$Fabs")                  ; 43
       (name-and-type "compute:(D)D")                           ; 44
       (name-and-type "expm1:(D)D")                             ; 45
       (utf8)                                                   ; 46
       (utf8)                                                   ; 47
       (utf8)                                                   ; 48
       (class (ref -1) "FdlibmTranslitN$Exp")                   ; 49
       (name-and-type "access$400:(D)[I")                       ; 50
       (class (ref -1) "java/lang/Integer")                     ; 51
       (name-and-type "compareUnsigned:(II)I")                  ; 52
       (utf8)                                                   ; 53
       (utf8)                                                   ; 54
       (utf8)                                                   ; 55
       (utf8)                                                   ; 56
       (utf8)                                                   ; 57
       (utf8)                                                   ; 58
       (utf8)                                                   ; 59
       (utf8)                                                   ; 60
       (utf8)                                                   ; 61
       (utf8)                                                   ; 62
       (utf8)                                                   ; 63
       (utf8)                                                   ; 64
       (utf8)                                                   ; 65
       (utf8)                                                   ; 66
      )
     #x00000020                                                 ; SUPER
     '(
       ("one:D" #x00000018)                                     ; STATIC FINAL
       ("half:D" #x00000018)                                    ; STATIC FINAL
       ("huge:D" #x00000018)                                    ; STATIC FINAL
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #917
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" #x00000808                               ; STATIC STRICT
        ; line_number #932
        (dload_0)                                               ; 0
        (invokestatic 2)                                        ; 1 FdlibmTranslitN.access$000:(D)I
        (istore 6)                                              ; 4
        ; line_number #933
        (iload 6)                                               ; 6
        (ldc 3)                                                 ; 8 2147483647
        (iand)                                                  ; 10
        (istore 6)                                              ; 11
        ; line_number #936
        (iload 6)                                               ; 13
        (ldc 4)                                                 ; 15 2146435072
        (if_icmplt 7)                                           ; 17
        (dload_0)                                               ; 20
        (dload_0)                                               ; 21
        (dmul)                                                  ; 22
        (dreturn)                                               ; 23
        ; line_number #939
        (iload 6)                                               ; 24
        (ldc 5)                                                 ; 26 1071001155
        (if_icmpge 38)                                          ; 28
        ; line_number #940
        (dload_0)                                               ; 31
        (invokestatic 6)                                        ; 32 FdlibmTranslitN$Fabs.compute:(D)D
        (invokestatic 7)                                        ; 35 FdlibmTranslitN.expm1:(D)D
        (dstore_2)                                              ; 38
        ; line_number #941
        (dconst_1)                                              ; 39
        (dload_2)                                               ; 40
        (dadd)                                                  ; 41
        (dstore 4)                                              ; 42
        ; line_number #942
        (iload 6)                                               ; 44
        (ldc 9)                                                 ; 46 1015021568
        (if_icmpge 6)                                           ; 48
        (dload 4)                                               ; 51
        (dreturn)                                               ; 53
        ; line_number #943
        (dconst_1)                                              ; 54
        (dload_2)                                               ; 55
        (dload_2)                                               ; 56
        (dmul)                                                  ; 57
        (dload 4)                                               ; 58
        (dload 4)                                               ; 60
        (dadd)                                                  ; 62
        (ddiv)                                                  ; 63
        (dadd)                                                  ; 64
        (dreturn)                                               ; 65
        ; line_number #947
        (iload 6)                                               ; 66
        (ldc 10)                                                ; 68 1077280768
        (if_icmpge 23)                                          ; 70
        ; line_number #948
        (dload_0)                                               ; 73
        (invokestatic 6)                                        ; 74 FdlibmTranslitN$Fabs.compute:(D)D
        (invokestatic 11)                                       ; 77 FdlibmTranslitN$Exp.compute:(D)D
        (dstore_2)                                              ; 80
        ; line_number #949
        (ldc2_w 12)                                             ; 81 0.5d
        (dload_2)                                               ; 84
        (dmul)                                                  ; 85
        (ldc2_w 12)                                             ; 86 0.5d
        (dload_2)                                               ; 89
        (ddiv)                                                  ; 90
        (dadd)                                                  ; 91
        (dreturn)                                               ; 92
        ; line_number #953
        (iload 6)                                               ; 93
        (ldc 14)                                                ; 95 1082535490
        (if_icmpge 15)                                          ; 97
        (ldc2_w 12)                                             ; 100 0.5d
        (dload_0)                                               ; 103
        (invokestatic 6)                                        ; 104 FdlibmTranslitN$Fabs.compute:(D)D
        (invokestatic 11)                                       ; 107 FdlibmTranslitN$Exp.compute:(D)D
        (dmul)                                                  ; 110
        (dreturn)                                               ; 111
        ; line_number #956
        (dload_0)                                               ; 112
        (invokestatic 15)                                       ; 113 FdlibmTranslitN.access$400:(D)[I
        (dconst_1)                                              ; 116
        (invokestatic 15)                                       ; 117 FdlibmTranslitN.access$400:(D)[I
        (iconst_0)                                              ; 120
        (iaload)                                                ; 121
        (bipush 29)                                             ; 122
        (iushr)                                                 ; 124
        (iaload)                                                ; 125
        (istore 7)                                              ; 126
        ; line_number #957
        (iload 6)                                               ; 128
        (ldc 16)                                                ; 130 1082536910
        (if_icmplt 20)                                          ; 132
        (iload 6)                                               ; 135
        (ldc 16)                                                ; 137 1082536910
        (if_icmpne 38)                                          ; 139
        (iload 7)                                               ; 142
        (ldc 17)                                                ; 144 -1883637635
        ; line_number #958
        (invokestatic 18)                                       ; 146 java.lang.Integer.compareUnsigned:(II)I
        (ifgt 28)                                               ; 149
        ; line_number #959
        (ldc2_w 12)                                             ; 152 0.5d
        (dload_0)                                               ; 155
        (invokestatic 6)                                        ; 156 FdlibmTranslitN$Fabs.compute:(D)D
        (dmul)                                                  ; 159
        (invokestatic 11)                                       ; 160 FdlibmTranslitN$Exp.compute:(D)D
        (dstore 4)                                              ; 163
        ; line_number #960
        (ldc2_w 12)                                             ; 165 0.5d
        (dload 4)                                               ; 168
        (dmul)                                                  ; 170
        (dstore_2)                                              ; 171
        ; line_number #961
        (dload_2)                                               ; 172
        (dload 4)                                               ; 173
        (dmul)                                                  ; 175
        (dreturn)                                               ; 176
        ; line_number #965
        (ldc2_w 19)                                             ; 177 Infinityd
        (dreturn)                                               ; 180
       ))
     '(ref -1)))