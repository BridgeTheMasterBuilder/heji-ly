\version "2.24.1"

\include "../src/heji.ily"

render-midi = ##t

\HejiScore {
  <<
    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a' {
        \clef treble

        \ji #'("" "3u5") <b g'>1
      }
    }

    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a' {
        \clef treble

        \ji #'("u7" "11") <g d'>1
      }
    }

    \HejiStaff {
      \set Staff.midiInstrument = "reed organ"

      \relative a, {
        \clef alto
        \ji #'("3u5" "3u13") <c' f>1
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
