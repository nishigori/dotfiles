set norestorescreen
set guioptions=
set t_ti=
set t_te=

" INFO: Please edit default window size @.vimrc.local
" set lines=
" set columns=

" When double clicked, search on word.
nnoremap <2-LeftMouse> g*
set mouse=a
" Show popup menu if right click.
set mousemodel=popup
set nomousefocus    " マウス移動によるフォーカス切り替えを無効

if has('gui_gtk2')
  set guifont=Ricty\ 11
  set guifontwide=めんまフォント
endif

nnoremap <silent> ZZ :<C-u>close<Cr>


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
