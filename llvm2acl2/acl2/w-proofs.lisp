(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)

(include-book "llvm/s_copysign")
(include-book "llvm/s_fabs")
(include-book "llvm/w_acos")
(include-book "llvm/w_asin")
(include-book "llvm/w_atan2")
(include-book "llvm/w_cosh")
(include-book "llvm/w_exp")
(include-book "llvm/w_hypot")
(include-book "llvm/w_log")
(include-book "llvm/w_log10")
(include-book "llvm/w_pow")
(include-book "llvm/w_sinh")
(include-book "llvm/w_sqrt")
(include-book "utils")

(defruled s-copysign
  (equal (@copysign x y)
         (make-double (or-i32 (and-I32 (get-hi-double x) 2147483647)
                              (and-I32 (get-hi-double y) -2147483648))
                      (get-lo-double x)))
  :enable (@copysign @copysign-%0 store-double load-double store-i32 load-i32)
  :disable (m5::int-fix m5::uint-fix))

(defruled s-fabs
  (equal (@fabs x)
         (make-double (and-i32 (get-hi-double x) #x7fffffff)
                      (get-lo-double x)))
  :enable (@fabs @fabs-%0 store-double load-double store-i32 load-i32)
  :disable (m5::int-fix m5::uint-fix))

(defruled w-acos
  (equal (@acos x)
         (@__ieee754_acos (double-fix x)))
  :enable (@acos @acos-%0 store-double load-double))

(defruled w-asin
  (equal (@asin x)
         (@__ieee754_asin (double-fix x)))
  :enable (@asin @asin-%0 store-double load-double))

(defruled w-atan2
  (equal (@atan2 y x)
         (@__ieee754_atan2 (double-fix y) (double-fix x)))
  :enable (@atan2 @atan2-%0 store-double load-double))

(defruled w-cosh
  (equal (@cosh x)
         (@__ieee754_cosh (double-fix x)))
  :enable (@cosh @cosh-%0 store-double load-double))

(defruled w-exp
  (equal (@exp x)
         (@__ieee754_exp (double-fix x)))
  :enable (@exp @exp-%0 store-double load-double))

(defruled w-hypot
  (equal (@hypot x y)
         (@__ieee754_hypot (double-fix x) (double-fix y)))
  :enable (@hypot @hypot-%0 store-double load-double))

(defruled w-log
  (equal (@log x)
         (@__ieee754_log (double-fix x)))
  :enable (@log @log-%0 store-double load-double))

(defruled w-log10
  (equal (@log10 x)
         (@__ieee754_log10 (double-fix x)))
  :enable (@log10 @log10-%0 store-double load-double))

(defruled w-pow
  (equal (@pow x y)
         (@__ieee754_pow (double-fix x) (double-fix y)))
  :enable (@pow @pow-%0 store-double load-double))

(defruled w-sinh
  (equal (@sinh x)
         (@__ieee754_sinh (double-fix x)))
  :enable (@sinh @sinh-%0 store-double load-double))

(defruled w-sqrt
  (equal (@sqrt x)
         (@__ieee754_sqrt (double-fix x)))
  :enable (@sqrt @sqrt-%0 store-double load-double))
