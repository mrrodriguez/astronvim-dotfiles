# astronvim-dotfiles

Personal AstroNvim v6 configuration.

## Layout

- `init.lua` — bootstraps `lazy.nvim`, then loads `lazy_setup` and `polish`.
- `lua/lazy_setup.lua` — plugin spec roots: AstroNvim core, `community`, `plugins`.
- `lua/community.lua` — AstroCommunity pack imports.
- `lua/plugins/astrocore.lua` — core options, mappings, features (this is the primary place editor
  behavior is configured, e.g. `wrap`/`textwidth`/`colorcolumn`).
- `lua/polish.lua` — currently disabled (`if true then return end`); nothing runs here yet.

## Known orphaned config: `vimrc.vim` / `lua/user/init.lua`

`lua/user/init.lua` runs `vim.cmd.runtime "vimrc.vim"`, but nothing in this repo or in AstroNvim v6
itself `require`s `lua/user/init.lua` anymore. That auto-load path was an AstroNvim v3 convention;
v6 replaced it with `lua/plugins/*.lua` LazySpecs plus an explicit `polish.lua`, which is disabled.

**Net effect: `vimrc.vim` is not sourced today**, either by standalone Neovim or by the VSCode
Neovim extension (which runs this same `init.lua`). This looks like leftover dead code from the
v3 → v6 migration (`64f5516`), not an intentional gap.

Contents of `vimrc.vim` and current status:

- `set textwidth=100` — superseded by `opt.textwidth` in `lua/plugins/astrocore.lua`. No conflict.
- `set clipboard+=unnamedplus` — redundant; AstroNvim v6 already sets this by default
  (`astronvim/plugins/_astrocore_options.lua`).
- `s` / `S` → `RepeatChar` helper (insert N repeats of a typed character, e.g. `40s-` draws a
  40-dash divider) — ported directly to `lua/plugins/astrocore.lua` (`repeat_char` local
  function), so it works in standalone Neovim and the VSCode Neovim extension. The Vimscript
  version stays in `vimrc.vim` intentionally, since it's the only one IdeaVim (no Lua engine) can
  run — the two implementations are meant to be kept in sync by hand, not sourced from one
  another.
- `g:vscode` block (`u`/`<C-r>` → `VSCodeNotify('undo'/'redo')`, clipboard) — removed from this
  file. The undo/redo sync now lives directly in `lua/plugins/astrocore.lua` (guarded on
  `vim.g.vscode`), so it no longer depends on `vimrc.vim` being sourced. The clipboard line in
  this block was redundant (see above) and was dropped, not ported.

**Flag for later:** decide whether to delete `vimrc.vim` / `lua/user/init.lua` outright, or wire it
back in (e.g. call `vim.cmd.runtime "vimrc.vim"` from `lua/polish.lua`) if some other tool turns out
to source it directly and there's a reason to keep it shared across editors. IdeaVim uses a separate
config (`~/ideavim-dotfiles`), so it is not a consumer of this file.
