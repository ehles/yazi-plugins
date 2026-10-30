# miller.yazi

CSV and TSV preview for [Yazi](https://github.com/sxyazi/yazi) 26.9+ as an aligned, colored table, rendered by [Miller](https://github.com/johnkerl/miller).

```sh
ya pkg add ehles/yazi-plugins:miller
```

```toml
# ~/.config/yazi/yazi.toml
[plugin]
prepend_previewers = [
  { url = "*.csv", run = "miller" },
  { url = "*.tsv", run = "miller" },
]
```

Needs `mlr` in `PATH`. See the [repository README](../README.md) for details.
