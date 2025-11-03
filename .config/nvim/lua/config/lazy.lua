-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- USAGE: Create plugin specs in ~/.config/nvim/lua/specs/
--
-- - Each file returns a table with the plugins to install.
--
-- SETUP: After fiddling with plugins, run health check:
--
--   :checkhealth lazy

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- FTREQ/2025-02-21: Enable lua_ls, and lint, and add annotations:
-- https://luals.github.io/wiki/annotations/
-- - Probably also add tests but that's a lesser priority.

---@class NvimDepoxy.Lazy
---@field defaults table<string, string>
local M = {}

M.defaults = {
  profile = "maximal", ---@type "minimal" | "midimal" | "maximal"
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- COPYD: https://lazy.folke.io/installation

-- REFER: Installs to ~/.local/share/nvim/lazy/lazy.nvim/
--
-- - Specs that need to be downloaded are also cloned thereunder:
--     ~/.local/share/nvim/
--   per:
--      vim.fn.stdpath("data")
--   at least that's the path on macOS (& prob. Linux).
--
-- - ASIDE: Config path is :echo stdpath('config'), e.g.,
--     ~/.config/nvim
--   aka :lua print(vim.fn.stdpath('config'))

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- MAYBE/2025-01-28 17:27: Or maybe called from init.lua:
--
-- require("modules.neovide")

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- COPYD: https://lazy.folke.io/installation

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--   vim.g.mapleader = " "
--   vim.g.maplocalleader = "\\"

-- I know a lot of people and distros use space for
-- leader, or even semicolon (or colon!), or dot.
-- But many of the maps defined by nvim-depoxy are
-- available from Insert mode, which makes backward
-- slash the obvious choice.
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
function M.lazy_setup()
  require("lazy").setup({
    spec = {
      -- import your plugins
      -- REFER: ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/specs/*.lua
      { import = "specs" },
    },
    -- Configure any other settings here. See the documentation for more details.

    -- https://lazy.folke.io/configuration
    dev = {
      -- Directory where you store your local plugin projects. If a function is used,
      -- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
      ---@type string | fun(plugin: LazyPlugin): string
      --
      -- FIXME/2025-01-30: MAYBE: Flatten ~/.kit/nvim subdirs (remove start/ and opt/)
      -- and use dev.path and dev.patterns to use local paths, and maybe set
      -- dev.fallback=true, so that I can replace { dev = "~/.kit/nvim/org/start/plug" }
      -- with a more universal and concise { "org/plug" } config
      path = "~/.kit/nvim",
      ---@type string[] plugins that match these patterns will use your
      ---local versions instead of being fetched from GitHub
      patterns = {}, -- For example {"folke"}
      fallback = false, -- Fallback to git when local plugin doesn't exist
    },

    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?

    -- automatically check for plugin updates
    checker = { enabled = false },

    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = true,
      -- It's not terrible, in theory, to be notified init.lua changes,
      -- e.g.,
      --   # Config Change Detected. Reloading...
      --
      --   - **changed**: `~/.config/nvim/lua/specs/group--most-entirely.lua`
      -- but because multiple lines, blocks Vim and requires confirmation.
      -- - Also if you open a file from the terminal, and the target editor
      --   is blocked on a prompt, the terminal window is hung (and the screen
      --   is blank, oddly, but returns when you unblock Neovim).
      notify = false, -- get a notification when changes are found
    },

    performance = {
      cache = {
        enabled = true,
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
        reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
        ---@type string[]
        paths = {}, -- add any custom paths here that you want to includes in the rtp
        ---@type string[] list any plugins you want to disable here
        disabled_plugins = {
          -- "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          -- "tarPlugin",
          -- "tohtml",
          -- "tutor",
          -- "zipPlugin",
        },
      },
    },

    -- colorscheme that will be used when installing plugins.
    -- SPIKE/2025-02-01: What does "will be used" mean?
    -- - I.e., other than calling :colorscheme, how is it used?
    --   - Does it matter when loading any plugin what the colorscheme is?
    --
    -- REFER: https://github.com/ntk148v/habamax.nvim
    --  install = { colorscheme = { "habamax" } },
    --  checker = { enabled = true },
    --
    -- FIXME/2025-02-01 13:26: Should match what's set in lazy_profile
    -- - SAVVY: Note this value doesn't matter if a lazy-load spec
    --   calls |colorscheme| from its config() fnc.
    --   - Which you're suppose to do, anyway, so not sure if setting
    --     here has some other intention.
    --   - CXREF:
    --     ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/specs/group--color-schemes.lua
    install = { colorscheme = { "after-dark" } },
  })
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

---@param opts? NvimDepoxy.Lazy
function M.setup(opts)
  local options = vim.tbl_deep_extend("force", M.defaults, opts or {})

  -- - REFER: See DepoXy NVD_PROFILE usage.
  --  print("options.profile: " .. options.profile)
  lazy_profile = require("config.profile"):profile(options.profile)

  M.lazy_setup()
end

-- M.setup(
--   { profile = vim.env.NVD_PROFILE and vim.env.NVD_PROFILE or "maximal" }
-- )

return M
