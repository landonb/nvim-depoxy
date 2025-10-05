-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

--              🤠
--            💯💯💯
--         💯   💯  💯
--        👇   💯💯  👇
--           💯    💯
--           💯    💯
--           👢    👢

-- :help lir
-- *Q: How do I disable netrw when invoked with `$ nvim /path/to/directory` ?*
-- https://github.com/justinmk/vim-dirvish/issues/213
-- Disable netrw
-- FIXME/2025-01-28 13:19: Unsure about this:
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- CRUMB: #vim_file_browsers

return {

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  -- {
  --   dir = "~/.kit/nvim/jeetsukumaran/start/vim-filebeagle",
  --   lazy = not lazy_profile["vim-filebeagle"],
  -- },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    dir = "~/.kit/nvim/justinmk/start/vim-dirvish",
    lazy = not lazy_profile["vim-dirvish"],
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    dir = "~/.kit/nvim/luukvbaal/start/nnn.nvim",
    lazy = not lazy_profile["nnn.nvim"],
    opts = {},
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    -- :CHADopen :CHADhelp
    dir = "~/.kit/nvim/ms-jpq/start/chadtree",
    lazy = not lazy_profile["chadtree"],
    -- opts = {},
    -- FIXME/2025-01-28 14:31: Works from CLI, untested from config.
    -- - FIXME: Also need to call on update.
    -- build = ":!python3 -m chadtree deps",
    build = ":CHADdeps",
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    dir = "~/.kit/nvim/nvim-lua/start/plenary.nvim",
    lazy = not lazy_profile["plenary.nvim"],
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  -- MAYBE/2025-02-16: This plugin is not too bad.
  -- - Although hidden file colors are a little too dark to see clearly.
  {
    dir = "~/.kit/nvim/nvim-neo-tree/start/neo-tree.nvim",
    lazy = not lazy_profile["neo-tree.nvim"],
    branch = "v3.x",
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   -- not strictly required, but recommended
    --   "nvim-tree/nvim-web-devicons",
    --   "MunifTanjim/nui.nvim",
    --   -- Optional image support in preview window: See `# Preview Mode` for more information
    --   -- https://github.com/3rd/image.nvim
    --   -- DUNNO: Might just work with Kitty, ueberzugpp (Wayland, iTerm2).
    --   -- {"3rd/image.nvim", opts = {}},
    -- }
    dependencies = {
      { dir = "~/.kit/nvim/nvim-lua/start/plenary.nvim" },
      { dir = "~/.kit/nvim/nvim-tree/start/nvim-web-devicons" },
      { dir = "~/.kit/nvim/MunifTanjim/start/nui.nvim" },
    },

    -- config = true,
    config = function()
      require("neo-tree").setup({
        -- default_component_configs = {
        --   name = {
        --     use_git_status_colors = false,
        --   },
        -- },
      })
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    -- REFER:
    -- https://github.com/nvim-telescope/telescope-file-browser.nvim
    -- DUNNO/2025-01-28: Why does it show one dir under user home?
    -- - Where's everything else? Otherwise I want to like this plugin...
    dir = "~/.kit/nvim/nvim-telescope/start/telescope-file-browser.nvim",
    lazy = not lazy_profile["telescope-file-browser.nvim"],

    dependencies = {
      { dir = "~/.kit/nvim/nvim-telescope/start/telescope.nvim" },
      { dir = "~/.kit/nvim/nvim-lua/start/plenary.nvim" },
    },

    -- REFER: https://github.com/nvim-telescope/telescope-file-browser.nvim#setup-and-configuration
    -- You don't need to set any of these options.
    -- IMPORTANT!: this is only a showcase of how you can set default options!
    config = function(_, _opts)
      local fb_actions = require("telescope").extensions.file_browser.actions

      -- SAVVY/2025-01-28: Call vim.keymap.set, not vim.api.nvim_set_keymap.
      -- Latter is part of Neovim API and predates Lua advancements, and
      -- former is Lua-specific interface with a few improvements.
      --   https://www.reddit.com/r/neovim/comments/uuh8xw/noob_vimkeymapset_vs_vimapinvim_set_keymap_key/
      -- Also, with vim.keymap.set, "rhs can be lua function", and mode
      -- can be a list.
      --   https://github.com/neovim/neovim/commit/6d41f65aa45f10a93ad476db01413abaac21f27d

      -- vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
      -- open file_browser with the path of the current buffer
      vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

      -- Alternatively, using lua API
      -- vim.keymap.set("n", "<space>fb", function()
      --   require("telescope").extensions.file_browser.file_browser()
      -- end)

      require("telescope").setup({
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
                -- remap to going to home directory
                -- WTF: What's wrong with this line? Oh, the var??
                -- ["<C-h>"] = fb_actions.goto_home_dir,
                ["<C-h>"] = function(prompt_bufnr)
                  local fb_actions = require("telescope").extensions.file_browser.actions
                  fb_actions.goto_home_dir()
                end,
                ["<C-x>"] = function(prompt_bufnr)
                  -- your custom function
                end,
              },
              ["n"] = {
                -- your custom normal mode mappings
                -- ["<space>fb"] = ":Telescope file_browser<CR>",
                -- -- unmap toggling `fb_actions.toggle_browser`
                -- f = false,
              },
            },
          },
        },
      })

      -- To get telescope-file-browser loaded and working with telescope,
      -- you need to call load_extension, somewhere after setup function:
      --
      require("telescope").load_extension("file_browser")
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    dir = "~/.kit/nvim/nvim-tree/start/nvim-tree.lua",
    lazy = not lazy_profile["nvim-tree.lua"],

    dependencies = {
      { dir = "~/.kit/nvim/nvim-tree/start/nvim-web-devicons" },
    },

    -- -- empty setup using defaults
    -- require("nvim-tree").setup()
    --config = require("nvim-tree").setup,
    --config = require("nvim-tree").setup(),
    opts = {},

    -- config = function(_, _opts)
    --   require("nvim-tree").setup({
    --     sort = {
    --       sorter = "case_sensitive",
    --     },
    --     view = {
    --       width = 30,
    --     },
    --     renderer = {
    --       group_empty = true,
    --     },
    --     filters = {
    --       dotfiles = true,
    --     },
    --   })
    -- end
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    -- https://github.com/nvim-tree/nvim-web-devicons
    dir = "~/.kit/nvim/nvim-tree/start/nvim-web-devicons",
    -- REFER: https://lazy.folke.io/spec/examples — because required
    -- by other modules and is uninteresting on its own (its an "api
    -- plugin"), we can always set lazy=true
    --   lazy = not lazy_profile["nvim-web-devicons"],
    lazy = true,
  },

  {
    -- HSTRY/2025-10-05: Rebranded from echasnovski/mini.icons:
    --   https://github.com/nvim-mini/mini.nvim/discussions/1970
    -- "nvim-mini/mini.icons",
    dir = "~/.kit/nvim/nvim-mini/mini.icons",
    -- lazy = not lazy_profile["mini.icons"],
    lazy = true,

    opts = {},

    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },

    -- COPYD:
    -- https://www.reddit.com/r/neovim/comments/1duf3w7/miniicons_general_icon_provider_several/
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  {
    -- https://github.com/scrooloose/nerdtree
    dir = "~/.kit/nvim/scrooloose/opt/nerdtree",
    lazy = not lazy_profile["nerdtree"],
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  -- *** lir.nvim

  {
    dir = "~/.kit/nvim/tamago324/start/lir.nvim",
    lazy = not lazy_profile["lir.nvim"],

    dependencies = {
      { dir = "~/.kit/nvim/nvim-lua/start/plenary.nvim" },
      { dir = "~/.kit/nvim/nvim-tree/start/nvim-web-devicons" },
    },

    -- REFER: https://github.com/tamago324/lir.nvim
    config = function(_, _opts)
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      -- Open lir like netrw with vinegar or dirvish
      local map = vim.api.nvim_set_keymap
      map("n", "-", [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]], { noremap = true })

      require("lir").setup({
        show_hidden_files = true,
        ignore = {}, -- { ".DS_Store", "node_modules" } etc.
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          -- https://github.com/justinmk/vim-dirvish/issues/213
          ["<CR>"] = actions.edit,
          ["-"] = actions.up,

          ["l"] = actions.edit,

          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["K"] = actions.mkdir,
          ["N"] = actions.newfile,
          ["R"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,

          ["J"] = function()
            mark_actions.toggle_mark()
            vim.cmd("normal! j")
          end,
          ["C"] = clipboard_actions.copy,
          ["X"] = clipboard_actions.cut,
          ["P"] = clipboard_actions.paste,
        },
        -- https://github.com/justinmk/vim-dirvish/issues/213
        -- float = { winblend = 0 }, -- keep float setting even if you don't use it, otherwise it will crash
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = false,
          },

          -- -- You can define a function that returns a table to be passed as the third
          -- -- argument of nvim_open_win().
          -- win_opts = function()
          --   local width = math.floor(vim.o.columns * 0.8)
          --   local height = math.floor(vim.o.lines * 0.8)
          --   return {
          --     border = {
          --       "+", "─", "+", "│", "+", "─", "+", "│",
          --     },
          --     width = width,
          --     height = height,
          --     row = 1,
          --     col = math.floor((vim.o.columns - width) / 2),
          --   }
          -- end,
        },
        hide_cursor = true,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "lir" },
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
        end,
      })

      -- custom folder icon
      require("nvim-web-devicons").set_icon({
        lir_folder_icon = {
          icon = "",
          color = "#7ebae4",
          name = "LirFolderNode",
        },
      })
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
}
