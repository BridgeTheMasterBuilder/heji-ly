\version "2.24.1"

\include "../src/heji.ily"

enable-playback = ##t

% The harmonic series up to the 49th partial with a drone
\score {
  <<
    \new Staff {
      \set Staff.midiInstrument = "reed organ"

      \tempo 4=40

      \relative a,,, {
        \clef bass
        \ottava #-1

        \heji {
          % It's absolutely essential that every single note within the \heji block
          % include \ji even if there are no accidentals, otherwise playback won't
          % work.
          \ji "" a4 \ottava #0 \ji "" a' \ji "" e' \ji "" a
          \ji "3u5" c \ji "" e \ji "u7" g \ji "" a
          \ji "" b \ji "3u5" c \ji "11" d \clef treble \ji "" e
          \ji "3u13" f \ji "u7" g \ji "3u5" g \ji "" a
          \ji "3u17" a \ji "" b \ji "19" c \ji "3u5" c
          \ji "u7" d \ji "o11" d \ji "3 23" d \ji "" e
          \ji "3u5^2" e \ji "3u13" f \ji "3" fis \ji "u7" g
          \ji "29" g \ji "3u5" g \ji "u31" a \ji "" a
          \ji "11" a \ji "3u17" a \ji "u5u7" b \ji "" b
          \ji "37" b \ji "19" c \ji "3u13" c \ji "3u5" c
          \ji "3 41" c \ji "u7" d \ji "43" d \ji "11" d
          \ji "3u5" d \ji "3 23" d \ji "3 47" d \ji "" e
          \ji "u7^2" f
        }
      }
    }

    \new Staff {
      \set Staff.midiInstrument = "church organ"

      \relative a,,, {
        \clef bass
        \ottava #-1
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a1~
        a4
      }
    }
  >>
  \midi{}
}
