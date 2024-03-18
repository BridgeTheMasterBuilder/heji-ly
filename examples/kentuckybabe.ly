\version "2.24.1"

\include "../src/heji.ily"
\include "swing.ly"

% Uncomment to produce a MIDI file
%heji-ly-render-midi = ##t

\header {
  title =  "Kentucky Babe"
  composer =  \markup {
    \column {
      "Music by Adam Geibel"
      "Arrangement by Kirk Roose"
    }
  }
  poet = "Words by Richard Henry Buck"
}

Tenor =  \relative d' {
  \clef "treble_8"
  \tempo 4=70
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d2 |
  \ji"u5"d4. f8 \ji"u5"d8 \ji"u5"d4. |
  \ji"u3u7"e2 ~ \ji"u3u7"e4 r4 |
  \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3u7"e8 \ji"u3u7"e8 \ji"u3u7"e8 \ji"u3u7"e8 |
  \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3u7"e2 |
  \ji"u5"e4. \ji"u5"e8 \ji"u5"e8 \ji"u5"e4. |
  \ji"u3u7"e2 ~ \ji"u3u7"e4 r4 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 f8
  f8 f8 f8 |
  \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3u7"e2 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8
  \ji"u5"d8 ~ \ji"u5"d8 \ji"u5"d16 \ji"u5"d16 |
  \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3u7"e2 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u3 5"d8
  \ji"u3 5"d8 ~ \ji"u3 5"d4 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u3 5u7"f8
  \ji"u3 5u7"f8 ~ \ji"u3 5u7"f4 |
  f4 f4 \ji"u5"e4 \ji"u5"e4 |
  \ji"u3u7"e2 ( \ji"u5u7"g2 ) |
  f4 ( \ji"u5"g4 f4 ) f4 |
  \ji"u5"d4 \ji"3^0 u7 17"d8 \ji"u7 17"d8 \ji"u3u7"e4 r4 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d16
  \ji"u5"d16 \ji"u5"d8 ~ \ji"u5"d4 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5u7"f4 r4 |
  g2. \ji"u3 5"e4 |
  \ji"u3u7"e4 \ji"u5"d8 \ji"u5"d8 \ji"u3u7"e4 r4 |
  \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3 5"e8 \ji"u3u7"e16
  \ji"u3u7"e16 \ji"u3u7"e8 ~ \ji"u3u7"e4 |
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 f8 \ji"u5"d4 r4 |
  \ji"u3 5u7"f1 ( |
  f2 \ji"u5"d4 ) r4 |
  \ji"u3 5u7"f1 ( |
  f2 \ji"u5"d4 ) r4 |
  \ji"u5"d2 f2 |
  \ji"u3u7"e2 r4 \ji"u3u7"e4 |
  \ji"u5"d1 ~ |
  \ji"u5"d1 \bar "|."
}

Lead =  \relative f {
  \clef "treble_8"
  f8 f8 f8 f8 \ji"u5"g8
  \ji"u5"g8 \ji"u5"g8 \ji"u5"g8 |
  f8 f8 f8 f8 \ji"u5"g2 |
  f4. \ji"u5"d8 f8 \ji"u3"b4. |
  \ji"u5"a2 ~ \ji"u5"a4 r4 |
  g8 g8 g8 g8 \ji"u5"a8 \ji"u5"a8 \ji"u5"a8 \ji"u5"a8 |
  g8 g8 g8 g8 \ji"u5"a2 |
  g4. g8 g8 \ji"u3u7"b4. |
  \ji"u5"a2 ~ \ji"u5"a4 r4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"a8 \ji"u5"a8 \ji"u5"a8 \ji"u5"a8 |
  g8 g8 g8 g8 f2 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"a8 \ji"u5"a8 ~ \ji"u5"a8 \ji"u5"a16 \ji"u5"a16 |
  g8 g8 g8 g8 f2 |
  f8 f8 f8 f8
  \ji"u3 5"g8 \ji"u3 5"g8 ~ \ji"u3 5"g4 |
  f8 f8 f8 f8
  \ji"u3 5"g8 \ji"u3 5"g8 ~ \ji"u3 5"g4 |
  f4 \ji"u5"g4 \ji"u5"a4 \ji"u3u7"b4 |
  c2 ( \ji"3u5^2"c2 ) |
  \ji"u5"d2. \ji"u5"d,4 |
  f2 ~ f4 r4 |
  f8 f8 f8 f8 \ji"u5"g16
  \ji"u5"g16 \ji"u5"g8 ~ \ji"u5"g4 |
  f8 f8 f8 f8 \ji"u5"g4
  r4 |
  \ji"u3 5"e'2 (\ji"u3u7"e4) g,4 |
  \ji"u5"a2 ~ \ji"u5"a4 r4 |
  g8 g8 g8 g8 \ji"u5"a16
  \ji"u5"a16 \ji"u5"a8 ~ \ji"u5"a4 |
  \ji"u5"g8 \ji"u5"g8 \ji"u5"g8 \ji"u5"d8 f4
  r4 |
  \ji"u3"b2 ( \ji"u3 5"g2 |
  f2 ~ f4 ) r4 |
  \ji"u3"b2 ( \ji"u3 5"g2 |
  f2 ~ f4 ) r4 |
  f2 f2 |
  f2 r4 f4 |
  f1 ~ |
  f1 \bar "|."
}

Bari =  \relative bes {
  \clef "bass"
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b2 |
  \ji"u3"b4. \ji"u3"b8 \ji"u3"b8 f4. |
  f8 f8 g8 f8 c'4 r4 |
  \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 c8
  c8 c8 c8 |
  \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 c2 |
  \ji"u3u7"b4. \ji"u3u7"b8 \ji"u3u7"b8 g4. |
  c2 ( f,4 ) r4 |
  f8 f8 f8 f8 f8
  f8 f8 f8 |
  \ji"u3 5"b8 \ji"u3 5"b8 c8 \ji"u3 5"b8 \ji"u5"a2 |
  f8 f8 f8 f8 f8
  f8 ~ f8 f16 f16 |
  \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 \ji"u5"a2 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u3"b8 ~ \ji"u3"b4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u3"b8 ~ \ji"u3"b4 |
  \ji"u3"b4 \ji"u3"b4 c4 g4 |
  \ji"u5"a2 ~ \ji"u5"a2 |
  \ji"u3"b2. \ji"u3"b4 |
  \ji"u3"b4 \ji"3u5 17"g8 \ji"3u5 17"g8 \ji"u5"a4 r4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b16
  \ji"u3"b16 \ji"u3"b8 ~ \ji"u3"b4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u5^2"b4 r4 |
  c4 ( \ji"u3 5"b4 \ji"u5"a4 ) \ji"u3 5"b4 |
  c4 f,8 f8 f4 r4 |
  \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 \ji"u3 5"b8 c16
  c16 c8 ~ c4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b4 r4 |
  \ji"u3 5"d2 ( \ji"u3"b2 ~ |
  \ji"u3"b2 ~ \ji"u3"b4 ) r4 |
  \ji"u3 5"d2 ( \ji"u3"b2 ~ |
  \ji"u3"b2 ~ \ji"u3"b4 ) r4 |
  \ji"u3"b2 \ji"u3"b2 |
  \ji"u3"b4 ( \ji"u5"a4 ) r4 \ji"u5"a4 |
  c1 ( |
  \ji"u3"b1 ) \bar "|."
}

Bass =  \relative bes, {
  \clef "bass"
  \ji""b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"g8 \ji"u5"g8 \ji"u5"g8 \ji"u5"g8 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u5"g2 |
  \ji"u3"b4. \ji"u3"b8 \ji"u3"b8 \ji"u3"b4. |
  c2 ( f4 ) r4 |
  c8 c8 c8 c8 f8
  f8 f8 f8 |
  c8 c8 c8 c8 f2 |
  c4. c8 c8 c4. |
  f8 f8 g8 f8 c4
  r4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 \ji"u5"d8 |
  c8 c8 c8 c8 c2 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"d8 \ji"u5"d8 ~ \ji"u5"d8 \ji"u5"d16 \ji"u5"d16 |
  c8 c8 c8 c8 c2 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u3 5"g8 \ji"u3 5"g8 ~ \ji"u3 5"g4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u3 5"d8 \ji"u3 5"d8 ~ \ji"u3 5"d4 |
  \ji"u5"d4 \ji"u3u7"d4 c4 c4 |
  f2 ( \ji"u5"e2 ) |
  \ji"u3"b2. \ji"u3"b4 |
  \ji"u3"b4 \ji"3^0 17"b8 \ji"17"b8 c4 r4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"g16 \ji"u5"g16 \ji"u5"g8 ~ \ji"u5"g4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u5"d4 r4 |
  c2. c4 |
  f4 \ji"u5"d8 \ji"u5"d8 c4 r4 |
  c8 c8 c8 c8 f,16
  f16 f8 ~ f4 |
  \ji"u3"b8 \ji"u3"b8 \ji"u3"b8 \ji"u3"b8
  \ji"u3"b4 r4 |
  \ji"u3 5"g'2 ( \ji"u3 5"d2 |
  \ji"u5"d2 \ji"u3"b4 ) r4 |
  \ji"u3 5"g2 ( \ji"u3 5"d'2 |
  \ji"u5"d2 \ji"u3"b4 ) r4 |
  \ji"u3"b2 \ji"u5"d2 |
  c2 r4 c4 |
  \ji"u3"b1 ~ |
  \ji"u3"b1 \bar "|."
}


\HejiScore {
  <<
    \new StaffGroup
    <<
      \HejiStaff
      <<
        \set Staff.instrumentName = \markup { \center-column { \line {"Tenor"} \line {"Lead"} } }
        \set Staff.midiInstrument = "trombone"

        \context Voice = "Tenor" { \tripletFeel 8 { \voiceOne \Tenor } }
        \context Voice = "Lead" { \tripletFeel 8 { \voiceTwo \Lead } }
      >>
      \HejiStaff
      <<
        \set Staff.instrumentName = \markup { \center-column { \line {"Bari"} \line {"Bass"} } }
        \set Staff.midiInstrument = "trombone"

        \context Voice = "Bari" { \tripletFeel 8 { \voiceOne \Bari } }
        \context Voice = "Bass" { \tripletFeel 8 { \voiceTwo \Bass } }
      >>
    >>
  >>
}

