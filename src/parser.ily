\version "2.24.1"

lex-number = #(define-scheme-function (input output factor k)
                (string? list? pair? procedure?)
                (let*
                 ; Ignore all non-numeric characters following 'o', 'u' or '^'
                 ((s (string-trim input (lambda (c) (not (char-numeric? c)))))
                  ; Index of the first non-numeric character following some string of digits,
                  ; or the end of the string if there is no such character
                  (i (or (string-skip s char-numeric?) (string-length s)))
                  (n (string->number (string-take s i)))
                  (rest (substring s i)))
                 (k rest output factor n)))

lex-factor = #(define-scheme-function (input output factor k)
                (string? list? pair? procedure?)
                (lex-number input
                            output
                            factor
                            (lambda
                             (input output factor n)
                             (let ((e (cdr factor)))
                               (k input output (cons n e))))))

lex-exponent = #(define-scheme-function (input output factor k)
                  (string? list? pair? procedure?)
                  (lex-number input
                              output
                              factor
                              (lambda
                               (input output factor n)
                               (let ((f (car factor))
                                     (e (cdr factor)))
                                 (k input output (cons f (* n e)))))))

% Continuation-passing style lexical analyzer
%
% Precondition: The input string is well-formed according to one rule:
%	- Any occurrence of the characters 'o', 'u' or '^' is eventually followed by a number,
%	  after zero or more arbitrary characters
% Postcondition: A list of pairs (x . y) corresponding to the input string, augmented with the
% 		 dummy element (2 . 0) which will be removed in a later pass.
lex = #(define-scheme-function (input output factor)
         (string? list? pair?)
         (if (string-null? input)
             (cons factor output)
             (let ((char (string-ref input 0))
                   (rest (substring input 1)))
               (cond ((char-ci=? char #\o) (lex-factor rest (cons factor output) '(0 . 1) lex))
                     ((char-ci=? char #\u) (lex-factor rest (cons factor output) '(0 . -1) lex))
                     ((char-ci=? char #\^) (lex-exponent rest output factor lex))
                     (else (lex rest output factor))))))

parse-heji-string = #(define-scheme-function (factors)
                       (string?)
                       (lex factors '() '(2 . 0)))