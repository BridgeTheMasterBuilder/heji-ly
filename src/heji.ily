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
render-midi = #(set-if-unset 'render-midi #f)
reference-pitch = #(set-if-unset 'reference-pitch 5)

HejiScore =
#(define-void-function (music)
   (ly:music?)
   (if render-midi
       (let* ((copy (ly:music-deep-copy music))
              (expanded (music-map (lambda (music)
                                     (if (equal? (ly:music-property music 'name) 'EventChord)
                                         (expand-chord music)
                                         music))
                                   copy))
              (main-score
               #{
                 \score
                 {
                   #music
                   \layout {}
               } #})
              (playback-score #{
                \score
                {
                  #expanded
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
                              } #}))
         (add-score main-score)
         (add-score playback-score))
       (add-score
        #{
          \score {
            #music
          }
        #} )))

HejiStaff =
#(define-music-function (music)
   (ly:music?)
   #{
     \new Staff \with { \accidentalStyle dodecaphonic }
     {
       #music
     }
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

ji =
#(define-music-function (factors note)
   (string? ly:music?)
   (if (not (eq? (ly:music-property note 'name) 'NoteEvent))
       (ly:parser-error "Expected note"))
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