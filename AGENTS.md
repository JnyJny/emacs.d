# AGENTS

Repo-local guidance for maintaining Erik's Emacs configuration.

## Scope

- This repository is a personal Emacs configuration, not an application.
- Prefer small, reversible edits that keep startup reliable.
- Do not track generated state, caches, package installs, cookies, history, or
  byte-compiled `.elc` files.

## Startup Shape

- `init.el` is the entry point.
- Handwritten modules live under `lisp/` and are loaded explicitly from
  `init.el`.
- Keep language-specific setup in `lisp/init-mode-*.el`.
- Avoid adding framework-heavy Emacs distributions or broad rewrites.

## External Tools

Expected host tools:

- Emacs 30 or newer.
- Homebrew on Apple Silicon at `/opt/homebrew`.
- `ruff` for Python formatting and fallback Python LSP support.
- `pyright-langserver` or `basedpyright-langserver` for fuller Python LSP
  support when available.
- `rust-analyzer`, `rustc`, and `cargo` for Rust support.
- `jq` for JSON buffer formatting.

Suggested installs on a new macOS host:

```sh
brew install emacs ruff pyright jq
rustup component add rust-analyzer rustfmt
```

If Rust is not installed yet, install it with `rustup` first.

## Emacs Packages

- Package archives are configured in `lisp/init-elpa.el`.
- `package-selected-packages` in `init.el` records the intended package set.
- After first startup or archive refresh, install missing selected packages from
  inside Emacs with `M-x package-install-selected-packages`.
- Do not commit `elpa/`; it is intentionally ignored.

## LSP Policy

- Use built-in Eglot as the Emacs LSP client.
- For Python, prefer `basedpyright-langserver` if present, then
  `pyright-langserver`, then `ruff server` as a fallback.
- Ruff formatting on save is configured separately from the Python language
  server, so installing Pyright should not disable Ruff formatting.
- For Rust, use `rust-analyzer` through Eglot.

## Validation

Run these before handing off changes:

```sh
emacs --batch --debug-init --load "$HOME/.emacs.d/init.el"
emacs --batch --eval '(byte-recompile-directory (expand-file-name "lisp" user-emacs-directory) 0)'
git -C "$HOME/.emacs.d" diff --check
git -C "$HOME/.emacs.d" diff --cached --check
```

The byte-compile command creates or updates ignored `.elc` files. Keep those
local cache files around for startup performance, but do not stage or commit
them.

## Git Hygiene

- Keep `.cache/`, `elpa/`, `request/`, `transient/`, autosaves, backups, and
  `.elc` files ignored.
- If generated files were accidentally committed, remove them from the index
  with `git rm --cached`, not by deleting Erik's local runtime state.
- Report staged generated-file untracking separately from source config edits
  because it can dominate the diffstat.
