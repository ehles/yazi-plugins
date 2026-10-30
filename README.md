# yazi-plugins

Two previewers for [Yazi](https://github.com/sxyazi/yazi) 26.9+:

| Plugin | Previews | Needs |
|---|---|---|
| [`glow.yazi`](glow.yazi/main.lua) | Markdown, rendered by [glow](https://github.com/charmbracelet/glow) | `glow` in `PATH` |
| [`miller.yazi`](miller.yazi/main.lua) | CSV and TSV as an aligned, colored table, by [Miller](https://github.com/johnkerl/miller) | `mlr` in `PATH` |

What they do:

- Fit the output to the preview pane: glow renders at the pane width, long lines wrap according to `[preview] wrap` in `yazi.toml`.
- Scroll with Yazi's `seek` command and stop at the last page.
- Show what went wrong instead of an empty pane: a missing tool, or the tool's own error, such as a CSV row with the wrong number of fields.
- Follow the terminal theme: glow uses its light style in a light terminal and dark otherwise.

## Install

```sh
ya pkg add ehles/yazi-plugins:glow
ya pkg add ehles/yazi-plugins:miller
```

Install the tools, for example with Homebrew:

```sh
brew install glow miller
```

Then add the previewers to `~/.config/yazi/yazi.toml`:

```toml
[plugin]
prepend_previewers = [
  { url = "*.md", run = "glow" },
  { url = "*.csv", run = "miller" },
  { url = "*.tsv", run = "miller" },
]
```

Match CSV by extension, not by `mime = "text/csv"`: `file` reports a CSV with uneven rows as `text/plain`, and the mime rule misses it.

miller.yazi reads `.tsv` and `.tab` files as TSV and everything else as CSV.

## Scrolling

The default preview scroll keys `K` and `J` work.
To bind other keys, add them to `~/.config/yazi/keymap.toml`:

```toml
[mgr]
prepend_keymap = [
  { on = "<C-e>", run = "seek 5" },
  { on = "<C-y>", run = "seek -5" },
]
```

## Update

```sh
ya pkg upgrade
```

## License

[MIT](LICENSE)
