; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslit$Atan*
    (make-class-decl
     "FdlibmTranslit$Atan"
     '("java/lang/Object")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 1
       (methodref "FdlibmTranslit" "access$000:(D)I" 2)         ; 2
       (integer 2147483647)                                     ; 3
       (integer 1141899264)                                     ; 4
       (integer 2146435072)                                     ; 5
       (methodref "FdlibmTranslit" "access$100:(D)I" 2)         ; 6
       (fieldref "FdlibmTranslit$Atan" "atanhi:[D" 1)           ; 7
       (fieldref "FdlibmTranslit$Atan" "atanlo:[D" 1)           ; 8
       (integer 1071382528)                                     ; 9
       (integer 1042284544)                                     ; 10
       (class (ref -1) "FdlibmTranslit$Atan")                   ; 11
       (double #x7e37e43c8800759c) ; 0x1.7e43c8800759cp996 1.0E300      ; 12
       nil
       (methodref "FdlibmTranslit$Fabs" "compute:(D)D" 2)       ; 14
       (integer 1072889856)                                     ; 15
       (integer 1072037888)                                     ; 16
       (double #x4000000000000000) ; 0x1.0p1 2.0                ; 17
       nil
       (integer 1073971200)                                     ; 19
       (double #x3ff8000000000000) ; 0x1.8p0 1.5                ; 20
       nil
       (double #xbff0000000000000) ; -0x1.0p0 -1.0              ; 22
       nil
       (fieldref "FdlibmTranslit$Atan" "aT:[D" 1)               ; 24
       (double #x3fddac670561bb4f) ; 0x1.dac670561bb4fp-2 0.4636476090008061    ; 25
       nil
       (double #x3fe921fb54442d18) ; 0x1.921fb54442d18p-1 0.7853981633974483    ; 27
       nil
       (double #x3fef730bd281f69b) ; 0x1.f730bd281f69bp-1 0.982793723247329     ; 29
       nil
       (double #x3ff921fb54442d18) ; 0x1.921fb54442d18p0 1.5707963267948966     ; 31
       nil
       (double #x3c7a2b7f222f65e2) ; 0x1.a2b7f222f65e2p-56 2.2698777452961687E-17       ; 33
       nil
       (double #x3c81a62633145c07) ; 0x1.1a62633145c07p-55 3.061616997868383E-17        ; 35
       nil
       (double #x3c7007887af0cbbd) ; 0x1.007887af0cbbdp-56 1.3903311031230998E-17       ; 37
       nil
       (double #x3c91a62633145c07) ; 0x1.1a62633145c07p-54 6.123233995736766E-17        ; 39
       nil
       (double #x3fd555555555550d) ; 0x1.555555555550dp-2 0.3333333333333293    ; 41
       nil
       (double #xbfc999999998ebc4) ; -0x1.999999998ebc4p-3 -0.19999999999876483 ; 43
       nil
       (double #x3fc24924920083ff) ; 0x1.24924920083ffp-3 0.14285714272503466   ; 45
       nil
       (double #xbfbc71c6fe231671) ; -0x1.c71c6fe231671p-4 -0.11111110405462356 ; 47
       nil
       (double #x3fb745cdc54c206e) ; 0x1.745cdc54c206ep-4 0.09090887133436507   ; 49
       nil
       (double #xbfb3b0f2af749a6d) ; -0x1.3b0f2af749a6dp-4 -0.0769187620504483  ; 51
       nil
       (double #x3fb10d66a0d03d51) ; 0x1.10d66a0d03d51p-4 0.06661073137387531   ; 53
       nil
       (double #xbfadde2d52defd9a) ; -0x1.dde2d52defd9ap-5 -0.058335701337905735        ; 55
       nil
       (double #x3fa97b4b24760deb) ; 0x1.97b4b24760debp-5 0.049768779946159324  ; 57
       nil
       (double #xbfa2b4442c6a6c2f) ; -0x1.2b4442c6a6c2fp-5 -0.036531572744216916        ; 59
       nil
       (double #x3f90ad3ae322da11) ; 0x1.0ad3ae322da11p-6 0.016285820115365782  ; 61
       nil
       (class (ref -1) "java/lang/Object")                      ; 63
       (utf8)                                                   ; 64
       (utf8)                                                   ; 65
       (utf8)                                                   ; 66
       (utf8)                                                   ; 67
       (utf8)                                                   ; 68
       (utf8)                                                   ; 69
       (utf8)                                                   ; 70
       (double #x3ff0000000000000) ; 0x1.0p0 1.0                ; 71
       nil
       (utf8)                                                   ; 73
       (utf8)                                                   ; 74
       (utf8)                                                   ; 75
       (utf8)                                                   ; 76
       (utf8)                                                   ; 77
       (utf8)                                                   ; 78
       (utf8)                                                   ; 79
       (utf8)                                                   ; 80
       (utf8)                                                   ; 81
       (utf8)                                                   ; 82
       (utf8)                                                   ; 83
       (name-and-type "<init>:()V")                             ; 84
       (class (ref -1) "FdlibmTranslit")                        ; 85
       (name-and-type "access$000:(D)I")                        ; 86
       (name-and-type "access$100:(D)I")                        ; 87
       (name-and-type "atanhi:[D")                              ; 88
       (name-and-type "atanlo:[D")                              ; 89
       (utf8)                                                   ; 90
       (utf8)                                                   ; 91
       (utf8)                                                   ; 92
       (class (ref -1) "FdlibmTranslit$Fabs")                   ; 93
       (name-and-type "compute:(D)D")                           ; 94
       (name-and-type "aT:[D")                                  ; 95
       (utf8)                                                   ; 96
       (utf8)                                                   ; 97
       (utf8)                                                   ; 98
       (utf8)                                                   ; 99
       (utf8)                                                   ; 100
       (utf8)                                                   ; 101
       (utf8)                                                   ; 102
      )
     #x00000020                                                 ; SUPER
     '(
       ("atanhi:[D" #x0000001a)                                 ; PRIVATE STATIC FINAL
       ("atanlo:[D" #x0000001a)                                 ; PRIVATE STATIC FINAL
       ("aT:[D" #x0000001a)                                     ; PRIVATE STATIC FINAL
       ("one:D" #x0000001a)                                     ; PRIVATE STATIC FINAL
       ("huge:D" #x0000001a)                                    ; PRIVATE STATIC FINAL
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #356
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" #x00000808                               ; STATIC STRICT
        ; line_number #390
        (dload_0)                                               ; 0
        (invokestatic 2)                                        ; 1 FdlibmTranslit.access$000:(D)I
        (istore 11)                                             ; 4
        ; line_number #391
        (iload 11)                                              ; 6
        (ldc 3)                                                 ; 8 2147483647
        (iand)                                                  ; 10
        (istore 10)                                             ; 11
        ; line_number #392
        (iload 10)                                              ; 13
        (ldc 4)                                                 ; 15 1141899264
        (if_icmplt 58)                                          ; 17
        ; line_number #394
        (iload 10)                                              ; 20
        (ldc 5)                                                 ; 22 2146435072
        (if_icmpgt 17)                                          ; 24
        (iload 10)                                              ; 27
        (ldc 5)                                                 ; 29 2146435072
        (if_icmpne 14)                                          ; 31
        (dload_0)                                               ; 34
        ; line_number #395
        (invokestatic 6)                                        ; 35 FdlibmTranslit.access$100:(D)I
        (ifeq 7)                                                ; 38
        ; line_number #396
        (dload_0)                                               ; 41
        (dload_0)                                               ; 42
        (dadd)                                                  ; 43
        (dreturn)                                               ; 44
        ; line_number #398
        (iload 11)                                              ; 45
        (ifle 15)                                               ; 47
        ; line_number #399
        (getstatic 7)                                           ; 50 FdlibmTranslit$Atan.atanhi:[D
        (iconst_3)                                              ; 53
        (daload)                                                ; 54
        (getstatic 8)                                           ; 55 FdlibmTranslit$Atan.atanlo:[D
        (iconst_3)                                              ; 58
        (daload)                                                ; 59
        (dadd)                                                  ; 60
        (dreturn)                                               ; 61
        ; line_number #401
        (getstatic 7)                                           ; 62 FdlibmTranslit$Atan.atanhi:[D
        (iconst_3)                                              ; 65
        (daload)                                                ; 66
        (dneg)                                                  ; 67
        (getstatic 8)                                           ; 68 FdlibmTranslit$Atan.atanlo:[D
        (iconst_3)                                              ; 71
        (daload)                                                ; 72
        (dsub)                                                  ; 73
        (dreturn)                                               ; 74
        ; line_number #404
        (iload 10)                                              ; 75
        (ldc 9)                                                 ; 77 1071382528
        (if_icmpge 28)                                          ; 79
        ; line_number #406
        (iload 10)                                              ; 82
        (ldc 10)                                                ; 84 1042284544
        (if_icmpge 15)                                          ; 86
        ; line_number #408
        (ldc2_w 12)                                             ; 89 1.0E300d
        (dload_0)                                               ; 92
        (dadd)                                                  ; 93
        (dconst_1)                                              ; 94
        (dcmpl)                                                 ; 95
        (ifle 5)                                                ; 96
        ; line_number #409
        (dload_0)                                               ; 99
        (dreturn)                                               ; 100
        ; line_number #412
        (iconst_m1)                                             ; 101
        (istore 12)                                             ; 102
        (goto 92)                                               ; 104
        ; line_number #414
        (dload_0)                                               ; 107
        (invokestatic 14)                                       ; 108 FdlibmTranslit$Fabs.compute:(D)D
        (dstore_0)                                              ; 111
        ; line_number #415
        (iload 10)                                              ; 112
        (ldc 15)                                                ; 114 1072889856
        (if_icmpge 44)                                          ; 116
        ; line_number #417
        (iload 10)                                              ; 119
        (ldc 16)                                                ; 121 1072037888
        (if_icmpge 23)                                          ; 123
        ; line_number #419
        (iconst_0)                                              ; 126
        (istore 12)                                             ; 127
        ; line_number #420
        (ldc2_w 17)                                             ; 129 2.0d
        (dload_0)                                               ; 132
        (dmul)                                                  ; 133
        (dconst_1)                                              ; 134
        (dsub)                                                  ; 135
        (ldc2_w 17)                                             ; 136 2.0d
        (dload_0)                                               ; 139
        (dadd)                                                  ; 140
        (ddiv)                                                  ; 141
        (dstore_0)                                              ; 142
        (goto 53)                                               ; 143
        ; line_number #423
        (iconst_1)                                              ; 146
        (istore 12)                                             ; 147
        ; line_number #424
        (dload_0)                                               ; 149
        (dconst_1)                                              ; 150
        (dsub)                                                  ; 151
        (dload_0)                                               ; 152
        (dconst_1)                                              ; 153
        (dadd)                                                  ; 154
        (ddiv)                                                  ; 155
        (dstore_0)                                              ; 156
        (goto 39)                                               ; 157
        ; line_number #426
        (iload 10)                                              ; 160
        (ldc 19)                                                ; 162 1073971200
        (if_icmpge 23)                                          ; 164
        ; line_number #428
        (iconst_2)                                              ; 167
        (istore 12)                                             ; 168
        ; line_number #429
        (dload_0)                                               ; 170
        (ldc2_w 20)                                             ; 171 1.5d
        (dsub)                                                  ; 174
        (dconst_1)                                              ; 175
        (ldc2_w 20)                                             ; 176 1.5d
        (dload_0)                                               ; 179
        (dmul)                                                  ; 180
        (dadd)                                                  ; 181
        (ddiv)                                                  ; 182
        (dstore_0)                                              ; 183
        (goto 12)                                               ; 184
        ; line_number #432
        (iconst_3)                                              ; 187
        (istore 12)                                             ; 188
        ; line_number #433
        (ldc2_w 22)                                             ; 190 -1.0d
        (dload_0)                                               ; 193
        (ddiv)                                                  ; 194
        (dstore_0)                                              ; 195
        ; line_number #437
        (dload_0)                                               ; 196
        (dload_0)                                               ; 197
        (dmul)                                                  ; 198
        (dstore 8)                                              ; 199
        ; line_number #438
        (dload 8)                                               ; 201
        (dload 8)                                               ; 203
        (dmul)                                                  ; 205
        (dstore_2)                                              ; 206
        ; line_number #440
        (dload 8)                                               ; 207
        (getstatic 24)                                          ; 209 FdlibmTranslit$Atan.aT:[D
        (iconst_0)                                              ; 212
        (daload)                                                ; 213
        (dload_2)                                               ; 214
        (getstatic 24)                                          ; 215 FdlibmTranslit$Atan.aT:[D
        (iconst_2)                                              ; 218
        (daload)                                                ; 219
        (dload_2)                                               ; 220
        (getstatic 24)                                          ; 221 FdlibmTranslit$Atan.aT:[D
        (iconst_4)                                              ; 224
        (daload)                                                ; 225
        (dload_2)                                               ; 226
        (getstatic 24)                                          ; 227 FdlibmTranslit$Atan.aT:[D
        (bipush 6)                                              ; 230
        (daload)                                                ; 232
        (dload_2)                                               ; 233
        (getstatic 24)                                          ; 234 FdlibmTranslit$Atan.aT:[D
        (bipush 8)                                              ; 237
        (daload)                                                ; 239
        (dload_2)                                               ; 240
        (getstatic 24)                                          ; 241 FdlibmTranslit$Atan.aT:[D
        (bipush 10)                                             ; 244
        (daload)                                                ; 246
        (dmul)                                                  ; 247
        (dadd)                                                  ; 248
        (dmul)                                                  ; 249
        (dadd)                                                  ; 250
        (dmul)                                                  ; 251
        (dadd)                                                  ; 252
        (dmul)                                                  ; 253
        (dadd)                                                  ; 254
        (dmul)                                                  ; 255
        (dadd)                                                  ; 256
        (dmul)                                                  ; 257
        (dstore 4)                                              ; 258
        ; line_number #441
        (dload_2)                                               ; 260
        (getstatic 24)                                          ; 261 FdlibmTranslit$Atan.aT:[D
        (iconst_1)                                              ; 264
        (daload)                                                ; 265
        (dload_2)                                               ; 266
        (getstatic 24)                                          ; 267 FdlibmTranslit$Atan.aT:[D
        (iconst_3)                                              ; 270
        (daload)                                                ; 271
        (dload_2)                                               ; 272
        (getstatic 24)                                          ; 273 FdlibmTranslit$Atan.aT:[D
        (iconst_5)                                              ; 276
        (daload)                                                ; 277
        (dload_2)                                               ; 278
        (getstatic 24)                                          ; 279 FdlibmTranslit$Atan.aT:[D
        (bipush 7)                                              ; 282
        (daload)                                                ; 284
        (dload_2)                                               ; 285
        (getstatic 24)                                          ; 286 FdlibmTranslit$Atan.aT:[D
        (bipush 9)                                              ; 289
        (daload)                                                ; 291
        (dmul)                                                  ; 292
        (dadd)                                                  ; 293
        (dmul)                                                  ; 294
        (dadd)                                                  ; 295
        (dmul)                                                  ; 296
        (dadd)                                                  ; 297
        (dmul)                                                  ; 298
        (dadd)                                                  ; 299
        (dmul)                                                  ; 300
        (dstore 6)                                              ; 301
        ; line_number #442
        (iload 12)                                              ; 303
        (ifge 13)                                               ; 305
        ; line_number #443
        (dload_0)                                               ; 308
        (dload_0)                                               ; 309
        (dload 4)                                               ; 310
        (dload 6)                                               ; 312
        (dadd)                                                  ; 314
        (dmul)                                                  ; 315
        (dsub)                                                  ; 316
        (dreturn)                                               ; 317
        ; line_number #445
        (getstatic 7)                                           ; 318 FdlibmTranslit$Atan.atanhi:[D
        (iload 12)                                              ; 321
        (daload)                                                ; 323
        (dload_0)                                               ; 324
        (dload 4)                                               ; 325
        (dload 6)                                               ; 327
        (dadd)                                                  ; 329
        (dmul)                                                  ; 330
        (getstatic 8)                                           ; 331 FdlibmTranslit$Atan.atanlo:[D
        (iload 12)                                              ; 334
        (daload)                                                ; 336
        (dsub)                                                  ; 337
        (dload_0)                                               ; 338
        (dsub)                                                  ; 339
        (dsub)                                                  ; 340
        (dstore 8)                                              ; 341
        ; line_number #446
        (iload 11)                                              ; 343
        (ifge 9)                                                ; 345
        (dload 8)                                               ; 348
        (dneg)                                                  ; 350
        (goto 5)                                                ; 351
        (dload 8)                                               ; 354
        (dreturn)                                               ; 356
       )
      '("<clinit>:()V" #x00000008                               ; STATIC
        ; line_number #358
        (iconst_4)                                              ; 0
        (newarray T_DOUBLE)                                     ; 1
        (dup)                                                   ; 3
        (iconst_0)                                              ; 4
        (ldc2_w 25)                                             ; 5 0.4636476090008061d
        (dastore)                                               ; 8
        (dup)                                                   ; 9
        (iconst_1)                                              ; 10
        (ldc2_w 27)                                             ; 11 0.7853981633974483d
        (dastore)                                               ; 14
        (dup)                                                   ; 15
        (iconst_2)                                              ; 16
        (ldc2_w 29)                                             ; 17 0.982793723247329d
        (dastore)                                               ; 20
        (dup)                                                   ; 21
        (iconst_3)                                              ; 22
        (ldc2_w 31)                                             ; 23 1.5707963267948966d
        (dastore)                                               ; 26
        (putstatic 7)                                           ; 27 FdlibmTranslit$Atan.atanhi:[D
        ; line_number #364
        (iconst_4)                                              ; 30
        (newarray T_DOUBLE)                                     ; 31
        (dup)                                                   ; 33
        (iconst_0)                                              ; 34
        (ldc2_w 33)                                             ; 35 2.2698777452961687E-17d
        (dastore)                                               ; 38
        (dup)                                                   ; 39
        (iconst_1)                                              ; 40
        (ldc2_w 35)                                             ; 41 3.061616997868383E-17d
        (dastore)                                               ; 44
        (dup)                                                   ; 45
        (iconst_2)                                              ; 46
        (ldc2_w 37)                                             ; 47 1.3903311031230998E-17d
        (dastore)                                               ; 50
        (dup)                                                   ; 51
        (iconst_3)                                              ; 52
        (ldc2_w 39)                                             ; 53 6.123233995736766E-17d
        (dastore)                                               ; 56
        (putstatic 8)                                           ; 57 FdlibmTranslit$Atan.atanlo:[D
        ; line_number #370
        (bipush 11)                                             ; 60
        (newarray T_DOUBLE)                                     ; 62
        (dup)                                                   ; 64
        (iconst_0)                                              ; 65
        (ldc2_w 41)                                             ; 66 0.3333333333333293d
        (dastore)                                               ; 69
        (dup)                                                   ; 70
        (iconst_1)                                              ; 71
        (ldc2_w 43)                                             ; 72 -0.19999999999876483d
        (dastore)                                               ; 75
        (dup)                                                   ; 76
        (iconst_2)                                              ; 77
        (ldc2_w 45)                                             ; 78 0.14285714272503466d
        (dastore)                                               ; 81
        (dup)                                                   ; 82
        (iconst_3)                                              ; 83
        (ldc2_w 47)                                             ; 84 -0.11111110405462356d
        (dastore)                                               ; 87
        (dup)                                                   ; 88
        (iconst_4)                                              ; 89
        (ldc2_w 49)                                             ; 90 0.09090887133436507d
        (dastore)                                               ; 93
        (dup)                                                   ; 94
        (iconst_5)                                              ; 95
        (ldc2_w 51)                                             ; 96 -0.0769187620504483d
        (dastore)                                               ; 99
        (dup)                                                   ; 100
        (bipush 6)                                              ; 101
        (ldc2_w 53)                                             ; 103 0.06661073137387531d
        (dastore)                                               ; 106
        (dup)                                                   ; 107
        (bipush 7)                                              ; 108
        (ldc2_w 55)                                             ; 110 -0.058335701337905735d
        (dastore)                                               ; 113
        (dup)                                                   ; 114
        (bipush 8)                                              ; 115
        (ldc2_w 57)                                             ; 117 0.049768779946159324d
        (dastore)                                               ; 120
        (dup)                                                   ; 121
        (bipush 9)                                              ; 122
        (ldc2_w 59)                                             ; 124 -0.036531572744216916d
        (dastore)                                               ; 127
        (dup)                                                   ; 128
        (bipush 10)                                             ; 129
        (ldc2_w 61)                                             ; 131 0.016285820115365782d
        (dastore)                                               ; 134
        (putstatic 24)                                          ; 135 FdlibmTranslit$Atan.aT:[D
        (return)                                                ; 138
       ))
     '(ref -1)))