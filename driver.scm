(load "logic.scm")
(load "enumeration.scm")

(define notA (list 'not 'A))

(define notC (list 'not 'C))

(define AVB (list 'or 'A 'B))

(define BVC (list 'or 'B 'C))

(define D^T (list 'and 'D #t))

(define AVBVC (list 'or 'A ( list 'or 'B 'C)))

(define AB->CD (list '=> (list 'and 'A 'B) (list 'or 'C 'D)))

(define conjunction-symbols (get-symbols D^T))

(define disjunction-symbols (get-symbols AVBVC))

(define model1 '((P . #t)))
(define model2 '((J . #f)))
(define model3 '((H . #t) (I . #f)))

(display "pl-true expected true \n")
(display (pl-true? 'P model1))
(newline)
(display "pl-true expected false \n")
(display (pl-true? 'J model2))
(newline)
(display "pl-true expected false \n")
(display (pl-true? 'I model3))
(newline)
(display "pl-true expected true \n")
(display (pl-true? 'H model3))
(newline)

(define KB1 (list 'and AVB (list 'and AB->CD  notC)))

(define query1 notC)
(define query2 'C)
(define query3 'E)
(define query4 'A)
(define query5 AVB)

(display "tt-entails expected true \n")
(display (tt-entails? KB1 query1))
(newline)
(display "tt-entails expected false \n")
(display (tt-entails? KB1 query2))
(newline)
(display "tt-entails expected false \n")
(display (tt-entails? KB1 query3))
(newline)


;; tt-check-all tests
(display "tt-check-all test  expected false\n")
(display (tt-check-all KB1
                       query4
                       (list-union (get-symbols KB1)
                                   (get-symbols query4))
                       '()
                       ))
(newline)
(display "tt-check-all test expected true \n")
(display (tt-check-all KB1
                       query5
                       (list-union (get-symbols KB1)
                                   (get-symbols query5))
                       '()
                       ))
(newline)
                       