\version "2.24.1"

\include "accidentals.ily"

valid-prime-exponent = #(define-scheme-function (factor exponent)
                          (number? number?)
                          (let ((max-exponent (cond ((= factor 3) 2)
                                                    ((= factor 5) 4)
                                                    ((= factor 7) 2)
                                                    (else 1))))
                            (cond
                             ((not (prime-p factor))
                              (ly:error (format #f "~d is not a prime factor." factor)))
                             ((> (abs exponent) max-exponent)
                              (ly:error (format #f "~d-limit accidentals currently only support a maximum exponent of ±~d." factor max-exponent)))
                             (else #t))))

% Precondition: Factors is a possibly empty sorted list of pairs (x . y)
% Postcondition: The returned list is a sorted list of pairs (x . y) satisfying the following conditions:
%	- Each pair has a unique left hand element (key)
%	- Adjacent pairs (x . y) and (x . z) in the input list are combined into (x . (+ y z))
%	- Adjacent pairs (3 . y) and (5 . z) in the input list are combined into
%		((* 5 prime) . z)
%	  where prime is some prime number, see `accidentals.ily` for an explanation
%	- No pair has 2 as its key
normalize-factors = #(define-scheme-function (factors)
                       (list?)
                       (if (nil? factors)
                           factors
                           (let* ((this-factor (car factors))
                                  (rest (cdr factors))
                                  (f (car this-factor))
                                  (e (cdr this-factor)))
                             (cond
                              ((or (= f 2) (= e 0)) (normalize-factors rest))
                              ((not (nil? rest))
                               (let* ((that-factor (cadr factors))
                                      (f1 f)
                                      (f2 (car that-factor))
                                      (e1 e)
                                      (e2 (cdr that-factor)))
                                 (cond ((= f1 f2)
                                        (cons (cons f1 (+ e1 e2))
                                              (normalize-factors (cdr rest))))
                                       ((= e2 0) (normalize-factors (cons this-factor (cdr rest))))
                                       ((and (= f1 3) (= f2 5))
                                        (cons (cons (* 5 (prime (+ e1 2)))
                                                    e2)
                                              (normalize-factors (cdr rest))))
                                       (else (cons this-factor (normalize-factors rest))))))
                              (else (list this-factor))))))

% Precondition: Factors is a possibly empty list of pairs (x . y) where x is a prime number and y is valid according to the
%		predicate valid-prime-exponent
% Postcondition: The returned list is a list of code points corresponding to the accidentals described by the input list
%		 in _descending_ order
parse-heji = #(define-scheme-function (factors)
                (list?)
                (define (factor-lt fe1 fe2) (< (car fe1) (car fe2)))
                (let* ((valid-factors (filter
                                       (lambda
                                        (factor-exponent)
                                        (valid-prime-exponent (car factor-exponent) (cdr factor-exponent)))
                                       factors))
                       (sorted-factors (sort valid-factors factor-lt))
                       (normalized-factors (let ((normalized (normalize-factors sorted-factors)))
                                             (if (and (nil? normalized) warn-on-empty-factor-list)
                                                 (ignore "Interpreting empty factor list as natural accidental" '((3 . 0)))
                                                 normalized)))
                       (indices (map
                                 (lambda (factor-exponent)
                                   (hash (car factor-exponent) (cdr factor-exponent)))
                                 normalized-factors)))
                  ; TODO The indices are reversed so that accidentals are printed in descending order, but
                  ; we could also just sort the factors in descending order and adjust normalize-factors.
                  (map
                   (lambda (index)
                     (assoc-ref accidental-map index))
                   (reverse indices))))