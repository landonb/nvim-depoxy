-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇

-- FIXME/2025-02-22 11:49: Uses
--   ~/.vim_mru_files
-- - <Enter> opens file in existing window and closes :MRU
--   window, but buffer not necessarily sent to mru window.
--   - I'd want to open in an existing window;
--     and possibly I'd want to use an FZF picker.
-- - But at least now I have a list of buffers
--   ordered by MRU.
-- https://github.com/yegappan/mru/wiki/User-Manual

-- USAGE:
--   :MRU
--   :MRUToggle
--
-- In the MRU window, the following keys can be used:
--
--  Key	Description
--  <Enter>	open the file under cursor
--  o	open the file under cursor in a horizontally split window
--  <S-Enter>	idem
--  O	open the file under cursor in a vertically split window
--  v	open the file under cursor in read-only mode
--  t	open the file under cursor in a tab page
--  p	open the file under cursor in the preview window
--  u	update (refresh) the MRU list
--  d	delete the file name under cursor from the MRU list
--  q	close the MRU window
--  <Esc>	idem
--
-- REFER
-- https://github.com/yegappan/mru/wiki/User-Manual

-- REFER: https://github.com/yegappan/mru
-- - Via: https://www.vim.org/scripts/script.php?script_id=521
-- BEGET/2025-02-22: From HN comment on *Vim anti-patterns*:
--   https://news.ycombinator.com/item?id=3563292
--   https://blog.sanctum.geek.nz/vim-anti-patterns/
-- - Though I had written a FTREQ for this feature an hour earlier.

return {
  {
    dir = "~/.kit/nvim/yegappan/mru",
    lazy = not lazy_profile["yegappan/mru"],

    init = function()
      -- Defaults to ~/.vim_mru_files
      local xdg_data_home = vim.env.XDG_DATA_HOME
      if not xdg_data_home then
        xdg_data_home = vim.env.HOME .. "/.local/share"
      end
      local plugin_data_home = xdg_data_home .. "/nvim/yegappan"
      vim.fn.mkdir(plugin_data_home, "p")
      vim.g.MRU_File = plugin_data_home .. "/.vim_mru_files"
    end
  },
}

