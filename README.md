# heji-ly
**NOTE: This package is under active development and should be considered experimental. Currently chords are partially supported (playback works, but the chords will appear as multiple voices).**

This [LilyPond](https://lilypond.org/index.html) package implements support for the [Helmholtz-Ellis Just Intonation](https://masa.plainsound.org/pdfs/notation.pdf) notation system. All standard accidentals (47-limit as of the time of writing) are supported and they can be combined in arbitrary ways through a general interface.

## Dependencies
The *HEJI2* font must be installed, which can be downloaded from [https://www.plainsound.org/](https://www.plainsound.org/). After downloading, just place it wherever LilyPond expects to find fonts on your system.

## Usage
To use this package in your project simply include the line 

```lilypond
\include "/path/to/heji.ily"
```
### HEJI scores and staves
Music that uses HEJI accidentals should be placed in a `\HejiScore` block instead of a `\score` context, which causes LilyPond to render the score to a MIDI file when the `render-midi` option is set (see [Options](#options)). Inside of `\HejiScore` blocks use `\HejiStaff` instead of `\new Staff` to ensure that accidentals are always printed properly:

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

<img src="img/1.png" height="200">

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

<img src="img/2.png" height="200">

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

<img src="img/3.png" height="200">

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

<img src="img/4.png" height="200">

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

<img src="img/5.png" height="200">

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

<img src="img/6.png" height="200">

## Options

- `heji-font` = <string> - Filename of the HEJI2 font on your system, excluding the file extension. Default: `"HEJI2"` 
- `warn-on-empty-factors` = Whether to issue a warning when no factors are supplied to the `\ji` function. Default: `#f` because currently chords require you to list the factors of all chord notes in order and will therefore cause spurious warnings.
- `skip-validation` - Whether to skip validation of factors. Normally, factors are checked to make sure that only prime number factors appear in the list and that the exponents do not exceed the maximum supported value. Only set to `#t` if you're generating LilyPond code and can guarantee the factors are legal and want to squeeze some extra performance. Default: `#f`
- `warn-on-ill-formed-factor-string` - The factor parser is extremely lenient; it will ignore any unexpected characters and continue parsing. Set to #t if you wish to be warned about these unexpected characters. 
- `render-midi` - Set to `#t` if you want a rendered MIDI file. No need for `\midi {}` blocks, just set to `#t` and LilyPond will produce a MIDI file as well as a PDF score. Default: `#f`
- `reference-pitch` - The reference pitch to use (only affects MIDI playback). Default: `5` (A)
