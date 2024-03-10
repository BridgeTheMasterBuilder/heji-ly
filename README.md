# heji-ly
**NOTE: This package is under active development and should be considered experimental.**

This [LilyPond](https://lilypond.org/index.html) package implements support for the [Helmholtz-Ellis Just Intonation](https://masa.plainsound.org/pdfs/notation.pdf) notation system. All standard accidentals (47-limit as of the time of writing) are supported and they can be combined in arbitrary ways through a general interface.

## Dependencies
The *HEJI2* font must be installed, which can be downloaded from [https://www.plainsound.org/](https://www.plainsound.org/). After downloading, just place it wherever LilyPond expects to find fonts on your system.

## Usage
To use this package in your project simply include the line 

```lilypond
\include "/path/to/heji.ily"
```
### HEJI scores and staves
Music that uses HEJI accidentals should be placed in a `\HejiScore` block instead of a `\score` context, which is necessary for LilyPond to properly render the score to a MIDI file when the `render-midi` option is set (see [Options](#options)). Inside of `\HejiScore` blocks use `\HejiStaff` instead of `\new Staff` to ensure that accidentals are always printed properly:

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      \ji "5" a
    }
  }
}
```

<img src="media/1.png" height="200">

compare to:

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \new Staff {
    \relative a {
      \ji "5" a
    }
  }
}
```

<img src="media/2.png" height="200">

### The \ji function
HEJI accidentals can be added to a note by writing `\ji <factor string> <note>`

The syntax for factor strings is specified by the following grammar:

```
factor string = '"', factor *, '"' ;

factor = otonal factor
       | utonal factor ;

otonal factor = [ 'o' ], prime factor ;

utonal factor = 'u', prime factor ;

prime factor = prime, [ exponent ] ; 

prime = ? prime number ? ;

exponent = '^', nat ;

nat = ? natural number ? ;
```

In plain English: A list of prime numbers optionally raised to some power ("x^a y^b ...") which we call a *factor*. Factors can be prefaced by the letters 'o' or 'u' to specify otonal and utonal factors respectively. A factor by itself is interpreted as otonal. Whitespace is only necessary to differentiate different numbers and can otherwise be omitted.

Examples of well-formed strings:

```
""
"o3"
"u5"
"7^0"
"11"
"3 5"
"7o11"
"o13^1u17"
```

More examples can be found in the `examples` folder.

Accidentals can be combined in arbitrary ways:

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      \ji "3 5 7 11 13 17 19 23 29 31 37 41 43 47" a
    }
  }
}
```

<img src="media/3.png" height="200">

The order of factors does not matter:

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      \ji "3 7 u11" a
    }
  }
}
```

<img src="media/4.png" height="200">

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      \ji "u11 7 3" a
    }
  }
}
```

<img src="media/5.png" height="200">

If there are repeated factors the exponents will be summed up:

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      \ji "u3 u5^3 u5^2 u3^2 u5 3^2 u3 5^4 5^2 3^2" a
    }
  }
}
```

<img src="media/6.png" height="200">

### Chords
Chords can be input in exactly the same way: 

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      <a \ji "3u5" c e \ji "u7" g b \ji "11" d \ji "3 u13" f \ji "3u17" a>
    }
  }
}
```

<img src="media/7.png" height="200">

Natural accidentals can be omitted by setting the `print-naturals` option. Unfortunately, this requires specifying factors for all notes in the file, even if they are empty: 

```lilypond
\version "2.24.1"

\include "heji.ily"

print-naturals = ##f

\HejiScore {
  \HejiStaff {
    \relative a {
      <\ji "" a \ji "3u5" c \ji "" e \ji "u7" g \ji "" b \ji "11" d \ji "3 u13" f \ji "3u17" a>
    }
  }
}
```

<img src="media/8.png" height="200">

Another option is to use sharpened/flattened note names for the notes with HEJI accidentals and set the accidental style manually, e.g.:

```lilypond
\version "2.24.1"

\include "heji.ily"

\HejiScore {
  \HejiStaff {
    \relative a {
      \accidentalStyle forget
      <a \ji "3u5" cis e \ji "u7" ges b \ji "11" dis \ji "3 u13" fis \ji "3u17" ais>1
    }
  }
}
```

<img src="media/9.png" height="200">

It's also possible to selectively omit accidentals:

```lilypond
\version "2.24.1"

\include "heji-ly/src/heji.ily"

render-midi = ##t

\HejiScore {
  \HejiStaff {
    \relative a {
      \once\omit Accidental <a \ji "3u5" cis e \ji "u7" ges b \ji "11" dis \ji "3 u13" fis \ji "3u17" ais>
    }
  }
}
```

<img src="media/10.png" height="200">

Note that these are not fully equivalent as evidenced by the difference in output.

The reason why this works is because the only thing that matters with regards to calculating the accidental and the tuning in the playback are the factors, the note name is irrelevant beyond specifying where the note should be placed in the staff.

Please open an issue if these restrictions seem unreasonable (lifting them to doable but not a high priority at the moment).

### Playback
Playback is only supported up to 16 simulatenous notes due to a limitation of MIDI. In order to support playback each note needs to be in its own channel and MIDI unfortunately only supports 16.

To render the previous example to a midi file we set the `render-midi` option to `#t`:

```lilypond
render-midi = ##t

\HejiScore {
  \HejiStaff {
    \set Staff.midiInstrument = "clarinet"

    \relative a {
      <a \ji "3u5" c e \ji "u7" g b \ji "11" d \ji "3 u13" f \ji "3u17" a>1
    }
  }
}
```


https://github.com/BridgeTheMasterBuilder/heji-ly/assets/71600489/86f3f603-cfbc-42d4-8eeb-e2d53fe83a9a


## Options

Options are set by assigning a value to variables, e.g.:

```lilypond
render-midi = ##t
```

Currently supported options:
- `heji-font` = <string> - Filename of the HEJI2 font on your system, excluding the file extension. Default: `"HEJI2"` 
- `warn-on-empty-factors` = Whether to issue a warning when no factors are supplied to the `\ji` function. Default: `#t` 
- `skip-validation` - Whether to skip validation of factors. Normally, factors are checked to make sure that only prime number factors appear in the list and that the exponents do not exceed the maximum supported value. Only set to `#t` if you're generating LilyPond code and can guarantee the factors are legal and want to squeeze some extra performance. Default: `#f`
- `warn-on-ill-formed-factor-string` - The factor parser is extremely lenient; it will ignore any unexpected characters and continue parsing. Set to #t if you wish to be warned about these unexpected characters. 
- `render-midi` - Set to `#t` if you want a rendered MIDI file. No need for `\midi {}` blocks, just set to `#t` and LilyPond will produce a MIDI file as well as a PDF score. Default: `#f`
- `reference-pitch` - The reference pitch to use (only affects MIDI playback). Default: `5` (A)
- `print-naturals` - Whether to print natural accidentals. Currently a binary choice that applies to the whole file. Default: `#t` 
