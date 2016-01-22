(in-package "ACL2")

(include-book "std/util/defrule" :dir :system)
(include-book "llvm/s_cbrt")
(include-book "cbrts")

(defrule globals-equ
  (equal *cbrt-globals* *cbrts-globals*)
  :rule-classes ())

(defruled ttt-%0
  (let ((s (@cbrts-%0 mem %x)))
    (equal (@cbrt-%0 mem %x)
           (case (car s)
             (@cbrts-%13 (@cbrt-%13 (cadr s)))
             (@cbrts-%17 (@cbrt-%17 (cadr s))))))
  :enable (@cbrts-%0 @cbrt-%0))

(defruled ttt-%13
  (equal (@cbrt-%13 mem)
         (@cbrt-%101 (cadr (@cbrts-%13 mem))))
  :enable (@cbrts-%13 @cbrt-%13))

(defruled ttt-%17
  (let ((s (@cbrts-%17 mem)))
    (equal (@cbrt-%17 mem)
           (case (car s)
             (@cbrts-%23 (@cbrt-%23 (cadr s)))
             (@cbrts-%25 (@cbrt-%25 (cadr s))))))
  :enable (@cbrts-%17 @cbrt-%17))

(defruled ttt-%23
  (equal (@cbrt-%23 mem)
         (@cbrt-%101 (cadr (@cbrts-%23 mem))))
  :enable (@cbrts-%23 @cbrt-%23))

(defruled ttt-%25
  (let ((s (@cbrts-%25 mem)))
    (equal (@cbrt-%25 mem)
           (case (car s)
             (@cbrts-%31 (@cbrt-%31 (cadr s)))
             (@cbrts-%44 (@cbrt-%44 (cadr s))))))
  :enable (@cbrts-%25 @cbrt-%25))

(defruled ttt-%31
  (equal (@cbrt-%31 mem)
         (@cbrt-%50 (cadr (@cbrts-%31 mem))))
  :enable (@cbrts-%31 @cbrt-%31))

(defruled ttt-%44
  (equal (@cbrt-%44 mem)
         (@cbrt-%50 (cadr (@cbrts-%44 mem))))
  :enable (@cbrts-%44 @cbrt-%44))

(defruled ttt-%50
  (equal (@cbrt-%50 mem)
         (@cbrt-%101 (cadr (@cbrts-%50 mem))))
  :enable (@cbrts-%50 @cbrt-%50))

(defruled ttt-%101
  (equal (@cbrt-%101 mem)
         (cadr (@cbrts-%101 mem)))
  :enable (@cbrts-%101 @cbrt-%101))

(defruled @cbrts-steps-sum
  (equal (@cbrts-steps (@cbrts-steps s m) n)
         (@cbrts-steps s (+ (nfix m) (nfix n))))
  :enable @cbrts-steps
  :induct (@cbrts-steps s m))
          
(defruled @cbrts-steps-nfix
  (equal (@cbrts-steps s (nfix n))
         (@cbrts-steps s n))
  :enable @cbrts-steps)

(defruled @cbrts-clock-aux-nfix
  (implies (equal (car (@cbrts-steps s (nfix n))) '@cbrts-ret)
           (equal (car (@cbrts-steps s (nfix (@cbrts-clock-aux s))))
                  '@cbrts-ret))
  :enable @cbrts-steps-nfix
  :use @cbrts-clock-aux)

(defrule @cbrts-clock-type
  (or (null (@cbrts-clock s))
      (natp (@cbrts-clock s)))
  :rule-classes :type-prescription)

(defrule @cbrts-clock-1
  (implies (not (@cbrts-clock s))
           (not (equal (car (@cbrts-steps s n)) '@cbrts-ret)))
  :enable (@cbrts-clock @cbrts-steps-nfix)
  :disable nfix
  :use @cbrts-clock-aux-nfix)

(defruled @cbrts-clock-2a 
  (implies (@cbrts-clock s)
           (equal (car (@cbrts-steps s (@cbrts-clock s))) '@cbrts-ret))
  :enable @cbrts-clock)

(defrule @cbrts-steps-nil
  (equal (@cbrts-steps nil n) nil)
  :enable @cbrts-steps)

(defrule @cbrts-clock-nil
  (equal (@cbrts-clock nil) nil)
  :use (:instance @cbrts-clock-2a (s nil)))

(defruled steps-after-final
  (implies (and (equal (car s) '@cbrts-ret)
                (posp n))
           (equal (@cbrts-steps s n) nil))
  :enable @cbrts-step
  :expand (@cbrts-steps s n))
           
(defrule @cbrts-clock-2
  (implies (equal (car (@cbrts-steps s n)) '@cbrts-ret)
           (equal (@cbrts-clock s) (nfix n)))
  :prep-lemmas (
    (defrule lemma
      (equal (+ n (- n) x)
             (fix x))))
  :enable (steps-after-final @cbrts-clock-2a)
  :cases ((> (nfix n) (@cbrts-clock s))
          (< (nfix n) (@cbrts-clock s)))
  :hints (
    ("subgoal 2" :use (:instance @cbrts-steps-sum
                        (m (@cbrts-clock s))
                        (n (- (nfix n) (@cbrts-clock s)))))
    ("subgoal 1" :cases ((natp n)))
    ("subgoal 1.2" :expand (@cbrts-steps s n)
                   :in-theory (disable steps-after-final)
                   :use ((:instance steps-after-final
                           (n (@cbrts-clock s)))
                         (:instance @cbrts-clock-2a)))
    ("subgoal 1.1" :in-theory (disable steps-after-final @cbrts-clock-2a)
                   :cases ((@cbrts-clock s))
                   :use ((:instance @cbrts-steps-sum
                           (m n)
                           (n (- (@cbrts-clock s) n)))
                         (:instance steps-after-final
                           (s (@cbrts-steps s n))
                           (n (- (@cbrts-clock s) n)))
                         (:instance @cbrts-clock-2a)))))
                

(defrule kkk-ret
  (equal (@cbrts-clock (cons '@cbrts-ret tail)) 0)
  :use (:instance @cbrts-clock-2
         (s (cons '@cbrts-ret tail))
         (n 0))
  :expand (@cbrts-steps (cons '@cbrts-ret tail) 0)) 

(defrule kkk-ret-1
  (implies (equal (car s) '@cbrts-ret)
           (equal (@cbrts-clock s) 0)))

(defrule steps-clock-bad-label
  (implies
   (not (member (car s)
                '(@cbrts-%0
                  @cbrts-%13
                  @cbrts-%17
                  @cbrts-%23
                  @cbrts-%25
                  @cbrts-%31
                  @cbrts-%31
                  @cbrts-%44
                  @cbrts-%50
                  @cbrts-%101
                  @cbrts-ret)))
   (equal (@cbrts-clock s) nil))
  :enable @cbrts-step
  :use @cbrts-clock-2a
  :expand (@cbrts-steps s (@cbrts-clock s)))
#|
(defrule steps-thm
  (equal (@cbrts-clock s)
         (cond ((equal (car s) '@cbrts-ret) 0)
               ((and
                 (member (car s)
                         '(@cbrts-%0
                           @cbrts-%13
                           @cbrts-%17
                           @cbrts-%23
                           @cbrts-%25
                           @cbrts-%31
                           @cbrts-%31
                           @cbrts-%44
                           @cbrts-%50
                           @cbrts-%101))
                 (@cbrts-clock (@cbrts-step s)))
                (1+ (@cbrts-clock (@cbrts-step s))))
               (t nil)))
;  :enable @cbrts-step
  :cases ((= (@cbrts-clock s) 0)
          (posp (@cbrts-clock s)))
  :hints (
;    ("subgoal 2" :cases (()))
  )
  :rule-classes ()
)

(defrule kkk-101
  (implies (equal (car s) '@cbrt-%101)
           (equal (@cbrt-clock s)
                  (1+ (@cbrt-clock (list '@cbrt-ret ( 

(defrule kkk-%101
  (implies (equal (car s) '@cbrts-%101)
           (equal (@cbrts-steps s (@cbrts-clock s))
                  (@cbrt-%101 (cadr s))))
)
;  (equal (@cbrt-step-steps (list '@cbrt-step-%101 mem) (@cbrt-clock-%101 %x))
;         (@cbrt-%101 mem))
;  :enable (@cbrt-clock-%101 @cbrt-step-step @cbrt-step-%101 @cbrt-%101)
;  :expand ((@cbrt-step-steps (list '@cbrt-step-%101 mem) 1)
;           (@cbrt-step-steps (list '@cbrt-step-ret (load-double '(ret . 0) mem)) 0)))
;----------------------------------

  (defund @cbrt-clock-%101 (%x)
  (declare (ignore %x))
  1)

(defrule ttt-%101
  (equal (@cbrt-step-steps (list '@cbrt-step-%101 mem) (@cbrt-clock-%101 %x))
         (@cbrt-%101 mem))
  :enable (@cbrt-clock-%101 @cbrt-step-step @cbrt-step-%101 @cbrt-%101)
  :expand ((@cbrt-step-steps (list '@cbrt-step-%101 mem) 1)
           (@cbrt-step-steps (list '@cbrt-step-ret (load-double '(ret . 0) mem)) 0)))

(defund @cbrt-clock-%50 (%x)
  (1+ (@cbrt-clock-%101 %x)))

(defrule ttt-%50
  (equal (@cbrt-step-steps (list '@cbrt-step-%50 mem) (@cbrt-clock-%50 %x))
         (@cbrt-%101 mem))
  :enable (@cbrt-clock-%50 @cbrt-step-step @cbrt-step-%50 @cbrt-%50)
  :expand ((@cbrt-step-steps (list '@cbrt-step-%50 mem) (1+ (@cbrt-clock-%101 %x)))
;           (@cbrt-step-steps (list '@cbrt-step-ret (load-double '(ret . 0)
;           mem)) 0))
           )
  )


#|
(defrule @cbrt-step-%101-equ
  (equal (@cbrt-step-%101 mem)
         (list '@cbrt-step-ret (@cbrt-%101 mem)))
  :enable (@cbrt-step-%101 @cbrt-%101))
|#
(defrule @cbrt-step-%50-equ
  (equal (@cbrt-step-%50 mem)
         (list '@cbrt-step-%101 (@cbrt-%101 mem)))
  :enable (@cbrt-step-%101 @cbrt-%101))
|#
