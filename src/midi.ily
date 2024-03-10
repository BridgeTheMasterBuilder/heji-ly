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

diatonic-pythagorean-scale = ##(1/1 9/8 32/27 4/3 3/2 128/81 16/9)
equal-tempered-intervals = ##(0 2 3 5 7 8 10)

% Precondition: Factors is a possibly empty list of pairs (x . y)
% Postcondition: The returned list is the product ∏x'_i^(y_i) for (x_i . y_i) ∈ factors
%                 where x'_i is the HEJI comma corresponding to factor x_i
factors-to-interval = #(define-scheme-function (factors)
                         (list?)
                         (if (nil? factors)
                             1
                             (let* ((this-factor (car factors))
                                    (rest (cdr factors))
                                    (f (car this-factor))
                                    (e (cdr this-factor))
                                    (comma (assoc-ref comma-map f)))
                               (if (= f 0)
                                   (factors-to-interval rest)
                                   (* (expt comma e) (factors-to-interval rest))))))

% Postcondition: The returned value is log_(12√(2^2)) interval expressed as a rational number
%		 accurate up to a difference of epsilon. What this expression tells us is how
%		 many equal tempered whole tones the interval consists of, which is how LilyPond
%		 (and MIDI) represent pitch bends
interval-to-alteration = #(define-scheme-function (interval)
                            (rational?)
                            (define epsilon 1/1000000000000000)
                            (rationalize (inexact->exact (log-b (expt 2 (/ 2 12)) interval)) epsilon))

% Postcondition: The returned value is the number of equal tempered whole tones (see above comment)
%		 that comprise the difference between the Pythagorean interval (formed by the input note and the
%		 reference pitch (by default, A)) and the corresponding equal tempered interval
pythagorean-alteration = #(define-scheme-function (note reference-pitch)
                            (number? number?)
                            (let* ((interval (let ((diff (- note reference-pitch)))
                                               (if (negative? diff)
                                                   (+ diff 7)
                                                   diff)))
                                   (et-interval (expt 2 (/ (vector-ref equal-tempered-intervals interval) 12)))
                                   (pythagorean-interval (vector-ref diatonic-pythagorean-scale interval))
                                   (difference (/ pythagorean-interval et-interval)))
                              (interval-to-alteration difference)))

% TODO Get rid of spurious missing glyph warnings
tune-pitches = #(define-scheme-function (music interval reference-pitch)
                  (ly:music? rational? number?)
                  ; We are going to get a ton of warnings because the alterations do not have
                  ; corresponding glyphs, but it doesn't matter since we are inserting the
                  ; glyphs manually using markup
                  (change-pitches music (lambda (pitch)
                                          (let* ((octave (ly:pitch-octave pitch))
                                                 (notename (ly:pitch-notename pitch))
                                                 (alteration (ly:pitch-alteration pitch))
                                                 (base-alteration (pythagorean-alteration notename reference-pitch)))
                                            (ly:make-pitch
                                             octave
                                             notename
                                             (+ base-alteration (if (= interval 1/1) alteration (interval-to-alteration interval))))))))

% LilyPond currently does not support microtonal playback for chords, so to achieve that we must split up chords
% into separate voices
expand-chord =
#(define-music-function (chord)
   (ly:music?)
   (let* ((notes (event-chord-notes chord))
          (num-notes (length notes))
          (first (car notes))
          (rest (cdr notes))
          (voices (cons first
                        (append-map (lambda (note)
                                      (list (make-music 'VoiceSeparator) note))
                                    rest)))
          (ids (reverse (iota num-notes 1))))
     #{ \voices #ids #(make-simultaneous-music voices) #}))