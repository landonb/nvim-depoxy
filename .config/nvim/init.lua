-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Bail now if `nvim --noplugin`.
if not vim.go.loadplugins then
  --

  return
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- USAGE: `NVD_PROFILE_START=1 nvim` starts `profile` immediately.
--
-- - ALTLY: See folke's sophisticated Lua profiler:
--     https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md
--
-- - ALTLY: Startup time profiling: See also:
--     (n)vim --startuptime <file>

-- FIXME/2025-02-22: Rename one of NVD_PROFILE and NVD_PROFILE_START.

if vim.fn.has("profile") == 1 and vim.env.NVD_PROFILE_START ~= nil then
  vim.cmd("profile start /tmp/vim-profile.log")
  vim.cmd("profile file *")
  vim.cmd("profile func *")

  print("nvim-depoxy: Started profiling: Run `profile dump` & `edit /tmp/vim-profile.log`")
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Configure Neovide settings.
-- - ISOFF/2025-02-21: Currently sets nothing; but it lists all the
--   options and makes it easily to fiddle switches to experiment.
-- - CXREF:
--   ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/modules/neovide.lua
-- MAYBE/2025-02-01: Rename modules/ ? Combine with config/ ?
-- - MAYBE/2025-02-22 17:44: Set meta key if 'lazy' profile?
--   (Or add literal maps.)
require("modules.neovide")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MAYBE/2025-02-01 13:21: Relocate this to another module?
-- - E.g.:
--   require('modules.startup')

-- Vim says &title defaults off, and it is via `vim --noplugin`, but
-- it defaults on when the GUI is run, e.g., `gvim --noplugin`. It's
-- not set in Neovide, however, and all you see by default is "Neovide".
-- Enable &title to see "<filename>" - NVIM" instead, or whatever
-- &titlestring is set to (i.e., per landonb/vim-title-bar-time-of-day).
-- - This is unnecessary if landonb/vim-title-bar-time-of-day loads.
vim.opt.title = true

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- UCASE: Mostly because <Ctrl-z> minimizes Neovide, which is a painful
-- price to pay when you forget that (n)vim is the only app you use that
-- doesn't wire <Ctrl-z> to undo.
--
-- - Also I don't ever background nvim in the terminal, so no love lost
--   there.
--
-- CXREF: /opt/homebrew/var/homebrew/linked/neovim/share/nvim/runtime/mswin.vim
--
-- SAVVY: The Neovim mswin.vim is almost identical to Vim mswin.vim,
--        e.g., if you compare against MacVim's mswin.vim:
--
--          /Applications/MacVim.app/Contents/Resources/vim/runtime/mswin.vim
--
--        You'll see
--
--          behave mswin
--
--        in the Vim file, but in Neovim you'll see:
--
--          set selection=exclusive
--          set selectmode=mouse,key
--          set mousemodel=popup
--          set keymodel=startsel,stopsel

-- FIXME/2025-02-22 21:32: Double-check what bindings change.
-- - <C-z> is suspend, which LazyVim doesn't change.
-- - <C-y> is ...
-- - <C-v> is Visual block mode, which mswin.win puts at
--   <C-q> and LazyVim doesn't appear to touch...
-- SPIKE/2025-02-22: List mswin.vim maps here.
-- - Disable this call and check against default LazyVim maps.

local enable_behave_mswin = function()
  -- stylua: ignore
  local running_windows = (
    false
    or vim.fn.has("win16") == 1
    or vim.fn.has("win32") == 1
    or vim.fn.has("win64") == 1
  )

  if running_windows then
    return
  end

  -- Neovim v0.10.4
  local mswin = vim.env.VIMRUNTIME .. "/mswin.vim"

  if vim.fn.filereadable(mswin) == 0 then
    -- Neovim v0.11.0-dev-{sha}-Homebrew
    mswin = vim.env.VIMRUNTIME .. "/scripts/mswin.vim"
  end

  if vim.fn.filereadable(mswin) == 0 then
    print("ERROR: Failed to find mswin.vim")
  else
    vim.cmd("source " .. mswin)
  end
end

-- FIXME/2025-02-27 19:58: Remove this
--enable_behave_mswin()

require("util.mswin").setup()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- SAVVY: nvim-depoxy supports both sets of characters — literal
-- <Option> keypresses (e.g., 'ƒ'), and their <Alt> counterparts
-- (e.g., <M-f>).
-- - But we use <Option> keypresses so that <Alt-number>s work,
--   albeit at the expense of a few two-character <Option>
--   combinations that macOS preemptively processes.
if vim.g.neovide then
  vim.g.neovide_input_macos_option_key_is_meta = "none"
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- CXREF: Setup lazy.nvim:
--   ~/.config/nvim/lua/config/lazy.lua
-- Using the "maximal" "profile" plugin group:
--   ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/config/profile.lua
-- Which basically loads all the plugins defined in the specs:
--   ~/.config/nvim/lua/specs/*.lua
-- Note that as more plugins are configured with more sophisticated
-- lazy loading properties (e.g., `cmd`, or `event`), the "profile"
-- feature is less and less necessary.
-- - But for now we use the profile to define at least 2 plugin
--   configurations — a "maximal" set to be used as your daily
--   development driver, and a "minimal" set to be load
--   ed via
--   your EDITOR setting, for when you're just performing a
--   quick one-off edit in your terminal.
-- - CXREF: The "minimal" profile currently loaded by external
--   project's minimal.lua, but really-maybe that file should
--   be brought into this project:
--     ~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal.lua

-- USAGE: Normal startup: `nvim` | Same as: `NVD_PROFILE="maximal" nvim`
-- - SAVVY: You cannot use empty string, e.g., after `NVD_PROFILE="" nvim`
--          you'll see that `lua print(vim.env.NVD_PROFILE)` is nil.
-- - USAGE: Start w/ lazy-load all: `NVD_PROFILE="none" nvim`

-- ALTLY: You *could* test different Neovim distributions using
--        NVD_PROFILE, e.g.,
--
--     if vim.env.NVD_PROFILE == "lazy" then
--       if vim.g.neovide then
--         vim.g.neovide_input_macos_option_key_is_meta = 'both'
--       end
--
--       -- CXREF:
--       -- ~/.kit/nvim/LazyVim/starter/lua/config/lazy.lua
--       vim.opt.rtp:prepend(vim.env.HOME .. "/.kit/nvim/LazyVim/starter")
--       require("config.lazy")
--     else
--
-- But then that distro shares the same xdg dirs, e.g.,
--
--   ~/.config/nvim
--   ~/.cache/nvim
--   ~/.local/share/nvim
--   ~/.local/state/nvim
--
-- which seems to mostly work in practice.
--
-- - But at least the `lazy-lock.json` file will thrash.
--
-- SAVVY: So instead, use NVIM_APPNAME isolation
--
--   :h NVIM_APPNAME
--
-- - CXREF: See how DepoXy uses NVIM_APPNAME to use this init.lua
--   explicitly, e.g.,
--
--     ln -sfn ~/.config/nvim_depoxy ~/.kit/nvim/nvim-depoxy/.config/nvim
--     NVIM_APPNAME=nvim_depoxy nvim ...
--
--   ~/.depoxy/ambers/core/alias-vim.sh

-- CXREF:
-- ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/config/lazy.lua
-- stylua: ignore
require("config.lazy").setup(
  { profile = vim.env.NVD_PROFILE and vim.env.NVD_PROFILE or "maximal" }
)
