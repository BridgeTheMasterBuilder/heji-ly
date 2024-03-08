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
         (markup-cmd `(make-concat-markup (list ,@accidentals (markup #:hspace -1)))))
    (interpret-markup layout props
                      (eval markup-cmd (current-module)))))

ji-chord =
#(define-music-function (factors note)
   (list? ly:music?)
   (let* ((notes (event-chord-notes note))
          (num-notes (length notes))
          (num-factors (length factors)))
     (if (and (not skip-validation) (not (= num-notes num-factors)))
         (ly:parser-error
          (format #f "Insufficient number of factor strings supplied, expected ~d but got ~d" num-notes num-factors)))
     (let
      ((voices (map (lambda (note-factors)
                      (let ((note (car note-factors))
                            (factors (cadr note-factors)))
                        ; TODO Necessary to reinvent the wheel by implementing conflict resolution manually?
                        ; TODO Also need stem direction heuristic
                        #{ \new Voice { \shiftOff #(ji factors note) } #})) (zip notes factors))))
      #{ #(eval `(make-simultaneous-music (list ,@voices)) (current-module)) #})))

ji-solo =
#(define-music-function (factors note)
   (string? ly:music?)
   (let* ((factor-list (parse-heji-string factors))
          (accidentals #{\markup\heji-markup #factor-list #}))
     #{
       \once \override Voice.Accidental.stencil =
       #ly:text-interface::print
       \once \override Voice.Accidental.text =
       #accidentals
       #note
     #}))

ji =
#(define-music-function (factors note)
   (scheme? ly:music?)
   (if (list? factors)
       (begin
        (if (not (eq? (ly:music-property note 'name) 'EventChord))
            (ly:parser-error "Expected chord"))
        (ji-chord factors note))
       (begin
        (if (not (eq? (ly:music-property note 'name) 'NoteEvent))
            (ly:parser-error "Expected note"))
        (ji-solo factors note))))

heji =
#(define-scheme-function (music)
   (ly:music?)
   #{
     \accidentalStyle dodecaphonic
     $music
   #})