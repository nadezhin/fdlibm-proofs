(in-package "ACL2")
(include-book "cbrt")
(include-book "llvm-lemmas")

(local
 (defruled @cbrt-%101-thm
   (implies (and (wordp ret-w0)
                 (wordp ret-w1))
            (equal (@cbrt-%101
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(ret . 0))
                   (make-double ret-w1 ret-w0)))
   :enable (@cbrt-%101 load-double)))

(local
 (defruled @cbrt-%50-thm
   (implies (and (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%50
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(r . 0)
                    '(s . 0)
                    '(sign . 0)
                    '(t . 0)
                    '(w . 0)
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%50-opt
                    (make-i32 sign-w0)
                    (make-double t-w1 t-w0)
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%50-opt @cbrt-%50 @cbrt-%101-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi)))

(local
 (defruled @cbrt-%44-thm
   (implies (and (wordp hx-w0)
                 (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%44
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(hx . 0)
                    '(r . 0)
                    '(s . 0)
                    '(sign . 0)
                    '(t . 0)
                    '(w . 0)
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%44-opt
                    (make-i32 hx-w0)
                    (make-i32 sign-w0)
                    (make-double t-w1 t-w0)
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%44-opt @cbrt-%44 @cbrt-%50-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi)))

(local
 (defruled @cbrt-%31-thm
   (implies (and (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%31
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(r . 0)
                    '(s . 0)
                    '(sign . 0)
                    '(t . 0)
                    '(w . 0)
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%31-opt
                    (make-i32 sign-w0)
                    (make-double t-w1 t-w0)
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%31-opt @cbrt-%31 @cbrt-%50-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi)))

(local
 (defruled @cbrt-%25-thm
   (implies (and (wordp hx-w0)
                 (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%25
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(hx . 0)
                    '(r . 0)
                    '(s . 0)
                    '(sign . 0)
                    '(t . 0)
                    '(w . 0)
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%25-opt
                    (make-i32 hx-w0)
                    (make-i32 sign-w0)
                    (make-double t-w1 t-w0)
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%25-opt @cbrt-%25 @cbrt-%31-thm @cbrt-%44-thm
                          load-double store-double load-i32 store-i32
                          get-hi set-lo set-hi i1p=-1)))

(local
 (defruled @cbrt-%23-thm
   (implies (and (wordp hx-w0)
                 (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%23
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%23-opt
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%23-opt @cbrt-%23 @cbrt-%101-thm
                          store-double load-double)))

(local
 (defruled @cbrt-%17-thm
   (implies (and (wordp hx-w0)
                 (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%17
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(hx . 0)
                    '(r . 0)
                    '(s . 0)
                    '(sign . 0)
                    '(t . 0)
                    '(w . 0)
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%17-opt
                    (make-i32 hx-w0)
                    (make-i32 sign-w0)
                    (make-double t-w1 t-w0)
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%17-opt @cbrt-%17 @cbrt-%23-thm @cbrt-%25-thm
                          load-double store-double load-i32 store-i32
                          get-lo get-hi set-lo set-hi i1p=-1)))

(local
 (defruled @cbrt-%13-thm
   (implies (and (wordp hx-w0)
                 (wordp sign-w0)
                 (wordp t-w0)
                 (wordp t-w1)
                 (wordp x-w0)
                 (wordp x-w1))
            (equal (@cbrt-%13
                    (list
                     (list 'ret ret-w0 ret-w1)
                     (list 'x x-w0 x-w1)
                     (list 'hx hx-w0)
                     (list 'r r-w0 r-w1)
                     (list 's s-w0 s-w1)
                     (list 't t-w0 t-w1)
                     (list 'w w-w0 w-w1)
                     (list 'sign sign-w0))
                    '(ret . 0)
                    '(x . 0))
                   (@cbrt-%13-opt
                    (make-double x-w1 x-w0))))
   :enable (@cbrt-%13-opt @cbrt-%13 @cbrt-%101-thm
                          load-double store-double)))

(local
 (defruled @cbrt-%0-thm
   (implies (doublep %x)
            (equal (@cbrt-%0 () %x)
                   (@cbrt-%0-opt %x)))
   :enable (@cbrt-%0-opt @cbrt-%0 @cbrt-%13-thm @cbrt-%17-thm
                         store-double load-i32 store-i32
                         get-hi i1p=-1)))

(defruled @cbrt-thm
  (implies (doublep %x)
           (equal (@cbrt %x)
                  (@cbrt-opt %x)))
  :enable (@cbrt-opt @cbrt @cbrt-%0-thm))
