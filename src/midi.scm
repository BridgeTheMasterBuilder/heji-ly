(define-module (midi)
  :export (tune-pitches factors-to-interval expand-chord alteration-heji-glyph-name-alist))

(add-to-load-path (dirname (current-filename)))
(use-modules (util) (lily) (srfi srfi-1))

(define comma-map '((3 . 2187/2048)
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
                    (47 . 752/729)))

(define diatonic-pythagorean-scale #(1/1 9/8 32/27 4/3 3/2 128/81 16/9))
(define equal-tempered-intervals #(0 2 3 5 7 8 10))
(define alteration-heji-glyph-name-alist '((0 . "accidentals.natural")))

;; Precondition: Factors is a possibly empty list of pairs (x . y)
;; Postcondition: The returned list is the product ∏x'_i^(y_i) for (x_i . y_i) ∈ factors
;;                where x'_i is the HEJI comma corresponding to factor x_i
(define (factors-to-interval factors)
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

;; Postcondition: The returned value is log_(12√(2^2)) interval expressed as a rational number
;;                accurate up to a difference of epsilon. What this expression tells us is how
;;                many equal tempered whole tones the interval consists of, which is how LilyPond
;;                (and MIDI) represent pitch bends
(define (interval-to-alteration interval)
  (irrational->rational (log-b (expt 2 (/ 2 12)) interval)))

;; Precondition: note and reference-pitch are integers between 0 and 6 inclusive
;; Postcondition: The returned value is the number of equal tempered whole tones (see above comment)
;;                that comprise the difference between the Pythagorean interval (formed by the input note and the
;;                reference pitch (by default, A)) and the corresponding equal tempered interval
(define (pythagorean-alteration note reference-pitch)
  (let* ((interval (let ((diff (- note reference-pitch)))
                     (if (negative? diff)
                         (+ diff 7)
                         diff)))
         (et-interval (expt 2 (/ (vector-ref equal-tempered-intervals interval) 12)))
         (pythagorean-interval (vector-ref diatonic-pythagorean-scale interval))
         (difference (/ pythagorean-interval et-interval)))
    (interval-to-alteration difference)))

(define (tune-pitches music interval reference-pitch render)
  (change-pitches music (lambda (pitch)
                          (let* ((octave (ly:pitch-octave pitch))
                                 (notename (ly:pitch-notename pitch))
                                 (alteration (ly:pitch-alteration pitch))
                                 (base-alteration (pythagorean-alteration notename reference-pitch))
                                 (new-alteration (if (and (= interval 1/1) (not render))
                                                     alteration
                                                     (+ base-alteration (interval-to-alteration interval)))))
                            ;; TODO Kind of a hack to suppress missing glyph warnings
                            (set! alteration-heji-glyph-name-alist
                                  (assoc-set! alteration-heji-glyph-name-alist
                                              new-alteration
                                              "accidentals.natural"))
                            (ly:make-pitch
                             octave
                             notename
                             new-alteration)))))

;; LilyPond currently does not support microtonal playback for chords, so to achieve that we must split up chords
;; into separate voices
(define (expand-chord chord)
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
