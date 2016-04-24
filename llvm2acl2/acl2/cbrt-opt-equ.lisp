(in-package "ACL2")
(include-book "cbrt")
(include-book "llvm-lemmas")

(local
 (defruled @cbrt-%101-thm
   (let ((ret (load-double '(ret . 0) mem)))
     (implies (doublep ret)
              (equal (@cbrt-%101 mem)
                     ret)))
   :enable (@cbrt-%101 load-double)))

(local
 (defruled @cbrt-%50-thm
   (let ((sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%50 mem)
                     (@cbrt-%50-opt sign tt x))))
   :enable (@cbrt-%50-opt @cbrt-%50 @cbrt-%101-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi)))

(local
 (defruled @cbrt-%44-thm
   (let ((hx (load-i32 '(hx . 0) mem))
         (sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p hx)
                   (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%44 mem)
                     (@cbrt-%44-opt hx sign tt x))))
   :enable (@cbrt-%44-opt @cbrt-%44 @cbrt-%50-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi)))

(local
 (defruled @cbrt-%31-thm
   (let ((sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%31 mem)
                     (@cbrt-%31-opt sign tt x))))
   :enable (@cbrt-%31-opt @cbrt-%31 @cbrt-%50-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi)))

(local
 (defruled @cbrt-%25-thm
   (let ((hx (load-i32 '(hx . 0) mem))
         (sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p hx)
                   (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%25 mem)
                     (@cbrt-%25-opt hx sign tt x))))
   :enable (@cbrt-%25-opt @cbrt-%25 @cbrt-%31-thm @cbrt-%44-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi i1p=-1)))

(local
 (defruled @cbrt-%23-thm
   (let ((hx (load-i32 '(hx . 0) mem))
         (sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p hx)
                   (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%23 mem)
                     (@cbrt-%23-opt x))))
   :enable (@cbrt-%23-opt @cbrt-%23 @cbrt-%101-thm
                          store-double load-double)))

(local
 (defruled @cbrt-%17-thm
   (let ((hx (load-i32 '(hx . 0) mem))
         (sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p hx)
                   (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%17 mem)
                     (@cbrt-%17-opt hx sign tt x))))
   :enable (@cbrt-%17-opt @cbrt-%17 @cbrt-%23-thm @cbrt-%25-thm
                          load-double store-double load-i32 store-i32
                          get-lo get-hi set-lo set-hi i1p=-1)))

(local
 (defruled @cbrt-%13-thm
   (let ((hx (load-i32 '(hx . 0) mem))
         (sign (load-i32 '(sign . 0) mem))
         (tt (load-double '(t . 0) mem))
         (x (load-double '(x . 0) mem)))
     (implies (and (i32p hx)
                   (i32p sign)
                   (doublep tt)
                   (doublep x))
              (equal (@cbrt-%13 mem)
                     (@cbrt-%13-opt x))))
   :enable (@cbrt-%13-opt @cbrt-%13 @cbrt-%101-thm
                          load-double store-double)))

(local
 (defruled @cbrt-%0-thm
   (implies (doublep %x)
            (equal (@cbrt-%0 mem %x)
                   (@cbrt-%0-opt %x)))
   :enable (@cbrt-%0-opt @cbrt-%0 @cbrt-%13-thm @cbrt-%17-thm
                         load-double store-double load-i32 store-i32
                         get-hi i1p=-1)))

(defruled @cbrt-thm
  (implies (doublep %x)
           (equal (@cbrt %x)
                  (@cbrt-opt %x)))
  :enable (@cbrt-opt @cbrt @cbrt-%0-thm))
