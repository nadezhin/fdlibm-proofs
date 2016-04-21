(in-package "ACL2")
(include-book "std/util/defrule" :dir :system)
(include-book "llvms/s_cbrt")
(include-book "cbrts")

(defruled @cbrt-%13-expand-bb-as-%14
  (equal (@cbrt-%13-bb mem loc pred)
         (let ((s13 (list mem loc pred)))
           (@cbrt-%14-rev
            (@cbrt-%13-mem s13)
            (@cbrt-%13-loc s13)
            (@cbrt-%13-pred s13))))
  :enable (@cbrt-%13-expand-bb @cbrt-%13-rev @cbrt-%13-mem @cbrt-%13-loc @cbrt-%13-pred))

(defruled @cbrt-%13-expand-bb-as-%15
  (equal (@cbrt-%13-bb mem loc pred)
         (let ((s13 (list mem loc pred)))
           (@cbrt-%15-rev
            (@cbrt-%13-mem s13)
            (@cbrt-%14-loc s13)
            (@cbrt-%13-pred s13))))
  :enable (@cbrt-%13-expand-bb-as-%14 @cbrt-%14-rev @cbrt-%14-loc @cbrt-%14-val))

(defruled @cbrt-%13-expand-bb-as-%16
  (equal (@cbrt-%13-bb mem loc pred)
         (let ((s13 (list mem loc pred)))
           (@cbrt-%16-rev
            (@cbrt-%13-mem s13)
            (@cbrt-%15-loc s13)
            (@cbrt-%13-pred s13))))
  :enable (@cbrt-%13-expand-bb-as-%15 @cbrt-%15-rev @cbrt-%15-loc  @cbrt-%15-val))

(defruled @cbrt-%13-expand-bb-as-m13.1
  (equal (@cbrt-%13-bb mem loc pred)
         (let ((s13 (list mem loc pred)))
           (@cbrt-m13.1-rev
            (@cbrt-%13-mem s13)
            (@cbrt-%16-loc s13)
            (@cbrt-%13-pred s13))))
  :enable (@cbrt-%13-expand-bb-as-%16 @cbrt-%16-rev @cbrt-%16-loc @cbrt-%16-val))

(defruled @cbrt-%13-expand-bb-as-succ13
  (equal (@cbrt-%13-bb mem loc pred)
         (let ((s13 (list mem loc pred)))
           (@cbrt-succ13-rev
            (@cbrt-m13.1-mem s13)
            (@cbrt-%16-loc s13)
            (@cbrt-%13-pred s13))))
  :enable (@cbrt-%13-expand-bb-as-m13.1 @cbrt-m13.1-rev @cbrt-m13.1-mem))

(defruled @cbrt-%13-expand-bb-as-mv
  (equal (@cbrt-%13-bb mem loc pred)
         (let ((s13 (list mem loc pred)))
           (mv
            (@cbrt-succ13-lab s13)
            (@cbrt-m13.1-mem s13)
            (@cbrt-%16-loc s13))))
  :enable (@cbrt-%13-expand-bb-as-succ13 @cbrt-succ13-rev @cbrt-succ13-lab))

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

(encapsulate ()
;  (local (in-theory nil))

  (defrule ttt_13_2
    (equal
     (@cbrt-%13-bb mem loc)
     (@cbrt-%13-succ (cons mem loc)))
  :enable (;g-diff-s g-same-s
           car-cons cdr-cons
                    @cbrt-%13-bb
                    @cbrt-%13-loc
                    @cbrt-%13-mem
                    @cbrt-%14
                    @cbrt-%14-loc
                    @cbrt-%15
                    @cbrt-%15-loc
                    @cbrt-%16
                    @cbrt-%16-loc
                    @cbrt-%1.1-mem
                    @cbrt-%13-succ
                    )
  :rule-classes ())
  
 (defrule ttt_0_2
    (equal
     (@cbrt-%0-bb mem loc)
     (@cbrt-%0-succ (cons mem loc)))
  :disable ((tau-system))
  :enable (;g-diff-s g-same-s
           car-cons cdr-cons
           @cbrt-%0-bb
           @cbrt-%0-succ         
           @cbrt-%hx.2-mem
           @cbrt-%sign.1-mem
           @cbrt-%hx.1-mem
           @cbrt-%t.1-mem
           @cbrt-%2.1-mem
           @cbrt-%sign-mem
           @cbrt-%sign-loc
           @cbrt-%w-mem
           @cbrt-%w-loc
           @cbrt-%t-mem
           @cbrt-%t-loc
           @cbrt-%s-mem
           @cbrt-%s-loc
           @cbrt-%r-mem
           @cbrt-%r-loc
           @cbrt-%hx-mem
           @cbrt-%hx-loc
           @cbrt-%2-mem
           @cbrt-%2-loc
           @cbrt-%1-mem
           @cbrt-%1-loc
           @cbrt-%0-mem
           @cbrt-%12-loc
           @cbrt-%12
           @cbrt-%11-loc
           @cbrt-%11
           @cbrt-%10-loc
           @cbrt-%10
           @cbrt-%9-loc
           @cbrt-%9
           @cbrt-%8-loc
           @cbrt-%8
           @cbrt-%7-loc
           @cbrt-%7
           @cbrt-%6-loc
           @cbrt-%6
           @cbrt-%5-loc
           @cbrt-%5
           @cbrt-%4-loc
           @cbrt-%4
           @cbrt-%3-loc
           @cbrt-%3
           @cbrt-%0-loc
           )
  :rule-classes ())

 (defrule ttt_5
  (mv-let
    (new-label new-mem new-loc)
    (@cbrt-%0-bb mem loc)
    (declare (ignore new-label))
    (and
     (equal new-mem (@cbrt-%hx.2-mem (cons mem loc)))
     (equal new-loc (@cbrt-%12-loc (cons mem loc)))
     
     ))
  :disable ((tau-system))
  :enable (;g-diff-s g-same-s
           car-cons cdr-cons
           @cbrt-%0-bb
           @cbrt-%hx.2-mem
           @cbrt-%sign.1-mem
           @cbrt-%hx.1-mem
           @cbrt-%t.1-mem
           @cbrt-%2.1-mem
           @cbrt-%sign-mem
           @cbrt-%sign-loc
           @cbrt-%w-mem
           @cbrt-%w-loc
           @cbrt-%t-mem
           @cbrt-%t-loc
           @cbrt-%s-mem
           @cbrt-%s-loc
           @cbrt-%r-mem
           @cbrt-%r-loc
           @cbrt-%hx-mem
           @cbrt-%hx-loc
           @cbrt-%2-mem
           @cbrt-%2-loc
           @cbrt-%1-mem
           @cbrt-%1-loc
           @cbrt-%0-mem
           @cbrt-%12-loc
           @cbrt-%12
           @cbrt-%11-loc
           @cbrt-%11
           @cbrt-%10-loc
           @cbrt-%10
           @cbrt-%9-loc
           @cbrt-%9
           @cbrt-%8-loc
           @cbrt-%8
           @cbrt-%7-loc
           @cbrt-%7
           @cbrt-%6-loc
           @cbrt-%6
           @cbrt-%5-loc
           @cbrt-%5
           @cbrt-%4-loc
           @cbrt-%4
           @cbrt-%3-loc
           @cbrt-%3
           @cbrt-%0-loc
           )
  :rule-classes ())

)
#|
        (:DEFINITION MV-NTH)
        (:EXECUTABLE-COUNTERPART BITCAST-DOUBLE*-TO-I32*)
        (:EXECUTABLE-COUNTERPART GETELEMENTPTR-I32)
        (:FAKE-RUNE-FOR-TYPE-SET NIL)
        (:REWRITE CAR-CONS)
        (:REWRITE CDR-CONS)
        (:REWRITE G-DIFF-S)
        (:REWRITE G-SAME-S)
        (:REWRITE S-DIFF-S))
|#
(defconst *cbrt-states* (list* 'ret *cbrt-labels*))

(defund cbrt-state-p (x)
  (and (member x *cbrt-states*) t))

(local
 (defund map-to-state (label mem loc)
   (declare (ignore mem loc))
   (and (member label *cbrt-states*) label)))

(local
 (defrule succ-bb-%0
   (b* (((mv new-label new-mem new-loc) (@cbrt-%0-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (or (equal s nil) (equal s '%13) (equal s '%17)))
   :enable (map-to-state @cbrt-%0-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%13
   (b* (((mv new-label new-mem new-loc) (@cbrt-%13-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%101))
   :enable (map-to-state @cbrt-%13-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%17
   (b* (((mv new-label new-mem new-loc) (@cbrt-%17-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (or (equal s nil) (equal s '%23) (equal s '%25)))
   :enable (map-to-state @cbrt-%17-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%23
   (b* (((mv new-label new-mem new-loc) (@cbrt-%23-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%101))
   :enable (map-to-state @cbrt-%23-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%25
   (b* (((mv new-label new-mem new-loc) (@cbrt-%25-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (or (equal s nil) (equal s '%31) (equal s '%44)))
   :enable (map-to-state @cbrt-%25-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%31
   (b* (((mv new-label new-mem new-loc) (@cbrt-%31-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%50))
   :enable (map-to-state @cbrt-%31-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%44
   (b* (((mv new-label new-mem new-loc) (@cbrt-%44-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%50))
   :enable (map-to-state @cbrt-%44-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%50
   (b* (((mv new-label new-mem new-loc) (@cbrt-%50-bb mem loc))
        (s (map-to-state new-label new-mem new-loc)))
     (equal s '%101))
   :enable (map-to-state @cbrt-%50-bb)
   :rule-classes ()))

(local
 (defrule succ-bb-%50-old
   (equal (mv-nth 0 (@cbrt-%50-bb mem loc)) '%101)
   :enable @cbrt-%50-bb
   :rule-classes ()))

(defund @cbrt-%50-mem (st) (car st))
(defund @cbrt-%50-loc (st) (cdr st))
(defund @cbrt-%51 (st) (load-double (g '%t (@cbrt-%50-loc st)) (@cbrt-%50-mem st)))
(defund @cbrt-%51-loc (st) (s '%51 (@cbrt-%51 st) (@cbrt-50-loc st)))

(defund @cbrt-%50-bb (mem loc)
  (b* (
    (loc (s '%51 (load-double (g '%t loc) mem) loc))
    (loc (s '%52 (load-double (g '%t loc) mem) loc))
    (loc (s '%53 (fmul-double (g '%51 loc) (g '%52 loc)) loc))
    (loc (s '%54 (load-double (g '%2 loc) mem) loc))
    (loc (s '%55 (fdiv-double (g '%53 loc) (g '%54 loc)) loc))
    (mem (store-double (g '%55 loc) (g '%r loc) mem))
    (loc (s '%56 (load-double (g '%r loc) mem) loc))
    (loc (s '%57 (load-double (g '%t loc) mem) loc))
    (loc (s '%58 (fmul-double (g '%56 loc) (g '%57 loc)) loc))
    (loc (s '%59 (fadd-double #x3FE15F15F15F15F1 (g '%58 loc)) loc))
    (mem (store-double (g '%59 loc) (g '%s loc) mem))
    (loc (s '%60 (load-double (g '%s loc) mem) loc))
    (loc (s '%61 (fadd-double (g '%60 loc) #x3FF6A0EA0EA0EA0F) loc))
    (loc (s '%62 (load-double (g '%s loc) mem) loc))
    (loc (s '%63 (fdiv-double #xBFE691DE2532C834 (g '%62 loc)) loc))
    (loc (s '%64 (fadd-double (g '%61 loc) (g '%63 loc)) loc))
    (loc (s '%65 (fdiv-double #x3FF9B6DB6DB6DB6E (g '%64 loc)) loc))
    (loc (s '%66 (fadd-double #x3FD6DB6DB6DB6DB7 (g '%65 loc)) loc))
    (loc (s '%67 (load-double (g '%t loc) mem) loc))
    (loc (s '%68 (fmul-double (g '%67 loc) (g '%66 loc)) loc))
    (mem (store-double (g '%68 loc) (g '%t loc) mem))
    (loc (s '%69 (bitcast-double*-to-i32* (g '%t loc)) loc))
    (mem (store-i32 0 (g '%69 loc) mem))
    (loc (s '%70 (bitcast-double*-to-i32* (g '%t loc)) loc))
    (loc (s '%71 (getelementptr-i32 (g '%70 loc) 1) loc))
    (loc (s '%72 (load-i32 (g '%71 loc) mem) loc))
    (loc (s '%73 (add-i32 (g '%72 loc) 1) loc))
    (mem (store-i32 (g '%73 loc) (g '%71 loc) mem))
    (loc (s '%74 (load-double (g '%t loc) mem) loc))
    (loc (s '%75 (load-double (g '%t loc) mem) loc))
    (loc (s '%76 (fmul-double (g '%74 loc) (g '%75 loc)) loc))
    (mem (store-double (g '%76 loc) (g '%s loc) mem))
    (loc (s '%77 (load-double (g '%2 loc) mem) loc))
    (loc (s '%78 (load-double (g '%s loc) mem) loc))
    (loc (s '%79 (fdiv-double (g '%77 loc) (g '%78 loc)) loc))
    (mem (store-double (g '%79 loc) (g '%r loc) mem))
    (loc (s '%80 (load-double (g '%t loc) mem) loc))
    (loc (s '%81 (load-double (g '%t loc) mem) loc))
    (loc (s '%82 (fadd-double (g '%80 loc) (g '%81 loc)) loc))
    (mem (store-double (g '%82 loc) (g '%w loc) mem))
    (loc (s '%83 (load-double (g '%r loc) mem) loc))
    (loc (s '%84 (load-double (g '%t loc) mem) loc))
    (loc (s '%85 (fsub-double (g '%83 loc) (g '%84 loc)) loc))
    (loc (s '%86 (load-double (g '%w loc) mem) loc))
    (loc (s '%87 (load-double (g '%r loc) mem) loc))
    (loc (s '%88 (fadd-double (g '%86 loc) (g '%87 loc)) loc))
    (loc (s '%89 (fdiv-double (g '%85 loc) (g '%88 loc)) loc))
    (mem (store-double (g '%89 loc) (g '%r loc) mem))
    (loc (s '%90 (load-double (g '%t loc) mem) loc))
    (loc (s '%91 (load-double (g '%t loc) mem) loc))
    (loc (s '%92 (load-double (g '%r loc) mem) loc))
    (loc (s '%93 (fmul-double (g '%91 loc) (g '%92 loc)) loc))
    (loc (s '%94 (fadd-double (g '%90 loc) (g '%93 loc)) loc))
    (mem (store-double (g '%94 loc) (g '%t loc) mem))
    (loc (s '%95 (load-i32 (g '%sign loc) mem) loc))
    (loc (s '%96 (bitcast-double*-to-i32* (g '%t loc)) loc))
    (loc (s '%97 (getelementptr-i32 (g '%96 loc) 1) loc))
    (loc (s '%98 (load-i32 (g '%97 loc) mem) loc))
    (loc (s '%99 (or-i32 (g '%98 loc) (g '%95 loc)) loc))
    (mem (store-i32 (g '%99 loc) (g '%97 loc) mem))
    (loc (s '%100 (load-double (g '%t loc) mem) loc))
    (mem (store-double (g '%100 loc) (g '%1 loc) mem)))
  (mv '%101 mem loc)))


#|
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
