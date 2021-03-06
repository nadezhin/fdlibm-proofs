; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *FdlibmTranslit*
    (make-class-decl
     "FdlibmTranslit"
     '("java/lang/Object")
     '(nil
       (methodref "FdlibmTranslit" "__LO:(DI)D" 3)              ; 1
       (methodref "FdlibmTranslit" "__HI:(DI)D" 3)              ; 2
       (methodref "FdlibmTranslit" "__LO:(D)I" 2)               ; 3
       (methodref "FdlibmTranslit" "__HI:(D)I" 2)               ; 4
       (methodref "java/lang/Object" "<init>:()V" 0)            ; 5
       (class (ref -1) "java/lang/UnsupportedOperationException")       ; 6
       (string (ref -1) ; "No FdLibmTranslit instances for you."
          78 111 32 70 100 76 105 98 109 84 114 97 110 115 108 105 116 32 105 110 115 116 97 110 99 101 115 32 102 111 114 32 121 111 117 46)   ; 7
       (methodref "java/lang/UnsupportedOperationException" "<init>:(Ljava/lang/String;)V" 1)   ; 8
       (methodref "java/lang/Double" "doubleToRawLongBits:(D)J" 2)      ; 9
       (long -4294967296)                                       ; 10
       nil
       (methodref "java/lang/Double" "longBitsToDouble:(J)D" 2) ; 12
       (long 4294967295)                                        ; 13
       nil
       (methodref "FdlibmTranslit$Hypot" "compute:(DD)D" 4)     ; 15
       (class (ref -1) "FdlibmTranslit")                        ; 16
       (class (ref -1) "java/lang/Object")                      ; 17
       (class (ref -1) "FdlibmTranslit$Hypot")                  ; 18
       (utf8)                                                   ; 19
       (utf8)                                                   ; 20
       (class (ref -1) "FdlibmTranslit$Cbrt")                   ; 21
       (utf8)                                                   ; 22
       (utf8)                                                   ; 23
       (utf8)                                                   ; 24
       (utf8)                                                   ; 25
       (utf8)                                                   ; 26
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
       (name-and-type "__LO:(DI)D")                             ; 39
       (name-and-type "__HI:(DI)D")                             ; 40
       (name-and-type "__LO:(D)I")                              ; 41
       (name-and-type "__HI:(D)I")                              ; 42
       (name-and-type "<init>:()V")                             ; 43
       (utf8)                                                   ; 44
       (utf8)                                                   ; 45
       (name-and-type "<init>:(Ljava/lang/String;)V")           ; 46
       (class (ref -1) "java/lang/Double")                      ; 47
       (name-and-type "doubleToRawLongBits:(D)J")               ; 48
       (name-and-type "longBitsToDouble:(J)D")                  ; 49
       (name-and-type "compute:(DD)D")                          ; 50
       (utf8)                                                   ; 51
       (utf8)                                                   ; 52
       (utf8)                                                   ; 53
       (utf8)                                                   ; 54
       (utf8)                                                   ; 55
       (utf8)                                                   ; 56
       (utf8)                                                   ; 57
       (utf8)                                                   ; 58
       (utf8)                                                   ; 59
       (utf8)                                                   ; 60
       (utf8)                                                   ; 61
      )
     #x00000021                                                 ; PUBLIC SUPER
     '(
      )
     (list
      '("<init>:()V" #x00000002                                 ; PRIVATE
        ; line_number #33
        (aload_0)                                               ; 0
        (invokespecial 5)                                       ; 1 java.lang.Object.<init>:()V
        ; line_number #34
        (new 6)                                                 ; 4 class java.lang.UnsupportedOperationException
        (dup)                                                   ; 7
        (ldc 7)                                                 ; 8 "No FdLibmTranslit instances for you."
        (invokespecial 8)                                       ; 10 java.lang.UnsupportedOperationException.<init>:(Ljava/lang/String;)V
        (athrow)                                                ; 13
       )
      '("__LO:(D)I" #x0000000a                                  ; PRIVATE STATIC
        ; line_number #41
        (dload_0)                                               ; 0
        (invokestatic 9)                                        ; 1 java.lang.Double.doubleToRawLongBits:(D)J
        (lstore_2)                                              ; 4
        ; line_number #42
        (lload_2)                                               ; 5
        (l2i)                                                   ; 6
        (ireturn)                                               ; 7
       )
      '("__LO:(DI)D" #x0000000a                                 ; PRIVATE STATIC
        ; line_number #50
        (dload_0)                                               ; 0
        (invokestatic 9)                                        ; 1 java.lang.Double.doubleToRawLongBits:(D)J
        (lstore_3)                                              ; 4
        ; line_number #51
        (lload_3)                                               ; 5
        (ldc2_w 10)                                             ; 6 -4294967296l
        (land)                                                  ; 9
        (iload_2)                                               ; 10
        (i2l)                                                   ; 11
        (lor)                                                   ; 12
        (invokestatic 12)                                       ; 13 java.lang.Double.longBitsToDouble:(J)D
        (dreturn)                                               ; 16
       )
      '("__HI:(D)I" #x0000000a                                  ; PRIVATE STATIC
        ; line_number #58
        (dload_0)                                               ; 0
        (invokestatic 9)                                        ; 1 java.lang.Double.doubleToRawLongBits:(D)J
        (lstore_2)                                              ; 4
        ; line_number #59
        (lload_2)                                               ; 5
        (bipush 32)                                             ; 6
        (lshr)                                                  ; 8
        (l2i)                                                   ; 9
        (ireturn)                                               ; 10
       )
      '("__HI:(DI)D" #x0000000a                                 ; PRIVATE STATIC
        ; line_number #67
        (dload_0)                                               ; 0
        (invokestatic 9)                                        ; 1 java.lang.Double.doubleToRawLongBits:(D)J
        (lstore_3)                                              ; 4
        ; line_number #68
        (lload_3)                                               ; 5
        (ldc2_w 13)                                             ; 6 4294967295l
        (land)                                                  ; 9
        (iload_2)                                               ; 10
        (i2l)                                                   ; 11
        (bipush 32)                                             ; 12
        (lshl)                                                  ; 14
        (lor)                                                   ; 15
        (invokestatic 12)                                       ; 16 java.lang.Double.longBitsToDouble:(J)D
        (dreturn)                                               ; 19
       )
      '("hypot:(DD)D" #x00000009                                ; PUBLIC STATIC
        ; line_number #72
        (dload_0)                                               ; 0
        (dload_2)                                               ; 1
        (invokestatic 15)                                       ; 2 FdlibmTranslit$Hypot.compute:(DD)D
        (dreturn)                                               ; 5
       )
      '("access$000:(D)I" #x00001008                            ; STATIC SYNTHETIC
        ; line_number #32
        (dload_0)                                               ; 0
        (invokestatic 4)                                        ; 1 FdlibmTranslit.__HI:(D)I
        (ireturn)                                               ; 4
       )
      '("access$100:(D)I" #x00001008                            ; STATIC SYNTHETIC
        ; line_number #32
        (dload_0)                                               ; 0
        (invokestatic 3)                                        ; 1 FdlibmTranslit.__LO:(D)I
        (ireturn)                                               ; 4
       )
      '("access$200:(DI)D" #x00001008                           ; STATIC SYNTHETIC
        ; line_number #32
        (dload_0)                                               ; 0
        (iload_2)                                               ; 1
        (invokestatic 2)                                        ; 2 FdlibmTranslit.__HI:(DI)D
        (dreturn)                                               ; 5
       )
      '("access$300:(DI)D" #x00001008                           ; STATIC SYNTHETIC
        ; line_number #32
        (dload_0)                                               ; 0
        (iload_2)                                               ; 1
        (invokestatic 1)                                        ; 2 FdlibmTranslit.__LO:(DI)D
        (dreturn)                                               ; 5
       ))
     '(ref -1)))