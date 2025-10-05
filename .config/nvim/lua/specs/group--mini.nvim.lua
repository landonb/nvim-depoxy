-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return {
  {
    -- HSTRY/2025-10-05: Rebranded from echasnovski/mini.icons:
    --   https://github.com/nvim-mini/mini.nvim/discussions/1970
    "nvim-mini/mini.nvim",
    version = false,
    -- dir = "~/.kit/nvim/nvim-mini/mini.nvim",
    -- lazy = not lazy_profile["mini.nvim"],

    config = function()
      -- CXREF:
      -- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-ai.md
      -- https://github.com/nvim-mini/mini.nvim/blob/main/doc/mini-ai.txt
      --  :h MiniAi-textobject-builtin
      require("mini.ai").setup()
    end,
  },
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
