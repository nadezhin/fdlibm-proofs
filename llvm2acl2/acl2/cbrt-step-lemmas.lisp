(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "llvms/s_cbrt")
(include-book "cbrts")


; -------------------------

(defnd @cbrt-local-vars-p (loc)
  (and (equal (g '%1 loc) '(ret . 0))
       (equal (g '%2 loc) '(x . 0))
       (equal (g '%hx loc) '(hx . 0))
       (equal (g '%r loc) '(r . 0))
       (equal (g '%s loc) '(s . 0))
       (equal (g '%t loc) '(t . 0))
       (equal (g '%w loc) '(w . 0))
       (equal (g '%sign loc) '(sign . 0))))

(defrule @cbrt-local-vars
  (implies (@cbrt-local-vars-p loc)
           (and (equal (g '%1 loc) '(ret . 0))
                (equal (g '%2 loc) '(x . 0))
                (equal (g '%hx loc) '(hx . 0))
                (equal (g '%r loc) '(r . 0))
                (equal (g '%s loc) '(s . 0))
                (equal (g '%t loc) '(t . 0))
                (equal (g '%w loc) '(w . 0))
                (equal (g '%sign loc) '(sign . 0))))
  :enable @cbrt-local-vars-p)

(defrule @cbrt-local-vars-s
  (implies (and (@cbrt-local-vars-p loc)
                (not (member key '(%1 %2 %hx %r %s %t %w %sign))))
           (@cbrt-local-vars-p (s key val loc)))
  :enable @cbrt-local-vars-p)

(defruled tttt-%0
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%0-bb mem loc pred)
    (implies (equal (g '%x loc) %x)
             (and (equal (@cbrts-%0 mem %x)
                         (case new-label
                           (%13 (list '@cbrts-%13 new-mem))
                           (%17 (list '@cbrts-%17 new-mem))))
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%0-bb @cbrts-%0 @cbrt-local-vars-p)
  :disable s-diff-s)

(defruled tttt-%13
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%13-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%13 mem)
                         (list '@cbrts-%101 new-mem))
                  (equal new-label '%101)
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%13-bb @cbrts-%13)
  :disable s-diff-s)

(defruled tttt-%17
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%17-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%17 mem)
                         (case new-label
                           (%23 (list '@cbrts-%23 new-mem))
                           (%25 (list '@cbrts-%25 new-mem))))
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%17-bb @cbrts-%17)
  :disable s-diff-s)

(defruled tttt-%23
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%23-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%23 mem)
                         (list '@cbrts-%101 new-mem))
                  (equal new-label '%101)
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%23-bb @cbrts-%23)
  :disable s-diff-s)

(defruled tttt-%25
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%25-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%25 mem)
                         (case new-label
                           (%31 (list '@cbrts-%31 new-mem))
                           (%44 (list '@cbrts-%44 new-mem))))
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%25-bb @cbrts-%25)
  :disable s-diff-s)

(defruled tttt-%31
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%31-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%31 mem)
                         (list '@cbrts-%50 new-mem))
                  (equal new-label '%50)
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%31-bb @cbrts-%31)
  :disable s-diff-s)

(defruled tttt-%44
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%44-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%44 mem)
                         (list '@cbrts-%50 new-mem))
                  (equal new-label '%50)
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%44-bb @cbrts-%44)
  :disable s-diff-s)

(defruled tttt-%50
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%50-bb mem loc pred)
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%50 mem)
                         (list '@cbrts-%101 new-mem))
                  (equal new-label '%101)
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%50-bb @cbrts-%50)
  :disable s-diff-s)

(defruled tttt-%101
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%101-bb mem loc pred)
    (declare (ignore new-mem))
    (implies (and (equal (g '%x loc) %x)
                  (@cbrt-local-vars-p loc))
             (and (equal (@cbrts-%101 mem)
                         (list '@cbrts-ret (g '%102 new-loc)))
                  (equal new-label 'ret)
                  (equal (g '%x new-loc) %x)
                  (@cbrt-local-vars-p new-loc))))
  :enable (@cbrt-%101-bb @cbrts-%101)
  :disable s-diff-s)

(defconst *cbrt-states* (list* 'ret *cbrt-labels*))

(defund cbrt-state-p (x)
  (and (member x *cbrt-states*) t))

(local
 (defund map-to-state (label mem loc)
   (declare (ignore mem loc))
   (and (member label *cbrt-states*) label)))

(local
 (defrule succ-bb-%0
   (b* (((mv new-label new-mem new-loc) (@cbrt-%0-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (or (equal s nil) (equal s '%13) (equal s '%17)))
   :enable (map-to-state @cbrt-%0-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%13
   (b* (((mv new-label new-mem new-loc) (@cbrt-%13-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%101))
   :enable (map-to-state @cbrt-%13-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%17
   (b* (((mv new-label new-mem new-loc) (@cbrt-%17-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (or (equal s nil) (equal s '%23) (equal s '%25)))
   :enable (map-to-state @cbrt-%17-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%23
   (b* (((mv new-label new-mem new-loc) (@cbrt-%23-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%101))
   :enable (map-to-state @cbrt-%23-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%25
   (b* (((mv new-label new-mem new-loc) (@cbrt-%25-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (or (equal s nil) (equal s '%31) (equal s '%44)))
   :enable (map-to-state @cbrt-%25-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%31
   (b* (((mv new-label new-mem new-loc) (@cbrt-%31-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%50))
   :enable (map-to-state @cbrt-%31-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%44
   (b* (((mv new-label new-mem new-loc) (@cbrt-%44-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%50))
   :enable (map-to-state @cbrt-%44-bb)
   :rule-classes ()))
#|
(local
 (defrule succ-bb-%50
   (b* (((mv new-label new-mem new-loc) (@cbrt-%50-bb mem loc pred))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%101))
   :enable (map-to-state @cbrt-%50-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%50-old
   (equal (mv-nth 0 (@cbrt-%50-bb mem loc pred)) '%101)
   :enable @cbrt-%50-bb
   :rule-classes ()))

(defund @cbrt-%50-mem (st) (car st))
(defund @cbrt-%50-loc (st) (cdr st))
(defund @cbrt-%51 (st) (load-double (g '%t (@cbrt-%50-loc st)) (@cbrt-%50-mem st)))
(defund @cbrt-%51-loc (st) (s '%51 (@cbrt-%51 st) (@cbrt-50-loc st)))

(local
 (defrule succ-bb-%0
   (member (car (@cbrt-%0-bb mem loc)) '(nil %13 %17))
   :prep-lemmas (
     (defrule lemma
       (let ((succ (car (@cbrt-%0-bb mem loc))))
         (or (equal succ nil)
             (equal succ '%13)
             (equal succ '%17)))
       :enable @cbrt-%0-bb
       :rule-classes ()))
   :use lemma
   :rule-classes ()))

(local
 (defrule succ-bb-%13
   (equal (car (@cbrt-%13-bb mem loc)) '%101)
   :enable @cbrt-%13-bb
   :rule-classes ()))

(local
 (defrule succ-bb-%17
   (member (car (@cbrt-%17-bb mem loc)) '(nil %23 %25))
   :enable @cbrt-%17-bb
   :rule-classes ()))

(local
 (defrule succ-bb-%23
   (equal (car (@cbrt-%23-bb mem loc)) '%101)
   :enable @cbrt-%23-bb
   :rule-classes ()))

(local
 (defrule succ-bb-%25
   (member (car (@cbrt-%25-bb mem loc)) '(nil %31 %44))
   :prep-lemmas (
     (defrule lemma
       (let ((succ (car (@cbrt-%25-bb mem loc))))
         (or (equal succ nil)
             (equal succ '%31)
             (equal succ '%44)))
       :enable @cbrt-%25-bb
       :rule-classes ()))
   :use lemma
   :rule-classes ()))

(local
 (defrule succ-bb-%31
   (equal (car (@cbrt-%31-bb mem loc)) '%50)
   :enable @cbrt-%31-bb
   :rule-classes ()))

(local
 (defrule succ-bb-%44
   (equal (car (@cbrt-%44-bb mem loc)) '%50)
   :enable @cbrt-%44-bb
   :rule-classes ()))

(local
 (defrule succ-bb-%50
   (equal (car (@cbrt-%50-bb mem loc)) '%101)
   :enable @cbrt-%50-bb
   :rule-classes ()))

(local
 (defrule succ-bb-%101
   (equal (car (@cbrt-%101-bb mem loc)) 'ret)
   :enable @cbrt-%101-bb
   :rule-classes ()))

(local
 (defrule map-to-state-correct
   (member (map-to-state label mem loc) *cbrt-states*)
   :enable map-to-state))

(defconst *cbrt-transitions*
  '((%0   %13 %17 nil)
    (%13  %101)
    (%17  %23 %25 nil)
    (%23  %101)
    (%25  %31 %44 nil)
    (%31  %50)
    (%44  %50)
    (%50  %101)
    (%101 ret)
    (ret  nil)
    (nil  nil)))

(local
 (defruled transitions-correct
   (b* ((state (map-to-state label mem loc))
        ((mv next-state next-mem next-loc) (@cbrt-step label mem loc))
        (next-state (map-to-state next-state next-mem next-loc)))
     (member next-state (cdr (assoc-equal state *cbrt-transitions*))))
   :enable (map-to-state @cbrt-step)
  :cases ((equal label '%0)
          (equal label '%13)
          (equal label '%17)
          (equal label '%23)
          (equal label '%25)
          (equal label '%31)
          (equal label '%44)
          (equal label '%50)
          (equal label '%101)
          (equal label 'ret))
  :hints (
    ("subgoal 10" :use succ-bb-%0)
    ("subgoal 9" :use succ-bb-%13)
    ("subgoal 8" :use succ-bb-%17)
    ("subgoal 7" :use succ-bb-%23)
    ("subgoal 6" :use succ-bb-%25)
    ("subgoal 5" :use succ-bb-%31)
    ("subgoal 4" :use succ-bb-%44)
    ("subgoal 3" :use succ-bb-%50)
    ("subgoal 2" :use succ-bb-%101))))
                              

(defund meas (label mem loc)
  (declare (ignore mem loc))
  (case label
    (%-0 6)
    (%-13 2)
    (%-17 5)
    (%-23 2)
    (%-25 4)
    (%-31 3)
    (%-44 3)
    (%-50 2)
    (%-101 1)
    (ret 0)
    (otherwise (if label 1 0))))

;(defruled ttt
;  (equal (meas nil mem loc) 0)
;  :enable meas)

(defruled meas-dec
  (implies (posp (meas label mem loc))
           (mv-let
             (new-label new-mem new-loc)
             (@cbrt-step label mem loc)
             (< (meas new-label new-mem new-loc)
                (meas label mem loc))))
  :enable (@cbrt-step meas)
  :cases ((equal label '%-0)
          (equal label '%-13)
          (equal label '%-17)
          (equal label '%-23)
          (equal label '%-25)
          (equal label '%-31)
          (equal label '%-44)
          (equal label '%-50)
          (equal label '%-101))
  :hints (
    ("subgoal 9" :use succ-bb-%0)
    ("subgoal 8" :use succ-bb-%13)
    ("subgoal 7" :use succ-bb-%17)
    ("subgoal 6" :use succ-bb-%23)
    ("subgoal 5" :use succ-bb-%25)
    ("subgoal 4" :use succ-bb-%31)
    ("subgoal 3" :use succ-bb-%44)
    ("subgoal 2" :use succ-bb-%50)
    ("subgoal 1" :use succ-bb-%101)))

(defund @cbrt-meaning (label mem loc)
  (declare (xargs :measure (meas label mem loc)
                  :hints (("goal" :use (:instance meas-dec) :in-theory (enable meas)))))
  (if (equal label 'ret)
      (g '%101 loc)
    (if (equal label nil)
        nil
      (mv-let
        (label mem loc)
        (@cbrt-step label mem loc)
        (@cbrt-meaning label mem loc)))))

(defund @cbrt__ (%x)
  (@cbrt-meaning '%-0 '() (s '%x %x ())))

(@cbrt__ 0)

(defund @cbrt-steps_1 (label mem loc n)
  (declare (xargs :measure (nfix n)))
  (if (zp n) (mv label mem loc)
    (mv-let
      (new-label new-mem new-loc)
      (@cbrt-step label mem loc)
      (@cbrt-steps_1 new-label new-mem new-loc (1- n)))))

(@cbrt-steps_1 '%-0 '() (s '%x #x3ff0000000000000 ()) 0)
(@cbrt-steps_1 '%-0 '() (s '%x #x3ff0000000000000 ()) 1)
(@cbrt-steps_1 '%-0 '() (s '%x #x3ff0000000000000 ()) 2)

(@cbrt__ #x3ff0000000000000)
|#
