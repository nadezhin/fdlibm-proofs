; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslit$Log*
    (make-class-decl
     "FdlibmTranslit$Log"
     '("java/lang/Object")
     '()
     '(
      "ln2_hi:D"
      "ln2_lo:D"
      "two54:D"
      "Lg1:D"
      "Lg2:D"
      "Lg3:D"
      "Lg4:D"
      "Lg5:D"
      "Lg6:D"
      "Lg7:D"
      "zero:D")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)           ; 1
       (methodref "FdlibmTranslit" "access$000:(D)I" 2)        ; 2
       (methodref "FdlibmTranslit" "access$100:(D)I" 2)        ; 3
       (integer 1048576)                                       ; 4
       (integer 2147483647)                                    ; 5
       (class (ref -1) "FdlibmTranslit$Log")                   ; 6
       (double #xfff0000000000000) ; -Infinity -Infinity       ; 7
       nil
       (double #x4350000000000000) ; 0x1.0p54 1.8014398509481984E16    ; 9
       nil
       (integer 2146435072)                                    ; 11
       (integer 1048575)                                       ; 12
       (integer 614244)                                        ; 13
       (integer 1072693248)                                    ; 14
       (methodref "FdlibmTranslit" "access$400:(DI)D" 3)       ; 15
       (double #x3fe62e42fee00000) ; 0x1.62e42feep-1 0.6931471803691238        ; 16
       nil
       (double #x3dea39ef35793c76) ; 0x1.a39ef35793c76p-33 1.9082149292705877E-10      ; 18
       nil
       (double #x3fe0000000000000) ; 0x1.0p-1 0.5              ; 20
       nil
       (double #x3fd5555555555555) ; 0x1.5555555555555p-2 0.3333333333333333   ; 22
       nil
       (double #x4000000000000000) ; 0x1.0p1 2.0               ; 24
       nil
       (integer 398458)                                        ; 26
       (integer 440401)                                        ; 27
       (double #x3fd999999997fa04) ; 0x1.999999997fa04p-2 0.3999999999940942   ; 28
       nil
       (double #x3fcc71c51d8e78af) ; 0x1.c71c51d8e78afp-3 0.22222198432149784  ; 30
       nil
       (double #x3fc39a09d078c69f) ; 0x1.39a09d078c69fp-3 0.15313837699209373  ; 32
       nil
       (double #x3fe5555555555593) ; 0x1.5555555555593p-1 0.6666666666666735   ; 34
       nil
       (double #x3fd2492494229359) ; 0x1.2492494229359p-2 0.2857142874366239   ; 36
       nil
       (double #x3fc7466496cb03de) ; 0x1.7466496cb03dep-3 0.1818357216161805   ; 38
       nil
       (double #x3fc2f112df3e5244) ; 0x1.2f112df3e5244p-3 0.14798198605116586  ; 40
       nil
       (class (ref -1) "java/lang/Object")                     ; 42
       (utf8)                                                  ; 43
       (utf8)                                                  ; 44
       (utf8)                                                  ; 45
       (utf8)                                                  ; 46
       (utf8)                                                  ; 47
       (utf8)                                                  ; 48
       (utf8)                                                  ; 49
       (utf8)                                                  ; 50
       (utf8)                                                  ; 51
       (utf8)                                                  ; 52
       (utf8)                                                  ; 53
       (utf8)                                                  ; 54
       (utf8)                                                  ; 55
       (double #x0000000000000000) ; 0x0.0p0 0.0               ; 56
       nil
       (utf8)                                                  ; 58
       (utf8)                                                  ; 59
       (utf8)                                                  ; 60
       (utf8)                                                  ; 61
       (utf8)                                                  ; 62
       (utf8)                                                  ; 63
       (utf8)                                                  ; 64
       (utf8)                                                  ; 65
       (utf8)                                                  ; 66
       (name-and-type "<init>:()V")                            ; 67
       (class (ref -1) "FdlibmTranslit")                       ; 68
       (name-and-type "access$000:(D)I")                       ; 69
       (name-and-type "access$100:(D)I")                       ; 70
       (utf8)                                                  ; 71
       (utf8)                                                  ; 72
       (utf8)                                                  ; 73
       (name-and-type "access$400:(DI)D")                      ; 74
       (utf8)                                                  ; 75
       (utf8)                                                  ; 76
       (utf8)                                                  ; 77
       (utf8)                                                  ; 78
       (utf8)                                                  ; 79
       (utf8)                                                  ; 80
       (utf8)                                                  ; 81
      )
     (list
      '("<init>:()V" nil
        ; line_number #1508
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(D)D" nil
        ; line_number #1528
        (dload_0)                                               ; 0
        (invokestatic 2)                                        ; 1 FdlibmTranslit.access$000:(D)I
        (istore 21)                                             ; 4
        ; line_number #1530
        (dload_0)                                               ; 6
        (invokestatic 3)                                        ; 7 FdlibmTranslit.access$100:(D)I
        (istore 24)                                             ; 10
        ; line_number #1533
        (iconst_0)                                              ; 12
        (istore 20)                                             ; 13
        ; line_number #1534
        (iload 21)                                              ; 15
        (ldc 4)                                                 ; 17 1048576
        (if_icmpge 44)                                          ; 19
        ; line_number #1536
        (iload 21)                                              ; 22
        (ldc 5)                                                 ; 24 2147483647
        (iand)                                                  ; 26
        (iload 24)                                              ; 27
        (ior)                                                   ; 29
        (ifne 7)                                                ; 30
        ; line_number #1537
        (ldc2_w 7)                                              ; 33 -Infinityd
        (dreturn)                                               ; 36
        ; line_number #1539
        (iload 21)                                              ; 37
        (ifge 9)                                                ; 39
        ; line_number #1540
        (dload_0)                                               ; 42
        (dload_0)                                               ; 43
        (dsub)                                                  ; 44
        (dconst_0)                                              ; 45
        (ddiv)                                                  ; 46
        (dreturn)                                               ; 47
        ; line_number #1542
        (iinc 20 -54)                                           ; 48
        ; line_number #1543
        (dload_0)                                               ; 51
        (ldc2_w 9)                                              ; 52 1.8014398509481984E16d
        (dmul)                                                  ; 55
        (dstore_0)                                              ; 56
        ; line_number #1545
        (dload_0)                                               ; 57
        (invokestatic 2)                                        ; 58 FdlibmTranslit.access$000:(D)I
        (istore 21)                                             ; 61
        ; line_number #1548
        (iload 21)                                              ; 63
        (ldc 11)                                                ; 65 2146435072
        (if_icmplt 7)                                           ; 67
        ; line_number #1549
        (dload_0)                                               ; 70
        (dload_0)                                               ; 71
        (dadd)                                                  ; 72
        (dreturn)                                               ; 73
        ; line_number #1551
        (iload 20)                                              ; 74
        (iload 21)                                              ; 76
        (bipush 20)                                             ; 78
        (ishr)                                                  ; 80
        (sipush 1023)                                           ; 81
        (isub)                                                  ; 84
        (iadd)                                                  ; 85
        (istore 20)                                             ; 86
        ; line_number #1552
        (iload 21)                                              ; 88
        (ldc 12)                                                ; 90 1048575
        (iand)                                                  ; 92
        (istore 21)                                             ; 93
        ; line_number #1553
        (iload 21)                                              ; 95
        (ldc 13)                                                ; 97 614244
        (iadd)                                                  ; 99
        (ldc 4)                                                 ; 100 1048576
        (iand)                                                  ; 102
        (istore 22)                                             ; 103
        ; line_number #1554
        (dload_0)                                               ; 105
        (iload 21)                                              ; 106
        (iload 22)                                              ; 108
        (ldc 14)                                                ; 110 1072693248
        (ixor)                                                  ; 112
        (ior)                                                   ; 113
        (invokestatic 15)                                       ; 114 FdlibmTranslit.access$400:(DI)D
        (dstore_0)                                              ; 117
        ; line_number #1556
        (iload 20)                                              ; 118
        (iload 22)                                              ; 120
        (bipush 20)                                             ; 122
        (ishr)                                                  ; 124
        (iadd)                                                  ; 125
        (istore 20)                                             ; 126
        ; line_number #1557
        (dload_0)                                               ; 128
        (dconst_1)                                              ; 129
        (dsub)                                                  ; 130
        (dstore 4)                                              ; 131
        ; line_number #1558
        (ldc 12)                                                ; 133 1048575
        (iconst_2)                                              ; 135
        (iload 21)                                              ; 136
        (iadd)                                                  ; 138
        (iand)                                                  ; 139
        (iconst_3)                                              ; 140
        (if_icmpge 90)                                          ; 141
        ; line_number #1560
        (dload 4)                                               ; 144
        (dconst_0)                                              ; 146
        (dcmpl)                                                 ; 147
        (ifne 29)                                               ; 148
        ; line_number #1561
        (iload 20)                                              ; 151
        (ifne 5)                                                ; 153
        ; line_number #1562
        (dconst_0)                                              ; 156
        (dreturn)                                               ; 157
        ; line_number #1564
        (iload 20)                                              ; 158
        (i2d)                                                   ; 160
        (dstore 18)                                             ; 161
        ; line_number #1565
        (dload 18)                                              ; 163
        (ldc2_w 16)                                             ; 165 0.6931471803691238d
        (dmul)                                                  ; 168
        (dload 18)                                              ; 169
        (ldc2_w 18)                                             ; 171 1.9082149292705877E-10d
        (dmul)                                                  ; 174
        (dadd)                                                  ; 175
        (dreturn)                                               ; 176
        ; line_number #1568
        (dload 4)                                               ; 177
        (dload 4)                                               ; 179
        (dmul)                                                  ; 181
        (ldc2_w 20)                                             ; 182 0.5d
        (ldc2_w 22)                                             ; 185 0.3333333333333333d
        (dload 4)                                               ; 188
        (dmul)                                                  ; 190
        (dsub)                                                  ; 191
        (dmul)                                                  ; 192
        (dstore 10)                                             ; 193
        ; line_number #1569
        (iload 20)                                              ; 195
        (ifne 9)                                                ; 197
        ; line_number #1570
        (dload 4)                                               ; 200
        (dload 10)                                              ; 202
        (dsub)                                                  ; 204
        (dreturn)                                               ; 205
        ; line_number #1572
        (iload 20)                                              ; 206
        (i2d)                                                   ; 208
        (dstore 18)                                             ; 209
        ; line_number #1573
        (dload 18)                                              ; 211
        (ldc2_w 16)                                             ; 213 0.6931471803691238d
        (dmul)                                                  ; 216
        (dload 10)                                              ; 217
        (dload 18)                                              ; 219
        (ldc2_w 18)                                             ; 221 1.9082149292705877E-10d
        (dmul)                                                  ; 224
        (dsub)                                                  ; 225
        (dload 4)                                               ; 226
        (dsub)                                                  ; 228
        (dsub)                                                  ; 229
        (dreturn)                                               ; 230
        ; line_number #1576
        (dload 4)                                               ; 231
        (ldc2_w 24)                                             ; 233 2.0d
        (dload 4)                                               ; 236
        (dadd)                                                  ; 238
        (ddiv)                                                  ; 239
        (dstore 6)                                              ; 240
        ; line_number #1577
        (iload 20)                                              ; 242
        (i2d)                                                   ; 244
        (dstore 18)                                             ; 245
        ; line_number #1578
        (dload 6)                                               ; 247
        (dload 6)                                               ; 249
        (dmul)                                                  ; 251
        (dstore 8)                                              ; 252
        ; line_number #1579
        (iload 21)                                              ; 254
        (ldc 26)                                                ; 256 398458
        (isub)                                                  ; 258
        (istore 22)                                             ; 259
        ; line_number #1580
        (dload 8)                                               ; 261
        (dload 8)                                               ; 263
        (dmul)                                                  ; 265
        (dstore 12)                                             ; 266
        ; line_number #1581
        (ldc 27)                                                ; 268 440401
        (iload 21)                                              ; 270
        (isub)                                                  ; 272
        (istore 23)                                             ; 273
        ; line_number #1582
        (dload 12)                                              ; 275
        (ldc2_w 28)                                             ; 277 0.3999999999940942d
        (dload 12)                                              ; 280
        (ldc2_w 30)                                             ; 282 0.22222198432149784d
        (dload 12)                                              ; 285
        (ldc2_w 32)                                             ; 287 0.15313837699209373d
        (dmul)                                                  ; 290
        (dadd)                                                  ; 291
        (dmul)                                                  ; 292
        (dadd)                                                  ; 293
        (dmul)                                                  ; 294
        (dstore 14)                                             ; 295
        ; line_number #1583
        (dload 8)                                               ; 297
        (ldc2_w 34)                                             ; 299 0.6666666666666735d
        (dload 12)                                              ; 302
        (ldc2_w 36)                                             ; 304 0.2857142874366239d
        (dload 12)                                              ; 307
        (ldc2_w 38)                                             ; 309 0.1818357216161805d
        (dload 12)                                              ; 312
        (ldc2_w 40)                                             ; 314 0.14798198605116586d
        (dmul)                                                  ; 317
        (dadd)                                                  ; 318
        (dmul)                                                  ; 319
        (dadd)                                                  ; 320
        (dmul)                                                  ; 321
        (dadd)                                                  ; 322
        (dmul)                                                  ; 323
        (dstore 16)                                             ; 324
        ; line_number #1584
        (iload 22)                                              ; 326
        (iload 23)                                              ; 328
        (ior)                                                   ; 330
        (istore 22)                                             ; 331
        ; line_number #1585
        (dload 16)                                              ; 333
        (dload 14)                                              ; 335
        (dadd)                                                  ; 337
        (dstore 10)                                             ; 338
        ; line_number #1586
        (iload 22)                                              ; 340
        (ifle 58)                                               ; 342
        ; line_number #1587
        (ldc2_w 20)                                             ; 345 0.5d
        (dload 4)                                               ; 348
        (dmul)                                                  ; 350
        (dload 4)                                               ; 351
        (dmul)                                                  ; 353
        (dstore_2)                                              ; 354
        ; line_number #1588
        (iload 20)                                              ; 355
        (ifne 16)                                               ; 357
        ; line_number #1589
        (dload 4)                                               ; 360
        (dload_2)                                               ; 362
        (dload 6)                                               ; 363
        (dload_2)                                               ; 365
        (dload 10)                                              ; 366
        (dadd)                                                  ; 368
        (dmul)                                                  ; 369
        (dsub)                                                  ; 370
        (dsub)                                                  ; 371
        (dreturn)                                               ; 372
        ; line_number #1591
        (dload 18)                                              ; 373
        (ldc2_w 16)                                             ; 375 0.6931471803691238d
        (dmul)                                                  ; 378
        (dload_2)                                               ; 379
        (dload 6)                                               ; 380
        (dload_2)                                               ; 382
        (dload 10)                                              ; 383
        (dadd)                                                  ; 385
        (dmul)                                                  ; 386
        (dload 18)                                              ; 387
        (ldc2_w 18)                                             ; 389 1.9082149292705877E-10d
        (dmul)                                                  ; 392
        (dadd)                                                  ; 393
        (dsub)                                                  ; 394
        (dload 4)                                               ; 395
        (dsub)                                                  ; 397
        (dsub)                                                  ; 398
        (dreturn)                                               ; 399
        ; line_number #1593
        (iload 20)                                              ; 400
        (ifne 15)                                               ; 402
        ; line_number #1594
        (dload 4)                                               ; 405
        (dload 6)                                               ; 407
        (dload 4)                                               ; 409
        (dload 10)                                              ; 411
        (dsub)                                                  ; 413
        (dmul)                                                  ; 414
        (dsub)                                                  ; 415
        (dreturn)                                               ; 416
        ; line_number #1596
        (dload 18)                                              ; 417
        (ldc2_w 16)                                             ; 419 0.6931471803691238d
        (dmul)                                                  ; 422
        (dload 6)                                               ; 423
        (dload 4)                                               ; 425
        (dload 10)                                              ; 427
        (dsub)                                                  ; 429
        (dmul)                                                  ; 430
        (dload 18)                                              ; 431
        (ldc2_w 18)                                             ; 433 1.9082149292705877E-10d
        (dmul)                                                  ; 436
        (dsub)                                                  ; 437
        (dload 4)                                               ; 438
        (dsub)                                                  ; 440
        (dsub)                                                  ; 441
        (dreturn)                                               ; 442
       ))
     '(ref -1)))