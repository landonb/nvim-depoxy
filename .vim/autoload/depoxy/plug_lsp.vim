" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/nvim-depoxy#🐇
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: Partial vim-plug config — third-party (not author's) plugins

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

" USYNC:
"
"   meld ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_lsp.vim \
"     ~/.kit/nvim/nvim-depoxy/.config/nvim/lua/plugins/spec-lsp.lua &
"
"   meld ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_lsp.vim \
"     ~/.kit/nvim/nvim-depoxy/mrconfig/_mrconfig-lsp--coc &

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function! g:depoxy#plug_lsp#load() abort
  " ISOFF/2025-02-12: Loading CoC fails if it's not built/installed,
  " and I've since essentially switched to NeoVim (though for some
  " reason I'm still maintaining somewhat of a working Vim config,
  " albeit with fewer features), so we'll skip CoC for classic Vim.
  return

  " Plug '~/.kit/nvim/prabirshrestha/opt/vim-lsp'
  " Plug '~/.kit/nvim/prabirshrestha/opt/async.vim'
  " Plug '~/.kit/nvim/mattn/opt/vim-lsp-settings'
  " Plug '~/.kit/nvim/prabirshrestha/opt/asyncomplete.vim'
  " Plug '~/.kit/nvim/prabirshrestha/opt/asyncomplete-lsp.vim'
  " Plug '~/.kit/nvim/ryanolsonx/opt/vim-lsp-typescript'
  " Plug '~/.kit/nvim/ryanolsonx/opt/vim-lsp-javascript'
  Plug '~/.kit/nvim/neoclide/start/coc.nvim'
  Plug '~/.kit/nvim/neoclide/start/coc-tsserver'
  Plug '~/.kit/nvim/neoclide/start/coc-json'
endfunction

