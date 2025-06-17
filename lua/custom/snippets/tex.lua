return {
  s(
    "tab",
    fmt(
      [[
        \begin{table}[<pos>]
            \centering
            \caption{<caption>}
            \label{tab:<label>}
            \begin{tabular}{<col>}
                \toprule
                <content>
                \bottomrule
            \end{tabular}
        \end{table}
    ]],
      {
        pos = i(1, "htpb"),
        caption = i(2, "caption"),
        label = i(3, "label"),
        col = i(4, "c"),
        content = i(5, ""),
      },
      { delimiters = "<>" }
    )
  ),
  s(
    "->",
    fmt(
      [[ \to
    ]],
      {}
    )
  ),
  s(
    "=>",
    fmt(
      [[ \Righarrow
    ]],
      {}
    )
  ),
  s(
    "<=",
    fmt(
      [[ \Leftarrow
    ]],
      {}
    )
  ),
  s(
    "<=>",
    fmt(
      [[ \Leftrightarrow
    ]],
      {}
    )
  ),
  s(
    "$",
    fmt(
      [[ \({expr}\)
    ]],
      { expr = i(1) }
    )
  ),
  s(
    "eq",
    fmt(
      [[
      \begin{align}
          <expr>
      \end{align}
    ]],
      { expr = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "eqn",
    fmt(
      [[
      \begin{align*}
          <expr>
      \end{align*}
    ]],
      { expr = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "min",
    fmt(
      [[
      \min\limits_{<lim>}
    ]],
      { lim = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "max",
    fmt(
      [[
      \max\limits_{<lim>}
    ]],
      { lim = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "argmin",
    fmt(
      [[
      \argmin\limits_{<lim>}
    ]],
      { lim = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "argmax",
    fmt(
      [[
      \argmax\limits_{<lim>}
    ]],
      { lim = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "norm",
    fmt(
      [[
      \left\| <value> \right\|
    ]],
      { value = i(1) },
      { delimiters = "<>" }
    )
  ),
  s(
    "proof",
    fmt(
      [[
      \begin{proof}
          <proof>
      \end{proof}
    ]],
      { proof = i(1) },
      { delimiters = "<>" }
    )
  ),
}
