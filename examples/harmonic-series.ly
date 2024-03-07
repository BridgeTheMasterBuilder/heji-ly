\version "2.24.1"

\include "../src/heji.ily"

% The harmonic series up to the 49th partial, using the explicit factor list syntax
\score {
  \new Staff {
    \relative c' {
      \clef bass
      \ottava #-1
      \heji {
        a,,,4 \ottava #0 a' e' a
        \ji #'((3 . 1) (5 . -1)) cis e \ji #'((7 . -1)) g a
        b \ji #'((3 . 1) (5 . -1)) cis \ji #'((11 . 1)) d \clef treble e
        \ji #'((3 . 1) (13 . -1)) fis \ji #'((7 . -1)) g \ji #'((3 . 1) (5 . -1)) gis a
        \ji #'((3 . 1) (17 . -1)) ais b \ji #'((19 . 1)) c \ji #'((3 . 1) (5 . -1)) cis
        \ji #'((7 . -1)) d \ji #'((11 . 1)) d \ji #'((3 . 1) (23 . 1)) dis e
        \ji #'((3 . 1) (5 . -2)) e \ji #'((3 . 1) (13 . -1)) fis \ji #'((3 . 1)) fis \ji #'((7 . -1)) g
        \ji #'((29 . 1)) g \ji #'((3 . 1) (5 . -1)) gis \ji #'((31 . -1)) a a
        \ji #'((11 . 1)) a \ji #'((3 . 1) (17 . -1)) ais \ji #'((5 . -1) (7 . -1)) b b
        \ji #'((37 . 1)) b \ji #'((19 . 1)) c \ji #'((3 . 1) (13 . -1)) cis \ji #'((3 . 1) (5 . -1)) cis
        \ji #'((3 . 1) (41 . 1)) cis \ji #'((7 . -1)) d \ji #'((43 . 1)) d \ji #'((11 . 1)) d
        \ji #'((3 . 1) (5 . -1)) d \ji #'((3 . 1) (23 . 1)) dis \ji #'((3 . 1) (47 . 1)) dis e
        \ji #'((7 . -2))  f
      }
    }
  }
}