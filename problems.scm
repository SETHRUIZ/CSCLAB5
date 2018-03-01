;(load "enumeration.scm")
(load "logic.scm")
(require "weinman-enumeration.scm")

;; Unicorn KB

; If the unicorn is mythical, then it is immortal, and if it
; isn't mythical, then it is not immortal. 
(define mythical? (list 'and
                        (list '=>
                              'mythical
                              'immortal)
                        (list '=>
                              (list 'not 'mythical)
                              (list 'not 'immortal))))

; Implies that if the unicorn is either immortal or mammal, then
; it is horned.
(define horned? (list '=>
                      (list 'or 'immortal 'mammal)
                      'horned))

; If the unicorn is horned, then it is magical.
(define magical? (list '=>
                       'horned
                       'magical))

(define unicorn-kb (list 'and
                         (list 'and
                               mythical?
                               horned?)
                         magical?))

(display "Is the unicorn mythical? \n")
(display (tt-entails? unicorn-kb 'mythical)) (newline)

(display "Is the unicorn magical? \n")
(display (tt-entails? unicorn-kb 'magical)) (newline)

(display "Is the unicorn horned? \n")
(display (tt-entails? unicorn-kb 'horned)) (newline)

;; Portia's Caskets
;  Symbols: gold-true, silver-true,lead-true,
;           gold-contains, silver-contains, lead-contains


; Only gold says the truth and the other two are false
(define gold-truth (list 'and
                         (list 'and
                               'gold-true
                               (list 'not 'silver-true))
                         (list 'not 'lead-true)))

; Only silver says the truth and the other two are false
(define silver-truth (list 'and
                           (list 'and
                                 'silver-true
                                 (list 'not 'gold-true))
                           (list 'not 'lead-true)))

; Only lead says the truth and the other two are false
(define lead-truth (list 'and
                         (list 'and
                               'lead-true
                               (list 'not 'silver-true))
                         (list 'not 'gold-true)))

; None of the caskets say the truth
(define no-truth (list 'and
                       (list 'and
                             (list 'not 'gold-true)
                             (list 'not 'silver-true))
                       (list 'not 'lead-true)))

; Combines the propositions above to say that at most
; one of the caskets say the truth
(define at-most-one-true (list 'or
                               (list 'or
                                     (list 'or
                                           gold-truth
                                           silver-truth)
                                     lead-truth)
                               no-truth))

; Translates the inscription "The portrait is in this casket"
(define gold (list 'and
                   (list '=>
                         'gold-true
                         'gold-contains)
                   (list '=>
                         (list 'not 'gold-true)
                         (list 'not 'gold-contains))))

; Translates the inscription "The portrait is not in this casket"
(define silver (list 'and
                   (list '=>
                         'silver-true
                         (list 'not 'silver-contains))
                   (list '=>
                         (list 'not 'silver-true)
                         'silver-contains)))

; Translates the inscription "The portrait is not in the gold casket"
(define lead (list 'and
                   (list '=>
                         'lead-true
                         (list 'not 'gold-contains))
                   (list '=>
                         (list 'not 'lead-true)
                         'gold-contains)))

; Combines the propositions above to create the knowedge base
(define portias-kb (list 'and
                         (list 'and
                               (list 'and
                                     at-most-one-true
                                     gold)
                               silver)
                         lead))

(display "Gold contains? \n")
(display (tt-entails? portias-kb 'gold-contains)) (newline)

(display "Silver contains? \n")
(display (tt-entails? portias-kb 'silver-contains)) (newline)

(display "Lead contains? \n")
(display (tt-entails? portias-kb 'lead-contains)) (newline)



;; Knights, Knaves, and Werewolves
; Symbols: a-knight, b-knight, c-knight
;          a-werewolf, b-werewolf, c-werewolf

; A is a knight and the other two are not knights
(define A-knight (list 'and
                       (list 'and
                             'a-knight
                             (list 'not 'b-knight))
                       (list 'not 'c-knight)))

; B is a knight and the other two are not knights
(define B-knight (list 'and
                       (list 'and
                             'b-knight
                             (list 'not 'a-knight))
                       (list 'not 'c-knight)))

; C is a knight and the other two are not knights
(define C-knight (list 'and
                       (list 'and
                             'c-knight
                             (list 'not 'a-knight))
                       (list 'not 'b-knight)))

; None of the inhabitants are knights
(define no-knight (list 'and
                        (list 'and
                              (list 'not 'a-knight)
                              (list 'not 'b-knight))
                        (list 'not 'c-knight)))

; Combines the propositions above to say that at most one
; of the inhabitants is a knight
(define at-most-one-knight (list 'or
                                 (list 'or
                                       (list 'or
                                             A-knight
                                             B-knight)
                                       C-knight)
                                 no-knight))

; A is a werewolf and the other two are not
(define a-werewolf (list 'and
                         (list 'and
                               'a-werewolf
                               (list 'not 'b-werewolf))
                         (list 'not 'c-werewolf)))

; B is a werewolf and the other two are not
(define b-werewolf (list 'and
                         (list 'and
                               'b-werewolf
                               (list 'not 'a-werewolf))
                         (list 'not 'c-werewolf)))

; C is a werewolf and the other two are not
(define c-werewolf (list 'and
                         (list 'and
                               'c-werewolf
                               (list 'not 'b-werewolf))
                         (list 'not 'a-werewolf)))

; Combines the propositions above to say that there is exactly
; one werewolf
(define exactly-one-werewolf (list 'or
                                   (list 'or
                                         a-werewolf
                                         b-werewolf)
                                   c-werewolf))
; Translates A's statement "I am a werewolf"
(define A (list 'and
                (list '=>
                      'a-knight
                      'a-werewolf)
                (list '=>
                      (list 'not 'a-knight)
                      (list 'not 'a-werewolf))))

; Translates B's statement "I am a werewolf"
(define B (list 'and
                (list '=>
                      'b-knight
                      'b-werewolf)
                (list '=>
                      (list 'not 'b-knight)
                      (list 'not 'b-werewolf))))

; Translates C's statement "At most one of us is a knight"
(define C (list 'and
                (list '=>
                      'c-knight
                      at-most-one-knight)
                (list '=>
                      (list 'not 'c-knight)
                      (list 'not at-most-one-knight))))

; Combines the statements above to create the knowledge base
(define liars-kb (list 'and
                       exactly-one-werewolf
                       (list 'and
                             (list 'and
                                   A
                                   B)
                             C)))

(display "Is A a knight? \n")
(display (tt-entails? liars-kb 'a-knight)) (newline)
(display "Is A a knave? \n")
(display (tt-entails? liars-kb (list 'not 'a-knight))) (newline)

(display "Is B a knight? \n")
(display (tt-entails? liars-kb 'b-knight)) (newline)
(display "Is B a knave? \n")
(display (tt-entails? liars-kb (list 'not 'b-knight))) (newline)

(display "Is C a knight? \n")
(display (tt-entails? liars-kb 'c-knight)) (newline)
(display "Is C a knave? \n")
(display (tt-entails? liars-kb (list 'not 'c-knight))) (newline)

(display "Is A a werewolf? \n")
(display (tt-entails? liars-kb 'a-werewolf)) (newline)
(display "Is A a human? \n")
(display (tt-entails? liars-kb (list 'not 'a-werewolf))) (newline)

(display "Is B a werewolf? \n")
(display (tt-entails? liars-kb 'b-werewolf)) (newline)
(display "Is B a human? \n")
(display (tt-entails? liars-kb (list 'not 'b-werewolf))) (newline)

(display "Is C a werewolf? \n")
(display (tt-entails? liars-kb 'c-werewolf)) (newline)
(display "Is C a human? \n")
(display (tt-entails? liars-kb (list 'not 'c-werewolf))) (newline)
