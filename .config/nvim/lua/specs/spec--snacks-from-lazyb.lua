-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: Unlicensed...

if not lazy_profile["folke/snacks.lua"] then
  return {}
end

-- CXREF: Load nvim-lazyb's snacks.lua:
-- nvim/landonb/nvim-lazyb/lua/plugins/snacks.lua
local M = require("plugins.snacks")

-- INERT: Extend it, e.g.
--
--   table.insert(M, {
--     "folke/snacks.lua",
--     build = function()
--       require("snacks").build():pwait()
--     end,
--     event = { "InsertEnter", "CmdlineEnter" },
--     opts = function(_, opts)
--       opts.foo = { enabled = false }
--     end,
--   })

return M
