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

" Basic: {{{
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
if !has('nvim')
  set norestorescreen
endif
" }}}
" QuickStartMyGvimRC: {{{
if exists('g:local_config')
  let $MYGVIMRC = g:local_config['dotfiles_dir'] . '/.gvimrc'
  let $MYGVIMRC_LOCAL = $HOME . '/.secrets/.gvimrc.local'
else
  let $MYGVIMRC = $HOME . '/.gvimrc'
  let $MYGVIMRC_LOCAL = $HOME . '/.secrets/.gvimrc.local'
endif
nnoremap e> :<C-u>edit $MYGVIMRC<CR>
nnoremap eS :<C-u>source $MYGVIMRC<CR>
" }}}
" Window: {{{
set lines=85
set columns=150

nnoremap <silent> ZZ :<C-u>close<CR>
" }}}
" Font: {{{
" INFO:
"   If You has any probrem,
"   Please reference HELP ('termencoding', 'macatsui').
set linespace=2
" }}}
" DependsOS: {{{
if has('mac') && !has('nvim')
  set transparency=5
endif
if has("gui_macvim") && !exists('g:vscode')
  " List of Enabled <D- keymap
  macmenu Edit.Cut<Tab>"+x				key=<D-x>
  macmenu Edit.Copy<Tab>"+y			key=<D-c>
  macmenu Edit.Paste<Tab>"+gP			key=<D-v>
  macmenu Edit.Select\ All<Tab>ggVG		key=<D-a>
  macmenu Edit.Font.Bigger				key=<D-=>
  macmenu Edit.Font.Smaller			key=<D-->
  macmenu Window.Toggle\ Full\ Screen\ Mode	key=<D-C-f>

  " Disabled needless default key mapping
  " @see h: macmenuenu, :e $VIMRUNTIME/menu.vim
  macmenu File.New\ Window				key=<Nop>
  macmenu File.New\ Tab				key=<Nop>
  "macmenu File.Open\.\.\.				key=<Nop>
  macmenu File.Open\ Tab\.\.\.<Tab>:tabnew		key=<Nop>
  macmenu File.Close\ Window<Tab>:qa		key=<D-W>
  macmenu File.Close				key=<D-w>
  macmenu File.Save<Tab>:w				key=<D-s>
  macmenu File.Save\ All				key=<Nop>
  "macmenu File.Save\ As\.\.\.<Tab>:sav		key=<Nop>
  macmenu File.Print				key=<Nop>
  macmenu Edit.Undo<Tab>u				key=<Nop>
  macmenu Edit.Redo<Tab>^R				key=<Nop>
  "macmenu Edit.Find.Find\.\.\.			key=<Nop>
  macmenu Edit.Find.Find\ Next			key=<Nop>
  macmenu Edit.Find.Find\ Previous			key=<Nop>
  macmenu Edit.Find.Use\ Selection\ for\ Find	key=<Nop>
  "macmenu Tools.Spelling.To\ Next\ error<Tab>]s	key=<Nop>
  macmenu Tools.Spelling.Suggest\ Corrections<Tab>z=   key=<Nop>
  macmenu Tools.Make<Tab>:make			key=<Nop>
  macmenu Tools.List\ Errors<Tab>:cl		key=<Nop>
  macmenu Tools.Next\ Error<Tab>:cn		key=<Nop>
  macmenu Tools.Previous\ Error<Tab>:cp		key=<Nop>
  macmenu Tools.Older\ List<Tab>:cold		key=<Nop>
  macmenu Tools.Newer\ List<Tab>:cnew		key=<Nop>

  macmenu Window.Minimize		key=<Nop>
  macmenu Window.Minimize\ All	key=<Nop>
  macmenu Window.Zoom		key=<Nop>
  macmenu Window.Zoom\ All		key=<Nop>
  "macmenu Window.Select\ Next\ Tab			key=<Nop>
  "macmenu Window.Select\ Previous\ Tab		key=<Nop>

  macmenu Help.MacVim\ Help			key=<Nop>
endif
" }}}
" LocalDependency: {{{
if filereadable(expand($MYGVIMRC_LOCAL))
  " Override GVIM settings
  source $MYGVIMRC_LOCAL
endif
" }}}

" Hook loaded gvimrc
if exists("*LoadedHookGVIMRC")
  call LoadedHookGVIMRC()
endif
