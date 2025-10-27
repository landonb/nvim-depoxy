-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

-- stylua: ignore
--      ___                       ___                                     ___           ___                   
--     /\  \                     /\  \          ___                      /\  \         /\  \                  
--    |::\  \       ___          \:\  \        /\  \        ___         |::\  \       /::\  \                 
--    |:|:\  \     /\__\          \:\  \       \:\  \      /\__\        |:|:\  \     /:/\:\  \                
--  __|:|\:\  \   /:/__/      _____\:\  \       \:\  \    /:/__/      __|:|\:\  \   /:/ /::\  \   ___     ___ 
-- /::::|_\:\__\ /::\  \     /::::::::\__\  ___  \:\__\  /::\  \     /::::|_\:\__\ /:/_/:/\:\__\ /\  \   /\__\
-- \:\~~\  \/__/ \/\:\  \__  \:\~~\~~\/__/ /\  \ |:|  |  \/\:\  \__  \:\~~\  \/__/ \:\/:/  \/__/ \:\  \ /:/  /
--  \:\  \        ~~\:\/\__\  \:\  \       \:\  \|:|  |   ~~\:\/\__\  \:\  \        \::/__/       \:\  /:/  / 
--   \:\  \          \::/  /   \:\  \       \:\__|:|__|      \::/  /   \:\  \        \:\  \        \:\/:/  /  
--    \:\__\         /:/  /     \:\__\       \::::/__/       /:/  /     \:\__\        \:\__\        \::/  /   
--     \/__/         \/__/       \/__/        ~~~~           \/__/       \/__/         \/__/         \/__/    

local obj = {}

---@param profile? string
-- profile = "maximal", ---@type "minimal" | "midimal" | "maximal"
function obj:profile(profile)
  -- print("obj:profile: profile: " .. profile)
  local minimal = profile == "minimal"
  local midimal = profile == "midimal"
  local maximal = profile == "maximal"

  local disabled = not profile or profile == "" or profile == "none"

  -- ***

  local batch_01 = not disabled
  local batch_02 = not disabled

  local batch_03 = not disabled
  local batch_04 = not disabled

  local batch_05 = not disabled
  -- Batch #6 is third-party Vim plugins I don't really use.
  -- - But a few of 'em maybe I might someday.
  local batch_06 = not disabled

  -- WTF__/2025-02-14 20:11: Perf drag again!
  --batch_05 = not disabled and false
  batch_06 = not disabled and false

  local batch_07 = not disabled

  -- Completely unnecessary plugin(s).
  local batch_99 = not disabled

  -- The Bad Batch plugins are somewhat "experimental" or at
  -- least tweak the UX in ways you might find unexpected.
  -- - E.g., vim-async-map adds non-blocking Insert mode maps.
  --   And vim-select-mode-stopped-down affects how <Ctrl-Arrow>
  --   Visual mode selections behave.
  local bad_batch = not disabled and false -- FIXME/LATER: Enable
  local async_map = not disabled and false -- FIXME/LATER: Enable

  local file_and_netrw = not disabled

  local javascript_typescript = not disabled

  local nvim_cmps = not disabled and false -- FIXME: AUDIT

  local reSTery = not disabled
  -- FIXME: If I `fs somefile`, then <Cmd-E>, then <Ctrl-End>:
  -- - Without dubs_ftype_mess, it's instantaneous.
  -- - With dubs_ftype_mess, it hangs for a sec or two.
  -- MAYBE: Load only the `rstLiteralBlock` match, and see
  --        if that's slow... (that's what lets me avoid
  --        using blank line after `::` code block leaders)
  local reSTery_dubs_ftype_mess = batch_03

  -- So that your Hammerspoon accelerators find the correct instance.
  local tbtod_gvim_open_kindness = not disabled

  local sneaky_on = not disabled or batch_01
  local sneaky_off = false

  local always_lazy = false

  local remove_me = false -- FIXME: These can be retired.

  -- ***

  -- DEVEL: Quick on/off testing
  --
  -- batch_01 = batch_01
  -- batch_02 = batch_02
  -- batch_03 = batch_03
  -- batch_04 = batch_04
  -- batch_05 = batch_05
  -- batch_06 = batch_06
  -- batch_07 = batch_07
  -- batch_99 = batch_99
  -- file_and_netrw = file_and_netrw
  -- javascript_typescript = javascript_typescript
  -- reSTery = reSTery
  -- reSTery_dubs_ftype_mess = reSTery_dubs_ftype_mess
  -- tbtod_gvim_open_kindness = tbtod_gvim_open_kindness
  -- sneaky_on = sneaky_on

  -- ***

  local lazy_profile = {
    -- Haha, just for completeness.
    ["lazy.nvim"] = true,

    -- CXREF:
    -- ~/.depoxy/ambers/home/.config/nvim/lua/minimal/minimal.lua

    -- USAGE: Pick *one* colorscheme
    -- - Color scheme is Priority 10×💯
    ["nord-vim"] = false,
    ["tokyonight.nvim"] = false,
    -- ISOFF/2025-02-22: Issues in v0.11.0-dev, incl. unreadable :Lazy.
    ["dubs_after_dark"] = profile ~= "lazy" and not disabled,
    ["jellybeans.vim"] = false,
    ["vim-vividchalk"] = false,
    -- You can try a zillion colorschemes in this one plugin,
    -- but our lazy.nvim spec doesn't specify any particular
    -- one to load (so setting this tyue won't pick a scheme).
    ["vim-colorschemes"] = false,
    ["catppuccin/nvim"] = profile == "lazy",

    -- Lazy-loads on |StartupTime| command
    -- DUNNO/2025-01-31: List this, for visibility?
    -- - It's not configurable, and doesn't need to be...
    --  ["vim-startuptime"] = true,
    --  ["vim-startuptime"] = "StartupTime",
    --  ["vim-startuptime"] = lazy_cmd,

    -- "Vim syntax for TOML"; now "included in the main (Neo)Vim distribution."
    ["vim-toml"] = always_lazy,
    -- The % g% [% ]% a% cmds, slightly ahead of Vim's copy — :h matchit
    ["matchit"] = batch_06,
    ["vim-easymotion"] = sneaky_off,
    -- "Go language support for Vim"
    ["vim-go"] = batch_06,
    ["editorconfig-vim"] = batch_02,
    ["flash.nvim"] = sneaky_on,
    ["leap.nvim"] = sneaky_on,
    -- E.g., :Tabularize /=/ | line up text along columns — :h tabular
    ["tabular"] = batch_06,
    -- For "transparent editing of gpg encrypted files"
    ["vim-gnupg"] = batch_06,
    -- Show uncovered lines, info from coverage.json; `istanbul report`, :IstanbulShow
    -- - LATER: Revive a coverage plugin, whether this or another.
    ["vim-istanbul"] = batch_06,
    ["fzf.vim"] = batch_02,
    -- "Hyperfocus-writing in Vim", :Limelight0.7 :Limelight! :Limelight!!0.8
    ["limelight.vim"] = always_lazy,
    ["vim-sneak"] = sneaky_off,
    -- Supports TS, .-repeat, L/R/U/D motions, hooks; I prefer NERD Commenter
    ["Comment.nvim"] = always_lazy,
    ["nerdcommenter"] = batch_02,
    -- Syn. hl'ing, fold'g, match'g rules, maps for orig Markdown + extensions
    ["vim-markdown"] = batch_06,
    -- :MergetoolToggle — diff btw ours/theirs w/out cx marks; ISOFF b/c usability
    ["vim-mergetool"] = remove_me,
    -- crs coerce to snake_case, crm mixed, crc camel, cru upper, cr-, cr.
    ["vim-abolish"] = batch_06,
    ["vim-fugitive"] = batch_02,
    -- "JSON manip. & pretty printing" | aj text obj (ij) | gqaj lints JSON fmt | gwaj inject JSON
    ["vim-jdaddy"] = batch_06,
    ["vim-pathogen"] = remove_me,
    -- "Ruby on Rails power tools" | I haven't rubied in ages...
    ["vim-rails"] = always_lazy,
    -- Enables . cmd to work on vim-surround ds, cs, and yss; speeddating, unimpaired, more.
    ["vim-repeat"] = batch_05,
    -- <Ctrl-X> decrements time component, <Ctrl-A> incs, V. Slick... but will I ever use?
    ["vim-speeddating"] = batch_06,
    -- Adds netrw `-` up-dir | hides '.' and '..' (see: `gh` and `a` cmds)
    ["vim-vinegar"] = file_and_netrw,
    ["bbye"] = batch_01,
    -- Used by \dQ, <M-f>e, <M-f>q, :only
    ["BufOnly.vim"] = batch_02,
    -- !WFM (errors) in nvim | Use \dT (dubs_edit_juice) makes only win using new tab
    ["ZoomWin"] = remove_me,
    -- !WFM? See instead Tree-sitter | 13 yo | % g% [% ]% | d]% v]%d dels V]%d lnwise
    ["vim-python-matchit"] = remove_me,
    -- Buffer :MRU :MRUToggle but could be improved: use picker, and open to curr. win.
    ["yegappan/mru"] = batch_07,
    -- Clipboard tweak so x, d, c, (and s) don't overwrite unnamed/clipboard registers.
    ["svermeulen/vim-cutlass"] = batch_07,
    ["svermeulen/vim-yoink"] = batch_07,
    -- File-wide substituter, but Dubs \s or newer Tree-sitter approaches do better.
    --  ["svermeulen/vim-subversive"] = always_lazy,

    -- Generic \j \J file path clipboarc-copiers | I use custom \j \J from DXC
    ["vim-clip-expand-path"] = always_lazy,
    -- Ansible 2.x syn. hl for YAML playbooks, Jinja2 templates, and hosts files
    ["ansible-vim"] = batch_06,
    ["dubs_appearance"] = minimal or batch_01,
    ["dubs_edit_juice"] = minimal or batch_01,
    -- rstLiteralBlock tweak (empty line not required after ::)
    ["dubs_ftype_mess"] = reSTery_dubs_ftype_mess,
    ["dubs_grep_steady"] = batch_01,
    ["dubs_html_entities"] = batch_05,
    ["dubs_mescaline"] = batch_99,
    ["dubs_project_tray"] = batch_01,
    ["dubs_quickfix_wrap"] = batch_02,
    ["dubs_style_guard"] = batch_02,
    ["dubs_toggle_textwrap"] = batch_02, -- XXX of 3
    -- Use <CR> to :copen matches.
    ["QFEnter"] = batch_03,
    ["vim-async-map"] = minimal or bad_batch or async_map,
    -- More & colorful external file change messages; concise conflicts prompt.
    ["vim-better-file-changed-prompt"] = batch_99,
    ["vim-blinky-search"] = batch_01,
    -- <C-S-Up>/<C-S-Down> window jumpers, __ :ls map
    ["vim-buffer-delights"] = batch_03,
    ["vim-buffer-ring"] = batch_02,
    -- ISOFF/2025-02-11: Deprecated. Too kludgy; & a waste of time to maintain.
    ["vim-command-line-clock"] = always_lazy,
    -- Not compatible with Neovide because :winpo not implemented.
    ["vim-fullscreen-toggle"] = always_lazy,
    -- gf|gF commands that work on ${BASH:-y} vars.
    ["vim-goto-file-sh"] = batch_03,
    -- lcd to project root for each file (vs. using dir you launced nvim from).
    ["vim-lcd-project-root"] = batch_05,
    -- Unnecessary because spellfile.txt... but also more is better? Ok, nope.
    ["vim-mkspell-when-stale"] = always_lazy,
    ["vim-netrw-cfg-split-explorer"] = file_and_netrw,
    ["vim-netrw-explore-map"] = file_and_netrw,
    -- Open :netrw paths at their canonical path (e.g., not symlink path).
    ["vim-netrw-link-resolve"] = file_and_netrw,
    -- vim-async-map kj/jk (but not gf 3t) | MAYBE: Move to vim-depoxy/init.lua
    ["vim-ovm-easyescape-kj-jk"] = async_map,
    ["vim-ovm-seven-of-spines"] = batch_01,
    ["vim-reSTfold"] = reSTery,
    ["vim-reST-highdefs"] = reSTery,
    ["vim-reST-highfive"] = reSTery,
    ["vim-reST-highline"] = reSTery,
    -- FIXME/2025-02-02 02:29: Why did I change recently, because I think
    -- this plugin is disabled, but <Shift-Arrow> and <Ctrl-Shift-Arrow>
    -- selecting is working as expected, and quickly, too.
    -- - E.g., from last char. in line, <Shift-Ctrl-Left> works, but
    --   I thought was I was demoing stock Neovim, that that behaved
    --   oddly.
    --   - Well, <Shift-Ctrl-Right> from left of the last word still
    --     selects the newline and leading whitespace on the next line,
    --     which is something this plugin changes...
    ["vim-select-mode-stopped-down"] = minimal or bad_batch,
    ["vim-source-reloader"] = batch_02,
    -- n: ds, cs, yss, yS, ySS | x: S, gS — :h ys
    ["vim-surround"] = batch_05, -- batch_01 material, but I can survive w/out...
    -- Not just for gvim-open-kindness and Hammerspoon accelerators,
    -- also NVIM's titlebar updating is *laggy*
    ["vim-title-bar-time-of-day"] = tbtod_gvim_open_kindness,
    -- <Ctrl-Alt-Arrow> jumpers from Insert mode like <Ctrl-w><Left/Right/Up/Down>
    ["vim-tmux-navigator"] = batch_03,
    -- :h unimpaired | [q ]q :cprev :cnext | [Q ]Q :cfirst :clast | [l ]l [t ]t | yos spell yow wrap
    ["vim-unimpaired"] = batch_06,
    ["vim-webopen"] = minimal or batch_02,

    -- GROUP: #vim_ctags_viewers
    --
    -- :TagbarToggle
    ["tagbar"] = batch_05,
    -- :TlistToggle (runs `ctags` on buffer); <Shift-Alt-1> via dubs_edit_juice
    ["vim-classic-taglist"] = batch_05,

    -- GROUP: #javascript_typescript_plugins
    --
    -- YATS: Yet Another TypeScript Syntax
    ["yats.vim"] = javascript_typescript,
    -- "🔦 [Vim script] JSX and TSX syntax pretty highlighting for vim."
    ["vim-jsx-pretty"] = javascript_typescript,
    -- DUNNO: Might conflict with yuezk/vim-js, so off until audited
    ["vim-javascript"] = always_lazy and javascript_typescript,
    ["vim-js"] = javascript_typescript,

    -- CXREF: GROUP: #vim_file_browsers
    -- ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/specs/group--file-browsers.lua
    --
    -- REFER: https://github.com/nvim-lua/plenary.nvim
    ["plenary.nvim"] = batch_01,
    -- REFER: https://github.com/nvim-tree/nvim-web-devicons
    -- - SAVVY: Loaded as dependency when necessary.
    ["nvim-web-devicons"] = always_lazy,
    ["mini.icons"] = always_lazy,
    --
    -- REFER: https://github.com/scrooloose/nerdtree
    ["nerdtree"] = false,
    -- REFER: https://github.com/tamago324/lir.nvim
    -- Works well enough. Not colorful. Simple. No tree view.
    ["lir.nvim"] = true and false,
    -- REFER: https://github.com/justinmk/vim-dirvish
    -- Not bad...
    ["vim-dirvish"] = true and false,
    -- REFER: https://github.com/luukvbaal/nnn.nvim
    ["nnn.nvim"] = false,
    -- REFER: https://github.com/ms-jpq/chadtree
    ["chadtree"] = false,
    -- REFER: https://github.com/nvim-neo-tree/neo-tree.nvim
    ["neo-tree.nvim"] = false,
    -- REFER: https://github.com/nvim-telescope/telescope-file-browser.nvim
    -- DUNNO/2025-01-28 19:08: Doesn't work on my home directory,
    -- shows just ~/.depoxy subdirectory and nothing else except ``../``.
    -- - Otherwise interesting inferface...
    ["telescope-file-browser.nvim"] = nil,
    -- REFER: https://github.com/nvim-tree/nvim-tree.lua
    ["nvim-tree.lua"] = false,

    -- CXREF:
    -- ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/specs/spec--telescope.nvim.lua
    -- FIXME/2025-02-10 11:43: This was missing; what else still is?
    ["telescope.nvim"] = batch_04,
    ["telescope-fzf-native.nvim"] = batch_04,
    ["telescope-lazy.nvim"] = batch_04,

    -- CXREF:
    -- ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/specs/spec--nvim-cmp.lua
    -- ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-lsp
    --
    -- "A completion engine plugin for neovim written in Lua."
    ["nvim-cmp"] = nvim_cmps,
    ["nvim-lspconfig"] = nvim_cmps,
    ["cmp-nvim-lsp"] = nvim_cmps,
    ["cmp-buffer"] = nvim_cmps,
    ["cmp-path"] = nvim_cmps,
    ["cmp-cmdline"] = nvim_cmps,

    -- CXREF:
    -- ~/.depoxy/ambers/home/.config/nvim/lua/minimal/nvim-treesitter.lua
    --
    -- LAZYL/2025-01-28: Leave lazy so you can more easily compare :syn on
    -- vs. tree-sitter highlighting. Also until you for figure out folding.
    -- REFER: https://github.com/nvim-treesitter/nvim-treesitter
    ["nvim-treesitter"] = false,
  }

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  local client_profile = {}

  if
    not pcall(function()
      -- FIXME/2025-02-22 16:36: Convert to M.profile() module call.
      client_profile = require("config.profile-client"):profile(profile)
    end)
  then
    -- The user profile config is optional, so ignore any error.
    -- - REFER: This is author's first time using pcall(), so
    --   just showing how you'd respond to an error, e.g.,
    --
    --   msg = "Failed to require `config.profile-client` for **" .. profile .. "**"
    --   print(msg)
  end

  -- print("obj:profile: client_profile: " .. vim.inspect(client_profile))

  lazy_profile = vim.tbl_deep_extend("force", lazy_profile, client_profile)

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

  return lazy_profile
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- HSTRY/2025-02-01: From last month, migrating to Neovim, adopting
-- a plugin manager, and hunting down a plugin performance issue
-- that was ultimately caused by orphaned `matchadd` calls creating
-- multiple, duplicate regex that would cause vim/nvim to lag, but
-- that wouldn't show up in a `:profile dump`.
-- - Also demoing vim-dirvish, treesitter, and flash and leap.

local lazy_profile_a_few_odd_things_2025_01 = {
  ["bbye"] = true,
  ["dubs_grep_steady"] = true,
  ["dubs_project_tray"] = true,
  ["vim-pathogen"] = true,

  ["dubs_appearance"] = true,
  ["vim-ovm-seven-of-spines"] = true,
  ["dubs_edit_juice"] = true,
  ["flash.nvim"] = true,
  ["leap.nvim"] = true,
  ["dubs_after_dark"] = true,
  ["vim-blinky-search"] = true,

  ["plenary.nvim"] = true,
  ["nvim-web-devicons"] = true,
  ["vim-dirvish"] = true,

  ["nvim-treesitter"] = true,
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return obj
