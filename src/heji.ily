\version "2.24.1"

\include "util.ily"
\include "accidentals.ily"
\include "lib.ily"
\include "parser.ily"
\include "midi.ily"

heji-font = #(set-if-unset 'heji-font "HEJI2")
warn-on-empty-factors = #(set-if-unset 'warn-on-empty-factors #t)
skip-validation = #(set-if-unset 'skip-validation #f)
warn-on-ill-formed-factor-string = #(set-if-unset 'warn-on-ill-formed-factor-string #t)
enable-playback = #(set-if-unset 'enable-playback #f)
reference-pitch = #(set-if-unset 'reference-pitch 5)

#(define-markup-command
  (heji-markup layout props factors)
  (list?)
  (let* ((accidentals
          (map
           (lambda (point-code)
             `(markup (#:override `(font-name . ,heji-font) #:fontsize 5 #:char ,point-code)))
           (parse-heji factors skip-validation)))
         (markup-cmd `(make-concat-markup (list ,@accidentals (markup #:hspace -1)))))
    (interpret-markup layout props
                      (eval markup-cmd (current-module)))))

ji =
#(define-music-function (factors)
   (string?)
   (let* ((factor-list (parse-heji-string factors))
          (accidentals #{\markup\heji-markup #factor-list #}))
     (if enable-playback
         (begin
          (set! tuning-map (assoc-set! tuning-map counter (factors-to-interval factor-list)))
          (set! counter (+ counter 1))))
     #{
       \once \override Voice.Accidental.stencil =
       #ly:text-interface::print
       \once \override Voice.Accidental.text =
       #accidentals
     #}))

heji =
#(define-scheme-function (music)
   (ly:music?)
   (if enable-playback (tune-pitches music tuning-map reference-pitch))
   #{
     \accidentalStyle dodecaphonic
     $music
   #})