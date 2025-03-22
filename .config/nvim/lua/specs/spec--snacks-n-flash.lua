-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: Unlicensed...

-- COPYD: Copied from:
-- https://gist.github.com/niba/300c413ffd87c694e5ab169d6b0009d4

-- BEGET:
-- https://www.reddit.com/r/neovim/comments/1ifyfou/comment/malwcwo/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- 
-- https://www.reddit.com/r/neovim/comments/1ifyfou/why_im_moving_from_telescope_to_snacks_picker_why/

-- FIXME/2025-02-23: Demo this
if true then return {} end

-- FIXME/2025-02-23: Demo the smart picker, should be *frecency*-esque.
--  snacks.picker.smart
-- - CALSO: https://github.com/danielfalk/smart-open.nvim

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local flash_on_picker = function(picker)
  require("flash").jump({
    pattern = "^",
    label = { after = { 0, 0 } },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
        end,
      },
    },
    action = function(match)
      local idx = picker.list:row2idx(match.pos[1])
      picker.list:_move(idx, true, true)
      -- you can also add auto confirm here
    end,
  })
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        actions = {
          flash = flash_on_picker,
        },
        win = {
          input = {
            keys = {
              ["<a-s>"] = { "flash", mode = { "n", "i" } },
              ["s"] = { "flash" },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>b",
        function()
          Snacks.picker.buffers({
            on_show = function(picker)
              vim.cmd.stopinsert()

              -- you can auto enable it if you want
              vim.schedule(function()
                flash_on_picker(picker)
              end)
            end,
          })
        end,
        desc = "Buffers",
      },
    },
  },
}

