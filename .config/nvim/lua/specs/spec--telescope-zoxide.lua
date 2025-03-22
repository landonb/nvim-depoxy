-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License:

-- INERT/2025-02-23: Wire this.
-- - I don't really care about `cd` from within Neovim.
--   - But a *frecency*/*zoxide* effect for jumping buffers
--     could be interesting... or maybe not, it's not always
--     easy to using a list whose order changes a lot...
--     though if you maintained a database over the long
--     haul, you'd see your most edited notes and code files
--     bubble up to the top, which might at least be
--     at best instructive, or at worst just a curiosity.
if true then return {} end

-- REFER:
-- https://github.com/jvgrootveld/telescope-zoxide

return {
  {
    "jvgrootveld/telescope-zoxide",
  },
}

