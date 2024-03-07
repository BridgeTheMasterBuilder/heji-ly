\version "2.24.1"

\include "util.ily"

comma-map = #'((3 . 2187/2048)
               (5 . 81/80)
               (7 . 64/63)
               (11 . 33/32)
               (13 . 27/26)
               (17 . 2187/2176)
               (19 . 513/512)
               (23 . 736/729)
               (29 . 261/256)
               (31 . 32/31)
               (37 . 37/36)
               (41 . 82/81)
               (43 . 129/128)
               (47 . 752/729))

tuning-map = #'()

diatonic-pythagorean-scale = ##(1/1 9/8 32/27 4/3 3/2 27/16 16/9)
equal-tempered-intervals = ##(0 2 4 5 7 9 10)

% TODO This is an awful hack! There must be some other way to identify pitches uniquely
counter = #0

epsilon = #1/1000000000000000

factors-to-interval = #(define-scheme-function (factors)
                         (list?)
                         (if (nil? factors)
                             1
                             (let* ((this-factor (car factors))
                                    (rest (cdr factors))
                                    (f (car this-factor))
                                    (e (cdr this-factor))
                                    (comma (assoc-ref comma-map f)))
                               (cond ((= f 0) (factors-to-interval rest))
                                     ((negative? e)
                                      (* (expt (/ 1 comma) (abs e)) (factors-to-interval rest)))
                                     (else (* (expt comma e) (factors-to-interval rest)))))))

interval-to-alteration = #(define-scheme-function (interval)
                            (rational?)
                            (rationalize (inexact->exact (log-b (expt 2 (/ 2 12)) interval)) epsilon))

pythagorean-alteration = #(define-scheme-function (note reference-pitch)
                            (number? number?)
                            (let* ((interval (let ((diff (abs (- note reference-pitch))))
                                               (if (negative? diff)
                                                   (+ diff 7)
                                                   diff)))
                                   (et-interval (expt 2 (/ (vector-ref equal-tempered-intervals interval) 12)))
                                   (pythagorean-interval (vector-ref diatonic-pythagorean-scale interval))
                                   (difference (/ et-interval pythagorean-interval)))
                              (rationalize (inexact->exact (log-b (expt 2 (/ 2 12)) difference)) epsilon)))

tune-pitches = #(define-scheme-function (music tuning-map reference-pitch)
                  (ly:music? list? number?)
                  (set! counter 0)
                  (change-pitches music (lambda (pitch)
                                          (let* ((octave (ly:pitch-octave pitch))
                                                 (notename (ly:pitch-notename pitch))
                                                 (alteration (ly:pitch-alteration pitch))
                                                 (interval (or (assoc-ref tuning-map counter) 1/1))
                                                 ;(base-alteration (pythagorean-alteration notename reference-pitch))
                                                 )
                                            ;(format #t "notename:~s\ninterval:~s\nbase alteration:~s\nresult:~s\n" notename interval base-alteration (interval-to-alteration interval))
                                            (set! counter (+ counter 1))
                                            (ly:make-pitch
                                             octave
                                             notename
                                             ;(+ base-alteration (if (= interval 1/1) alteration (interval-to-alteration interval)))
                                             (if (= interval 1/1) alteration (interval-to-alteration interval)))))))