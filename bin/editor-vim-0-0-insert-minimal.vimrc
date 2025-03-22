" vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/nvim-depoxy#🐇
" License: MIT. Please find more in the LICENSE file.

" Copyright (c) © 2015, 2018-2025 Landon Bouma. All Rights Reserved.

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" COPYD: OS Bootstrap and MacVim setup copied from .vim/.vimrc
" ~/.kit/nvim/nvim-depoxy/.vim/.vimrc

" ----------------------------------------
"  Distro Bootstrap
" ----------------------------------------

" Not every Vim distribution includes a vimrc, but if we can find one,
" load it.
" - CALSO: Same with defaults.vim, which we'll source after this.
function! s:SourceDistroVimrc() abort
  if filereadable($VIMRUNTIME .. "/../vimrc")
    " - E.g., MacVim:
    "   /Applications/MacVim.app/Contents/Resources/vim/runtime/../vimrc
    "   - CALSO:
    "     /Applications/MacVim.app/Contents/Resources/vim/gvimrc
    source $VIMRUNTIME/../vimrc
  elseif filereadable($VIMRUNTIME .. "/../_vimrc")
    " - SAVVY/2009-09-21: For native Windows gVim to work properly.
    "   - HSTRY/2025-01-23: Keeping for historic reasons, but cannot vouch.
    source $VIMRUNTIME/../_vimrc
  elseif filereadable($VIMRUNTIME .. "/../.vimrc")
    " - Possibly found on some 'nix distros [author added this block in
    "   2009, when I may have been on Fedora in VM on Windows, and also
    "   using Cygwin, but 2009 Cygwin Vim doesn't include a vimrc file].
    source $VIMRUNTIME/../.vimrc
  else
    " Don't bother complaining. This file doesn't exist everywhere.
    " - E.g., Debian 12 has /usr/share/vim/gvimrc, but no vimrc (and
    "   gvimrc is just comments).
    " - Also, e.g., LM 19.3: Author runs local build, where
    "   $VIMRUNTIME is ~/.local/share/vim/vim82/ but there's nothing
    "   else under ~/.local/share/vim and no vimrc thereunder.
  endif
endfunction

call s:SourceDistroVimrc()

" ***

" You'll likely find a defaults.vim in the runtime path,
" but it's not always necessary to source it.
" - E.g., the author's usual Vim configuration ignores it
"   and runs just fine.
" - But I had issues when I didn't source it for minimal.vim:
"   - There were strange phantom control characters on the first
"     line of input; the arrow keys didn't work (they'd insert
"     As, Bs, Cs, and Ds); Ctrl-s didn't work; and also probably
"     lots more but I quit after noting those three.
"   - DUNNO: I think MacVim vim TUI, but might have been Linux build.
" - So this `source defaults.vim` necessary from minimal.vimrc,
"   but probably not from your normal ~/.vimrc
function! s:SourceDistroDefaults() abort
  if filereadable($VIMRUNTIME .. "/defaults.vim")
    " CXREF: Some places you might find this file:
    "   /Applications/MacVim.app/Contents/Resources/vim/runtime/defaults.vim
    "   /usr/share/vim/vim90/defaults.vim
    "   ~/.local/share/vim/vim90/defaults.vim
    source $VIMRUNTIME/defaults.vim
  endif
endfunction

call s:SourceDistroDefaults()

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" CALSO: See also author's more complicated mswin.vim loader,
"        which saves and restores <C-f> and <C-h> bindings.
"
" - That's only necessary if you call `mswin.vim` during normal
"   plugin startup, in case another plugin sets <C-f> and <C-h>
"   before mswin.vim runs. But if you call it early, no worries.
"
" CXREF: https://github.com/landonb/dubs_edit_juice#🧃
"
"   https://github.com/landonb/dubs_edit_juice/blob/release/after/plugin/enable-behave-mswin.vim
"
" ALTLY: You can also source that plugin file here, e.g.:
"
"  source ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/enable-behave-mswin.vim

function! s:EnableBehaveMswin() abort
  let s:running_windows = has("win16") || has("win32") || has("win64")

  if !s:running_windows
    if has('nvim')
      " CXREF:
      " /Applications/MacVim.app/Contents/Resources/vim/runtime/mswin.vim
      source $VIMRUNTIME/mswin.vim
    else
      behave mswin
    endif

    return 1
  endif

  return 0
endfunction

" DEVEL: Enable this to test bare mswin Vim.
if 0 && s:EnableBehaveMswin()

  finish
endif

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" ------------------------------------------------------
" Preemptive MacVim configuration
" ------------------------------------------------------

" Disable features from MacVim gvimrc, and enable Alt-key sequences.
"
" CXREF:
" /Applications/MacVim.app/Contents/Resources/vim/gvimrc

" SAVVY: Because scope, do not call `let` from within fcn.
"
" - E.g., this won't work:
"
"     function! s:ConfigureMacVim() abort
"       let macvim_skip_colorscheme=1
"       ...
"
"   because macvim_skip_colorscheme won't be visiable outside
"   that function.

" Note that MacVim also sets 'gui_macvim' for terminal Vim.
if has('macunix') && has('gui_macvim')
  " ISOFF: For broader compatibility throughout macOS (n)vim instances,
  " be they GUIs or TUIs, prefer using literal <Option> key map sequences,
  " and not control sequences.
  " - E.g., while this binds <Shift-Alt-3> on Linux and in MacVim with
  "   |macmeta| enabled:
  "     nnoremap <M-#> :Foobar<CR>
  "   It doesn't work in Neovide or terminal Vim.
  " - So use literal characters instead, e.g.:
  "     nnoremap ‹ :Foobar<CR>
  "   though note you'll want to avoid 2-character macOS accent-generator
  "   bindings, like <Option-e>, <Option-i>, etc.
  "
  "  " Enable Alt-key (aka Meta, aka Option) mappings (e.g., <M-a>).
  "  set macmeta

  " Don't let MacVim call `colorscheme macvim`.
  " - See our `colorscheme` call elsewhere in this file.
  " - CXREF:
  "   ~/.kit/nvim/landonb/dubs_after_dark/
  " - REFER: |macvim-colorscheme|
  let macvim_skip_colorscheme=1

  " Glossary: HIG: Apple's Human interface Guidelines.

  " Disable HIG Cmd and Option (Alt) movement mappings.
  " - Dubs Vim makes its own mappings.
  " - CXREF: :h alt-movement
  let macvim_skip_cmd_opt_movement=1

  " Enable so-called HIG shift movement, which makes Vim a little more like
  " GUI text editors, e.g., holding down Shift + a movement key will extend
  " the selection.
  " - Dubs Vim makes its own mappings.
  " - CXREF: :h macvim-shift-movement
  let macvim_hig_shift_movement=1
endif

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" USAGE: Set NVIMDEPOXY_PLUG_PATH if your plugins are not under ~/.vim/pack
"
" - Note that |packadd| scans the |packpath| directories to locate
"   plugin scripts — at {packpath}/pack/*/opt/{plugin-name}/plugin/
"
"     - And also at {packpath}/pack/*/start/{plugin-name}/plugin/
"       if --noplugins or noloadplugins in effect.
"
" - Because ~/.vim is the first path on &packpath, ~/.vim/pack is
"   commonly used for storing plugins, at least if the user is
"   relying on built-in |packloadall| behavior.
"
" - But if user is using a plugin manager, e.g., vim-plug, then they're
"   likely *not* using ~/.vim/pack, so that Vim does not automatically
"   load any plugins.
"
"   - In this case, there is no conventional plugins path.
"
"   - Furthermore, plugin managers don't expact the packpath layout.
"
"     - E.g., you'd call just `Plug '~/path/to/my/plugin` to register
"       a plugin with vim-plug (and later vim-plug calls `source` on
"       the individual plugin/ and after/ files).
"
" - Note that DepoXy stores plugins under the arbitrarily-picked
"   ~/.kit/nvim (which you'll see refereneced in comments throughout
"   this file).
"
"   - But ~/.kit/nvim doesn't itself have a pack/ subdirectory.
"
"   - If we wanted to use |packadd|, we'd need that pack/ directory:
"
"     - We could stuff everything under ~/.kit/nvim/pack/
"
"     - Or we could create an intermediate directory, e.g.,
"
"         mkdir ~/.vim/foo
"         ln -s ~/.kit/nvim ~/.vim/foo/pack
"         TIGNEWTONS_VIM_PACKPATH=~/.vim/foo \
"           vim -u minimal.vimrc --noplugin
"
"       - And then herein: set packpath+=$TIGNEWTONS_VIM_PACKPATH
"
"   - Because of this (minor) issue, use vim-plug and don't worry 'bout
"     the intermediate pack/ directory.

" ----------------------------------------
"  Plugin declarations
" ----------------------------------------

function! s:PlugBootstrap() abort
  if has('nvim')
    " Unnecessary check: Neovim doesn't source this file unless you source it.
    echom "ALERT: Don't source ~/.vimrc from Neovim, eh"

    return 0
  endif

  " ***

  " Check if plugin dir for vim-plug, e.g., DepoXy uses ~/.kit/nvim
  let s:plugins_dir = $NVIMDEPOXY_PLUG_PATH

  " Fallback ~/.vim/pack and |packadd|
  if s:plugins_dir == ''
      \ || fnamemodify(s:plugins_dir, ':p') == fnamemodify($HOME .. '/.vim/pack', ':p')
    let s:plugins_dir = ''

    " REFER: |loadplugins| aka |lpl| is unnecessary here if caller
    " used --noplugin, but setting here means they don't have to.
    " - E.g., these both work:
    "     vim -u /path/to/editor-vim-0-0-insert-minimal.vimrc --noplugin
    "     vim -u /path/to/editor-vim-0-0-insert-minimal.vimrc
    " - BWARE: But don't use with vim-plug or nothing loads.
    set noloadplugins
  endif

  " ***

  if s:plugins_dir != ''
    try
      call plug#begin()
    catch /^Vim\%((\a\+)\)\=:E117:/
      " E.g., E117: Unknown function: foo#bar#baz
      echom "ERROR: Missing autoload/plug.vim from:"
      echom "  https://github.com/junegunn/vim-plug"

      return 0
    endtry
  endif

  " ***

  " vim-sensible — 'Defaults everyone can agree on'
  " https://github.com/tpope/vim-sensible
  " - CXREF:
  "   ~/.kit/nvim/tpope/opt/vim-sensible/plugin/sensible.vim
  call s:PlugsRegister(s:plugins_dir, 'tpope/opt/vim-sensible')

  " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
  " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

  " SAVVY/2024-12-12: Load select plugins at runtime.
  " - So far I don't notice a performance difference
  "   with these enabled or not.
  " - Note that after/plugin/ scripts are *not* loaded by |packadd|
  "   (if ~/.vim/pack exists), but they are by vim-plug (if using
  "   user-provided plugins path).

  call s:SourcePluginsPre()

  " ***

  " Load a look 'n feel (lots of `set` commands).
  " https://github.com/landonb/dubs_appearance#💅
  call s:PlugsRegister(s:plugins_dir, 'landonb/dubs_appearance')

  " ***

  " Load a ton of command maps to which author is accustomed.
  " https://github.com/landonb/dubs_edit_juice#🧃
  call s:PlugsRegister(s:plugins_dir, 'landonb/dubs_edit_juice')

  " ***

  " Load selection gestures (like <Ctrl-Shift-{Arrow}>).
  " https://github.com/landonb/vim-select-mode-stopped-down#🛑
  call s:PlugsRegister(s:plugins_dir, 'landonb/vim-select-mode-stopped-down')

  " ***

  " Supports non-blocking Insert mode maps, e.g., `gf` to open files,
  " or `kj` to 'escape' to Normal mode.
  call s:PlugsRegister(s:plugins_dir, 'embrace-vim/start/vim-async-map')

  " Supports opening links, and searching and defining words in new
  " browser window.
  call s:PlugsRegister(s:plugins_dir, 'embrace-vim/start/vim-webopen')

  " Author's vibrant colorscheme with actual black background (and
  " not just a dark grey).
  call s:PlugsRegister(s:plugins_dir, 'landonb/dubs_after_dark')

  " ***

  " Update &runtimepath and initialize the plugin system.
  " - Also runs `filetype plugin indent on` and `syntax enable`.
  if s:plugins_dir != ''
    call plug#end()
  endif

  " ***

  " Author's (favorite) colorscheme (won't error if not installed).
  " CXREF: ~/.kit/nvim/landonb/dubs_after_dark/colors/after-dark.vim
  " - Should be found on &rtp now because plug#end().
  silent! colorscheme after-dark

  return 1
endfunction

" ***

function! s:PlugsRegister(plugins_dir, subdir) abort
  if a:plugins_dir != ''
    " Using arbitrary plugins path, and bootstrapping with vim-plug.
    call s:PlugsRegister_Vimplug(a:plugins_dir, a:subdir)
  else
    " Using conventional ~/.vim/pack path, and relying on |packadd|.
    call s:PlugsRegister_Packpath(a:subdir)
  endif
endfunction

" SAVVY: Note that 'Plug' will source files under after/, but when
" using |packadd|, Vim will not source files under after/.
" - See below: s:LoadDubsAfterJuiceCommands()
"   which manually sources after/ scripts when using |packadd|
" - Otherwise just FYI: |Plug| sources all after/ scripts.
function! s:PlugsRegister_Vimplug(plugins_dir, subdir) abort
  let l:project_path = a:plugins_dir .. '/' .. a:subdir

  if isdirectory(l:project_path)
    Plug l:project_path
  else
    echom 'ALERT: Missing vim-plug plugin: ' .. l:project_path
  endif
endfunction

function! s:PlugsRegister_Packpath(subdir) abort
  let l:plugin_name = fnamemodify(a:subdir, ':t')

  try
    exec 'packadd ' .. l:plugin_name
  catch /^Vim\%((\a\+)\)\=:E919:/
    " E.g., E919: Directory not found in 'packpath': "pack/*/opt/foo"
    echom 'ALERT: Missing packpath plugin: ' .. l:plugin_name
  endtry
endfunction

" ***

" REFER: See also same comment below:
" - <C-s> saves and quits (:wq).
"   ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/ctrl-s-save-command.vim
function! s:SourcePluginsPre() abort
  let $VIM_EDIT_JUICE_EXIT_ON_SAVE = 1
endfunction

" ***

if ! s:PlugBootstrap()

  finish
endif

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" SAVVY: :packadd does not source after/plugin/ scripts.

" CXREF: https://github.com/landonb/dubs_edit_juice
"
" - <C-c> copy, etc.
"   ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/enable-behave-mswin.vim
"
" - <C-h> hides search highlight (:nohlsearch)
"   ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/hide-highlights.vim
"
" - Center cursor on search jump (n, N, <M-n>, <M-N>, *, #, g*, g#)
"   ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/center-cursor-on-highlight-next-search-match.vim
"
" - <C-s> saves and quits (:wq).
"   ~/.kit/nvim/landonb/dubs_edit_juice/after/plugin/ctrl-s-save-command.vim
"
"     let $VIM_EDIT_JUICE_EXIT_ON_SAVE = 1
"
"   - CXREF: See above: s:SourcePluginsPre()

function! s:LoadDubsAfterJuiceCommands() abort
  " Check if custom plugin path, e.g., ~/.kit/nvim
  if s:plugins_dir != ''
    " Unnecessary when using vim-plug, which sources after/ files.

    return
  endif

  call s:SourcePluginsPre()

  " Conventional ~/.vim/pack path
  let l:pack_dir = $HOME .. '/.vim/pack'

  for l:sourcep in [
    \ l:pack_dir .. '/landonb/dubs_edit_juice/after/plugin/enable-behave-mswin.vim',
    \ l:pack_dir .. '/landonb/dubs_edit_juice/after/plugin/hide-highlights.vim',
    \ l:pack_dir .. '/landonb/dubs_edit_juice/after/plugin/center-cursor-on-highlight-next-search-match.vim',
    \ l:pack_dir .. '/landonb/dubs_edit_juice/after/plugin/ctrl-s-save-command.vim',
  \ ]
    if filereadable(l:sourcep)
      exec "source " .. l:sourcep
    endif
  endfor
endfunction

call s:LoadDubsAfterJuiceCommands()

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" Use the path to this script to find the grep script.
" - CXREF:
"   ~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal.vim
exec 'source ' .. expand('<script>:h') .. '/editor-vim-0-0-insert-minimal.vim'

" " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

