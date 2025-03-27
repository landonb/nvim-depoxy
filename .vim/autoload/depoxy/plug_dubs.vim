" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/nvim-depoxy#🐇
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: Partial vim-plug config — author's plugins

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

" USYNC:
"
"   meld ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_dubs.vim \
"     ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/plugins/spec-dubs.lua &
"
"   meld ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_dubs.vim \
"     ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-dubs &

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function! g:depoxy#plug_dubs#load() abort
  " *** ~/.kit/nvim/DepoXy

  " SAVVY: Caller sources vim-depoxy last:
  "   Plug '~/.kit/nvim/DepoXy/start/vim-depoxy'
  " CXREF:
  "   ~/.kit/nvim/nvim-depoxy/.vim/.vimrc
  Plug '~/.kit/nvim/DepoXy/start/vim-clip-expand-path'

  " *** ~/.kit/nvim/landonb

  Plug '~/.kit/nvim/landonb/ansible-vim'
  Plug '~/.kit/nvim/landonb/dubs_after_dark'
  Plug '~/.kit/nvim/landonb/dubs_appearance'
  Plug '~/.kit/nvim/landonb/dubs_edit_juice'
  Plug '~/.kit/nvim/landonb/dubs_ftype_mess'

  " REFER: Depends on vim-pathogen, which is sourced (Plug'd) by:
  "   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_3rdp.vim
  " - vim-plug doesn't have a dependencies option like lazy.nvim.
  Plug '~/.kit/nvim/landonb/dubs_grep_steady'

  let g:dubs_html_entities_create_maps = 1
  Plug '~/.kit/nvim/landonb/dubs_html_entities'
  Plug '~/.kit/nvim/landonb/dubs_mescaline'
  Plug '~/.kit/nvim/landonb/dubs_project_tray'
  let g:dubs_quickfix_wrap_create_maps = 1
  Plug '~/.kit/nvim/landonb/dubs_quickfix_wrap'
  Plug '~/.kit/nvim/landonb/dubs_style_guard'
  Plug '~/.kit/nvim/landonb/dubs_toggle_textwrap'
  Plug '~/.kit/nvim/landonb/QFEnter'

  " ISOFF/2025-01-21: Disabled plugins:
  "   Plug '~/.kit/nvim/landonb/.whilom/dubs_after_ice'
  "   Plug '~/.kit/nvim/landonb/.whilom/dubs_cycloplan'
  "   Plug '~/.kit/nvim/landonb/.whilom/dubs_file_finder'
  "   Plug '~/.kit/nvim/landonb/.whilom/dubs_syntastic_wrap'

  " *** ~/.kit/nvim/embrace-vim (and promotable nvim/landonb)

  Plug '~/.kit/nvim/embrace-vim/start/vim-async-map'
  Plug '~/.kit/nvim/embrace-vim/start/vim-better-file-changed-prompt'
  Plug '~/.kit/nvim/embrace-vim/start/vim-blinky-search'
  Plug '~/.kit/nvim/embrace-vim/start/vim-buffer-delights'
  Plug '~/.kit/nvim/landonb/vim-buffer-ring'
  Plug '~/.kit/nvim/landonb/vim-classic-taglist'

  " ISOFF/2025-02-11: Ugh, all that now-wasted development time.
  "   Plug '~/.kit/nvim/embrace-vim/start/vim-command-line-clock'

  let g:vim_fullscreen_toggle_create_maps = 1
  Plug '~/.kit/nvim/embrace-vim/start/vim-fullscreen-toggle'

  Plug '~/.kit/nvim/embrace-vim/start/vim-goto-file-sh'
  Plug '~/.kit/nvim/landonb/vim-lcd-project-root'
  Plug '~/.kit/nvim/landonb/vim-mkspell-when-stale'
  Plug '~/.kit/nvim/landonb/vim-netrw-cfg-split-explorer'
  Plug '~/.kit/nvim/embrace-vim/start/vim-netrw-explore-map'
  Plug '~/.kit/nvim/landonb/vim-netrw-link-resolve'
  Plug '~/.kit/nvim/landonb/vim-ovm-easyescape-kj-jk'
  Plug '~/.kit/nvim/landonb/vim-ovm-seven-of-spines'

  Plug '~/.kit/nvim/landonb/vim-reSTfold'
  " FEATS: Plethora of special .rst highlights
  Plug '~/.kit/nvim/landonb/vim-reST-highdefs'
  " FEATS: FIVER highlighting (FIVERsPunctuated, etc.)
  Plug '~/.kit/nvim/landonb/vim-reST-highfive'
  " FEATS: Repeating character (hrule) highlights (rstFakeHR*)
  Plug '~/.kit/nvim/landonb/vim-reST-highline'

  Plug '~/.kit/nvim/landonb/vim-select-mode-stopped-down'
  Plug '~/.kit/nvim/embrace-vim/start/vim-source-reloader'
  Plug '~/.kit/nvim/landonb/vim-surround'
  Plug '~/.kit/nvim/landonb/vim-title-bar-time-of-day'
  Plug '~/.kit/nvim/landonb/vim-tmux-navigator'
  Plug '~/.kit/nvim/landonb/vim-unimpaired'
  Plug '~/.kit/nvim/embrace-vim/start/vim-webopen'

  " ISOFF/2025-01-21: Disabled plugins:
  "
  "   Plug '~/.kit/nvim/landonb/.whilom/vim-jsx'
  "   Plug '~/.kit/nvim/landonb/.whilom/vim-markdown'
endfunction

