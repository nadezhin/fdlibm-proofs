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
(local (include-book "llvm-lemmas"))

(defruled s-copysign
  (equal (@copysign x y)
         (set-hi x (or-i32 (and-i32 (get-hi x) 2147483647)
                           (and-i32 (get-hi y) -2147483648))));)
  :enable (@copysign @copysign-%0 store-double load-double store-i32 load-i32 get-hi set-hi)
  :disable (mod floor)
  :cases ((and (doublep x) (doublep y)))
  :hints (("subgoal 2" :in-theory (enable get-hi-double get-lo-double
                                          or-i32 make-double))))

(defruled s-fabs
  (equal (@fabs x)
         (set-hi x (and-i32 (get-hi x) #x7fffffff)))
  :enable (@fabs @fabs-%0 store-double load-double store-i32 load-i32 get-hi
                 set-hi)
  :cases ((doublep x))
  :hints (("subgoal 2" :in-theory (enable get-lo-double make-double))))

(defruled w-acos
  (equal (@acos x)
         (@__ieee754_acos x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_acos x)))
      :enable (@__ieee754_acos @__ieee754_acos-%0 store-double)))
  :enable (@acos @acos-%0 store-double load-double))

(defruled w-asin
  (equal (@asin x)
         (@__ieee754_asin x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_asin x)))
      :enable (@__ieee754_asin @__ieee754_asin-%0 store-double)))
  :enable (@asin @asin-%0 store-double load-double))

(defruled w-atan2
  (equal (@atan2 y x)
         (@__ieee754_atan2 y x))
  :prep-lemmas (
    (defrule lemma
      (implies (or (not (doublep y))
                   (not (doublep x)))
               (not (@__ieee754_atan2 y x)))
      :enable (@__ieee754_atan2 @__ieee754_atan2-%0
                                @__ieee754_atan2-%26
                                @__ieee754_atan2-%35
                                @__ieee754_atan2-%144
                                load-double store-double fadd-double load-i32 store-i32)))
  :enable (@atan2 @atan2-%0 store-double load-double))

(defruled w-cosh
  (equal (@cosh x)
         (@__ieee754_cosh x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_cosh x)))
      :enable (@__ieee754_cosh @__ieee754_cosh-%0 store-double)))
  :enable (@cosh @cosh-%0 store-double load-double))

(defruled w-exp
  (equal (@exp x)
         (@__ieee754_exp x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_exp x)))
      :enable (@__ieee754_exp @__ieee754_exp-%0 store-double)))
  :enable (@exp @exp-%0 store-double load-double))

(defruled w-hypot
  (equal (@hypot x y)
         (@__ieee754_hypot x y))
  :prep-lemmas (
    (defrule lemma
      (implies (or (not (doublep x))
                   (not (doublep y)))
               (not (@__ieee754_hypot x y)))
      :enable (@__ieee754_hypot @__ieee754_hypot-%0
                                @__IEEE754_HYPOT-%17
                                @__IEEE754_HYPOT-%23
                                @__IEEE754_HYPOT-%26
                                @__IEEE754_HYPOT-%37
                                @__IEEE754_HYPOT-%41
                                @__IEEE754_HYPOT-%44
                                @__IEEE754_HYPOT-%47
                                @__IEEE754_HYPOT-%57
                                @__IEEE754_HYPOT-%59
                                @__IEEE754_HYPOT-%70
                                @__IEEE754_HYPOT-%83
                                @__IEEE754_HYPOT-%200
                                load-double store-double fadd-double load-i32 store-i32)))
  :enable (@hypot @hypot-%0 store-double load-double))

(defruled w-log
  (equal (@log x)
         (@__ieee754_log x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_log x)))
      :enable (@__ieee754_log @__ieee754_log-%0 store-double)))
  :enable (@log @log-%0 store-double load-double))

(defruled w-log10
  (equal (@log10 x)
         (@__ieee754_log10 x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_log10 x)))
      :enable (@__ieee754_log10 @__ieee754_log10-%0 store-double)))
  :enable (@log10 @log10-%0 store-double load-double))

(defruled w-pow
  (equal (@pow x y)
         (@__ieee754_pow x y))
  :prep-lemmas (
    (defruled lemma1
      (implies (not (doublep x))
               (equal (@__ieee754_pow x y)
                      (@__ieee754_pow nil y)))
      :enable (@__ieee754_pow @__ieee754_pow-%0
                              ;@__IEEE754_POW-%27
                              ;@__IEEE754_POW-%28
                              ;@__IEEE754_POW-%706
                              load-double store-double load-i32 store-i32))
    (defrule lemma2
      (implies (not (doublep y))
               (not (@__ieee754_pow x y)))
      :enable (@__ieee754_pow @__ieee754_pow-%0
                              load-double
                              store-double load-i32 store-i32
                              )))
  :enable (@pow @pow-%0 store-double load-double)
  :use lemma1)

(defruled w-sinh
  (equal (@sinh x)
         (@__ieee754_sinh x))
  :prep-lemmas (
    (defrule lemma
      (implies (not (doublep x))
               (not (@__ieee754_sinh x)))
      :enable (@__ieee754_sinh @__ieee754_sinh-%0 store-double)))
  :enable (@sinh @sinh-%0 store-double load-double))

(defruled w-sqrt
  (equal (@sqrt x)
         (if (doublep x)
             (@__ieee754_sqrt x)
           nil))
  :enable (@sqrt @sqrt-%0 store-double load-double))
