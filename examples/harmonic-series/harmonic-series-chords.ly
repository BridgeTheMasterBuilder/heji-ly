\version "2.24.1"

\include "../../src/heji.ily"

render-midi = ##t

% The harmonic series up to the 49th partial in chords of four adjacent harmonics
\HejiScore {
  \HejiStaff {
    \set Staff.midiInstrument = "clarinet"

    \tempo 4=40

    \relative a,,, {
      \clef bass
      \ottava #-1

      <a a' e' a>4 \ottava #0 <a' e' a \ji"3u5"c> <e' a \ji"3u5"c e> <a \ji"3u5"c e \ji"u7"g>
      <\ji"3u5"c e \ji"u7"g a> <e \ji"u7"g a b> <\ji"u7"g a b \ji"3u5"c> <a b \ji"3u5"c \ji"11"d>
      <b \ji"3u5"c \ji"11"d e> <\ji"3u5"c \ji"11"d e \ji"3u13"f> <\ji"11"d e \ji"3u13"f \ji"u7"g> r
    }
  }
}
