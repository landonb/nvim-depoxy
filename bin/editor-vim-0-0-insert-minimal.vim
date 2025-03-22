" vim:tw=0:ts=2:sw=2:et:norl:ft=vim
" Author: Landon Bouma <https://tallybark.com/>
" Project: https://github.com/DepoXy/nvim-depoxy#🐇
" License: MIT. Please find more in the LICENSE file.

" Copyright (c) © 2015, 2018-2025 Landon Bouma. All Rights Reserved.

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" Close undo sequence on newline.
" - Use case is normally starting a fresh line and messing up the
"   first few words or changing what I'm thinking of writing.
" - Though normally I'll hit <Ctrl-W> to delete back a word,
"   or <Shift-Ctrl-W> to delete the whole line.
" - Really, I don't use undo that often, but when I do, I'm
"   still not used to Vim obliterately everything I've written
"   since I entered Insert mode!
" - Note, too, that using <Ctrl-{Arrow}> to jump around will
"   break an undo sequence (e.g., <Ctrl-Left> runs <C-O>b,
"   and the <C-O> naturally ends an undo sequence because
"   it temporary breaks out of insert mode to run a command,
"   which inherently closes the current undo sequence).
"
" REFER: :h i_CTRL-G_u

" Create new undo block at every newline, undoes to end of prev line.
"   inoremap <CR> <C-g>u<CR>
" Create new undo block at every newline, undoes to end of curr line.
inoremap <CR> <CR><C-g>u

" Undoes to start of word that's removed.
"   inoremap <Space> <Space><C-g>u
" Undoes to end of word that's removed.
" - But if you tab and it expands, *every space is an undo!*
" - So I'd say this is too annoying, way too fine-grained.
"   - You're better off <Ctrl-W>'ing to delete the previous
"     word or otherwise normally editing any mistakes on the
"     current line.
"
"   inoremap <Space> <C-g>u<Space>

" You could similar close undo sequences on <Tab>, but author
" almost exclusively expands <Tab>, and this Vimrc is mainly
" for Git commit messages wherein you won't use a real <Tab>.
"
"   inoremap <Tab> <Tab><C-g>u

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" CXREF: The \dQ here is same as <C-s> 
" Most for parity, so I'm not suprised if this doesn't work.
" - But generally I <C-s> to save and quit a Git commit message
"   EDITOR session.
" - This is not exactly COPYD, but a much simpler impl. of Dubs Vim's
"   it's same as <C-s> ctrl-s-save-command.vim sourced above.
" CXREF: https://github.com/DepoXy/vim-depoxy#🤙
"   ~/.kit/nvim/DepoXy/start/vim-depoxy/plugin/save-close-quit-maps.vim

nnoremap <Leader>dQ :wq<CR>
inoremap <Leader>dQ <C-o>:wq<CR>

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" COPYD: ~/.kit/nvim/landonb/dubs_ftype_mess/plugin/dubs_ftype_mess.vim
"   https://github.com/landonb/dubs_ftype_mess

" SAVVY: Vim defaults textwidth=72 and wraps once you type past that boundary.

" SAVVY: Even with spellcheck on, Vim ignores spell errors below the diff line.
" - E.g.:
"    # Please enter the commit message for your changes. Lines starting
"    # with '#' will be ignored, and an empty message aborts the commit.
"    ...
"    SpellingError <--Spell checked
"    diff --git foo foo
"    SpellingError <-- Not spelled checked

autocmd FileType gitcommit setlocal textwidth=0 shiftwidth=2 tabstop=2 expandtab spell

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

" Disable line no. for distraction-free Git commit authoring.
" - CXREF:
"   ~/.kit/nvim/landonb/dubs_appearance/plugin/line_numbers_show.vim
set nonu

" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

