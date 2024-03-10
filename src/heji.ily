\version "2.24.1"

\include "util.ily"
\include "accidentals.ily"
\include "lib.ily"
\include "parser.ily"
\include "midi.ily"

heji-font = #(set-if-unset 'heji-font "HEJI2")
warn-on-empty-factors = #(set-if-unset 'warn-on-empty-factors #f)
skip-validation = #(set-if-unset 'skip-validation #f)
warn-on-ill-formed-factor-string = #(set-if-unset 'warn-on-ill-formed-factor-string #t)
render-midi = #(set-if-unset 'render-midi #f)
reference-pitch = #(set-if-unset 'reference-pitch 5)

HejiScore =
#(define-scheme-function (music)
   (ly:music?)
   (if render-midi
       #{
         \score
         {
           $music
           \layout {}
           \midi {
             \context {
               \Staff
               \remove "Staff_performer"
             }
             \context {
               \Voice
               \consists "Staff_performer"
             }
           }
         }
       #}
       #{
         \score
         {
           $music
         }
       #}))

HejiStaff =
#(define-scheme-function (music)
   (ly:music?)
   #{
     \new Staff \with { \accidentalStyle dodecaphonic }
     { $music }
   #})

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

% TODO, if render-midi is set, comb over the whole staff tuning notes and looking for chords to split up and put them
% in invisible staves
ji-chord =
#(define-music-function (factor-list note)
   (list? ly:music?)
   (let* ((notes (event-chord-notes note))
          (num-notes (length notes))
          (num-factors (length factor-list)))
     (if (and (not skip-validation) (not (= num-notes num-factors)))
         (ly:parser-error
          (format #f "Insufficient number of factor strings supplied, expected ~d but got ~d" num-notes num-factors)))
     (let*
      ((note-factor-list (zip notes factor-list))
       (first (car note-factor-list))
       (rest (cdr note-factor-list))
       (tune-note (lambda (note-factors)
                    (let ((note (car note-factors))
                          (factors (cadr note-factors)))
                      (ji-solo factors note))))
       ;        (voices (cons (tune-note first) (append-map (lambda (note-factors)
       ;                                                      (list (make-music 'VoiceSeparator) (tune-note note-factors))) rest)))
       ;        (ids (reverse (iota num-notes 1))))
       ;       #{ \voices #ids #(make-simultaneous-music voices) #})))
       (voices (map (lambda (note-factors) (tune-note note-factors)) note-factor-list))
       (ids (reverse (iota num-notes 1))))
      (make-event-chord voices))))

ji-solo = #(define-music-function (factors note)
             (string? ly:music?)
             (let* ((factor-list (parse-heji-string factors))
                    (accidentals #{\markup\heji-markup #factor-list #}))
               (if render-midi (tune-pitches note (factors-to-interval factor-list) reference-pitch))
               #{
                 \tweak Accidental.stencil
                 #ly:text-interface::print
                 \tweak Accidental.text
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