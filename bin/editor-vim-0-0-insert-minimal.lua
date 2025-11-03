-- vim:tw=0:ts=2:sw=2:et:norl:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT. Please find more in the LICENSE file.

-- Copyright (c) © 2025 Landon Bouma. All Rights Reserved.

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- USAGE: Generally called via EDITOR shim:
--
--   ~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal
--
-- Can also be used directly, e.g.,
--
--   NVIMDEPOXY_PLUG_PATH=~/.kit/nvim nvim -u path/to/this/file
--
-- Or used with gvim-open-kindness:
--
--   GVIM_OPEN_INIT_VIMRC=~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal.lua gvim-open-kindness

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- Use mswin to modify a few things so we don't have to do it ourselves:
-- - Remap <Ctrl-Z> to Undo, not just for comfority with most DEs, but
--   also because <Ctrl-Z> otherwise suspends (or minimizes) the editor.
-- - Wire Cut-Copy-Paste to familar <Ctrl> key combos, and also to the
--   OS clipboard.
require("util.mswin").setup()

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- CXREF: Use another module to customize any Neovide settings:
--   require('modules.neovide')
-- ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/modules/neovide.lua
if vim.g.neovide then
  -- Nothing.
end

-- FIXME/2025-01-28 14:57: This belongs... somewhere else...
-- FIXME/2025-02-01 13:20: Does this even matter to terminal vim/nvim?
vim.opt.title = true

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- CXREF: See also same comment below:
-- - <C-s> saves and quits (:wq).
--   ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/ctrl-s-save-command.vim
vim.env.VIM_EDIT_JUICE_EXIT_ON_SAVE = 1

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- CXREF:
-- ~/.config/nvim/lua/config/lazy.lua
-- ~/.config/nvim/lua/config/profile.lua

require("config.lazy").setup({ profile = "minimal" })

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

-- Finally, load a script shared with the minimal.vimrc script
-- that wires a few niceties:
-- - Create new undo block on <CR> so undo undoes curr. line and not
--   entire Insert session;
-- - Map <C-l> to <C-k> (:digraphs) to match normal nvim-depoxy wiring;
-- - Map \dQ to save-and-quit (in normal nvim-depoxy, \dQ is
--   save-all-and-quit);
-- - Set gitcommit filetype indent style to 2 spaces, with spellcheck;
-- - Wire web openers (\T and gW, \D, \W, and g!);
-- - Wire async-map kj/jk Insert mode escapes; and
-- - Map <Shift-Ctrl-D> and <Shift-Ctrl-W> magic characters, to enable
--   <c-s-d> indent and <c-s-w> delete-to-start-of-line.
--
-- Use the path to this script to find the shared script.
-- - CXREF:
--   ~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal.vim
vim.cmd("source " .. vim.fn.expand("<script>:h") .. "/editor-vim-0-0-insert-minimal.vim")

-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
