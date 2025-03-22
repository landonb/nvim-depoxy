-- vim:tw=0:ts=2:sw=2:et:ai:ft=lua
-- Author: Landon Bouma <https://tallybark.com/>
-- Project: https://github.com/DepoXy/nvim-depoxy#🐇
-- License: MIT

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- REFER: Check if Neovide (macOS) Neovim GUI: exists("g:neovide") / vim.g.neovide

-- SAVVY: Use end-of-args separator to add nvim options to neovide command, e.g,:
--
--   neovide -- --noplugin

if vim.g.neovide then
  -- REFER: https://neovide.dev/configuration.html
  --
  -- Neovide version
  --  vim.g.neovide_version
  -- Neovide metadata, e.g.
  --  lua vim.print(vim.api.nvim_get_chan_info(vim.g.neovide_channel_id))

  -- *** Display

  -- Display > Font
  --  vim.o.guifont = "Source Code Pro:h14"
  --  vim.o.guifont = "Hack Nerd Font Mono:h12.75:w-1"
  --
  -- Display > Line spacing
  --  vim.opt.linespace = 0
  --
  -- Display > Scale
  --  vim.g.neovide_scale_factor = 1.0
  --
  -- Display > Text Gamma and Contrast
  --  vim.g.neovide_text_gamma = 0.0
  --  vim.g.neovide_text_contrast = 0.5
  --
  -- Display > Padding
  --  vim.g.neovide_padding_top = 0
  --  vim.g.neovide_padding_bottom = 0
  --  vim.g.neovide_padding_right = 0
  --  vim.g.neovide_padding_left = 0
  --
  -- Display > Background Color (Deprecated, Currently macOS only)
  --  -- Helper function for transparency formatting
  --  local alpha = function()
  --    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  --  end
  --  -- g:neovide_transparency should be 0 if you want to unify
  --  -- transparency of content and title bar.
  --  vim.g.neovide_transparency = 0.0
  --  vim.g.transparency = 0.8
  --  vim.g.neovide_background_color = "#0f1117" .. alpha()
  --
  -- Display > Title Bar Color (Currently Windows only)
  --  vim.g.neovide_title_background_color = string.format(
  --    "%x",
  --    vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
  --  )
  --  vim.g.neovide_title_text_color = "pink"
  --
  -- Display > Window Blur (Currently macOS only)
  --  vim.g.neovide_window_blurred = true
  --
  -- Display > Floating Blur Amount
  --  vim.g.neovide_floating_blur_amount_x = 2.0
  --  vim.g.neovide_floating_blur_amount_y = 2.0
  --
  -- Display > Floating Shadow
  --  vim.g.neovide_floating_shadow = true
  --  vim.g.neovide_floating_z_height = 10
  --  vim.g.neovide_light_angle_degrees = 45
  --  vim.g.neovide_light_radius = 5
  --
  -- Display > Floating Corner Radius
  --  vim.g.neovide_floating_corner_radius = 0.0
  --
  -- Display > Transparency
  --  vim.g.neovide_transparency = 0.8
  --  vim.g.neovide_normal_opacity = 0.8
  --
  -- Display >
  --  vim.g.neovide_show_border = true
  --
  -- Display > Position Animation Length
  --  vim.g.neovide_position_animation_length = 0.15
  --
  -- Display > Show Border (Currently macOS only)
  --  vim.g.neovide_scroll_animation_length = 0.3
  --
  -- Display > Scroll Animation Length
  --  vim.g.neovide_scroll_animation_far_lines = 1
  --
  -- Display > Hiding the mouse when typing
  --  vim.g.neovide_hide_mouse_when_typing = false
  -- - ISOFF/2025-01-24: Sometimes when I Alt-Tab away from Neovide and
  --   then back, the mouse cursor is hidden — when you mouse off the
  --   Neovide window, it's visible; but it's invisible over Neovide.
  --   Clicking doesn't bring it back. Nor do arrow keys. But typing
  --   a character and then using the mouse, or pressing <Esc> makes
  --   it visible again.
  --   - ISOFF: Which makes it a little too annoying to use...
  --  vim.g.neovide_hide_mouse_when_typing = true
  --
  -- Display > Underline automatic scaling
  --  vim.g.neovide_underline_stroke_scale = 1.0
  --
  -- Display > Theme
  --  vim.g.neovide_theme = 'auto'
  --
  -- Display > Layer grouping
  --  vim.g.experimental_layer_grouping = false

  -- *** Functionality

  -- Functionality > Refresh Rate
  --  vim.g.neovide_refresh_rate = 60
  --
  -- Functionality > Idle Refresh Rate
  --  vim.g.neovide_refresh_rate_idle = 5
  --
  -- Functionality > No Idle
  --  vim.g.neovide_no_idle = true
  --
  -- Functionality > Confirm Quit
  --  vim.g.neovide_confirm_quit = true
  --
  -- Functionality > Detach On Quit
  --  vim.g.neovide_detach_on_quit = 'always_quit'
  --
  -- Functionality > Fullscreen
  --  vim.g.neovide_fullscreen = true
  --
  -- Functionality > Remember Previous Window Size
  --  vim.g.neovide_remember_window_size = true
  --
  -- Functionality > Profiler
  -- The Neovide profiler shows a frametime graph in the upper left corner.
  --  vim.g.neovide_profiler = true

  -- *** Input Settings

  -- Input Settings > macOS Option Key is Meta
  -- Meta Key Enablement: both|only_left|only_right|none
  -- - Aka *macOS Option Key is Meta*, set to none by default.
  -- - (Also buried in the help!)
  --   https://neovide.dev/configuration.html#macos-option-key-is-meta
  -- - "Interprets Alt + whatever actually as <M-whatever>, instead
  --    of sending the actual special character to Neovim."
  -- - DUNNO: TBH, I don't know use case for sending "actual special
  --   character". Is it just another way to specify keybindings,
  --   but with the same outcome? Or is there another use case
  --   besides user keybindings?
  --
  -- SAVVY: Enables some binding, e.g., <M-f> for <Alt-f>, but not all
  -- Alt-bindings, e.g., <M-#> works in Vim for <Shift-Alt-3>, but not
  -- in Neovide.
  -- - For all Alt-bindings to work in Neovide, leave this option-key-
  --   is-meta option disabled ('none'), and use *literal* characters
  --   in the :map commands, e.g.,
  --
  --       if has('nvim')
  --         " DUNNO: In Vim, in Insert mode, during <Ctrl-Q> blockwise visual
  --         " select, if you press <Shift-Alt-3>, prints '£'. But in Neovide
  --         " in Insert mode if you press <Shift-Alt-3>, inserts '‹'.
  --         nnoremap ‹ :QFix(0)<CR>
  --       else
  --         nnoremap <M-#> :QFix(0)<CR>
  --       endif
  --
  -- FIXME/2025-02-22 10:01: Add compatibility with LazyVim and other distros...
  -- - MAYBE: Leave this option off and add literal keybindings...
  --
  --  vim.g.neovide_input_macos_option_key_is_meta = 'none'
  -- -- vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

  -- Input Settings > IME
  --  vim.g.neovide_input_ime = true
  --
  -- Input Settings > Touch Deadzone
  --  vim.g.neovide_touch_deadzone = 6.0
  --
  -- Input Settings > Touch Drag Timeout
  --  vim.g.neovide_touch_drag_timeout = 0.17

  -- *** Cursor Settings
  --
  -- **** Cursor animations
  --
  -- REFER:
  -- https://neovide.dev/configuration.html#animation-length
  --
  -- Animation Length
  -- - SAVVY/2025-02-02: Docs shows 0.13, but author's Neovide uses 0.06
  -- - WRKLG/2025-01-26:
  --     lua vim.g.neovide_cursor_animation_length = 0.13
  --     lua vim.g.neovide_cursor_animation_length = 0.01
  --     lua vim.g.neovide_cursor_animation_length = 0
  --     -- Hmmm, I like 0.02, and makes 0.13 *feel slow!*
  --     lua vim.g.neovide_cursor_animation_length = 0.02
  --  vim.g.neovide_cursor_animation_length = 0.13
  --
  -- Animation Trail Size
  --  vim.g.neovide_cursor_trail_size = 0.8
  --
  -- Antialiasing
  --  vim.g.neovide_cursor_antialiasing = v:true
  --
  -- Animate in insert mode
  --  vim.g.neovide_cursor_animate_in_insert_mode = v:true
  --
  -- Animate switch to command line
  --  vim.g.neovide_cursor_animate_command_line = v:true
  --
  -- Unfocused Outline Width
  --  vim.g.neovide_cursor_unfocused_outline_width = 0.125
  --
  -- Animate cursor blink
  --  vim.g.neovide_cursor_smooth_blink = v:false

  -- **** Cursor Particles
  --  vim.g.neovide_cursor_vfx_mode = ""
  --  vim.g.neovide_cursor_vfx_mode = "railgun"
  --  vim.g.neovide_cursor_vfx_mode = "torpedo"
  --  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  --  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  --  vim.g.neovide_cursor_vfx_mode = "ripple"
  --  vim.g.neovide_cursor_vfx_mode = "wireframe"

  -- **** Particle Settings
  -- Particle Opacity
  --  vim.g.neovide_cursor_vfx_opacity = 200.0
  -- Particle Lifetime
  --  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  -- Particle Density
  --  vim.g.neovide_cursor_vfx_particle_density = 7.0
  -- Particle Speed
  --  vim.g.neovide_cursor_vfx_particle_speed = 10.0
  -- Particle Phase
  -- -- For railgun vfx mode:
  --  vim.g.neovide_cursor_vfx_particle_phase = 1.5
  -- Particle Curl
  -- -- For railgun vfx mode:
  --  vim.g.neovide_cursor_vfx_particle_curl = 1.0
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- COPYD: https://github.com/9mm/dotfiles/blob/master/.config/nvim/lua/zesty/gui.lua

-- if vim.g.neovide then
if false then

  local function buffer_modified()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
    return modified
  end

  local function close_tab(force)
    -- check if standard file buffer or a new unsaved buffer, otherwise do standard
    -- bd as barbar won't handle quickfix window, neotree, etc
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.fn.bufname(bufnr)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
    if (buftype == "" and bufname ~= "") then
      vim.cmd(force and "BufferClose!" or "BufferClose")
    else
      vim.cmd(force and "bd!" or "bd")
    end
  end

  local function confirm_close_tab()
    if buffer_modified() then
      local choice = vim.fn.confirm("Save changes?", "&Yes\n&No\n&Cancel")
      if choice == 2 then
        close_tab(true)
      end
    else
      close_tab(false)
    end
  end

  -- padding
  vim.g.neovide_padding_top    = 20
  vim.g.neovide_padding_bottom = 20
  vim.g.neovide_padding_right  = 20
  vim.g.neovide_padding_left   = 20

  -- display
  --  vim.g.neovide_transparency = 0.98
  vim.g.neovide_refresh_rate = 960 -- fps peaks over 1000+ (requires NEOVIDE_VSYNC=0)
  vim.g.neovide_refresh_rate_idle = 60
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_underline_stroke_scale = 1.2

  -- blur
  vim.g.neovide_floating_blur_amount_x = 0.0
  vim.g.neovide_floating_blur_amount_y = 0.0

  -- window
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_confirm_quit = true

  -- animation
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animate_command_line = false

  -- other
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"

  -- command mapping
  vim.keymap.set({ "i", "n" }, "<D-a>", "<Esc>ggVG")                              -- select all
  vim.keymap.set({ "i", "n" }, "<D-w>", function() confirm_close_tab() end)       -- close tab
  vim.keymap.set({ "i", "n" }, "<D-[>", function() vim.cmd("BufferPrevious") end) -- previous tab
  vim.keymap.set({ "i", "n" }, "<D-]>", function() vim.cmd("BufferNext") end)     -- next tab
  vim.keymap.set("i", "<D-t>", "<C-o>:tabnew<CR><Esc>")                           -- new tab (insert)
  vim.keymap.set("n", "<D-t>", ":tabnew<CR>")                                     -- new tab (insert)
  vim.keymap.set("i", "<D-s>", "<C-o>:w<CR>")                                     -- save (insert)
  vim.keymap.set("n", "<D-s>", ":w<CR>")                                          -- save (normal)
  vim.keymap.set("x", "<D-x>", '"+dm0i<Esc>`0')                                   -- cut (include insert hack to fix whichkey issue #518)
  vim.keymap.set("x", "<D-c>", '"+y')                                             -- copy
  vim.keymap.set("i", "<D-v>", "<C-r><C-o>+")                                     -- paste (insert)
  vim.keymap.set("n", "<D-v>", "i<C-r><C-o>+<Esc>l")                              -- paste (normal)
  vim.keymap.set("x", "<D-v>", '"+P')                                             -- paste (visual)
  vim.keymap.set("c", "<D-v>", "<C-r>+")                                          -- paste (command)
  vim.keymap.set("n", "<D-z>", "u")                                               -- undo
  vim.keymap.set({ "i", "n" }, "<D-q>", function() vim.cmd("confirm qa") end)     -- quit
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

