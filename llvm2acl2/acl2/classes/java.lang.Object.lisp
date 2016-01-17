; Automatically generated by jvm2m5

(in-package "M5")
(include-book "models/jvm/m5/m5" :dir :system)

(defconst *java.lang.Object*
    (make-class-decl
     "java/lang/Object"
     ()
     '()
     '()
     '(nil
       (class (ref -1) "java/lang/StringBuilder")              ; 1
       (methodref "java/lang/StringBuilder" "<init>:()V" 0)    ; 2
       (methodref "java/lang/Object" "getClass:()Ljava/lang/Class;" 0) ; 3
       (methodref "java/lang/Class" "getName:()Ljava/lang/String;" 0)  ; 4
       (methodref "java/lang/StringBuilder" "append:(Ljava/lang/String;)Ljava/lang/StringBuilder;" 1)  ; 5
       (string (ref -1) ; "@"
          64)                                                  ; 6
       (methodref "java/lang/Object" "hashCode:()I" 0)         ; 7
       (methodref "java/lang/Integer" "toHexString:(I)Ljava/lang/String;" 1)   ; 8
       (methodref "java/lang/StringBuilder" "toString:()Ljava/lang/String;" 0) ; 9
       (class (ref -1) "java/lang/IllegalArgumentException")   ; 10
       (string (ref -1) ; "timeout value is negative"
          116 105 109 101 111 117 116 32 118 97 108 117 101 32 105 115 32 110 101 103 97 116 105 118 101)      ; 11
       (methodref "java/lang/IllegalArgumentException" "<init>:(Ljava/lang/String;)V" 1)       ; 12
       (integer 999999)                                        ; 13
       (string (ref -1) ; "nanosecond timeout value out of range"
          110 97 110 111 115 101 99 111 110 100 32 116 105 109 101 111 117 116 32 118 97 108 117 101 32 111 117 116 32 111 102 32 114 97 110 103 101)  ; 14
       (methodref "java/lang/Object" "wait:(J)V" 2)            ; 15
       (methodref "java/lang/Object" "registerNatives:()V" 0)  ; 16
       (class (ref -1) "java/lang/Object")                     ; 17
       (utf8)                                                  ; 18
       (utf8)                                                  ; 19
       (utf8)                                                  ; 20
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
       (utf8)                                                  ; 36
       (class (ref -1) "java/lang/CloneNotSupportedException") ; 37
       (utf8)                                                  ; 38
       (utf8)                                                  ; 39
       (utf8)                                                  ; 40
       (utf8)                                                  ; 41
       (utf8)                                                  ; 42
       (utf8)                                                  ; 43
       (class (ref -1) "java/lang/InterruptedException")       ; 44
       (utf8)                                                  ; 45
       (utf8)                                                  ; 46
       (class (ref -1) "java/lang/Throwable")                  ; 47
       (utf8)                                                  ; 48
       (utf8)                                                  ; 49
       (utf8)                                                  ; 50
       (utf8)                                                  ; 51
       (name-and-type "<init>:()V")                            ; 52
       (name-and-type "getClass:()Ljava/lang/Class;")          ; 53
       (class (ref -1) "java/lang/Class")                      ; 54
       (name-and-type "getName:()Ljava/lang/String;")          ; 55
       (name-and-type "append:(Ljava/lang/String;)Ljava/lang/StringBuilder;")  ; 56
       (utf8)                                                  ; 57
       (name-and-type "hashCode:()I")                          ; 58
       (class (ref -1) "java/lang/Integer")                    ; 59
       (name-and-type "toHexString:(I)Ljava/lang/String;")     ; 60
       (name-and-type "toString:()Ljava/lang/String;")         ; 61
       (utf8)                                                  ; 62
       (utf8)                                                  ; 63
       (name-and-type "<init>:(Ljava/lang/String;)V")          ; 64
       (utf8)                                                  ; 65
       (name-and-type "wait:(J)V")                             ; 66
       (name-and-type "registerNatives:()V")                   ; 67
       (utf8)                                                  ; 68
       (utf8)                                                  ; 69
       (utf8)                                                  ; 70
       (utf8)                                                  ; 71
       (utf8)                                                  ; 72
       (utf8)                                                  ; 73
       (utf8)                                                  ; 74
       (utf8)                                                  ; 75
       (utf8)                                                  ; 76
       (utf8)                                                  ; 77
       (utf8)                                                  ; 78
       (utf8)                                                  ; 79
      )
     (list
      '("registerNatives:()V" nil
        ; native method
       )
      '("<init>:()V" nil
        ; line_number #50
        (return)                                                ; 0
       )
      '("getClass:()Ljava/lang/Class;" nil
        ; native method
       )
      '("hashCode:()I" nil
        ; native method
       )
      '("equals:(Ljava/lang/Object;)Z" nil
        ; line_number #158
        (aload_0)                                               ; 0
        (aload_1)                                               ; 1
        (if_acmpne 7)                                           ; 2
        (iconst_1)                                              ; 5
        (goto 4)                                                ; 6
        (iconst_0)                                              ; 9
        (ireturn)                                               ; 10
       )
      '("clone:()Ljava/lang/Object;" nil
        ; native method
       )
      '("toString:()Ljava/lang/String;" nil
        ; line_number #246
        (new 1)                                                 ; 0 class java.lang.StringBuilder
        (dup)                                                   ; 3
        (invokespecial 2)                                       ; 4 java.lang.StringBuilder.<init>:()V
        (aload_0)                                               ; 7
        (invokevirtual 3)                                       ; 8 java.lang.Object.getClass:()Ljava/lang/Class;
        (invokevirtual 4)                                       ; 11 java.lang.Class.getName:()Ljava/lang/String;
        (invokevirtual 5)                                       ; 14 java.lang.StringBuilder.append:(Ljava/lang/String;)Ljava/lang/StringBuilder;
        (ldc 6)                                                 ; 17 "@"
        (invokevirtual 5)                                       ; 19 java.lang.StringBuilder.append:(Ljava/lang/String;)Ljava/lang/StringBuilder;
        (aload_0)                                               ; 22
        (invokevirtual 7)                                       ; 23 java.lang.Object.hashCode:()I
        (invokestatic 8)                                        ; 26 java.lang.Integer.toHexString:(I)Ljava/lang/String;
        (invokevirtual 5)                                       ; 29 java.lang.StringBuilder.append:(Ljava/lang/String;)Ljava/lang/StringBuilder;
        (invokevirtual 9)                                       ; 32 java.lang.StringBuilder.toString:()Ljava/lang/String;
        (areturn)                                               ; 35
       )
      '("notify:()V" nil
        ; native method
       )
      '("notifyAll:()V" nil
        ; native method
       )
      '("wait:(J)V" nil
        ; native method
       )
      '("wait:(JI)V" nil
        ; line_number #461
        (lload_1)                                               ; 0
        (lconst_0)                                              ; 1
        (lcmp)                                                  ; 2
        (ifge 13)                                               ; 3
        ; line_number #462
        (new 10)                                                ; 6 class java.lang.IllegalArgumentException
        (dup)                                                   ; 9
        (ldc 11)                                                ; 10 "timeout value is negative"
        (invokespecial 12)                                      ; 12 java.lang.IllegalArgumentException.<init>:(Ljava/lang/String;)V
        (athrow)                                                ; 15
        ; line_number #465
        (iload_3)                                               ; 16
        (iflt 9)                                                ; 17
        (iload_3)                                               ; 20
        (ldc 13)                                                ; 21 999999
        (if_icmple 13)                                          ; 23
        ; line_number #466
        (new 10)                                                ; 26 class java.lang.IllegalArgumentException
        (dup)                                                   ; 29
        (ldc 14)                                                ; 30 "nanosecond timeout value out of range"
        (invokespecial 12)                                      ; 32 java.lang.IllegalArgumentException.<init>:(Ljava/lang/String;)V
        (athrow)                                                ; 35
        ; line_number #470
        (iload_3)                                               ; 36
        (ifle 7)                                                ; 37
        ; line_number #471
        (lload_1)                                               ; 40
        (lconst_1)                                              ; 41
        (ladd)                                                  ; 42
        (lstore_1)                                              ; 43
        ; line_number #474
        (aload_0)                                               ; 44
        (lload_1)                                               ; 45
        (invokevirtual 15)                                      ; 46 java.lang.Object.wait:(J)V
        ; line_number #475
        (return)                                                ; 49
       )
      '("wait:()V" nil
        ; line_number #516
        (aload_0)                                               ; 0
        (lconst_0)                                              ; 1
        (invokevirtual 15)                                      ; 2 java.lang.Object.wait:(J)V
        ; line_number #517
        (return)                                                ; 5
       )
      '("finalize:()V" nil
        ; line_number #569
        (return)                                                ; 0
       )
      '("<clinit>:()V" nil
        ; line_number #43
        (invokestatic 16)                                       ; 0 java.lang.Object.registerNatives:()V
        ; line_number #44
        (return)                                                ; 3
       ))
     '(ref -1)))