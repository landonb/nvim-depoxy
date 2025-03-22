" One developer's Vim directory (dotfiles, etc.).
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/depoxy#🍯
"     Née: https://github.com/landonb/dubs-vim#🖖
" License: GPLv3

" ========================================================================

" SAVVY: You can disable automatically loading plugins in many ways:
"
"   $ vim -u NONE
"   $ vim -u DEFAULTS
"   $ vim --noplugin
"
" CALSO: |loadplugins| |lpl|
"
" - E.g., you could add this to you ~/.vimrc
"   instead of using `vim --noplugin`:
"
"   " BWARE: This inhibits vim-plug from working,
"   "        but it can be used with |packadd|
"   " Disable automatic loading
"   set noloadplugins
"
" REFER: |runtimepath| |packpath| |packadd| |packloadall|
"
" REFER: DepoXy uses vim-plug:
"
"     https://github.com/junegunn/vim-plug
"
" ABOUT: Below we call autoload# functions to register each plugin
" explicitly (so that we can disable plugins more easily than if
" we used Vim's conventional built-in ~/.vim/pack directory).
"
" - CXREF: When installed in DepoXy, plug specs found at:
"   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_3rdp.vim
"   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_dubs.vim
"   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_lsp.vim
"   ~/.kit/nvim/nvim-depoxy/.vim/autoload/depoxy/plug_pre.vim

" ------------------------------------------------------------

" USAGE: `NVD_PROFILE_START=1 vim` starts `profile` immediately.
"
" - SAVVY: Built-in Apple /usr/bin/vim does not support |profile|.
"
" - ALTLY: Startup time profiling: See also:
"     (n)vim --startuptime <file>

if has('profile') && $NVD_PROFILE_START != ''
  profile start /tmp/vim-profile.log
  profile file *
  profile func *

  echom 'nvim-depoxy: Started profiling: Run `profile dump` & `edit /tmp/vim-profile.log`'
endif

" ------------------------------------------------------------

" ------------------------------------------------------------
" Add user local bin to path.
" ------------------------------------------------------------

function! s:AppendPath_HomeLocalBin() abort
  let s:user_local_bin_path = $HOME . '/.local/bin'

  if isdirectory(s:user_local_bin_path)
    let $PATH = $PATH . ':' . s:user_local_bin_path
  endif
endfunction

" ------------------------------------------------------------
" Add system usr local bin to path.
" ------------------------------------------------------------

" 2020-09-23: Added so Vim Coc can run Homebrew node.
function! s:AppendPath_UsrLocalBin() abort
  let s:usr_local_bin_path = '/usr/local/bin'

  if isdirectory(s:usr_local_bin_path)
    let $PATH = $PATH . ':' . s:usr_local_bin_path
  endif
endfunction

" ------------------------------------------------------------
" Add user gopath bin to path.
" ------------------------------------------------------------

function! s:AppendPath_HomeGopathBin() abort
  let s:user_gopath_bin_path = $HOME . '/.gopath/bin'
  
  if isdirectory(s:user_gopath_bin_path)
    let $PATH = $PATH . ':' . s:user_gopath_bin_path
  endif
endfunction

call s:AppendPath_HomeLocalBin()
call s:AppendPath_UsrLocalBin()
call s:AppendPath_HomeGopathBin()

" ------------------------------------------------------------

" FIXME/2025-02-03 12:20: Merge these now, b/c same project.
" USYNC: OS Bootstrap and MacVim setup shared with minimal.vimrc
"        ~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal.vimrc
"
" - CPYST::
"   meld \
"     ~/.kit/nvim/nvim-depoxy/.vim/.vimrc \
"     ~/.kit/nvim/nvim-depoxy/bin/editor-vim-0-0-insert-minimal.vimrc &

" ----------------------------------------
"  Distro Bootstrap
" ----------------------------------------

" Not every Vim distribution includes a vimrc, but if we can find one,
" load it.
" - CALSO: Same with defaults.vim, which we'll source after this.
function! s:SourceDistroVimrc() abort
  if filereadable($VIMRUNTIME . "/../vimrc")
    " - E.g., MacVim:
    "   /Applications/MacVim.app/Contents/Resources/vim/runtime/../vimrc
    "   - CALSO:
    "     /Applications/MacVim.app/Contents/Resources/vim/gvimrc
    source $VIMRUNTIME/../vimrc
  elseif filereadable($VIMRUNTIME . "/../_vimrc")
    " - SAVVY/2009-09-21: For native Windows gVim to work properly.
    "   - HSTRY/2025-01-23: Keeping for historic reasons, but cannot vouch.
    source $VIMRUNTIME/../_vimrc
  elseif filereadable($VIMRUNTIME . "/../.vimrc")
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
  if filereadable($VIMRUNTIME . "/defaults.vim")
    " CXREF: Some places you might find this file:
    "   /Applications/MacVim.app/Contents/Resources/vim/runtime/defaults.vim
    "   /usr/share/vim/vim90/defaults.vim
    "   ~/.local/share/vim/vim90/defaults.vim
    source $VIMRUNTIME/defaults.vim
  endif
endfunction

" ISOFF/2025-01-23: I've found defaults.vim is necessary for minimal.vim,
" but I've never sourced for my regular Vim environment.
" - MAYBE: Enable this and see if has any impact.
if 0
  call s:SourceDistroDefaults()
endif

" ------------------------------------------------------------

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
  " REFER: If you want <Option> key presses to work more like
  " they do on Linux, enable |macmeta|.
  "
  " - On Linux, you can use `map <M->` syntax.
  "
  "   - E.g., use `<M-#>` to hook <Shift-Alt-3>.
  "
  "   - This also works in MacVim if you enable |macmeta|.
  "
  " - But `<M-#>` doesn't work with all GUIs, e.g., Neovide, or
  "   terminal Vim (macOS Alacritty).
  "
  " - The alternative is to disable |macmeta| and to use the literal
  "   characters that macOS emits when you use an <Alt>-combination.
  "
  " - E.g., here's how you might map <Shift-Alt-3>:
  "
  "     if has('macunix')
  "       " Use literal characters for macOS <Alt> keybindings
  "       nnoremap ‹ :Foobar<CR>
  "     else
  "       nnoremap <M-#> :Foobar<CR>
  "     endif
  "
  " - But note there's a trade-off:
  "
  "   - Neither approach supports all sequences.
  "
  "   - E.g., if you disable |macmeta|, you can wire <Shift-Alt-3>,
  "     but you cannot use the first character of the 2-character
  "     accent generators, e.g., <Alt-e>, <Alt-i>, <Alt-u>, etc.
  "
  "     When you press one of these, macOS waits for a second
  "     character before timing out, but if you press a second
  "     character, macOS sends a specific accented character.
  "     Obviously, you want to avoid using these in map commands.
  "
  "     - Unless there's another way to get `<M-#>` to work in Neovide
  "       like it does in MacVim... but I'm guessing something's not
  "       plumbed right... and I don't have digging-through-source
  "       kinda time at the moment.
  "
  " - Also note the <M-> bindings don't work in macOS unless you
  "   enable Option-as-Alt-key throughout your stack:
  "
  "   - You'd need to enable in your terminal, e.g.,
  "
  "       # ~/.config/alacritty/alacritty.toml
  "       option_as_alt = "Both"
  "
  "   - And then you'd need to enable in your editor, e.g.,
  "
  "       " ~/.vimrc  " (this file)
  "       if has('gui_macvim') | set macmeta | endif
  "
  "     And also in related editors, e.g., if you use Neovide:
  "
  "       -- ~/.depoxy/ambers/home/.config/nvim/init.lua
  "       vim.g.neovide_input_macos_option_key_is_meta = 'both'
  "
  " " Enable Alt-key (aka Meta, aka Option) mappings (e.g., <M-a>).
  " set macmeta

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

" ***

" Just a friendly reminder/nag while you onboard a new Mac.

function! s:AlertIfRunningAppleVim() abort
  if has('macunix') && !has('gui_macvim') && !has('nvim')
    " BWARE: This is meant to only run for Apple Vim, but if there's another
    " macOS Vim other than Apple's or MacVim, this'll likely alert on that.
    echom "ALERT: Please install MacVim for a better experience"
  endif
endfunction

call s:AlertIfRunningAppleVim()

" ------------------------------------------------------------

" ----------------------------------------
"  Plugin declarations
" ----------------------------------------

function! s:PlugBootstrap() abort
  if has('nvim')
    " Unnecessary check: Neovim doesn't source this file unless you source it.
    echom "ALERT: Don't source ~/.vimrc from Neovim, eh"

    return
  endif

  try
    call plug#begin()
  catch /^Vim\%((\a\+)\)\=:E117:/
    " E.g., E117: Unknown function: foo#bar#baz
    echom "ERROR: Missing autoload/plug.vim"
    echom "  https://github.com/junegunn/vim-plug"

    return
  endtry

  " Setup &rtp during ~/.vimrc processing so Vim auto-loads the plugins we register.
  " CXREF:
  "   ~/.vim/autoload/depoxy/plug_dubs.vim
  "   ~/.vim/autoload/depoxy/plug_3rdp.vim
  "   ~/.vim/autoload/depoxy/plug_lsp.vim
  call g:depoxy#plug_dubs#load()
  call g:depoxy#plug_3rdp#load()
  " ISOFF/2025-02-12: Not maintaining LSP support in Vim; use Neovim.
  " - In fact, use Neovim for everything, not sure why I'm maintaining
  "   ~/.vimrc config... but I think it migth finally be time to let go.
  call g:depoxy#plug_lsp#load()
  " FIXME/2025-02-09 09:02: Use infuse to inject DXC loaders
  " - E.g.,
  "     call g:depoxy#plug_client#load()
  " - NTHEN: Put next 3 Plug calls there.
  " So that vim-depoxy loads last.
  Plug '~/.kit/nvim/DepoXy/start/vim-depoxy'
  Plug '~/.kit/nvim/DepoXy/start/vim-trap'

  " CXREF:
  "   ~/.vim/autoload/depoxy/plug_pre.vim
  call g:depoxy#plug_pre#load()

  " Update &runtimepath and initialize the plugin system.
  " - Also runs `filetype plugin indent on` and `syntax enable`.
  call plug#end()

  " ***

  " SAVVY/2025-01-23: We could add VimEnter hook if we needed to do
  " any post-processing, e.g.
  "
  "   au VimEnter * call s:SourcePluginsPost()

  " Author's (favorite) colorscheme (won't error if not installed).
  " CXREF: ~/.kit/nvim/landonb/dubs_after_dark/colors/after-dark.vim
  " - Should be found on &rtp now because plug#end().
  silent! colorscheme after-dark
endfunction

call s:PlugBootstrap()

