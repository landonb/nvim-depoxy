" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/nvim-depoxy#🐇
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: Partial vim-plug config — third-party (not author's) plugins

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

" USYNC:
"
"   meld ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_3rdp.vim \
"     ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/plugins/spec-3rdp.lua &
"
"   meld ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_3rdp.vim \
"     ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-3rdp &

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

" USYNC: Refer also:
"
"   ls -lad ~/.kit/nvim/*/start/*

" ISOFF/2025-02-01: I doubt I'll maintain this file.
" - I've fully migrated to Neovim and don't expect to
"   need to run classic Vim again... the Vim is dead,
"   long live the Vim! ( Also RIP Bram!
"     https://slackmojis.com/emojis/8103-pour_one_out )

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function! g:depoxy#plug_3rdp#load() abort
  " Plug '~/.kit/nvim/arcticicestudio/opt/nord-vim'
  Plug '~/.kit/nvim/cespare/start/vim-toml'
  " Plug '~/.kit/nvim/chrisbra/opt/improvedft'
  Plug '~/.kit/nvim/chrisbra/start/matchit'
  " Plug '~/.kit/nvim/ctrlpvim/opt/ctrlp.vim'
  " Plug '~/.kit/nvim/djoshea/opt/vim-autoread'
  Plug '~/.kit/nvim/easymotion/start/vim-easymotion'
  Plug '~/.kit/nvim/editorconfig/start/vim-go'
  Plug '~/.kit/nvim/editorconfig/start/editorconfig-vim'
  " Plug '~/.kit/nvim/flazz/opt/vim-colorschemes'
  " Neovim-only:
  "   Plug '~/.kit/nvim/folke/flash.nvim'
  "   Plug '~/.kit/nvim/folke/lazy.nvim'
  Plug '~/.kit/nvim/godlygeek/start/tabular'
  " Plug '~/.kit/nvim/greg0ire/opt/more-instantly-better-vim'
  Plug '~/.kit/nvim/HerringtonDarkholme/start/yats.vim'
  Plug '~/.kit/nvim/jamessan/start/vim-gnupg'
  Plug '~/.kit/nvim/juanpabloaj/start/vim-istanbul'
  Plug '~/.kit/nvim/junegunn/start/fzf.vim'
  " Plug '~/.kit/nvim/junegunn/opt/goyo.vim'
  Plug '~/.kit/nvim/junegunn/start/limelight.vim'
  " Plug '~/.kit/nvim/junegunn/start/vim-plug'
  " Plug '~/.kit/nvim/junegunn/opt/vim-slash'
  Plug '~/.kit/nvim/justinmk/start/vim-sneak'
  " Plug '~/.kit/nvim/leafgarland/opt/typescript-vim'
  Plug '~/.kit/nvim/majutsushi/start/tagbar'
  " Plug '~/.kit/nvim/marshallward/opt/vim-restructuredtext'
  Plug '~/.kit/nvim/MaxMEllon/start/vim-jsx-pretty'
  " Plug '~/.kit/nvim/nanotech/opt/jellybeans.vim'
  " CHOSN/2025-01-23: Not sure if they'd work in concert or not,
  "   but disabled pangloss/vim-javascript to ensure no conflict
  "   with yuezk/vim-js
  "
  "  Plug '~/.kit/nvim/pangloss/start/vim-javascript'
  Plug '~/.kit/nvim/preservim/nerdcommenter'
  Plug '~/.kit/nvim/preservim/vim-markdown'
  Plug '~/.kit/nvim/samoshkin/start/vim-mergetool'
  " Plug '~/.kit/nvim/scrooloose/opt/nerdtree'
  " Plug '~/.kit/nvim/scrooloose/opt/syntastic'
  " Plug '~/.kit/nvim/thinca/opt/vim-visualstar'
  " Plug '~/.kit/nvim/tomtom/opt/tlib_vim'
  " Plug '~/.kit/nvim/tomtom/opt/viki_vim'
  " Plug '~/.kit/nvim/tpope/opt/vim-commentary'
  " Plug '~/.kit/nvim/tpope/opt/vim-endwise'
  " USEBY: vim-pathogen (pathogen#split) used by dubs_grep_steady:
  "   ~/.kit/nvim/landonb/dubs_grep_steady/plugin/dubs_grep_steady.vim
  " - ALTLY: Put ~/.vim/autoload/pathogen.vim on autoload path (runtimepath)
  Plug '~/.kit/nvim/tpope/opt/vim-pathogen'
  " Plug '~/.kit/nvim/tpope/opt/vim-scriptease'
  " Plug '~/.kit/nvim/tpope/opt/vim-vividchalk'
  " Plug '~/.kit/nvim/tpope/opt/vim-sensible'
  Plug '~/.kit/nvim/tpope/start/vim-abolish'
  Plug '~/.kit/nvim/tpope/start/vim-fugitive'
  Plug '~/.kit/nvim/tpope/start/vim-jdaddy'
  Plug '~/.kit/nvim/tpope/start/vim-rails'
  Plug '~/.kit/nvim/tpope/start/vim-repeat'
  Plug '~/.kit/nvim/tpope/start/vim-speeddating'
  Plug '~/.kit/nvim/tpope/start/vim-vinegar'
  " Plug '~/.kit/nvim/vim-scripts/opt/AutoAdapt'
  " Plug '~/.kit/nvim/vim-scripts/opt/ingo-library'
  Plug '~/.kit/nvim/vim-scripts/start/bbye'
  Plug '~/.kit/nvim/vim-scripts/start/BufOnly.vim'
  " Plug '~/.kit/nvim/vim-scripts/opt/TeTrIs.vim'
  Plug '~/.kit/nvim/vim-scripts/start/ZoomWin'
  Plug '~/.kit/nvim/voithos/start/vim-python-matchit'
  " Plug '~/.kit/nvim/wincent/opt/command-t'
  " Plug '~/.kit/nvim/xolox/opt/vim-misc'
  Plug '~/.kit/nvim/yuezk/start/vim-js'
  " Plug '~/.kit/nvim/zhou13/opt/vim-easyescape'
endfunction

