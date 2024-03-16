\version "2.24.1"

#(add-to-load-path (dirname (current-filename)))
#(use-modules (lib) (util) (midi) (parser))

heji-font = #(set-if-unset 'heji-font "HEJI2")
warn-on-empty-factors = #(set-if-unset 'warn-on-empty-factors #t)
skip-validation = #(set-if-unset 'skip-validation #f)
warn-on-ill-formed-factor-string = #(set-if-unset 'warn-on-ill-formed-factor-string #t)
render-midi = #(set-if-unset 'render-midi #f)
reference-pitch = #(set-if-unset 'reference-pitch 5)
print-naturals = #(set-if-unset 'print-naturals #t)

HejiScore =
#(define-void-function (music)
   (ly:music?)
   (if render-midi
       (let* ((copy (ly:music-deep-copy music))
              (expanded (music-map (lambda (music)
                                     (cond ((equal? (ly:music-property music 'name) 'EventChord)
                                            (expand-chord music))
                                           ((equal? (ly:music-property music 'name) 'NoteEvent)
                                            (let ((pitch (ly:music-property music 'pitch)))
                                              (if (= (ly:pitch-alteration pitch) 0)
                                                  (let ((factor-list (parse-heji-string "3^0")))
                                                    (tune-pitches music (factors-to-interval factor-list) reference-pitch render-midi)
                                                    music))
                                              music))
                                           (else music)))
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
                    % Ensures that LilyPond assigns separate MIDI channels to each voice, which is needed to
                    % support playback
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
         ; playback-score has no layout {} block so it won't be visible
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
     \new Staff
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
     (tune-pitches note (factors-to-interval factor-list) reference-pitch render-midi)
     #{
       \tweak Accidental.stencil
       #ly:text-interface::print
       \tweak Accidental.text
       #accidentals
       #note
     #}))
