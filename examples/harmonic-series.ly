#(ly:set-option 'compile-scheme-code)

\version "2.24.1"

\include "../src/heji.ily"

% The harmonic series up to the 49th partial, using the string syntax
\score {
  \new Staff {
    \relative a,,, {
      \clef bass
      \ottava #-1
      \heji {
        a4 \ottava #0 a' e' a
        \ji "3u5" cis e \ji "u7" g a
        b \ji "3u5" cis \ji "11" d \clef treble e
        \ji "3u13" fis \ji "u7" g \ji "3u5" gis a
        \ji "3u17" ais b \ji "19" c \ji "3u5" cis
        \ji "u7" d \ji "o11" d \ji "3 23" dis e
        \ji "3u5^2" eis \ji "3u13" fis fis \ji "u7" g
        \ji "29" g \ji "3u5" gis \ji "u31" a a
        \ji "11" a \ji "3u17" ais \ji "u5u7" b b
        \ji "37" b \ji "19" c \ji "3u13" cis \ji "3u5" cis
        \ji "3 41" cis \ji "u7" d \ji "43" d \ji "11" d
        \ji "3u5" d \ji "3 23" dis \ji "3 47" dis e
        \ji "u7^2" f
      }
    }
  }
}
