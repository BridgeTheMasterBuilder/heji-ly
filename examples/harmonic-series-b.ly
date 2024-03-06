\version "2.24.1"

\include "../src/heji.ily"

% The harmonic series up to the 32nd partial, using the string syntax
\score {
  \new Staff {
    \relative c' {
      \clef bass
      \ottava #-1
      \heji {
        a,,,4 \ottava #0 a' e' a
        \ji "o3u5" cis e \ji "u7" g a
        b \ji "o3u5" cis \ji "o11" d \clef treble e
        \ji "o3u13" fis \ji "u7" g \ji "o3u5" gis a
        \ji "o3o17" ais b \ji "o19" c \ji "o3u5" cis
        \ji "u7" d \ji "o11" d \ji "o3o23" dis e
        \ji "o3u5^2" e \ji "o3u13" fis \ji "o3" fis \ji "u7" g
        \ji "o29" g \ji "o3u5" gis \ji "u31" a a
      }
    }
  }
}