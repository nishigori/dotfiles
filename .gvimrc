"=============================================================================
" FILE:    .gvimrc
" AUTHOR:  Takuya Nishigori <nishigori.tak@gmail.com>
" LICENSE: WTFPL Version 2 {{{
"           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                    Version 2, December 2004
"
" Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
"
" Everyone is permitted to copy and distribute verbatim or modified
" copies of this license document, and changing it is allowed as long
" as the name is changed.
"
"            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
"
"  0. You just DO WHAT THE FUCK YOU WANT TO.
" }}}
"=============================================================================
" vim: set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:

" # Basic {{{
set norestorescreen
set guioptions=
set t_ti=
set t_te=

" need gvimrc on MacVim??
set hlsearch

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
" # Quick Start $MYGVIMRC {{{
if exists('g:local_config')
  let $MYGVIMRC = g:local_config['dotfiles_dir'] . '/.gvimrc'
  let $MYGVIMRC_LOCAL = $HOME . '/.gvimrc.local'
else
  if has('win32')
    let s:gvimrc = '_gvimrc'
    let s:gvimrc_local = '_gvimrc.local'
  else
    let s:gvimrc = '.gvimrc'
    let s:gvimrc_local = '.gvimrc.local'
  endif
  let $MYGVIMRC = $HOME . '/' . s:gvimrc
  let $MYGVIMRC_LOCAL = $HOME . '/' . s:gvimrc_local
endif
nnoremap e> :<C-u>edit $MYGVIMRC<CR>
nnoremap eS :<C-u>source $MYGVIMRC<CR>
" }}}
" # Window {{{
set lines=80
set columns=120

nnoremap <silent> ZZ :<C-u>close<CR>
" }}}
" # Font {{{
" INFO:
"   If You has any probrem,
"   Please reference HELP ('termencoding', 'macatsui').

if has('gui_gtk2')
  set guifont=Ricty\ Discord\ 11
  set guifontwide=めんまフォント
elseif has('gui_macvim')
  " TODO: めんまフォントに漢字合成
  set guifont=Ricty:h14,\ Monaco:h14
  "set guifontwide=ゆたぽん（コーディング）,\ みかちゃん,\ あくあフォント,\ Monaco
  set antialias
elseif has('win32')
  " WARNING: encodingを一時的に変える必要があるかもしれない
  "set encoding=cp932

  " not checked guifont.
  " http://magicant.txt-nifty.com/main/2009/03/gvim-on-windows.html
  set guifont=Inconsolata:h10.5
  set guifontwide=MS_Gothic
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
  set transparency=8
  set noimdisableactivate
elseif has('win32')
  "set guioptions+=C
  gui
  set transparency=222
endif
" }}}
" # Local Dependency {{{
if filereadable(expand($MYGVIMRC_LOCAL))
  " Override GVIM settings
  source $MYGVIMRC_LOCAL
endif
" }}}
" # Colorsheme {{{
if !g:my_config_use_plugin || !exists('g:colors_name')
  let g:colors_name = 'desert'
  set background=light
endif
" }}}
