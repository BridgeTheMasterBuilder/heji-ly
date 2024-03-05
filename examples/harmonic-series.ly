\version "2.24.1"

\include "../src/heji.ily"

\score {
  \new Staff {
    \relative a,,, {
      \clef bass
      \ottava #-1
      a4 \ottava #0 a' e' a
      \heji #'((3 . 1) (5 . -1)) cis e \heji #'((7 . -1)) g a
      b \heji #'((3 . 1) (5 . -1)) cis \heji #'((11 . 1)) d \clef treble e
      \heji #'((3 . 1) (13 . -1)) fis \heji #'((7 . -1)) g \heji #'((3 . 1) (5 . -1)) gis a
      \heji #'((3 . 1) (17 . 1)) ais b \heji #'((19 . 1)) c \heji #'((3 . 1) (5 . -1)) cis
      \heji #'((7 . -1)) d \heji #'((11 . 1)) d \heji #'((3 . 1) (23 . 1)) dis e
      \heji #'((3 . 1) (5 . -2)) e \heji #'((3 . 1) (13 . -1)) fis \heji #'((3 . 1)) fis \heji #'((7 . -1)) g
      \heji #'((29 . 1)) g \heji #'((3 . 1) (5 . -1)) gis \heji #'((31 . -1)) a a
    }
  }
}