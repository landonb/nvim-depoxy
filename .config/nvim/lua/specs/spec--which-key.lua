-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

return {
  {
    -- "folke/which-key.nvim",
    dir = "~/.kit/nvim/folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below

      -- -- Delay before showing the popup. Can be a number or a function that returns a number.
      -- ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
      -- delay = function(ctx)
      --   return ctx.plugin and 0 or 200
      -- end,

      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      -- ---@type wk.Win.opts
      -- win = {
      --   -- don't allow the popup to overlap with the cursor
      --   no_overlap = true,
      --   -- width = 1,
      --   -- height = { min = 4, max = 25 },
      --   -- col = 0,
      --   -- row = math.huge,
      --   -- border = "none",
      --   padding = { 1, 2, -- extra window padding [top/bottom, right/left]
      --   title = true,
      --   title_pos = "center",
      --   zindex = 1000,
      --   -- Additional vim.wo and vim.bo options
      --   bo = {},
      --   wo = {
      --     -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      --   },
      -- },
      -- layout = {
      --   width = { min = 20 }, -- min and max width of the columns
      --   spacing = 3, -- spacing between columns
      -- },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({
            global = false,
            loop = true, -- keep the popup open until you hit <esc>
          })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
