\version "2.24.1"

\include "../../src/heji.ily"

% Uncomment to produce a MIDI file
heji-ly-render-midi = ##t

% The utonal harmonic series down to the 48th subharmonic
\HejiScore {
  \HejiStaff {
    \set Staff.midiInstrument = "clarinet"
    \accidentalStyle dodecaphonic

    \relative e'''' {
      \ottava #1

      e4 \ottava #0 e, a, e
      \ji"5"c a \ji"3 7"fis e
      \clef bass
      d \ji"5"c \ji"u11"b a
      \ji"13"g \ji"3 7"fis \ji"5"f e
      \ji"u3 17"es d \ji"3u19"cis \ji"5"c
      \ji"7"b \ji"u11"b \ji"u3u23"bes a
      \ji"u3 5^2"aes \ji"13"g g \ji"3 7"fis
      \ji"3 u29"fis \ji"5"f \ji"31"e e
      \ji"u11"e \ji"u3 17"es \ji"5 7"d d
      \ji"u37"d \ji"3 u19"cis \ji"13"c \ji"5"c
      \ji"u41"c \ji"7"b \ji"u43"b \ji"u11"b
      \ji"u3 5"bes \ji"u3u23"bes \ji"u3u47"bes a
      \ji"3 7^2"gis
    }
  }
}
