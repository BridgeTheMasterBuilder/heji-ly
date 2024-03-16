\version "2.24.1"

\include "../src/heji.ily"

pad-x = #(define-scheme-function (offset)
           (number?)
           #{ \once \override Accidental.X-extent = #`(,offset . 0) #})

\header {
  title =  "The Sweet Maid of Glendaruel"
  composer =  "Traditional"
}

\layout {
  indent = 0.0
}

% Uncomment to produce a MIDI file
%heji-ly-render-midi = ##t

\score {
  \new Staff {
    \set Staff.midiInstrument = "bagpipe"

    \tempo 4 = 80
    \clef "treble"
    \time 2/4
    \key d \major
    \transposition bes

    \relative e'' {
      \partial 8 e8 |
      \repeat volta 2 {
        \grace \ji"u7"g32 a,8. b16 \grace \ji"u7"g'32 \ji"3u5"cis,8 d8 |
        \grace { \ji"u7"g32 \ji"3u5"cis,32 d32 } e8. \ji"3u5"cis16 \grace \ji"u7"g'32 a,8 d8 |
        \grace { \ji"u7"g32 \ji"3u5"cis,32 d32 } \ji"3u5"cis8 a8 \grace { \ji"u7"g'32 e32 \pad-x 0.2 \ji"3u5"fis32 } e8 \ji"3u5"cis8 |
        \grace { \ji"u7"g'32 \ji"3u5"cis,32 d32 } \ji"3u5"cis8 b8 \grace \ji"u7"g32 b8 e8 | \break
        \grace \ji"u7"g32 a,8. b16 \grace \ji"u7"g'32 \ji"3u5"cis,8 d8 |
        \grace { \ji"u7"g32 e32 \pad-x 0.2 \ji"3u5"fis32 } e8. \ji"3u5"cis16 \grace \ji"u7"g'32 a,8 \grace \ji"u7"g'32 b,16. \ji"3u5"cis32 |
        \grace { \ji"u7"g32 d'32 \pad-x 0.2 \ji"3u5"cis32 } d8. b16 \grace \ji"u7"g'32 \ji"u7"g,8 b8 |
      }
      \alternative {
        {
          \grace { \ji"u7"g'32 b,32 d32 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g32 a32 \ji"u7"g32 } a8 e'8 |
        }
        {
          \break
          \grace { \ji"u7"g32 b,32 d32 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g32 a32 \ji"u7"g32 } a8 \grace { \ji"u7"g'32 \pad-x 0.2 \ji"3u5"fis32 } \ji"u7"g8 |
        }
      }
      \repeat volta 2 {
        \grace { \ji"3u5"fis32 \pad-x 0.2 \ji"u7"g32 } \ji"3u5"fis8 e8 \grace { a32 \ji"u7"g32 } a8. \ji"3u5"fis16 |
        \grace { \ji"u7"g32 e32 \pad-x 0.2  \ji"3u5"fis32 } e8. \ji"3u5"cis16 \grace \ji"u7"g'32 a,8 \grace { \ji"u7"g'32 \ji"3u5"fis32 } \ji"u7"g8 |
        \pad-x -0.5 \grace { \ji"3u5"fis32 \ji"u7"g32 } \ji"3u5"fis8 e8 \grace { a32 \ji"u7"g32 } a8 \ji"3u5"cis,8 |
        \grace { \ji"u7"g'32 \ji"3u5"cis,32 d32 } \ji"3u5"cis8 b8 \pad-x -0.5 \grace { \ji"u7"g32 } b8 \grace { \ji"u7"g'32 \pad-x 0.2  \ji"3u5"fis32 } \ji"u7"g8 |
      }
      \alternative {
        {
          \pad-x -0.5 \grace { \ji"3u5"fis32 \ji"u7"g32 } \ji"3u5"fis8 e8 \grace { a32 \ji"u7"g32 } a8. \ji"3u5"fis16 |
          \grace { \ji"u7"g32 e32 \pad-x 0.2 \ji"3u5"fis32 } e8. \ji"3u5"cis16 \grace \ji"u7"g'32 a,8 \grace \ji"u7"g'32 b,16. \ji"3u5"cis32 |
          \pad-x -0.5 \grace { \ji"u7"g32 d'32 \pad-x 0.2 \ji"3u5"cis32 } d8. b16 \grace { \ji"u7"g'32 } \ji"u7"g,8 b8 |
          \grace { \ji"u7"g'32 b,32 d32 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g32 a32 \ji"u7"g32 } a8 \ji"u7"g'8 |
        }
        {
          \pad-x -0.5 \grace { \ji"3u5"fis32 \pad-x 0.2 \ji"u7"g32 } \ji"3u5"fis8 e8 \grace { \ji"u7"g32 \ji"3u5"fis32 \ji"u7"g32 } \ji"3u5"fis8 d8 |
          \grace { \ji"u7"g32 e32 \pad-x 0.2 \ji"3u5"fis32 } e8. \ji"3u5"cis16 \grace \ji"u7"g'32 a,8 \grace { \ji"u7"g'32 } b,16. \ji"3u5"cis32 |
          \pad-x -0.5 \grace { \ji"u7"g32 d'32 \pad-x 0.2 \ji"3u5"cis32 } d8. b16 \grace { \ji"u7"g'32 } \ji"u7"g,8 b8 |
          \grace { \ji"u7"g'32 b,32 d32 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g32 a32 \ji"u7"g32 } a8 \bar "|."
        }
      }
    }
  }

  \layout {}
}

\score {
  <<
    \new Staff {
      \set Staff.midiInstrument = "bagpipe"

      \tempo 4 = 80
      \clef "treble"
      \time 2/4
      \key d \major
      \transposition bes

      \unfoldRepeats {
        \relative e'' {
          \partial 8 e8 |
          \repeat volta 2 {
            \grace \ji"u7"g16 a,8. b16 \grace \ji"u7"g'16 \ji"3u5"cis,8 d8 |
            \grace { \ji"u7"g16 \ji"3u5"cis,16 d16 } e8. \ji"3u5"cis16 \grace \ji"u7"g'16 a,8 d8 |
            \grace { \ji"u7"g16 \ji"3u5"cis,16 d16 } \ji"3u5"cis8 a8 \grace { \ji"u7"g'16 e16 \pad-x 0.2 \ji"3u5"fis16 } e8 \ji"3u5"cis8 |
            \grace { \ji"u7"g'16 \ji"3u5"cis,16 d16 } \ji"3u5"cis8 b8 \grace \ji"u7"g16 b8 e8 | \break
            \grace \ji"u7"g16 a,8. b16 \grace \ji"u7"g'16 \ji"3u5"cis,8 d8 |
            \grace { \ji"u7"g16 e16 \pad-x 0.2 \ji"3u5"fis16 } e8. \ji"3u5"cis16 \grace \ji"u7"g'16 a,8 \grace \ji"u7"g'16 b,16. \ji"3u5"cis32 |
            \grace { \ji"u7"g16 d'16 \pad-x 0.2 \ji"3u5"cis16 } d8. b16 \grace \ji"u7"g'16 \ji"u7"g,8 b8 |
          }
          \alternative {
            {
              \grace { \ji"u7"g'16 b,16 d16 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g16 a16 \ji"u7"g16 } a8 e'8 |
            }
            {
              \break
              \grace { \ji"u7"g16 b,16 d16 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g16 a16 \ji"u7"g16 } a8 \grace { \ji"u7"g'16 \pad-x 0.2 \ji"3u5"fis16 } \ji"u7"g8 |
            }
          }
          \repeat volta 2 {
            \grace { \ji"3u5"fis16 \pad-x 0.2 \ji"u7"g16 } \ji"3u5"fis8 e8 \grace { a16 \ji"u7"g16 } a8. \ji"3u5"fis16 |
            \grace { \ji"u7"g16 e16 \pad-x 0.2  \ji"3u5"fis16 } e8. \ji"3u5"cis16 \grace \ji"u7"g'16 a,8 \grace { \ji"u7"g'16 \ji"3u5"fis16 } \ji"u7"g8 |
            \pad-x -0.5 \grace { \ji"3u5"fis16 \ji"u7"g16 } \ji"3u5"fis8 e8 \grace { a16 \ji"u7"g16 } a8 \ji"3u5"cis,8 |
            \grace { \ji"u7"g'16 \ji"3u5"cis,16 d16 } \ji"3u5"cis8 b8 \pad-x -0.5 \grace { \ji"u7"g16 } b8 \grace { \ji"u7"g'16 \pad-x 0.2  \ji"3u5"fis16 } \ji"u7"g8 |
          }
          \alternative {
            {
              \pad-x -0.5 \grace { \ji"3u5"fis16 \ji"u7"g16 } \ji"3u5"fis8 e8 \grace { a16 \ji"u7"g16 } a8. \ji"3u5"fis16 |
              \grace { \ji"u7"g16 e16 \pad-x 0.2 \ji"3u5"fis16 } e8. \ji"3u5"cis16 \grace \ji"u7"g'16 a,8 \grace \ji"u7"g'16 b,16. \ji"3u5"cis32 |
              \pad-x -0.5 \grace { \ji"u7"g16 d'16 \pad-x 0.2 \ji"3u5"cis16 } d8. b16 \grace { \ji"u7"g'16 } \ji"u7"g,8 b8 |
              \grace { \ji"u7"g'16 b,16 d16 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g16 a16 \ji"u7"g16 } a8 \ji"u7"g'8 |
            }
            {
              \pad-x -0.5 \grace { \ji"3u5"fis16 \pad-x 0.2 \ji"u7"g16 } \ji"3u5"fis8 e8 \grace { \ji"u7"g16 \ji"3u5"fis16 \ji"u7"g16 } \ji"3u5"fis8 d8 |
              \grace { \ji"u7"g16 e16 \pad-x 0.2 \ji"3u5"fis16 } e8. \ji"3u5"cis16 \grace \ji"u7"g'16 a,8 \grace { \ji"u7"g'16 } b,16. \ji"3u5"cis32 |
              \pad-x -0.5 \grace { \ji"u7"g16 d'16 \pad-x 0.2 \ji"3u5"cis16 } d8. b16 \grace { \ji"u7"g'16 } \ji"u7"g,8 b8 |
              \grace { \ji"u7"g'16 b,16 d16 } b8 a8 \pad-x -0.5 \grace { \ji"u7"g16 a16 \ji"u7"g16 } a8 \bar "|."
            }
          }
        }
      }
    }

    \new Staff {
      \set Staff.midiInstrument = "reed organ"

      \key d \major \transposition bes

      \unfoldRepeats {
        \relative a {
          \partial 8 a8~ |
          \repeat volta 2 {
            \grace { a~ } a2~ |
            a~ |
            a~ |
            a~ |
            a~ |
            a~ |
            a~ |
          }
          \alternative {
            {
              a~ |
            }
            {
              \grace { a16~ a~ a~ } a2~ |
            }
          }
          \repeat volta 2 {
            \grace { a16~ a~ } a2~ |
            a~ |
            a~ |
          }
          \alternative {
            {
              a~ |
              a~ |
              a~ |
              a~ |
              a~ |
            }
            {
              \grace { a16~ a~ } a2~
              a~ |
              a~ |
              a~ |
              a \bar "|."
            }
          }
        }
      }
    }
  >>

  #(if render-midi #{ \midi { } #})
}
