-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇

return {
  -- ------------------------------------------------------------
  -- ------------------------------------------------------------

  -- CXREF/2025-01-31: ~matches OMR config order:
  --   ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-lsp--coc
  --   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_lsp.vim

  {
    dir = "~/.kit/nvim/neoclide/start/coc.nvim",
    lazy = not lazy_profile["coc.nvim"],
  },

  {
    dir = "~/.kit/nvim/neoclide/start/coc-tsserver",
    lazy = not lazy_profile["coc-tsserver"],
  },

  {
    dir = "~/.kit/nvim/neoclide/start/coc-json",
    lazy = not lazy_profile["coc-json"],
  },

  -- ------------------------------------------------------------
  -- ------------------------------------------------------------
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


