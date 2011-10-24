" # Basic {{{
set norestorescreen
set guioptions=
set t_ti=
set t_te=

" need gvimrc on MacVim??
set hlsearch

colorscheme candycode

if has('clipboard')
  " :h gui-clipboard
  set guioptions+=a
endif
" When double clicked, search on word.
nnoremap <2-LeftMouse> g*
set mouse=a
" Show popup menu if right click.
set mousemodel=popup
set nomousefocus
" }}}
" # Encoding {{{
if has('win32')
  set encoding=utf-8
  scriptencoding cp932
endif
" }}}
" # Quick Start $MYGVIMRC {{{
if has('win32')
  let s:gvimrc = '_gvimrc'
  let s:gvimrc_local = '_gvimrc.local'
else
  let s:gvimrc = '.gvimrc'
  let s:gvimrc_local = '.gvimrc.local'
endif
if exists('g:dependency_local_lists')
  let $MYGVIMRC = g:dependency_local_lists['dotfiles_dir'] . '/' . s:gvimrc
else
  let $MYGVIMRC = $HOME . '/' . s:gvimrc
endif
let $MYGVIMRC_LOCAL = $HOME . '/' . s:gvimrc_local
nnoremap e> :<C-u>edit $MYGVIMRC<Cr>
nnoremap eS :<C-u>source $MYGVIMRC<Cr>
" }}}
" # Window {{{
" INFO: Please edit default window size @.gvimrc.local
if filereadable(expand($MYGVIMRC_LOCAL))
  echo 'test'
  source $MYGVIMRC_LOCAL
  " set lines= columns=
endif

nnoremap <silent> ZZ :<C-u>close<Cr>
" }}}
" # Font {{{
" INFO:
"   If You has any probrem,
"   Please reference HELP ('termencoding', 'macatsui').

if has('gui_gtk2')
  set guifont=Ricty\ 11
  set guifontwide=めんまフォント
elseif has('gui_macvim')
  " TODO: めんまフォントに漢字合成
  set guifont=Ricty:h14,\ Monaco:h14
  set guifontwide=ゆたぽん（コーディング）,\ みかちゃん,\ あくあフォント,\ Monaco
  set antialias
elseif has('win32')
  " WARNING: encodingを一時的に変える必要があるかもしれない
  "set encoding=cp932

  " not checked guifont.
  " http://q.hatena.ne.jp/1138349864
  " http://magicant.txt-nifty.com/main/2009/03/gvim-on-windows.html
  set guifont=Inconsolata:h12
  "set guifontwide=ゆたぽん（コーディング）:みかちゃん:めんまフォント:MS_Gothic

  "set encoding=utf-8
endif

if has('kaoriya')
  " TODO: need checking Windows
  set linespace=2
  " ?? ambiwidth=single
  "set ambiwidth=auto
endif
" }}}
" # Depends On OS {{{
"if has('gui_macvim')
if has('mac')
  set transparency=11
endif

if has('win32')
  set guioptions+=C
  set transparency=233
endif
" }}}


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
