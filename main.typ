= Typst (for presentations)

Hello World. The syntax is very similar to Markdown, and supports *bold* and _underline_.

// this is a comment

- Lists are also possible
- Just like you're already used to
- And there's
  $
  hat(f)(x) = integral_(-infinity)^(infinity) f(x) e^(-2 i pi xi x) dif x,
  $
  mathematics, using a much simpler syntax than LaTeX.
- And it can do *so much more*!

#let slide(content) = content
#slide[
  We can compile Typst documents (`*.typ`) using the `typst` compiler:
  ```
  typst compile main.typ
  typst watch main.typ
  ```
  The latter with watch the file for changes and recompile when updated.
  ```
  typst compile --help
  ...
        --pages <PAGES>
            Which pages to export. When unspecified, all document pages are
            exported.

            Pages to export are separated by commas, and can be either simple page
            numbers (e.g. '2,5' to export only pages 2 and 5) or page ranges (e.g.
            '2,3-6,8-' to export page 2, pages 3 to 6 (inclusive), page 8 and any
            pages after it).
  ...
    -f, --format <FORMAT>
            The format of the output file, inferred from the extension by default
  ```
]

#slide[
  = Concepts

  Typst has a number of functions we can use to specify document layout. We can invoke a *function* using the `#` prefix. For example, `#lorem(40)` will generate:

  #lorem(40)

  Functions can be used to *insert content* or to modify document state.

  For example: the `text` function can be used to manipulate the properties of the text:

  ```
  #text(fill: red)[Hello World]
  ```
  #text(fill: red)[Hello World]

  Note the use of `[]` square brackets.
]

#slide[
  == Scopes

  (My nomenclature, not official)

  There are two types of scope in Typst:
  - `[content]`
  - `{logical}`

  Logical scope treats every line as Typst syntax, so will invoke functions directly.

  What happens in a scope, *stays in a scope*.

  If a scope immediately follows a function, it is passed as the last *positional argument*, as we saw with `#text(fill: red)[Hello World]`.

  The properties of scopes can be modified using `set`. If used in the global scope, it will apply _from the moment it is invoked_.

  ```
  #[
    This is fine. \
    #set text(fill: green)
    This is good!
  ]
  ```
  #[
    This is fine. \
    #set text(fill: green)
    This is good!
  ]

  _Note:_ white spaces are generally ignored, as is indentation.
]

#slide[
  == Page

  Each page is its own scope, and we can manipulate what it looks like with `page`, which must be at the top of the page before any content is added.

  E.g.
  ```
  #set page(paper: "a5")
  #set page(margin: (top: 2cm, bottom: 2cm))
  #set page(margin: 2cm, height: 30cm, width: 40cm)
  #set page(footer: [This will show on every page!])
  ```
  // set the footer and page dimensions
]

#slide[
  = Scripting

  Typst has programming primitives including number types, array types, dictionaries, and strings.

  We can therefore use expressions and have Typst insert the result
  ```
  #{25 + 8}
  ```
  #{25 + 8}

  Assign to variables:
  ```
  #let x = 38 + 3
  #let x = x + 1
  #x
  ```
  #let x = 38 + 3
  #let x = x + 1
  #x

  ```
  #{
    let colors = (red, green, blue, yellow)
    lorem(10).split().enumerate().map(i =>
      text(fill: colors.at(calc.rem(i.at(0), colors.len())), i.at(1))
    ).join(" ")
  }
  ```
  #{
    let colors = (red, green, blue, yellow)
    lorem(10).split().enumerate().map(i =>
      text(fill: colors.at(calc.rem(i.at(0), colors.len())), i.at(1))
    ).join(" ")
  }
  The `=>` syntax specifies a lambda function (we'll see those more later).
]

#slide[
  = Rules

  Rules let us modify how objects are drawn.

  == An example rule

  Headings are denoted with
  ```
  = Section
  == Subsection
  === Subsubsection
  ```

  Say we wanted all of the `= Section` to appear different. We can do that with a `show` rule:
  ```
  #show heading.where(level: 1): h => smallcaps(h)
  ```
  (There is really advanced introspection, but that's beyond what we'll cover today.)
]

#slide[
  = Alignments and spacing

  We can align a given scope with `align`:
  ```
  #align(center)[This text will now be centered.]
  #[
    #set align(right)
    Everything in this scope will be right aligned.
  ]
  ```
  #align(center)[This text will now be centered.]
  #[
    #set align(right)
    Everything in this scope will be right aligned.
  ]

  There are two useful functions for spacing `h` and `v` for horizontal and vertical spacing. They take a length as their arguments:
  ```
  #h(1cm)
  #h(1fr)
  ```
  The `fr` is used to fill remaining.

  // now we have everything to make a title slide
]

#slide[
  = References

  There is a whole citation system that is Bibtex compatible. You cite with `@thing` or `cite(<thing>)`.

  The same syntax is used to refer to other things, such as figures or sections. You mark these with `<labels>` for them to be referable.

  // now make a table of contents, and do a recursive reference
  // #show heading.where(level: 1): h => smallcaps(h.body)
  // #set heading(numbering: "1.")
  // #outline()
]

#slide[
  = Functions

  We've already seen lambda functions. We can assign these to variables using `let` or directly declare functions that way too:
  ```
  #let hl(content) = text(style: "italic", fill: red, content)
  This is #hl[important].
  ```
  #let hl(content) = text(style: "italic", fill: red, content)
  This is #hl[important].

  Functions accept positional or keyword arguments:
  ```
  #let hl(content, fill: red) = text(style: "italic", fill: fill, content)
  This is #hl[important].
  This is #hl(fill: green)[vital].
  ```
  #let hl(content, fill: red) = text(style: "italic", fill: fill, content)
  This is #hl[important].
  This is #hl(fill: green)[vital].
]

#slide[
  = Presentations

  Have to import a package:
  ```
  #import "@preview/polylux:0.4.0": *
  #set page(paper: "presentation-4-3")
  ```
]

#slide[
  Putting it all together
]


