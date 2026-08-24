-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇

-- REFER:
-- https://github.com/saghen/blink.cmp

if not lazy_profile["saghen/blink.cmp"] then
  return {}
end

-- CXREF: Start with nvim-lazyb's blink-cmp.lua, then add a few tweaks:
-- nvim/landonb/nvim-lazyb/lua/plugins/blink-cmp.lua
local M = require("plugins.blink-cmp")

-- SAVVY/2026-08-24: For blink.cmp V2 (AFAIK, LazyVim still using V1?).
table.insert(M, {
  "saghen/blink.lib",
})

table.insert(M, {
  -- CXREF:
  -- ~/.local/share/nvim_lazyb/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/blink.lua @ 16
  "saghen/blink.cmp",

  -- REFER: |blink-cmp-installation|
  -- - Pinning to V1:
  --     branch = "v1",
  --   - Or:
  --     version = "1.*",
  -- - Omit 'branch' and 'version' for V2, but include 'saghen/blink.lib'
  --   plugin, and define 'build' function.
  --
  -- FIXME: FTREQ: Build on DepoXy install...
  -- - Maybe nvim-depoxy OMR 'install' puts cargo on PATH and calls nvim -c.
  --
  -- AWARE: If 'cargo' not on PATH, build silently fails.
  -- - But at least on startup, blink.cmp will message you.
  -- - STEPS: Put 'cargo' on PATH and build manually:
  --   - MANLY:
  --       # DepoXy users: Put 'cargo' on PATH (call lazy-loader).
  --       $ _hf_jit_load_rust
  --       $ nvim
  --     - And then:
  --       :lua require('blink.cmp').build():wait(60000)
  build = function()
    require("blink.cmp").build():pwait()
  end,

  -- REFER: Some other options you could tweak:
  --
  -- opts_extend = {
  --   "sources.completion.enabled_providers",
  --   "sources.compat",
  --   "sources.default",
  -- },
  --
  -- dependencies = {
  --   "rafamadriz/friendly-snippets",
  --   -- add blink.compat to dependencies
  --   {
  --     "saghen/blink.compat",
  --     optional = true, -- make optional so it's only enabled if any extras need it
  --     opts = {},
  --     version = not vim.g.lazyvim_blink_main and "*",
  --   },
  -- },

  event = { "InsertEnter", "CmdlineEnter" },

  -- REFER: |blink-cmp-installation|
  -- https://cmp.saghen.dev/configuration/general
  opts = function(_, opts)
    -- Disable cmdline
    opts.cmdline = { enabled = false }

    -- 'prefix' will fuzzy match on the text before the cursor
    -- 'full' will fuzzy match on the text before _and_ after the cursor
    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    opts.completion.keyword = { range = "full" }

    -- Changes nothing?:
    --
    --   opts.snippets = {
    --     preset = "default",
    --   }

    -- Changes nothing?:
    --
    --   opts.appearance = {
    --     -- sets the fallback highlight groups to nvim-cmp's highlight groups
    --     -- useful for when your theme doesn't support blink.cmp
    --     -- will be removed in a future release, assuming themes add support
    --     use_nvim_cmp_as_default = false,
    --     -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --     -- adjusts spacing to ensure icons are aligned
    --     nerd_font_variant = "mono",
    --   }

    -- USYNC: Same exact opts.sources:
    --   nvim/landonb/nvim-lazyb/lua/plugins/blink-cmp.lua @ 1376
    --   nvim/nvim-depoxy/.config/nvim/lua/specs/spec--blink.cmp.lua @ 103
    opts.sources = {
      -- CALSO: Shouldn't need to set opts.sources.compat or opts.sources.default:
      --
      --   -- adding any nvim-cmp sources here will enable them
      --   -- with blink.compat
      --   -- - ORNOT/2026-08-24:
      --   --   ...local/share/nvim/lazy/blink.lib/lua/blink/lib/config.lua:204: sources.compat: unknown field
      --   --
      --   --  compat = {},
      --
      --   default = { "lsp", "path", "snippets", "buffer" },

      -- REFER: blink's default providers.path.opts:
      --
      --   --- @type blink.cmp.PathOpts
      --   opts = vim.tbl_deep_extend('keep', opts, {
      --     trailing_slash = true,
      --     label_trailing_slash = true,
      --     get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
      --     show_hidden_files_by_default = false,
      --     ignore_root_slash = false,
      --     max_entries = 10000,
      --   })
      --
      -- - CXREF:
      --   ~/.local/share/nvim/lazy/blink.cmp/lua/blink/cmp/sources/path/init.lua @ 23

      -- REFER: :BlinkCmp status
      providers = {
        -- Default object copied (and mostly comment-disabled) from docs
        --   https://cmp.saghen.dev/configuration/reference.html#sources
        path = {
          -- module = "blink.cmp.sources.path",
          -- score_offset = 3,
          -- fallbacks = { "buffer" },
          opts = {
            -- trailing_slash = true,
            -- label_trailing_slash = true,
            -- get_cwd = function(context)
            --   return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            -- end,
            -- -- Default keep hidden hidden:
            -- show_hidden_files_by_default = false,
            show_hidden_files_by_default = true,
            -- -- Treat `/path` as starting from the current working directory
            -- -- (cwd) instead of the root of your filesystem
            -- ignore_root_slash = false,
            -- -- Maximum number of files/directories to return. This limits
            -- -- memory use and responsiveness for very large folders.
            -- max_entries = 10000,
          },
        },
      },
    }
  end,
})

return M
