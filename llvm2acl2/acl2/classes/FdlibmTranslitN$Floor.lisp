; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslitN$Floor*
    (make-class-decl
     "FdlibmTranslitN$Floor"
     '("java/lang/Object")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 1
       (methodref "FdlibmTranslitN" "access$000:(D)I" 2)        ; 2
       (methodref "FdlibmTranslitN" "access$100:(D)I" 2)        ; 3
       (class (ref -1) "FdlibmTranslitN$Floor")                 ; 4
       (double #x7e37e43c8800759c) ; 0x1.7e43c8800759cp996 1.0E300      ; 5
       nil
       (integer 2147483647)                                     ; 7
       (integer -1074790400)                                    ; 8
       (integer 1048575)                                        ; 9
       (integer 1048576)                                        ; 10
       (methodref "java/lang/Integer" "compareUnsigned:(II)I" 2)        ; 11
       (methodref "FdlibmTranslitN" "access$300:(DI)D" 3)       ; 12
       (methodref "FdlibmTranslitN" "access$200:(DI)D" 3)       ; 13
       (class (ref -1) "java/lang/Object")                      ; 14
       (utf8)                                                   ; 15
       (utf8)                                                   ; 16
       (utf8)                                                   ; 17
       (utf8)                                                   ; 18
       (utf8)                                                   ; 19
       (utf8)                                                   ; 20
       (utf8)                                                   ; 21
       (utf8)                                                   ; 22
       (utf8)                                                   ; 23
       (utf8)                                                   ; 24
       (utf8)                                                   ; 25
       (utf8)                                                   ; 26
       (name-and-type "<init>:()V")                             ; 27
       (class (ref -1) "FdlibmTranslitN")                       ; 28
       (name-and-type "access$000:(D)I")                        ; 29
       (name-and-type "access$100:(D)I")                        ; 30
       (utf8)                                                   ; 31
       (utf8)                                                   ; 32
       (utf8)                                                   ; 33
       (class (ref -1) "java/lang/Integer")                     ; 34
       (name-and-type "compareUnsigned:(II)I")                  ; 35
       (name-and-type "access$300:(DI)D")                       ; 36
       (name-and-type "access$200:(DI)D")                       ; 37
       (utf8)                                                   ; 38
       (utf8)                                                   ; 39
       (utf8)                                                   ; 40
       (utf8)                                                   ; 41
       (utf8)                                                   ; 42
       (utf8)                                                   ; 43
       (utf8)                                                   ; 44
       (utf8)                                                   ; 45
       (utf8)                                                   ; 46
       (utf8)                                                   ; 47
       (utf8)                                                   ; 48
      )
     #x00000020                                                 ; SUPER
     '(
       ("huge:D" #x00000018)                                    ; STATIC FINAL
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #1380
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" #x00000808                               ; STATIC STRICT
        ; line_number #1392
        (dload_0)                                               ; 0
        (invokestatic 2)                                        ; 1 FdlibmTranslitN.access$000:(D)I
        (istore_2)                                              ; 4
        ; line_number #1393
        (dload_0)                                               ; 5
        (invokestatic 3)                                        ; 6 FdlibmTranslitN.access$100:(D)I
        (istore_3)                                              ; 9
        ; line_number #1394
        (iload_2)                                               ; 10
        (bipush 20)                                             ; 11
        (ishr)                                                  ; 13
        (sipush 2047)                                           ; 14
        (iand)                                                  ; 17
        (sipush 1023)                                           ; 18
        (isub)                                                  ; 21
        (istore 4)                                              ; 22
        ; line_number #1395
        (iload 4)                                               ; 24
        (bipush 20)                                             ; 26
        (if_icmpge 98)                                          ; 28
        ; line_number #1396
        (iload 4)                                               ; 31
        (ifge 41)                                               ; 33
        ; line_number #1397
        (ldc2_w 5)                                              ; 36 1.0E300d
        (dload_0)                                               ; 39
        (dadd)                                                  ; 40
        (dconst_0)                                              ; 41
        (dcmpl)                                                 ; 42
        (ifle 182)                                              ; 43
        ; line_number #1398
        (iload_2)                                               ; 46
        (iflt 10)                                               ; 47
        (iconst_0)                                              ; 50
        (dup)                                                   ; 51
        (istore_3)                                              ; 52
        (istore_2)                                              ; 53
        (goto 171)                                              ; 54
        ; line_number #1399
        (iload_2)                                               ; 57
        (ldc 7)                                                 ; 58 2147483647
        (iand)                                                  ; 60
        (iload_3)                                               ; 61
        (ior)                                                   ; 62
        (ifeq 162)                                              ; 63
        ; line_number #1400
        (ldc 8)                                                 ; 66 -1074790400
        (istore_2)                                              ; 68
        (iconst_0)                                              ; 69
        (istore_3)                                              ; 70
        (goto 154)                                              ; 71
        ; line_number #1403
        (ldc 9)                                                 ; 74 1048575
        (iload 4)                                               ; 76
        (ishr)                                                  ; 78
        (istore 5)                                              ; 79
        ; line_number #1404
        (iload_2)                                               ; 81
        (iload 5)                                               ; 82
        (iand)                                                  ; 84
        (iload_3)                                               ; 85
        (ior)                                                   ; 86
        (ifne 5)                                                ; 87
        (dload_0)                                               ; 90
        (dreturn)                                               ; 91
        ; line_number #1405
        (ldc2_w 5)                                              ; 92 1.0E300d
        (dload_0)                                               ; 95
        (dadd)                                                  ; 96
        (dconst_0)                                              ; 97
        (dcmpl)                                                 ; 98
        (ifle 126)                                              ; 99
        ; line_number #1406
        (iload_2)                                               ; 102
        (ifge 11)                                               ; 103
        (iload_2)                                               ; 106
        (ldc 10)                                                ; 107 1048576
        (iload 4)                                               ; 109
        (ishr)                                                  ; 111
        (iadd)                                                  ; 112
        (istore_2)                                              ; 113
        ; line_number #1407
        (iload_2)                                               ; 114
        (iload 5)                                               ; 115
        (iconst_m1)                                             ; 117
        (ixor)                                                  ; 118
        (iand)                                                  ; 119
        (istore_2)                                              ; 120
        (iconst_0)                                              ; 121
        (istore_3)                                              ; 122
        (goto 102)                                              ; 123
        ; line_number #1410
        (iload 4)                                               ; 126
        (bipush 51)                                             ; 128
        (if_icmple 17)                                          ; 130
        ; line_number #1411
        (iload 4)                                               ; 133
        (sipush 1024)                                           ; 135
        (if_icmpne 7)                                           ; 138
        (dload_0)                                               ; 141
        (dload_0)                                               ; 142
        (dadd)                                                  ; 143
        (dreturn)                                               ; 144
        ; line_number #1412
        (dload_0)                                               ; 145
        (dreturn)                                               ; 146
        ; line_number #1414
        (iconst_m1)                                             ; 147
        (iload 4)                                               ; 148
        (bipush 20)                                             ; 150
        (isub)                                                  ; 152
        (iushr)                                                 ; 153
        (istore 5)                                              ; 154
        ; line_number #1415
        (iload_3)                                               ; 156
        (iload 5)                                               ; 157
        (iand)                                                  ; 159
        (ifne 5)                                                ; 160
        (dload_0)                                               ; 163
        (dreturn)                                               ; 164
        ; line_number #1416
        (ldc2_w 5)                                              ; 165 1.0E300d
        (dload_0)                                               ; 168
        (dadd)                                                  ; 169
        (dconst_0)                                              ; 170
        (dcmpl)                                                 ; 171
        (ifle 53)                                               ; 172
        ; line_number #1417
        (iload_2)                                               ; 175
        (ifge 42)                                               ; 176
        ; line_number #1418
        (iload 4)                                               ; 179
        (bipush 20)                                             ; 181
        (if_icmpne 9)                                           ; 183
        (iinc 2 1)                                              ; 186
        (goto 29)                                               ; 189
        ; line_number #1420
        (iload_3)                                               ; 192
        (iconst_1)                                              ; 193
        (bipush 52)                                             ; 194
        (iload 4)                                               ; 196
        (isub)                                                  ; 198
        (ishl)                                                  ; 199
        (iadd)                                                  ; 200
        (istore 6)                                              ; 201
        ; line_number #1421
        (iload 6)                                               ; 203
        (iload_3)                                               ; 205
        (invokestatic 11)                                       ; 206 java.lang.Integer.compareUnsigned:(II)I
        (ifge 6)                                                ; 209
        (iinc 2 1)                                              ; 212
        ; line_number #1422
        (iload 6)                                               ; 215
        (istore_3)                                              ; 217
        ; line_number #1425
        (iload_3)                                               ; 218
        (iload 5)                                               ; 219
        (iconst_m1)                                             ; 221
        (ixor)                                                  ; 222
        (iand)                                                  ; 223
        (istore_3)                                              ; 224
        ; line_number #1428
        (dload_0)                                               ; 225
        (iload_2)                                               ; 226
        (invokestatic 12)                                       ; 227 FdlibmTranslitN.access$300:(DI)D
        (dstore_0)                                              ; 230
        ; line_number #1429
        (dload_0)                                               ; 231
        (iload_3)                                               ; 232
        (invokestatic 13)                                       ; 233 FdlibmTranslitN.access$200:(DI)D
        (dstore_0)                                              ; 236
        ; line_number #1430
        (dload_0)                                               ; 237
        (dreturn)                                               ; 238
       ))
     '(ref -1)))