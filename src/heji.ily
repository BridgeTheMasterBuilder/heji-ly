\version "2.24.1"

\include "util.ily"
\include "accidentals.ily"
\include "lib.ily"
\include "parser.ily"

heji-font = #(set-if-unset 'heji-font "HEJI2")
warn-on-empty-factors = #(set-if-unset 'warn-on-empty-factors #t)
skip-validation = #(set-if-unset 'skip-validation #f)
warn-on-ill-formed-factor-string = #(set-if-unset 'warn-on-ill-formed-factor-string #t)

#(define-markup-command
  (heji-markup layout props factors)
  (list?)
  (let* ((accidentals
          (map
           (lambda (point-code)
             `(markup (#:override `(font-name . ,heji-font) #:fontsize 5 #:char ,point-code)))
           (parse-heji factors skip-validation)))
         (markup-cmd `(make-concat-markup (list ,@accidentals))))
    (interpret-markup layout props
                      (eval markup-cmd (current-module)))))

ji =
#(define-music-function (factors note)
   (scheme? scheme?)
   (let* ((factor-list (cond ((list? factors) factors)
                             ((string? factors)
                              (parse-heji-string factors))
                             (else (ly:error "Ill-formed factors, expected either an alist of (factor . exponent) or a string"))))
          (accidentals #{\markup\heji-markup #factor-list #})
          (mark-up #{
            \once \override Voice.Accidental.stencil =
            #ly:text-interface::print
            \once \override Voice.Accidental.text =
            #accidentals
                   #}))
     #{ $mark-up $note #}))

heji =
#(define-scheme-function (music)
   (ly:music?)
   #{
     \accidentalStyle dodecaphonic
     $music
   #})