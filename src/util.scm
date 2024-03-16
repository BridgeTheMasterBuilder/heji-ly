(define-module (util)
  :export (set-if-unset prime-p ignore log-b))

(use-modules (lily))

(define (set-if-unset sym val)
  (if (null? (ly:parser-lookup sym)) val (eval sym (current-module))))

;; TODO - Replace with more efficient primality test?
(define (prime-p n)
  (define (aux k)
    (cond ((> (* k k) n) #t)
          ((= (modulo n k) 0) #f)
          (else (aux (+ k 1)))))
  (if (<= n 1)
      #f
      (aux 2)))

(define (ignore msg x)
  (begin (ly:warning msg) x))

(define (log-b b x)
  (/ (log10 x) (log10 b)))
