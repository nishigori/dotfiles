colorscheme candycode
set norestorescreen
set guioptions=
set t_ti=
set t_te=

" INFO: Please edit default window size @.gvimrc.local
if filereadable(expand($HOME . '/.gvimrc.local'))
  source $HOME/.gvimrc.local
  " set lines= columns=
endif

if has('clipboard')
  " :h gui-clipboard
  set guioptions+=a
endif

" When double clicked, search on word.
nnoremap <2-LeftMouse> g*
set mouse=a
" Show popup menu if right click.
set mousemodel=popup
set nomousefocus    " マウス移動によるフォーカス切り替えを無効

if has('gui_gtk2') || has('gui_macvim')
  "set guifont=Ricty\ 11
  "set guifontwide=めんまフォント
endif

" For MacVim
if has('gui_macvim')
  set transparency=11
  set antialias
  " MacVimではhlsearchをgvimrcに書かないといけないらしい
  " 詳細: $VIM/gvimrc
  set hlsearch
endif

nnoremap <silent> ZZ :<C-u>close<Cr>


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
