\version "2.24.1"

\include "../src/heji.ily"

render-midi = ##t

\HejiScore {
  <<
    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a' {
        \clef treble

        <b \ji "3u5" g'>1
      }
    }

    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a' {
        \clef treble

        <\ji "u7" g \ji "11" d'>1
      }
    }

    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a, {
        \clef alto
        <\ji "3u5" c' \ji "3u13" f>1
      }
    }

    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a, {
        \clef bass

        <a e'>1
      }
    }
  >>
}
