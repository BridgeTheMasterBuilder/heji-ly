#(ly:set-option 'compile-scheme-code)

\version "2.24.1"

\include "../src/heji.ily"

enable-playback = ##t

% The harmonic series up to the 49th partial, using the string syntax
\score {
  \new Staff {
    \relative c' {
      \clef bass
      \ottava #-1
      \heji {
        % It's absolutely essential that every single note within the \heji block
        % include \ji even if there are no accidentals, otherwise playback won't
        % work.
        \ji "" a,,,4\sustainOn \ottava #0 \ji "" a' \ji "" e' \ji "" a
        \ji "3u5" cis \ji "" e \ji "u7" g \ji "" a
        \ji "" b \ji "3u5" cis \ji "11" d \clef treble \ji "" e
        \ji "3u13" fis \ji "u7" g \ji "3u5" gis \ji "" a
        \ji "3u17" ais \ji "" b \ji "19" c \ji "3u5" cis
        \ji "u7" d \ji "o11" d \ji "3 23" dis \ji "" e
        \ji "3u5^2" eis \ji "3u13" fis \ji "" fis \ji "u7" g
        \ji "29" g \ji "3u5" gis \ji "u31" a \ji "" a
        \ji "11" a \ji "3u17" ais \ji "u5u7" b \ji "" b
        \ji "37" b \ji "19" c \ji "3u13" cis \ji "3u5" cis
        \ji "3 41" cis \ji "u7" d \ji "43" d \ji "11" d
        \ji "3u5" d \ji "3 23" dis \ji "3 47" dis \ji "" e
        \ji "u7^2" f
      }
    }
  }
  \midi{}
}
