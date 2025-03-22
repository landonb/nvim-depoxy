-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇

-- FIXME/2025-01-31 22:06: Decide:
-- License: MIT
-- License: https://creativecommons.org/publicdomain/zero/1.0/

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- -- essentials
-- vim.g.mapleader = ","
-- vim.g.maplocalleader = ","
-- vim.opt.termguicolors = true

-- As suggested by |nvim-tree-quickstart-setup|
-- https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
-- optionally enable 24-bit colour
-- SPIKE: It's probably already enabled?
--  -- lua print(vim.inspect(vim.opt.termguicolors))
--  vim.opt.termguicolors = true

-- DUNNO/2025-02-01 10:15: Why did I care about this?
-- FIXME/2025-01-25 19:07: Test, then REMOVE THIS:
--  vim.g.loaded_matchparen = 1

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- FTREQ/2025-01-31: Remove start/ and opt/ intermediates.
-- - NTHEN: Rely on lazy.cfg.dev.path with GH fallback:
--   - Use this format:
--       "folke/tokyonight.nvim",
--     Instead of this:
--       dir = "~/.kit/nvim/folke/tokyonight.nvim",
-- - REFER: On macOS (& prob. Linux), GH "org/proj" format
--   installs to:
--     ~/.local/share/nvim/lazy/lazy.nvim/tokyonight.nvim/
--   - SPIKE: Does lazy.nvim use lazy.cfg.dev.path for this?
--     - Probably not...
--     - One idea: symlink ~/.loca/share path to ~/.kit/nvim ?

-- REFER: See lazy.nvim docs for spec def'n and examples:
-- https://lazy.folke.io/spec/examples

return {
  -- ------------------------------------------------------------
  -- ------------------------------------------------------------

  {
    -- REFER: On macOS (& prob. Linux), installs to:
    --   ~/.local/share/nvim/lazy/lazy.nvim/vim-startuptime/
    -- "dstein64/vim-startuptime",
    dir = "~/.kit/nvim/dstein64/vim-startuptime",
    -- "lazy-load on a command"
    cmd = "StartupTime",
    -- "init is called during startup. Configuration for vim plugins
    --  typically should be set in an init function"
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- ------------------------------------------------------------
  -- ------------------------------------------------------------

  -- CXREF/2025-01-31: Mostly matches OMR config order (which is
  --                   mostly alphabetical):
  --   ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-3rdp
  --   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_3rdp.vim
  --
  -- - CPYST: See list of "active" plugins (assumes under start/ dirs):
  --     grep "^\[.*/start/.*\]" ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-3rdp
  -- - CPYST: See list of "active" plugins (assumes uses mr_exclusive tag):
  --     MR_INCLUDE=vim_active mr -d ~/.kit/nvim run sh -c 'echo "${MR_REPO}"'

  {
    dir = "~/.kit/nvim/cespare/start/vim-toml",
    lazy = not lazy_profile["vim-toml"],
  },

  {
    dir = "~/.kit/nvim/chrisbra/start/matchit",
    lazy = not lazy_profile["matchit"],
  },

  {
    dir = "~/.kit/nvim/easymotion/start/vim-easymotion",
    lazy = not lazy_profile["vim-easymotion"],
  },

  {
    dir = "~/.kit/nvim/editorconfig/start/vim-go",
    lazy = not lazy_profile["vim-go"],
  },

  {
    dir = "~/.kit/nvim/editorconfig/start/editorconfig-vim",
    lazy = not lazy_profile["editorconfig-vim"],
  },

  {
    dir = "~/.kit/nvim/folke/flash.nvim",
    lazy = not lazy_profile["flash.nvim"],
    -- event = "VeryLazy",

    ---@type Flash.Config
    opts = {},
    -- SAVVY: Even if `lazy = true`, these keys still mapped, and because
    -- of the `require("flash")`, the plugin will be loaded when you press
    -- 's' if not already loaded.
    keys = {
      -- BWARE/2025-02-12: Using "o" mode w/ "s" or "S" conflicts with
      -- vim-surround (e.g., `ysiw"` to you-surround-inner-word-doublequote
      -- starts flash.nvim when `s` is pressed.
      -- - SPIKE: How does flash.nvim work as operator-pending function?
      --   Is it a usefule feature?
      --
      --   { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      --   { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      {
        "s",
        mode = { "n" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- folke/tokyonight.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #colorscheme_plugins

  -- folke/lazy.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - lazy.nvim loaded by config/*.lua (it's what loads this file!).

  {
    -- "ggandor/leap.nvim",
    dir = "~/.kit/nvim/ggandor/start/leap.nvim",
    lazy = not lazy_profile["leap.nvim"],

    -- THANX: https://github.com/LazyVim/LazyVim/issues/2379#issuecomment-1898491969
    --   https://github.com/ggandor/leap.nvim/issues/191
    config = function(_, opts)
      local leap = require("leap")
      -- DUNNO/2025-01-26 16:25: Where do opts come from?
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      --leap.add_default_mappings(true)

      -- From LazyVim issue, pretty sure I don't need
      -- vim.keymap.del({ "x", "o" }, "x")
      -- vim.keymap.del({ "x", "o" }, "X")
      -- vim.keymap.set("n", "s", function()
      --   require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
      -- end)

      -- 2025-01-26 16:35: Cleanup flash.nvim bindings so I
      -- don't have to restart Vim...
      if false then
        vim.keymap.del({ "n", "x", "o" }, "s")
        vim.keymap.del({ "n", "x", "o" }, "S")
      end

      -- FIXME/2025-01-26 16:46: Combine with flash.nvim, because
      -- I like the Tree-sitter motions from flash, but I might
      -- like the two-letter search and feels-like-vim-sneak
      -- appeal of leap.nvim.

      -- leap.create_default_mappings():
      --   vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
      --   vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
      --   vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
      -- REFER: See other config options/ideas:
      -- https://github.com/ggandor/leap.nvim?tab=readme-ov-file#installation
      if false then
        -- FIXME: Set different maps for flash.nvim then compare UX and choose
        leap.create_default_mappings()
      end

      -- *** Suggestions from lazy.nvim README

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group:
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

      -- Use the traversal keys to repeat the previous motion without
      -- explicitly invoking Leap:
      -- DUNNO/2025-01-26 16:40: I like these, but maybe <F> and <S-F> keys...
      --
      -- FIXME/2025-01-26 17:02: Find a spot for these...
      --   require('leap.user').set_repeat_keys('<enter>', '<backspace>')

      -- Define a preview filter (skip the middle of alphanumeric words):
      require("leap").opts.preview_filter = function(ch0, ch1, ch2)
        return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
      end

      -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++

      -- REFER:
      -- https://github.com/ggandor/leap.nvim?tab=readme-ov-file#extending-leap

      local function get_line_starts(winid, skip_range)
        local wininfo = vim.fn.getwininfo(winid)[1]
        local cur_line = vim.fn.line(".")
        -- Skip lines close to the cursor.
        local skip_range = skip_range or 2

        -- Get targets.
        local targets = {}
        local lnum = wininfo.topline
        while lnum <= wininfo.botline do
          local fold_end = vim.fn.foldclosedend(lnum)
          -- Skip folded ranges.
          if fold_end ~= -1 then
            lnum = fold_end + 1
          else
            if (lnum < cur_line - skip_range) or (lnum > cur_line + skip_range) then
              table.insert(targets, { pos = { lnum, 1 } })
            end
            lnum = lnum + 1
          end
        end

        -- Sort them by vertical screen distance from cursor.
        local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
        local function screen_rows_from_cur(t)
          local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
          return math.abs(cur_screen_row - t_screen_row)
        end
        table.sort(targets, function(t1, t2)
          return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
        end)

        if #targets >= 1 then
          return targets
        end
      end

      -- You can pass an argument to specify a range to be skipped
      -- before/after the cursor (default is +/-2).
      function leap_line_start(skip_range)
        local winid = vim.api.nvim_get_current_win()
        require("leap").leap({
          target_windows = { winid },
          targets = get_line_starts(winid, skip_range),
        })
      end

      -- FIXME/2025-01-26 19:13: Add jumping to line without selection.
      -- - MAYBE: Use vim-sneak for that, or was it vim-easymotion.
      --   - I'd guess that leap can do it, too, but not sure how;
      --     but I know how to do it with another plugin.

      -- This is an awesome linewise Visual select that prompts
      -- for the line using a letter mark, so much easier than
      -- counting lines to use a number modifier.
      -- - SAVVY: In stock nvim, ``v|`` selects to the start of the
      --          line (though I didn't check docs; I just demoed).
      --
      -- "For maximum comfort, force linewise selection in the mappings:"
      vim.keymap.set("x", "|", function()
        -- Only force V if not already in it (otherwise it would exit Visual mode).
        if vim.fn.mode(1) ~= "V" then
          vim.cmd("normal! V")
        end
        leap_line_start()
      end)
      vim.keymap.set("o", "|", "V<cmd>lua leap_line_start()<cr>")

      -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++
    end,
  },

  -- https://github.com/glacambre/firenvim/
  -- https://chromewebstore.google.com/detail/firenvim/egpjdkipkomnmjhjmdamaniclmdlobbo?pli=1
  -- https://addons.mozilla.org/en-US/firefox/addon/firenvim/
  {
    -- "glacambre/firenvim",
    dir = "~/.kit/nvim/glacambre/firenvim",
    lazy = true,

    build = ":call firenvim#install(0)",
  },

  -- *Vim script for text filtering and alignment*
  {
    dir = "~/.kit/nvim/godlygeek/start/tabular",
    lazy = not lazy_profile["tabular"],
  },

  -- *Yet Another TypeScript Syntax*
  {
    dir = "~/.kit/nvim/HerringtonDarkholme/start/yats.vim",
    lazy = not lazy_profile["yats.vim"],
  },

  {
    dir = "~/.kit/nvim/jamessan/start/vim-gnupg",
    lazy = not lazy_profile["vim-gnupg"],
  },

  -- jeetsukumaran/vim-filebeagle
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  -- *Show coverage information generated by Istanbul*
  {
    dir = "~/.kit/nvim/juanpabloaj/start/vim-istanbul",
    lazy = not lazy_profile["vim-istanbul"],
  },

  {
    dir = "~/.kit/nvim/junegunn/start/fzf.vim",
    lazy = not lazy_profile["fzf.vim"],

    -- keys = {
    --   -- -- GROUP: #vim_buffer_picker
    --   -- { "__", mode = { "n" }, '<cmd>:Buffers<CR>', desc = "FZF buffer picker" },
    -- },
  },

  -- *Hyperfocus-writing in Vim.*
  -- - CALSO: Zen mode (incl. in LazyVim).
  {
    dir = "~/.kit/nvim/junegunn/start/limelight.vim",
    lazy = not lazy_profile["limelight.vim"],
  },

  -- junegunn/vim-plug
  --
  -- This comment added for parity with the OMR and vim-plug configs.

  -- justinmk/vim-dirvish
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  {
    dir = "~/.kit/nvim/justinmk/start/vim-sneak",
    lazy = not lazy_profile["vim-sneak"],
  },

  -- luukvbaal/nnn.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  {
    dir = "~/.kit/nvim/majutsushi/start/tagbar",
    lazy = not lazy_profile["tagbar"],
  },

  {
    dir = "~/.kit/nvim/MaxMEllon/start/vim-jsx-pretty",
    lazy = not lazy_profile["vim-jsx-pretty"],
  },

  -- ms-jpq/chadtree
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  -- FIXME/2025-02-01: Compare to NERDCommenter, and to
  --                   Neovim's built-in Visual mode gc
  {
    dir = "~/.kit/nvim/numToStr/start/Comment.nvim",
    lazy = not lazy_profile["Comment.nvim"],

    config = true,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  -- nvim-lua/plenary.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers (dependency of)

  -- nvim-neo-tree/neo-tree.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  -- nvim-telescope/telescope-file-browser.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  -- nvim-telescope/telescope.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers (dependency of)

  -- nvim-tree/nvim-tree.lua
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  -- nvim-tree/nvim-web-devicons
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers (dependency of)

  -- nvim-treesitter/nvim-treesitter
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CXREF:
  --   ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/minimal/nvim-treesitter.lua

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  -- CHOSN/2025-01-23: Not sure if they'd work in concert or not,
  --   but disabled pangloss/vim-javascript to ensure no conflict
  --   with yuezk/vim-js. See profile non-enablement:
  --   ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/config/profile.lua
  {
    dir = "~/.kit/nvim/pangloss/start/vim-javascript",
    lazy = not lazy_profile["vim-javascript"],
  },

  -- USDBY: \cs
  -- - SAVVY: Neovim has built-in gc{motion} comment/uncomment command.
  -- INERT: Move map def'n herein.
  -- - CXREF:
  --   ~/.kit/nvim/landonb/nvim-lazyb/lua/plugins/nerdcommenter.lua
  {
    dir = "~/.kit/nvim/preservim/nerdcommenter",
    lazy = not lazy_profile["nerdcommenter"],

    -- CXREF: | FTREQ: Pull that config into a config() or opts{}:
    --   ~/.kit/nvim/DepoXy/start/vim-depoxy/plugin/nerdcommenter-config.vim
    -- and probably move spec to:
    --   ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/specs/spec--nerdcommenter.lua

    init = function()
      vim.g.NERDCreateDefaultMappings = 0
    end,
  },

  {
    dir = "~/.kit/nvim/preservim/vim-markdown",
    lazy = not lazy_profile["vim-markdown"],

    dependencies = {
      { dir = "~/.kit/nvim/godlygeek/start/tabular" },
    },
  },

  {
    -- ISOFF/2025-02-12: This has a few usability issues, e.g.,
    --   https://github.com/samoshkin/vim-mergetool/issues/27
    -- also I almost always have to hand-edit conflicts. So I
    -- don't really need a git-mergetool tool.
    dir = "~/.kit/nvim/samoshkin/start/vim-mergetool",
    lazy = not lazy_profile["vim-mergetool"],

    dependencies = {
      -- :MergetoolToggle assumes cwd/lcd is set to repo root.
      { dir = "~/.kit/nvim/landonb/vim-lcd-project-root" },
    },
  },

  -- tamago324/lir.nvim
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #vim_file_browsers

  {
    dir = "~/.kit/nvim/tpope/start/vim-abolish",
    lazy = not lazy_profile["vim-abolish"],
  },

  {
    dir = "~/.kit/nvim/tpope/start/vim-fugitive",
    lazy = not lazy_profile["vim-fugitive"],
  },

  {
    dir = "~/.kit/nvim/tpope/start/vim-jdaddy",
    lazy = not lazy_profile["vim-jdaddy"],
  },

  {
    dir = "~/.kit/nvim/tpope/opt/vim-pathogen",
    lazy = not lazy_profile["vim-pathogen"],
  },

  {
    dir = "~/.kit/nvim/tpope/start/vim-rails",
    lazy = not lazy_profile["vim-rails"],
  },

  {
    dir = "~/.kit/nvim/tpope/start/vim-repeat",
    lazy = not lazy_profile["vim-repeat"],
  },

  -- *use CTRL-A/CTRL-X to increment dates, times, and more*
  {
    dir = "~/.kit/nvim/tpope/start/vim-speeddating",
    lazy = not lazy_profile["vim-speeddating"],

    dependencies = {
      { dir = "~/.kit/nvim/tpope/start/vim-repeat" },
    },
  },

  -- netrw "salad dressing"
  {
    -- https://github.com/tpope/vim-vinegar
    dir = "~/.kit/nvim/tpope/start/vim-vinegar",
    lazy = not lazy_profile["vim-vinegar"],
  },

  -- USDBY: \dC (Bdelete)
  {
    dir = "~/.kit/nvim/vim-scripts/start/bbye",
    lazy = not lazy_profile["bbye"],
  },

  -- USDBY: <Alt-f>o, <Alt-f>e (BufOnly)
  {
    dir = "~/.kit/nvim/vim-scripts/start/BufOnly.vim",
    lazy = not lazy_profile["BufOnly.vim"],
  },

  {
    dir = "~/.kit/nvim/vim-scripts/start/ZoomWin",
    lazy = not lazy_profile["ZoomWin"],
  },

  {
    dir = "~/.kit/nvim/voithos/start/vim-python-matchit",
    lazy = not lazy_profile["vim-python-matchit"],
  },

  {
    dir = "~/.kit/nvim/yuezk/start/vim-js",
    lazy = not lazy_profile["vim-js"],
  },

  -- ------------------------------------------------------------
  -- ------------------------------------------------------------

  -- CXREF/2025-01-31: Mostly matches OMR config order (which is
  --                   mostly alphabetical):
  --   ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-dubs
  --   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_dubs.vim

  {
    dir = "~/.kit/nvim/DepoXy/start/vim-clip-expand-path",
    lazy = not lazy_profile["vim-clip-expand-path"],
  },

  {
    dir = "~/.kit/nvim/DepoXy/start/vim-depoxy-coc-defaults",
    lazy = not lazy_profile["vim-depoxy-coc-defaults"],
  },

  {
    dir = "~/.kit/nvim/landonb/ansible-vim",
    lazy = not lazy_profile["ansible-vim"],
  },

  -- landonb/dubs_after_dark
  --
  -- This comment added for parity with the OMR and vim-plug configs.
  -- - CRUMB: #colorscheme_plugins

  {
    dir = "~/.kit/nvim/landonb/dubs_appearance",
    lazy = not lazy_profile["dubs_appearance"],
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_edit_juice",
    lazy = not lazy_profile["dubs_edit_juice"],

    init = function()
      vim.g.dubs_edit_juice_everything = true
    end,

    config = function(lazy_cfg, user_opts)
      if not lazy_profile["vim-async-map"] then
        vim.cmd("iabbrev <expr> 3t '################<CR>' . strftime('%Y-%m-%d %H:%M') . '<CR>################<CR>'")
      end

      -- REFER/2025-02-07: Some nifty abbreviation ideas:
      -- https://www.reddit.com/r/neovim/comments/16mijcz/anyone_here_use_iabbrev/
      -- - One user uses comma leader beause "I will never type comma
      --   without space in normal text or code."
      vim.cmd("inoreabbrev <expr> ,u system('uuidgen')->trim()->tolower()")

      -- FINLY/2025-02-10: Not sure why I haven't abbrev'd this 'til now.
      vim.cmd("cnoreabbrev TM TabMessage")
    end,

    keys = {
      {
        "<LocalLeader>dM",
        mode = { "n", "i" },
        "<cmd>TabMessage messages<CR>",
        desc = ":TabMessage messages",
      },
    },
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_ftype_mess",
    lazy = not lazy_profile["dubs_ftype_mess"],
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_grep_steady",
    lazy = not lazy_profile["dubs_grep_steady"],

    config = function()
      local wk = require("which-key")
      wk.add({
        mode = { "n", "i", "v" },
        { "<LocalLeader>g", desc = "Grep-Steady Prompt Term/Locat" },
        { "<LocalLeader>G", desc = "Grep-Steady Case-Sensitive" },
        { "<LocalLeader>C", desc = "Grep-Steady First Hits Only" },
        { "<F4>", desc = "Grep-Steady Word or Selection" },
        { "<S-F4>", desc = "Grep-Steady Prompt Location" },
        { "<M-F4>", desc = "Grep-Steady Prompt Word" },
        { "<LocalLeader>dg", desc = "Grep-Steady Toggle Multicase" },
        { "<LocalLeader>dn", desc = "Grep-Steady Toggle Col Numbs" },
        { "<LocalLeader>dp", desc = "Grep-Steady Reload Projects" },
        { "<LocalLeader>dP", desc = "Grep-Steady Edit Projects" },
      })
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_html_entities",
    -- Load when key map used.
    --  lazy = not lazy_profile["dubs_html_entities"],
    keys = {
      {
        mode = { "n" },
        "<LocalLeader>dh",
        [[<cmd>exec "normal \<Plug>DubsHtmlEntities_ToggleLookup"<CR>]],
        silent = true,
        desc = "HTML Entities Lookup",
      },
      {
        mode = "n",
        "<LocalLeader>dH",
        "<Plug>DubsHtmlEntities_QuickLookup",
        silent = true,
        desc = "HTML Entities Prompt",
      },
    },
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_mescaline",
    lazy = not lazy_profile["dubs_mescaline"],

    dependencies = {
      -- FIXME/2025-02-13 10:27: Document this dep.
      { dir = "~/.kit/nvim/tpope/start/vim-fugitive" },
    },

    config = function()
      vim.fn["embrace#mescaline#Setup"]({
        mescaline_disable = false,
        clock_enable = true,
        clock_rate = 2500,
        git_icon = "",
      })
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_project_tray",
    lazy = not lazy_profile["dubs_project_tray"],
    init = function()
      -- CXREF:
      -- ~/.kit/nvim/landonb/dubs_project_tray/plugin/dubs_project.vim @ 72
      vim.g.proj_flags = "imstB"
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_quickfix_wrap",
    lazy = not lazy_profile["dubs_quickfix_wrap"],

    config = function()
      local group = vim.api.nvim_create_augroup("nvim_depoxy_qf_au", { clear = true })

      -- 2016.01.27: Avoid distracting spell check, esp. when search results is code.
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = { "quickfix" },
        callback = function()
          vim.bo.spell = false
        end,
      })
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_style_guard",
    lazy = not lazy_profile["dubs_style_guard"],
  },

  {
    dir = "~/.kit/nvim/landonb/dubs_toggle_textwrap",
    lazy = not lazy_profile["dubs_toggle_textwrap"],
  },

  {
    dir = "~/.kit/nvim/landonb/QFEnter",
    lazy = not lazy_profile["QFEnter"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-async-map",
    lazy = not lazy_profile["vim-async-map"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-better-file-changed-prompt",
    lazy = not lazy_profile["vim-better-file-changed-prompt"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-blinky-search",
    lazy = not lazy_profile["vim-blinky-search"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-buffer-delights",
    lazy = not lazy_profile["vim-buffer-delights"],

    init = function()
      -- Disable `__` and `<S-F2>` :ls|:b commands.
      vim.g.vim_buffer_delights_disable_fzf_buffers = 1
    end,

    keys = {
      { "<leader>d1", mode = { "n", "i" }, "<cmd>1wincmd w<CR>", desc = "Window #1 jumper" },
      { "<leader>d2", mode = { "n", "i" }, "<cmd>2wincmd w<CR>", desc = "Window #2 jumper" },
      { "<leader>d3", mode = { "n", "i" }, "<cmd>3wincmd w<CR>", desc = "Window #3 jumper" },
      { "<leader>d4", mode = { "n", "i" }, "<cmd>4wincmd w<CR>", desc = "Window #4 jumper" },
      { "<leader>d5", mode = { "n", "i" }, "<cmd>5wincmd w<CR>", desc = "Window #5 jumper" },
      { "<leader>d6", mode = { "n", "i" }, "<cmd>6wincmd w<CR>", desc = "Window #6 jumper" },
      { "<leader>d7", mode = { "n", "i" }, "<cmd>7wincmd w<CR>", desc = "Window #7 jumper" },
      { "<leader>d8", mode = { "n", "i" }, "<cmd>8wincmd w<CR>", desc = "Window #8 jumper" },
      { "<leader>d9", mode = { "n", "i" }, "<cmd>9wincmd w<CR>", desc = "Window #9 jumper" },
    },
  },

  {
    dir = "~/.kit/nvim/landonb/vim-buffer-ring",
    lazy = not lazy_profile["vim-buffer-ring"],

    -- CXREF: Wire a map to show buffer history list.
    -- - FIXME: Add other maps here, too...
    -- ~/.kit/nvim/landonb/vim-buffer-ring/autoload/embrace/bufsurf.vim
    --
    -- DUNNO/2025-02-05: Neovim inhibits output when you use vim.keymap.set
    -- and hides messages — which user can view using :messages. But that's
    -- not helpful if point of command is show the user some output!
    -- - I fount at least 2 work-arounds, though.
    -- - ALTLY: Use a floating window or some other mechanism.
    --
    -- - BWARE: Sends output directly to messages, so user won't see it
    --   unless they run :messages
    --
    --     lua vim.keymap.set("n", "<Leader>db", function()
    --       vim.api.nvim_call_function("g:embrace#bufsurf#BufferRingListAll", {})
    --     end, { silent = false })
    --
    -- - BWARE: Quietly prints to messages; you won't see anything unless `:messages`:
    --
    --     lua vim.keymap.set("n", "<Leader>db", function() print("foo\nbar\nbaz\n") end, { silent = false })
    --
    -- - WORKS: Calling `nvim_set_keymap` directory works (albeit the Lua
    --   string you pass it is less Lua-like than using a function () end.
    --
    --     lua vim.api.nvim_set_keymap("n", "<leader>db",
    --       '<cmd>lua vim.api.nvim_call_function("g:embrace#bufsurf#BufferRingListAll", {})<CR>', {})
    --
    -- - WORKS: You can also thunk back to classic Vim, e.g., this also works:
    --
    --    lua vim.cmd('nnoremap <silent> <leader>db :call g:embrace#bufsurf#BufferRingListAll()<CR>')
    --
    -- - WRKLG/2025-02-05: Ugh, for posterity:
    --
    --     keys__WRONG = {
    --       {
    --         "<leader>db", mode = { "n", "i" }, function()
    --           -- DUNNO/2025-02-05: This all prints silently to :messages.
    --           local foo = vim.api.nvim_call_function("g:embrace#bufsurf#BufferRingListAll", {})
    --           print('foo/1: ' .. vim.inspect(foo))
    --
    --           vim.api.nvim_echo({{'foo!'}}, true, {verbose = false})
    --
    --           -- Vim:E121: Undefined variable: call
    --           --   local foo = vim.api.nvim_eval('call g:embrace#bufsurf#BufferRingListAll()')
    --           local foo = vim.api.nvim_eval('g:embrace#bufsurf#BufferRingListAll()')
    --           print('foo/2: ' .. vim.inspect(foo))
    --
    --           local output = vim.api.nvim_exec2('call g:embrace#bufsurf#BufferRingListAll()', {output = true})
    --           print('output: ' .. vim.inspect(output))
    --           print(output.output)
    --           print('- done')
    --         end, desc = "BufferRingListAll"
    --       },
    --     },
    --
    --     config__WORKS = function()
    --       vim.cmd('nnoremap <silent> <leader>db :call g:embrace#bufsurf#BufferRingListAll()<CR>')
    --       vim.cmd('inoremap <silent> <leader>db :<C-O>call g:embrace#bufsurf#BufferRingListAll()<CR>')
    --     end,
    keys = {
      {
        "<leader>db",
        mode = { "n", "i" },
        -- SPIKE/2025-02-05: Why does using closure inhibit user seeing
        -- messages and needing to acknowledge &more prompt? E.g., this:
        --   function() vim.api.nvim_call_function()...  end,
        -- vs. this:
        '<cmd>lua vim.api.nvim_call_function("g:embrace#bufsurf#BufferRingListAll", {})<CR>',
        desc = "BufferRingListAll",
      },
      -- CXREF: For parity with nvim-lazyb:
      -- ~/.kit/nvim/landonb/nvim-lazyb/lua/plugins/buffer-ring.lua
      { "<M-;>", "<cmd>:BufferRingReverse<CR>", desc = "Buffer Ring Reverse", mode = { "n", "i" } },
      { "<M-'>", "<cmd>:BufferRingForward<CR>", desc = "Buffer Ring Forward", mode = { "n", "i" } },
      { "", "<cmd>:BufferRingReverse<CR>", desc = "Buffer Ring Reverse", mode = { "n", "i" } },
      { "", "<cmd>:BufferRingForward<CR>", desc = "Buffer Ring Forward", mode = { "n", "i" } },
    },
  },

  {
    dir = "~/.kit/nvim/landonb/vim-classic-taglist",
    lazy = not lazy_profile["vim-classic-taglist"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-command-line-clock",
    lazy = not lazy_profile["vim-command-line-clock"],

    config = function()
      vim.fn["embrace#command_line_clock#CreateMaps"]()

      vim.fn.timer_start(1000, function()
        vim.fn["embrace#command_line_clock#Start"]()
      end)
    end,
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-fullscreen-toggle",
    lazy = not lazy_profile["vim-fullscreen-toggle"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-goto-file-sh",
    lazy = not lazy_profile["vim-goto-file-sh"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-lcd-project-root",
    lazy = not lazy_profile["vim-lcd-project-root"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-mkspell-when-stale",
    lazy = not lazy_profile["vim-mkspell-when-stale"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-netrw-cfg-split-explorer",
    lazy = not lazy_profile["vim-netrw-cfg-split-explorer"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-netrw-explore-map",
    lazy = not lazy_profile["vim-netrw-explore-map"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-netrw-link-resolve",
    lazy = not lazy_profile["vim-netrw-link-resolve"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-ovm-easyescape-kj-jk",
    lazy = not lazy_profile["vim-ovm-easyescape-kj-jk"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-ovm-seven-of-spines",
    lazy = not lazy_profile["vim-ovm-seven-of-spines"],

    -- CXREF:
    -- ~/.kit/nvim/landonb/vim-ovm-seven-of-spines/plugin/vim_ovm_seven_of_spines.vim
    config = function()
      local wk = require("which-key")
      wk.add({
        mode = { "n", "i" },
        { "<C-->", desc = "Write Seven Dashes" },
      })
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/vim-reSTfold",
    lazy = not lazy_profile["vim-reSTfold"],

    init = function()
      -- FIXME/2025-02-05 11:19: Will this improve performance?
      -- - You'll see 2 pages of `syn` items vs. over a dozen!
      --   - `syn` output fills 48 pages!!! (~70 line height).
      -- - Or maybe not, I had already been restricting it to
      --   just 3 items = ['bash', 'javascript', 'python']
      --     ~/.kit/nvim/landonb/dubs_ftype_mess/plugin/dubs_preloads.vim
      --   - `syn` output fills 8 pages (~70 line height).
      -- - When vim.g.rst_syntax_code_list is empty table:
      --   - `syn` output fills 3 pages (~70 line height).
      --
      -- let g:rst_syntax_code_list = {
      --     \ 'vim': ['vim'],
      --     \ 'java': ['java'],
      --     \ 'cpp': ['cpp', 'c++'],
      --     \ 'lisp': ['lisp'],
      --     \ 'php': ['php'],
      --     \ 'python': ['python'],
      --     \ 'perl': ['perl'],
      --     \ 'sh': ['sh'],
      --     \ }
      -- CXREF: /opt/homebrew/Cellar/neovim/0.10.3/share/nvim/runtime/syntax/rst.vim
      vim.g.rst_syntax_code_list = {}
    end,

    keys = {
      {
        ft = "rst",
        mode = { "n", "i" },
        "<S-F5>",
        "<cmd>call ReSTFolderUpdateFolds(1)<CR>",
        silent = true,
        buffer = true,
        desc = "Reset reSTfolds (and Close All)",
      },
      {
        ft = "rst",
        mode = { "n", "i" },
        "<F5>",
        "<cmd>call ReSTFolderUpdateFolds(0)<CR>",
        silent = true,
        buffer = true,
        desc = "Update reSTfolds (and Close All But 1)",
      },
      {
        ft = "rst",
        mode = { "n" },
        -- BNDNG: <Shift-Alt-K>
        "",
        "<cmd>silent call ReSTFolderMoveUp()<CR>",
        silent = true,
        buffer = true,
        desc = "Move reSTfold § Up",
      },
      {
        ft = "rst",
        mode = { "n" },
        -- BNDNG: <Shift-Alt-J>
        "Ô",
        "<cmd>silent call ReSTFolderMoveFoldDown()<CR>",
        silent = true,
        buffer = true,
        desc = "Move reSTfold § Down",
      },
    },

    -- CXREF:
    -- ~/.kit/nvim/landonb/vim-reSTfold/autoload/embrace/reSecTions.vim
    config = function()
      local wk = require("which-key")
      wk.add({
        mode = { "n" },
        { "<LocalLeader>(", group = "Draw rst borders", icon = "" },
        { "<LocalLeader>)", group = "Draw rst borders", icon = "" },
        { "<LocalLeader>/", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><", group = "Draw rst borders", icon = "" },
        { "<LocalLeader>>", group = "Draw rst borders", icon = "" },
        { "<LocalLeader>[", group = "Draw rst borders", icon = "" },
        { "<LocalLeader>{", group = "Draw rst borders", icon = "" },
        { "<LocalLeader>}", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|(", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|)", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|/", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|<", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|>", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|[", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|{", group = "Draw rst borders", icon = "" },
        { "<LocalLeader><LocalLeader>|}", group = "Draw rst borders", icon = "" },
      })
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/vim-reST-highdefs",
    lazy = not lazy_profile["vim-reST-highdefs"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-reST-highfive",
    lazy = not lazy_profile["vim-reST-highfive"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-reST-highline",
    lazy = not lazy_profile["vim-reST-highline"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-select-mode-stopped-down",
    lazy = not lazy_profile["vim-select-mode-stopped-down"],
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-source-reloader",
    lazy = not lazy_profile["vim-source-reloader"],
  },

  {
    dir = "~/.kit/nvim/landonb/vim-surround",
    lazy = not lazy_profile["vim-surround"],

    dependencies = {
      { dir = "~/.kit/nvim/tpope/start/vim-repeat" },
    },
  },

  {
    dir = "~/.kit/nvim/landonb/vim-title-bar-time-of-day",
    lazy = not lazy_profile["vim-title-bar-time-of-day"],

    config = function()
      vim.fn["embrace#titlebar#Setup"]({
        titlebar_disable = false,
        clock_rate = 2500,
      })
    end,
  },

  {
    -- ALTLY: https://github.com/numToStr/Navigator.nvim
    dir = "~/.kit/nvim/landonb/vim-tmux-navigator",
    lazy = not lazy_profile["vim-tmux-navigator"],
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },

  {
    dir = "~/.kit/nvim/landonb/vim-unimpaired",
    lazy = not lazy_profile["vim-unimpaired"],

    dependencies = {
      { dir = "~/.kit/nvim/tpope/start/vim-repeat" },
    },
  },

  {
    dir = "~/.kit/nvim/embrace-vim/start/vim-webopen",
    lazy = not lazy_profile["vim-webopen"],

    -- FIXME/2025-01-31: Absorb vim-depoxy/plugin/ config.
    -- - Following copied from flash.nvim, which seems
    --   like good pattern to follow.
    --
    --   -- stylua: ignore
    --   keys = {
    --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    --     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    --   },
  },

  -- ------------------------------------------------------------
  -- ------------------------------------------------------------
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
