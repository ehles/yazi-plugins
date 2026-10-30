# glow.yazi

Markdown preview for [Yazi](https://github.com/sxyazi/yazi) 26.9+, rendered by [glow](https://github.com/charmbracelet/glow).

```sh
ya pkg add ehles/yazi-plugins:glow
```

```toml
# ~/.config/yazi/yazi.toml
[plugin]
prepend_previewers = [
  { url = "*.md", run = "glow" },
]
```

Needs `glow` in `PATH`. See the [repository README](../README.md) for details.
