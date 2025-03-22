" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/nvim-depoxy#🐇
" License: https://creativecommons.org/publicdomain/zero/1.0/
" Summary: vim-plug plug#end() preflight

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

" CXREF: This script sourced by:
"
"   ~/.kit/nvim/nvim-depoxy/.vim/.vimrc
"
" before it calls plug#end(), so we can setup any
" g: vars, mostly, that must occur before loading
" plugins.
"
" - ALTLY: Plugins are loaded in their 'Plug' order,
"   so ideally you could just fiddle with the order.
"   But if two plugins are inter-dependent, you can
"   do it this way.

" -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function! g:depoxy#plug_pre#load() abort
  " ------------------------------------------------------
  " NERDCommenter config
  " ------------------------------------------------------

  " ABOUT: Inhibit NERDCommenter from creating any maps.
  " - CXREF: This setting cannot be done from the vim-depoxy plugin:
  "     ~/.kit/nvim/DepoXy/start/vim-depoxy/plugin/nerdcommenter-config.vim
  "   as explained next.

  " SAVVY: NERDCommenter runs from plugin/, and if you rely on the
  " default |packadd| behavior, the nerdcommenter/plugin/ files may
  " load before those under vim-depoxy/plugin/ (including the
  " vim-depoxy NERDCommenter config:
  "   ~/.kit/nvim/DepoXy/start/vim-depoxy/plugin/nerdcommenter-config.vim
  " ) because Vim loads directories under ~/.vim/pack alphabetically.
  " - Alternatively, you can fork NERDCommenter and
  "     mkdir -p after && git mv plugin/ after/plugin/
  "   and then this setting works from vim-depoxy.
  " - Or, you can use a plugin manager.
  "   - E.g., lazy.nvim allows you to set this value this from the
  "     plugin spec's init() method.
  "   But for vim-plug (this path), we need to call set this
  "   before plug#end() loads everything.
  "   - ALTLY: We could move this to a plugin that is earlier
  "     in the 'Plug' order. Because nerdcommenter-config.vim
  "     expects NERDCommenter to be loaded, we'd need to create
  "     a new plugin, e.g., vim-depoxy-preflight, or something.
  "     But for just this one settings (and long-winded comment),
  "     it seems easier to just do it this way.

  let g:NERDCreateDefaultMappings = 0
endfunction

