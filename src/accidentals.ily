\version "2.24.1"

#(define (hash factor exponent)
   (* factor exponent))

% Here's an explanation of why `low-primes` and `prime` are necessary:
% Seeing as Helmholtz-Ellis notation combines "classical" accidentals
% with alterations by syntonic commas, it's necessary to combine the
% prime factors 3 and 5 into a single (factor . exponent) pair to be
% able to hash it. To represent a combined accidental we multiply 5 by
% a prime number distinct from 3 and 5 (and 2, for that matter) which
% we get via this mapping:
%
%	7 = double flat
%	11 = flat
%	17 = sharp
%	19 = double sharp
%
% How is this mapping derived? We simply use the exponent for the prime
% factor 3 displaced by 2 (-2 -> 0, -1 -> 1, 1 -> 3 and 2 -> 4) as an
% index into the list `low-primes`. This pseudofactor is guaranteed to
% be distinct from any real factor we may ever wish to use so the resulting
% hash will be unique.
%
% There is one caveat however, let's say that we would like to extend the
% system to allow for higher exponents for the prime factors which we decided
% to use in `low-primes`. Then there would be a conflict between
%
%	(hash (5 7) 1)
%
% and
%
%	(hash 7 5)
%
% as these would hash to the same number according to the current hash function.
% There are at least two possible solutions:
%
% 	1) Use larger prime numbers.
%	2) Use a different hashing function.
%
% It might be worth the effort to future-proof this scheme but this seems adequate
% for the time being.

#(define low-primes '(7 11 13 17 19))

#(define (prime i)
   (list-ref low-primes i))

% TODO - Precompute this table?
#(define accidental-map `((,(hash 3 0) . #x6e)
                    (,(hash 3 1) . #x76)
                    (,(hash 3 2) . #x56)
                    (,(hash 3 -1) . #x65)
                    (,(hash 3 -2) . #x45)
                    (,(hash 5 1) . #x6f)
                    (,(hash 5 2) . #x70)
                    (,(hash 5 3) . #x71)
                    (,(hash 5 4) . #x4e)
                    (,(hash 5 -1) . #x6d)
                    (,(hash 5 -2) . #x6c)
                    (,(hash 5 -3) . #x6b)
                    (,(hash 5 -4) . #x4d)
                    (,(hash (* 5 (prime 3)) 1) . #x77)
                    (,(hash (* 5 (prime 3)) 2) . #x78)
                    (,(hash (* 5 (prime 3)) 3) . #x79)
                    (,(hash (* 5 (prime 3)) 4) . #x50)
                    (,(hash (* 5 (prime 3)) -1) . #x75)
                    (,(hash (* 5 (prime 3)) -2) . #x74)
                    (,(hash (* 5 (prime 3)) -3) . #x73)
                    (,(hash (* 5 (prime 3)) -4) . #x4f)
                    (,(hash (* 5 (prime 4)) 1) . #x57)
                    (,(hash (* 5 (prime 4)) 2) . #x58)
                    (,(hash (* 5 (prime 4)) 3) . #x59)
                    (,(hash (* 5 (prime 4)) 4) . #x51)
                    (,(hash (* 5 (prime 4)) -1) . #x55)
                    (,(hash (* 5 (prime 4)) -2) . #x54)
                    (,(hash (* 5 (prime 4)) -3) . #x53)
                    (,(hash (* 5 (prime 4)) -4) . #x52)
                    (,(hash (* 5 (prime 1)) 1) . #x66)
                    (,(hash (* 5 (prime 1)) 2) . #x67)
                    (,(hash (* 5 (prime 1)) 3) . #x68)
                    (,(hash (* 5 (prime 1)) 4) . #x4c)
                    (,(hash (* 5 (prime 1)) -1) . #x64)
                    (,(hash (* 5 (prime 1)) -2) . #x63)
                    (,(hash (* 5 (prime 1)) -3) . #x62)
                    (,(hash (* 5 (prime 1)) -4) . #x4b)
                    (,(hash (* 5 (prime 0)) 1) . #x46)
                    (,(hash (* 5 (prime 0)) 2) . #x47)
                    (,(hash (* 5 (prime 0)) 3) . #x48)
                    (,(hash (* 5 (prime 0)) 4) . #x4a)
                    (,(hash (* 5 (prime 0)) -1) . #x44)
                    (,(hash (* 5 (prime 0)) -2) . #x43)
                    (,(hash (* 5 (prime 0)) -3) . #x42)
                    (,(hash (* 5 (prime 0)) -4) . #x49)
                    (,(hash 7 1) . #x3e)
                    (,(hash 7 2) . #x2e)
                    (,(hash 7 -1) . #x3c)
                    (,(hash 7 -2) . #x2c)
                    (,(hash 11 1) . #x34)
                    (,(hash 11 -1) . #x35)
                    (,(hash 13 1) . #x39)
                    (,(hash 13 -1) . #x30)
                    (,(hash 17 1) . #x3b)
                    (,(hash 17 -1) . #x3a)
                    (,(hash 19 1) . #x2f)
                    (,(hash 19 -1) . #x2a)
                    (,(hash 23 1) . #x33)
                    (,(hash 23 -1) . #x36)
                    (,(hash 29 1) . #x32)
                    (,(hash 29 -1) . #x37)
                    (,(hash 31 1) . #x38)
                    (,(hash 31 -1) . #x31)
                    (,(hash 37 1) . #xe1)
                    (,(hash 37 -1) . #xe0)
                    (,(hash 41 1) . #x2b)
                    (,(hash 41 -1) . #x2d)
                    (,(hash 43 1) . #xe9)
                    (,(hash 43 -1) . #xe8)
                    (,(hash 47 1) . #xed)
                    (,(hash 47 -1) . #xec)))
