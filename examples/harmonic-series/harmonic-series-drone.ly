\version "2.24.1"

\include "../../src/heji.ily"

% Uncomment to produce a MIDI file
%heji-ly-render-midi = ##t

% The harmonic series up to the 49th partial with a drone
\HejiScore {
  <<
    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"
      \accidentalStyle dodecaphonic

      \tempo 4=40

      \relative a,,, {
        \clef bass
        \ottava #-1

        a4 \ottava #0 a' e' a
        \ji"3u5"c e \ji"u7"g a
        b \ji"3u5"c \ji"11"d \clef treble e
        \ji"3u13"f \ji"u7"g \ji"3u5"g a
        \ji"3u17"a b \ji"19"c \ji"3u5"c
        \ji"u7"d \ji"11"d \ji"3 23"d e
        \ji"3u5^2"e \ji"3u13"f \ji"3"fis \ji"u7"g
        \ji"29"g \ji"3u5"g \ji"u31"a a
        \ji"11"a \ji"3u17"a \ji"u5u7"b b
        \ji"37"b \ji"19"c \ji"3u13"c \ji"3u5"c
        \ji"3 41"c \ji"u7"d \ji"43"d \ji"11"d
        \ji"3u5"d \ji"3 23"d \ji"3 47"d e
        \ji"u7^2"f
      }
    }

    \HejiStaff {
      \set Staff.midiInstrument = "church organ"
      \accidentalStyle dodecaphonic

      \relative a,,, {
        \clef bass
        \ottava #-1

        a1~
        a~
        a~
        a~
        a~
        a~
        a~
        a~
        a~
        a~
        a~
        a~
        a4
      }
    }
  >>
}
