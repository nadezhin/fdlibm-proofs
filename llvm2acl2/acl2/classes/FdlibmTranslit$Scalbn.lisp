; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslit$Scalbn*
    (make-class-decl
     "FdlibmTranslit$Scalbn"
     '("java/lang/Object")
     '()
     '(
      "two54:D"
      "twom54:D"
      "huge:D"
      "tiny:D")
     '(nil
       (methodref "java/lang/Object" "<init>:()V" 0)           ; 1
       (methodref "FdlibmTranslit" "access$000:(D)I" 2)        ; 2
       (methodref "FdlibmTranslit" "access$100:(D)I" 2)        ; 3
       (integer 2146435072)                                    ; 4
       (integer 2147483647)                                    ; 5
       (class (ref -1) "FdlibmTranslit$Scalbn")                ; 6
       (double #x4350000000000000) ; 0x1.0p54 1.8014398509481984E16    ; 7
       nil
       (integer -50000)                                        ; 9
       (double #x01a56e1fc2f8f359) ; 0x1.56e1fc2f8f359p-997 1.0E-300   ; 10
       nil
       (double #x7e37e43c8800759c) ; 0x1.7e43c8800759cp996 1.0E300     ; 12
       nil
       (methodref "FdlibmTranslit$Copysign" "compute:(DD)D" 4) ; 14
       (integer -2146435073)                                   ; 15
       (methodref "FdlibmTranslit" "access$400:(DI)D" 3)       ; 16
       (integer 50000)                                         ; 17
       (double #x3c90000000000000) ; 0x1.0p-54 5.551115123125783E-17   ; 18
       nil
       (class (ref -1) "java/lang/Object")                     ; 20
       (utf8)                                                  ; 21
       (utf8)                                                  ; 22
       (utf8)                                                  ; 23
       (utf8)                                                  ; 24
       (utf8)                                                  ; 25
       (utf8)                                                  ; 26
       (utf8)                                                  ; 27
       (utf8)                                                  ; 28
       (utf8)                                                  ; 29
       (utf8)                                                  ; 30
       (utf8)                                                  ; 31
       (utf8)                                                  ; 32
       (utf8)                                                  ; 33
       (utf8)                                                  ; 34
       (utf8)                                                  ; 35
       (name-and-type "<init>:()V")                            ; 36
       (class (ref -1) "FdlibmTranslit")                       ; 37
       (name-and-type "access$000:(D)I")                       ; 38
       (name-and-type "access$100:(D)I")                       ; 39
       (utf8)                                                  ; 40
       (utf8)                                                  ; 41
       (utf8)                                                  ; 42
       (class (ref -1) "FdlibmTranslit$Copysign")              ; 43
       (name-and-type "compute:(DD)D")                         ; 44
       (name-and-type "access$400:(DI)D")                      ; 45
       (utf8)                                                  ; 46
       (utf8)                                                  ; 47
       (utf8)                                                  ; 48
       (utf8)                                                  ; 49
       (utf8)                                                  ; 50
       (utf8)                                                  ; 51
       (utf8)                                                  ; 52
       (utf8)                                                  ; 53
       (utf8)                                                  ; 54
      )
     (list
      '("<init>:()V" nil
        ; line_number #2714
        (aload_0)                                               ; 0
        (invokespecial 1)                                       ; 1 java.lang.Object.<init>:()V
        (return)                                                ; 4
       )
      '("compute:(DI)D" nil
        ; line_number #2723
        (dload_0)                                               ; 0
        (invokestatic 2)                                        ; 1 FdlibmTranslit.access$000:(D)I
        (istore 4)                                              ; 4
        ; line_number #2724
        (dload_0)                                               ; 6
        (invokestatic 3)                                        ; 7 FdlibmTranslit.access$100:(D)I
        (istore 5)                                              ; 10
        ; line_number #2725
        (iload 4)                                               ; 12
        (ldc 4)                                                 ; 14 2146435072
        (iand)                                                  ; 16
        (bipush 20)                                             ; 17
        (ishr)                                                  ; 19
        (istore_3)                                              ; 20
        ; line_number #2727
        (iload_3)                                               ; 21
        (ifne 52)                                               ; 22
        ; line_number #2729
        (iload 5)                                               ; 25
        (iload 4)                                               ; 27
        (ldc 5)                                                 ; 29 2147483647
        (iand)                                                  ; 31
        (ior)                                                   ; 32
        (ifne 5)                                                ; 33
        ; line_number #2730
        (dload_0)                                               ; 36
        (dreturn)                                               ; 37
        ; line_number #2732
        (dload_0)                                               ; 38
        (ldc2_w 7)                                              ; 39 1.8014398509481984E16d
        (dmul)                                                  ; 42
        (dstore_0)                                              ; 43
        ; line_number #2733
        (dload_0)                                               ; 44
        (invokestatic 2)                                        ; 45 FdlibmTranslit.access$000:(D)I
        (istore 4)                                              ; 48
        ; line_number #2734
        (iload 4)                                               ; 50
        (ldc 4)                                                 ; 52 2146435072
        (iand)                                                  ; 54
        (bipush 20)                                             ; 55
        (ishr)                                                  ; 57
        (bipush 54)                                             ; 58
        (isub)                                                  ; 60
        (istore_3)                                              ; 61
        ; line_number #2735
        (iload_2)                                               ; 62
        (ldc 9)                                                 ; 63 -50000
        (if_icmpge 9)                                           ; 65
        ; line_number #2736
        (ldc2_w 10)                                             ; 68 1.0E-300d
        (dload_0)                                               ; 71
        (dmul)                                                  ; 72
        (dreturn)                                               ; 73
        ; line_number #2739
        (iload_3)                                               ; 74
        (sipush 2047)                                           ; 75
        (if_icmpne 7)                                           ; 78
        ; line_number #2740
        (dload_0)                                               ; 81
        (dload_0)                                               ; 82
        (dadd)                                                  ; 83
        (dreturn)                                               ; 84
        ; line_number #2742
        (iload_3)                                               ; 85
        (iload_2)                                               ; 86
        (iadd)                                                  ; 87
        (istore_3)                                              ; 88
        ; line_number #2743
        (iload_3)                                               ; 89
        (sipush 2046)                                           ; 90
        (if_icmple 15)                                          ; 93
        ; line_number #2744
        (ldc2_w 12)                                             ; 96 1.0E300d
        (ldc2_w 12)                                             ; 99 1.0E300d
        (dload_0)                                               ; 102
        (invokestatic 14)                                       ; 103 FdlibmTranslit$Copysign.compute:(DD)D
        (dmul)                                                  ; 106
        (dreturn)                                               ; 107
        ; line_number #2746
        (iload_3)                                               ; 108
        (ifle 20)                                               ; 109
        ; line_number #2747
        (dload_0)                                               ; 112
        (iload 4)                                               ; 113
        (ldc 15)                                                ; 115 -2146435073
        (iand)                                                  ; 117
        (iload_3)                                               ; 118
        (bipush 20)                                             ; 119
        (ishl)                                                  ; 121
        (ior)                                                   ; 122
        (invokestatic 16)                                       ; 123 FdlibmTranslit.access$400:(DI)D
        (dstore_0)                                              ; 126
        ; line_number #2748
        (dload_0)                                               ; 127
        (dreturn)                                               ; 128
        ; line_number #2750
        (iload_3)                                               ; 129
        (bipush -54)                                            ; 130
        (if_icmpgt 33)                                          ; 132
        ; line_number #2751
        (iload_2)                                               ; 135
        (ldc 17)                                                ; 136 50000
        (if_icmple 15)                                          ; 138
        ; line_number #2752
        (ldc2_w 12)                                             ; 141 1.0E300d
        (ldc2_w 12)                                             ; 144 1.0E300d
        (dload_0)                                               ; 147
        (invokestatic 14)                                       ; 148 FdlibmTranslit$Copysign.compute:(DD)D
        (dmul)                                                  ; 151
        (dreturn)                                               ; 152
        ; line_number #2754
        (ldc2_w 10)                                             ; 153 1.0E-300d
        (ldc2_w 10)                                             ; 156 1.0E-300d
        (dload_0)                                               ; 159
        (invokestatic 14)                                       ; 160 FdlibmTranslit$Copysign.compute:(DD)D
        (dmul)                                                  ; 163
        (dreturn)                                               ; 164
        ; line_number #2757
        (iinc 3 54)                                             ; 165
        ; line_number #2759
        (dload_0)                                               ; 168
        (iload 4)                                               ; 169
        (ldc 15)                                                ; 171 -2146435073
        (iand)                                                  ; 173
        (iload_3)                                               ; 174
        (bipush 20)                                             ; 175
        (ishl)                                                  ; 177
        (ior)                                                   ; 178
        (invokestatic 16)                                       ; 179 FdlibmTranslit.access$400:(DI)D
        (dstore_0)                                              ; 182
        ; line_number #2760
        (dload_0)                                               ; 183
        (ldc2_w 18)                                             ; 184 5.551115123125783E-17d
        (dmul)                                                  ; 187
        (dreturn)                                               ; 188
       ))
     '(ref -1)))