\version "2.24.1"

\include "util.ily"
\include "accidentals.ily"
\include "lib.ily"

heji-font = #(set-if-unset 'heji-font "HEJI2")
warn-on-empty-factor-list = #(set-if-unset 'warn-on-empty-factor-list #t)

#(define-markup-command
  (heji-markup layout props factors)
  (list?)
  (let* ((accidentals
          (map
           (lambda (point-code)
             `(markup (#:override `(font-name . ,heji-font) #:fontsize 5 #:char ,point-code)))
           (parse-heji factors)))
         (markup-cmd `(make-concat-markup (list ,@accidentals))))
    (interpret-markup layout props
                      (eval markup-cmd (current-module)))))

heji =
#(define-music-function (factors note)
   (list? ly:music?)
   (let ((accidentals #{\markup\heji-markup #factors #}))
     #{
       \once \override Voice.Accidental.stencil =
       #ly:text-interface::print
       \once \override Voice.Accidental.text =
       #accidentals
       #(ly:music-set-property! note 'force-accidental #t)
       $note
     #}))