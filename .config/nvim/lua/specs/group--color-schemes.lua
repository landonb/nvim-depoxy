-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

-- "the colorscheme should be available when starting Neovim"

-- lazy.nvim advises: "make sure we load this during startup
-- if it is your main colorscheme", though works in practice
-- if loaded later, and unclear what *can* go wrong otherwise.
-- - In any case, we list all colorschemes DepoXy installs in
--   this file, and user should pick *one* via lazy_profile.
-- - Note, too, the higher priority: "make sure to load this
--   before all the other start plugins", although, again,
--   unclear with happens in lower priority (because WFM).

local high_priority = 1000

return {
  {
    -- "arcticicestudio/nord-vim",
    dir = "~/.kit/nvim/arcticicestudio/opt/nord-vim",
    lazy = not lazy_profile["nord-vim"],
    priority = high_priority,
    config = function()
      vim.cmd([[colorscheme nord-vim]])
    end,
  },

  {
    -- "flazz/vim-colorschemes",
    dir = "~/.kit/nvim/flazz/opt/vim-colorschemes",
    lazy = not lazy_profile["vim-colorschemes"],
    priority = high_priority,
    -- CXREF: This is a *collection* of colorschemes
    --   ~/.kit/nvim/flazz/start/vim-colorschemes/README.md
    -- - E.g., 'wombat', 'molokai', etc.
    --
    --   config = function()
    --     vim.cmd([[colorscheme wombat]])
    --   end,
  },

  {
    -- "folke/tokyonight.nvim",
    dir = "~/.kit/nvim/folke/tokyonight.nvim",
    lazy = not lazy_profile["tokyonight.nvim"],
    priority = high_priority,
    config = function()
      -- 'tokyonight' is abbrev. for 'tokyonight-moon'
      --    vim.cmd([[colorscheme tokyonight]])
      vim.cmd([[colorscheme tokyonight-moon]])
      --  Here's slighter darker version, night-night:
      --    vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  {
    -- "landonb/dubs_after_dark",
    dir = "~/.kit/nvim/landonb/dubs_after_dark",
    lazy = not lazy_profile["dubs_after_dark"],
    priority = high_priority,
    config = function()
      vim.cmd([[colorscheme after-dark]])
    end,
  },

  {
    -- "nanotech/jellybeans.vim",
    dir = "~/.kit/nvim/nanotech/opt/jellybeans.vim",
    lazy = not lazy_profile["jellybeans.vim"],
    priority = high_priority,
    config = function()
      vim.cmd([[colorscheme jellybeans.vim]])
    end,
  },

  {
    -- "tpope/vim-vividchalk",
    dir = "~/.kit/nvim/tpope/opt/vim-vividchalk",
    lazy = not lazy_profile["vim-vividchalk"],
    priority = high_priority,
    config = function()
      vim.cmd([[colorscheme vim-vividchalk]])
    end,
  },

  {
    "catppuccin/nvim",
    -- Set the name, otherwise Lazy shows as "nvim".
    name = "catppuccin",
    lazy = not lazy_profile["catppuccin/nvim"],
    priority = high_priority,

    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end,

    -- COPYD: From LazyVim:
    -- ~/.local/share/nvim_lazyb/lazy/LazyVim/lua/lazyvim/plugins/colorscheme.lua
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    -- specs = {
    --   {
    --     "akinsho/bufferline.nvim",
    --     optional = true,
    --     opts = function(_, opts)
    --       if (vim.g.colors_name or ""):find("catppuccin") then
    --         opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    --       end
    --     end,
    --   },
    -- },
  },

  -- https://github.com/JoosepAlviste/palenightfall.nvim
  -- BEGET: https://github.com/joosepalviste/dotfiles/
  --   *Thnks fr th Trsttr - Tiny text editing automations with Treesitter*
  --   https://www.youtube.com/watch?v=_m7amJZpQQ8
  {
    "JoosepAlviste/palenightfall.nvim",
    lazy = not lazy_profile["palenightfall.nvim"],
  },

}

