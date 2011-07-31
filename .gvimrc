set norestorescreen
set guioptions=
set t_ti=
set t_te=

" Default window size
" TODO: vimrc.local定義に移す
set lines=50
set columns=160

" When double clicked, search on word.
nnoremap <2-LeftMouse> g*
set mouse=a
" Show popup menu if right click.
set mousemodel=popup
set nomousefocus		" マウス移動によるフォーカス切り替えを無効

if has('gui_gtk2')
  " Font_list { common: [Ricty, monofur, Monaco], wide: [めんまフォント] }
  set guifont=Ricty\ 11
  set guifontwide=めんまフォント
endif

nnoremap <silent> ZZ :<C-u>close<Cr>


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
