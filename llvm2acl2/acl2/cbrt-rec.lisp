(in-package "ACL2")
(include-book "llvm/s_cbrt-rec")
(include-book "llvm-rec-lemmas")

(defrule @cbrt-%101-type
  (implies (and (wordp (nth 0 (g 'ret mem)))
                (wordp (nth 1 (g 'ret mem))))
           (doublep (@cbrt-%101 mem '(ret . 0))))
  :enable (@cbrt-%101 load-double))

(defrule @cbrt-%50-type
  (implies (and (wordp (nth 0 (g 't mem)))
                (wordp (nth 1 (g 't mem)))
                (wordp (nth 0 (g 'sign mem)))
                (wordp (nth 0 (g 'x mem)))
                (wordp (nth 1 (g 'x mem))))
           (doublep (@cbrt-%50
                     mem
                     '(r . 0)
                     '(s . 0)
                     '(sign . 0)
                     '(t . 0)
                     '(w . 0)
                     '(ret . 0)
                     '(x . 0))))
  :enable (@cbrt-%50 store-double load-double store-i32 load-i32))
