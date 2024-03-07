\version "2.24.1"

set-if-unset = #(define-scheme-function (sym val)
                  (symbol? scheme?)
                  (if (null? (ly:parser-lookup sym)) val (eval sym (current-module))))

% TODO - Replace with more efficient primality test?
prime-p = #(define-scheme-function (n)
             (number?)
             (define (aux k)
               (cond ((> (* k k) n) #t)
                     ((= (modulo n k) 0) #f)
                     (else (aux (+ k 1)))))
             (if (<= n 1)
                 #f
                 (aux 2)))

ignore = #(define-scheme-function (msg x)
            (string? scheme?)
            (begin (ly:warning msg) x))

log-b = #(define-scheme-function (b x)
           (number? number?)
           (/ (log10 x) (log10 b)))