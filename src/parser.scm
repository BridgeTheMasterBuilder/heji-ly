(define-module (parser)
  :export (parse-heji-string))

(use-modules (lily))

(define (add-factor factor factor-list)
  (let ((f (caar factor-list)))
    (if (= f 0)
        (cons factor (cdr factor-list))
        (cons factor factor-list))))

(define (lex-number input output k)
  (let*
   (
     ;; Index of the first non-numeric character following some string of digits,
     ;; or the end of the string if there is no such character
     (i (or (string-skip input char-numeric?) (string-length input)))
     (n (string->number (string-take input i)))
     (rest (substring input i)))
   (k rest output n)))

(define (lex-factor input output k)
  (lex-number input
              output
              (lambda
               (input output n)
               (let* ((factor (car output))
                      (rest (cdr output))
                      (e (cdr factor)))
                 (k input (add-factor (cons n e) output)  lex-factor)))))

(define (lex-exponent input output k)
  (lex-number input
              output
              (lambda
               (input output n)
               (let* ((factor (car output))
                      (rest (cdr output))
                      (f (car factor))
                      (e (cdr factor)))
                 (k input (cons (cons f (* n e)) rest) lex-factor)))))

;; Continuation-passing style lexical analyzer
;;
;; Precondition: The input string is well-formed according to one rule:
;;               - Any occurrence of the characters 'o', 'u' or '^' is eventually followed by a number,
;;                 after zero or more arbitrary characters
;; Postcondition: A list of pairs (x . y) corresponding to the input string, or '((0 . 1)) if it's empty
(define (lex input output k)
  (if (string-null? input)
      output
      (let ((char (string-ref input 0))
            (rest (substring input 1)))
        (cond ((char-ci=? char #\o) (lex rest (add-factor '(0 . 1) output) lex-factor))
              ((char-ci=? char #\u) (lex rest (add-factor '(0 . -1) output) lex-factor))
              ((char-ci=? char #\^) (lex rest output lex-exponent))
              ((char-whitespace? char) (lex rest (add-factor '(0 . 1) output) lex-factor))
              ((char-numeric? char) (k input output lex))
              (else
               ;; TODO should probably accept a boolean parameter instead but that is a bit of an intrusive change
               (if (ly:parser-lookup 'heji-ly-warn-on-ill-formed-factor-string)
                   (ly:warning (format #f "Ignoring spurious character ~c" char)))
               (lex rest output k))))))

(define (parse-heji-string factors warn-on-empty-factors)
  (if (and (string-null? factors) warn-on-empty-factors) (ly:warning "Interpreting empty factor list as natural accidental"))
  (lex factors '((0 . 1)) lex-factor))
