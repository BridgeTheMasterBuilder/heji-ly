\version "2.24.1"

lex-number = #(define-scheme-function (input output factor k)
                (string? list? pair? procedure?)
                (let*
                 (
                   ; Index of the first non-numeric character following some string of digits,
                   ; or the end of the string if there is no such character
                   (i (or (string-skip input char-numeric?) (string-length input)))
                   (n (string->number (string-take input i)))
                   (rest (substring input i)))
                 (k rest output factor n)))

lex-factor = #(define-scheme-function (input output factor k)
                (string? list? pair? procedure?)
                (lex-number input
                            output
                            factor
                            (lambda
                             (input output factor n)
                             (let ((e (cdr factor)))
                               (k input output (cons n e) lex-factor)))))

lex-exponent = #(define-scheme-function (input output factor k)
                  (string? list? pair? procedure?)
                  (lex-number input
                              output
                              factor
                              (lambda
                               (input output factor n)
                               (let ((f (car factor))
                                     (e (cdr factor)))
                                 (k input output (cons f (* n e)) lex-factor)))))

% Continuation-passing style lexical analyzer
%
% Precondition: The input string is well-formed according to one rule:
%	- Any occurrence of the characters 'o', 'u' or '^' is eventually followed by a number,
%	  after zero or more arbitrary characters
% Postcondition: A list of pairs (x . y) corresponding to the input string, possibly augmented with some
% 		 dummy elements which will be removed in a later pass.
lex = #(define-scheme-function (input output factor k)
         (string? list? pair? procedure?)
         (if (string-null? input)
             (cons factor output)
             (let ((char (string-ref input 0))
                   (rest (substring input 1)))
               (cond ((char-ci=? char #\o) (lex rest (cons factor output) '(0 . 1) lex-factor))
                     ((char-ci=? char #\u) (lex rest (cons factor output) '(0 . -1) lex-factor))
                     ((char-ci=? char #\^) (lex rest output factor lex-exponent))
                     ((char-whitespace? char) (lex rest (cons factor output) '(0 . 1) lex-factor))
                     ((char-numeric? char) (k input output factor lex))
                     (else
                      ; TODO should probably accept a boolean parameter instead but that is a bit of an intrusive change
                      (if (ly:parser-lookup 'warn-on-ill-formed-factor-string)
                          (ly:warning (format #f "Ignoring spurious character ~c" char)))
                      (lex rest output factor k))))))

parse-heji-string = #(define-scheme-function (factors)
                       (string?)
                       (lex factors '() '(0 . 1) lex-factor))