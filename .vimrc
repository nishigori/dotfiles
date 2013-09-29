"=============================================================================
"  _       _    ____              _ _                       _        _
" | |__   | |  |  _ \  ___  _ __ ( ) |_   _ __   __ _ _ __ (_) ___  | |
" | '_ \  | |  | | | |/ _ \| '_ \|/| __| | '_ \ / _` | '_ \| |/ __| | |
" | | | | |_|  | |_| | (_) | | | | | |_  | |_) | (_| | | | | | (__  |_|
" |_| |_| (_)  |____/ \___/|_| |_|  \__| | .__/ \__,_|_| |_|_|\___| (_)
"                                        |_|
"
" FILE:    .vimrc
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

" # runtimepath {{{
if has('vim_starting') && has('win32')
  " INFO: .vimrc unifies vimrc
  "       .vim   unifies vimfiles
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
endif
" }}}
" # encoding {{{
" Note: Kaoriya MacVim is needless encoding.
if !has('gui_macvim') || !has('kaoriya')
  " INFO: If encode is fixed, :e ++enc={encoding-name}
  set encoding=utf-8
  set fileencodings=utf-8,shiftjis,euc-jp,iso-2022-jp
endif
if has('win32')
  let &termencoding=&encoding
  set encoding=utf-8
  set fileencodings=utf-8,cp932,shiftjis,euc-jp,iso-2022-jp
endif
" }}}
" # Basic "{{{
"filetype plugin indent on
set nocompatible               " Use Vim defaults (much better!)
set showcmd                    " Highliting bracket set.
set hidden                     " Enable open new file, when while editing other file.
set autoread
set history=255
set viminfo='20,\"100           " Read/write a .viminfo file, don't store more than 50 lines of registers
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set ambiwidth=double
set virtualedit+=block         " Block-select to the end of the line for blockwise Visual mode.
set shortmess+=filmnrxoOtT     " Avoid all the hit-enter prompts
set title
set completeopt=menuone        " A comma separated list of options

set helplang=ja,en
set keywordprg=:help
nnoremap <silent> <C-h> :<C-u>help<Space><C-r><C-w><CR>

let mapleader = " "
" }}}
" Local Dependency {{{
set nobackup noswapfile
let g:my_config_use_plugin = get(g:, 'my_config_use_plugin', 0)

let $MYVIMRC_LOCAL = $HOME . '/.vimrc.local'
if filereadable(expand($MYVIMRC_LOCAL))
  set backup swapfile
  " INFO: Read more .vimrc.local.dist
  source $MYVIMRC_LOCAL

  let $MYVIMRC = g:local_config['dotfiles_dir'] . '/.vimrc'
  " Quick start my vimrc
  nnoremap <silent> e. :<C-u>edit $MYVIMRC<CR>
  nnoremap <silent> eS :<C-u>source $MYVIMRC<CR>

  " Use weekly buffer for GTD.
  nnoremap <silent> <S-t><S-t> :call weekly_buffer#open()<CR>

  " Load settings for each location {{{
  augroup load_local_config
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:load_rc_local(expand('<afile>:p:h'))
  augroup END
  function! s:load_rc_local(loc)
    let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
      source `=i`
    endfor
  endfunction " }}}
  " Bundle {{{
  if g:my_config_use_plugin && !exists('g:loaded_neobundle')
    source $HOME/.vim/bundle.vim
    let s:bundle_dir = $HOME . '/.vim/bundle'
  endif
  " }}}
endif

let s:tmpdir = exists('g:local_config["tmp_dir"]')
  \ ? g:local_config['tmp_dir']
  \ : $HOME
" }}}
" # Switch ; <-> : {{{
" Warning: Don't use ':remap' as possible (for Unaffected).
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

nnoremap q; q:
vnoremap q; q:
" }}}
" # Syntax {{{
if has('syntax')
  syntax enable
  set synmaxcol=1500
  set nospell
  "scriptencoding utf-8

  set list
  " - tab: タブ文字, trail: 行末スペース, eol: 改行文字, extends: 行末短縮, precedes: 行頭短縮, nbsp: 空白文字
  set listchars=tab:»-,extends:>,precedes:<,eol:↲,nbsp:%,trail:-,nbsp:>

  augroup ZenSpace
    autocmd!
    autocmd ColorScheme * highlight ZenSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
    autocmd WinEnter,BufNew,BufReadPost,ColorScheme *
      \ if &filetype !~ 'unite\|vimshell\|vimfiler\|git\|rst'
      \   | match ZenSpace /　\|\s\+$/ |
      \ endif
  augroup END

  if v:version >= 703
    set relativenumber
  endif
  set number
  set numberwidth=4
endif

set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
" }}}
" # Indent {{{
set autoindent
set expandtab " replaced Tab with Indent
set tabstop=4
set shiftwidth=4
set softtabstop=0

let g:vim_indent_cont = 2
" }}}
" # Filetype Detect {{{
" Moved ~/.vim/filetype.vim
let g:sql_type_default = 'mysql' " SQL
" }}}
" # Color Scheme {{{
set t_Co=256
if !has('gui_runnig') || !g:my_config_use_plugin || !exists('g:colors_name')
  let g:colors_name = 'desert'
  set background=dark
endif

let g:solarized_termcolors = 256  " CASE: g:colors_name is solarized

" Add cursorline at the current window.
augroup cch
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

let g:apache_version = '2.0' " apache highliting

" highlighting target of long line.
if exists('&colorcolumn')
  set colorcolumn=+1
  "nnoremap <silent> <Leader>l :<C-u>set<Space>spell!<Space>list!<Space>colorcolumn=-1<CR>
  nnoremap <silent> <Leader>l :<C-u>set<Space>list!<Space>colorcolumn=-1<CR>
endif

"# HIGHLIGHT_CURRENT_LINE
nnoremap <silent> <Leader>hs :<C-u>HighlightCurrentLine Search<CR>
nnoremap <silent> <Leader>hd :<C-u>HighlightCurrentLine DiffAdd<CR>
nnoremap <silent> <Leader>he :<C-u>HighlightCurrentLine Error<CR>
nnoremap <silent> <Leader>H  :<C-u>UnHighlightCurrentLine<CR>
command! -nargs=1 HighlightCurrentLine execute 'match <args> /<bslash>%'.line('.').'l/'
command! -nargs=0 UnHighlightCurrentLine match
" }}}
" # Console {{{
" By Sir.thinca http://d.hatena.ne.jp/thinca/20101215/1292340358
if has('unix') && !has('gui_running')
  " Use meta keys in console.
  function! s:use_meta_keys()  " {{{2
    for i in map(
      \   range(char2nr('a'), char2nr('z'))
      \ + range(char2nr('A'), char2nr('Z'))
      \ + range(char2nr('0'), char2nr('9'))
      \ , 'nr2char(v:val)')
      " <ESC>O do not map because used by arrow keys.
      if i != 'O'
        execute 'nmap <ESC>' . i '<M-' . i . '>'
      endif
    endfor
  endfunction  " }}}2

  call s:use_meta_keys()
  map <NUL> <C-Space>
  map! <NUL> <C-Space>

  " stopped job
  nnoremap <silent> gZZ :set t_te = t_ti = <CR>:quit<CR>:set t_te& t_ti&<CR>
  nnoremap <silent> gsh :set t_te = t_ti = <CR>:st<CR>:set t_te& t_ti&<CR>
  nnoremap <silent> gst :set t_te = t_ti = <CR>:st<CR>:set t_te& t_ti&<CR>
endif
" }}}
" # Status Bar {{{
set ruler
set showcmd
set showmode
set cmdheight=1
set wildmenu
set wildmode=list:longest,full
set laststatus=2
set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P
"set statusline=[%{winnr('$')>1?.winnr().'/'.winnr('$'):}]\ %<\ %f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).'\|'.&ff.']'}%=%l/%L\ (%P)
" }}}
" # <Tab> {{{
set showtabline=2 " :h tabline
nnoremap tn :<C-u>tabnew<Space>
nnoremap <silent> <Tab> :<C-u>tabnext<CR>
nnoremap <silent> <S-Tab> :<C-u>tabprevious<CR>
" }}}
" # Search {{{
set hlsearch    " Highlight search option
set incsearch   " Typed so far, matches
set ignorecase  " Ignoring case in a pattern
set smartcase   " Override ignorecase option (search contains upper case).
set nowrapscan  " Searches nowrap around.

nnoremap * *N
nnoremap # #N
" regex pattern
nnoremap \ /^
" }}}
" # Copy & Paste {{{
"set paste " When you're setting paste, can't use inoremap extend ;-<
if has('clipboard')
  set clipboard=unnamed,autoselect
  " For Ubuntu "+y not * (;h clipboard)

  " Copy
  vnoremap <C-c> "+y
  " Paste
  vnoremap <C-v> d"+P
  cnoremap <C-v> <C-R>+
  inoremap <C-v> <ESC>"+pa
  " source $VIMRUNTIME/mswin.vim
endif
" }}}
" # Insert {{{
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap \| \|\|<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
inoremap \|\| \|
inoremap "" "
inoremap '' '
inoremap `` `

inoremap <C-r> <CR>

cnoremap { {}<LEFT>
cnoremap [ []<LEFT>
cnoremap ( ()<LEFT>
cnoremap \| \|\|<LEFT>
cnoremap "" ""<LEFT>
cnoremap '' ''<LEFT>
cnoremap `` ``<LEFT>
cnoremap \|\| \|\|<LEFT>

" Support Input Date
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" Input vertical serial number
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber
  \ let c = col('.')
  \ | for n in range(1, <count>?<count>-line('.'):1)
  \ |   exec 'normal! j' . n . <q-args>
  \ |   call cursor('.', c)
  \ | endfor
" }}}
" # Yank {{{
" Like nmap 'D' and 'C'
nnoremap Y y$

" カーソル位置の単語をヤンクした単語に置換
nnoremap <silent> cy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR><ESC>
nnoremap <silent> ciy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR><ESC>
" }}}
" # IME Control {{{
" <ESC> insert mode, IME off
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <C-@> <ESC>:set iminsert=0<CR>
inoremap <silent> <C-]> <ESC>:set iminsert=0<CR>
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
if has('multi_byte_ime')
  augroup MutibyteIMEStrategy
    autocmd!
    autocmd ColorScheme * highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
    autocmd ColorScheme * highlight CursorIM guifg=NONE guibg=#ecbcbc
  augroup END
endif
augroup InsModeAu
  autocmd!
  autocmd InsertEnter,CmdwinEnter * set noimdisable
  autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END
" }}}
" # Moving Cursole {{{
augroup MovementPreviousSaveLine
  autocmd BufReadPost *
    \ if  line("'\"") > 0 && line("'\"") <= line("$")
    \   | exe "normal g`\"" |
    \ endif
augroup END

" for snippet complete
nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>

" .bash like
" but up-down mapped j-k
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Delete>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-l> <C-d>
cnoremap <C-d> <Delete>

nnoremap cw ciw
nnoremap dw diw
inoremap <C-w> <ESC>ciw

" selected at last editting text.
"" ちなみにVisualModeで最後に選択したテキストのに戻るはgv
nnoremap gc '[v']
vnoremap <silent>gc :<C-u>normal gc<CR>
onoremap <silent>gc :<C-u>normal gc<CR>

" vim-users.jp Hack #214
nnoremap ) f)
nnoremap ( f(
onoremap ) f)
onoremap ( f(
vnoremap ) f)
vnoremap ( f(

" Only do this part, when compiled with support for autocommands
augroup RedHatEnterpriseNantoka  "{{{2
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$")
    \   | exe "normal! g'\"" |
    \ endif
augroup END "}}}
" }}}
" # Window {{{
" FIXME: When setted winmin(height|width), errored unite-outline
"set winminheight=8
"set winminwidth=20
"set winfixheight
"set winfixwidth
set splitright  " Default vsplit, left
set splitbelow  " Default split, top

" vim-users.jp Hack #42
"nnoremap <silent> <C-w>h <C-w>h:call <SID>good_width()<CR>
"nnoremap <silent> <C-w>l <C-w>l:call <SID>good_width()<CR>
"nnoremap <silent> <C-w>H <C-w>H:call <SID>good_width()<CR>
"nnoremap <silent> <C-w>L <C-w>L:call <SID>good_width()<CR>
function! s:good_width()  "{{{2
  if winwidth(0) < 84 && &ft != 'taglist' && &ft != 'quickrun'
    vertical resize 84
  endif
endfunction "}}}2

set noequalalways " Minimize Window Size
" }}}
" # Buffer {{{
" Inspaired @taku-o's Kwdb.vim
com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn
nnoremap <silent> <Leader>d :<C-u>:Kwbd<CR>
" }}}
" # Fold, View {{{
nnoremap <Leader>f za
set foldcolumn=4
" INFO: foldlevel moved to each fplugin
"set foldlevel=0
set fillchars+=fold:-
" Don't save options.
set viewoptions-=options
if has('win32')
  set viewoptions+=unix
endif
augroup MkviewAccessor " Save fold settings. Vim-user.jp Hack #84
  autocmd!
  autocmd BufWritePost *
    \ if &filetype !~ 'vim\|php\|ruby\|git'
    \   | exe "mkview" |
    \ endif
  autocmd BufRead *
    \ if &filetype !~ 'vim\|php\|ruby\|git'
    \   | exe "silent loadview" |
    \ endif
augroup END
" }}}
" # Directory {{{
" disabled autochdir depends to Vimshell
"set autochdir
augroup AutoChDir
  autocmd!
  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
augroup END
" Change directory. vim-users.jp Hack #69
nnoremap <silent> cd :<C-u>CD<CR>
nnoremap <silent> gu :<C-u>GU<CR>
" nmap `gh` is using vim-rooter
nnoremap <silent> gH :<C-u>GH<CR>
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
command! -nargs=? -complete=dir -bang GU  call s:ChangeCurrentDir('../', '<bang>')
command! -nargs=? -complete=dir -bang GH  call s:ChangeCurrentDir('$HOME', '<bang>')
function! s:ChangeCurrentDir(directory, bang) "{{{2
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction "}}}
" }}}
" # Dictionary {{{
set dictionary=$HOME/.vim/dict/default.dict
"inoremap <silent> <C-k> <C-x><C-k> " FIXME: duplicate mapping <Up>
" }}}
" # Ctags {{{
if has('path_extra') && &filetype !~ 'zsh\|conf'
  setlocal tags=~/tags
  setlocal tags+=.
  if filereadable("tags")
    setlocal tags+=tags
  endif
  if filereadable("tags-ja")
    setlocal tags+=tags-ja
  endif

  set showfulltag
  set notagbsearch
endif
" }}}
" # Cscope {{{
"if has("cscope") && filereadable("/usr/bin/cscope")
" set csprg=/usr/bin/cscope
" set csto=0
" set cst
" set nocsverb
" " add any database in current directory
" if filereadable("cscope.out")
" cs add cscope.out
" " else add database pointed to by environment
" elseif $CSCOPE_DB != ""
" cs add $CSCOPE_DB
" endif
" set csverb
"endif
" }}}
" # Migemo {{{
" Howto: g/, g?
if has('migemo')
  set migemo
endif
" }}}
" # Omni complete {{{
" omni_complete, completed each ftplugin
inoremap <silent> <C-o> <C-x><C-o>
" }}}
" # Undo persistence {{{
if has('persistent_undo')
  augroup UndoPersistence
    autocmd!
    autocmd BufReadPost * call ReadUndo()
    autocmd BufWritePost * call WriteUndo()
  augroup END

  function! ReadUndo() "{{{2
    let undo_file = substitute(expand('%:p'), '\/\|\\', '\_', 'g')
    if filereadable(&undodir .'/'. undo_file)
      silent execute 'rundo' &undodir.'/'.undo_file
    endif
  endfunction "}}}
  function! WriteUndo() "{{{2
    if !isdirectory(&undodir)
      call mkdir(&undodir)
    endif
    let undo_file = substitute(expand('%:p'), '\/\|\\', '\_', 'g')
    silent execute 'wundo' &undodir.'/'.undo_file
  endfunction "}}}
endif
" }}}
" # Alt key {{{
" By Sir.thinca http://d.hatena.ne.jp/thinca/20101215/1292340358
if has('unix') && !has('gui_running')
  " Use meta keys in console.
  function! s:use_meta_keys()  " {{{2
    for i in map(
    \   range(char2nr('a'), char2nr('z'))
    \ + range(char2nr('A'), char2nr('Z'))
    \ + range(char2nr('0'), char2nr('9'))
    \ , 'nr2char(v:val)')
      " <ESC>O do not map because used by arrow keys.
      if i != 'O'
        execute 'nmap <ESC>' . i '<M-' . i . '>'
      endif
    endfor
  endfunction  " }}}2

  call s:use_meta_keys()
  map <NUL> <C-Space>
  map! <NUL> <C-Space>
endif
" }}}
" Plugin
if !g:my_config_use_plugin
  echo "INFO: g:my_config_use_plugin is 0 or not defined. and no reading plugin settings"
  finish " ここまで読んだらお前は死ぬ
endif
" Plugin: vim-startify {{{
let g:startify_files_number = 15
"let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions']
let g:startify_list_order = ['files', 'bookmarks', 'sessions']
let g:startify_bookmarks = [
  \ '~/.ssh/config',
  \ '~/.vim/bundle.vim',
  \ '~/.vim/bundle.vim.local',
  \ '~/.vimrc',
  \ '~/.vimrc.local',
  \ '~/.gvimrc',
  \ '~/.gvimrc.local',
  \ ]
" }}}
" Plugin: vimproc {{{
"let g:vimproc_dll_path = s:bundle_dir . '/vimproc/autoload'
" }}}
" Plugin: vim-airline {{{
" Themes https://github.com/bling/vim-airline/wiki/Screenshots
let g:airline_theme = 'luna'
"let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline_branch_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'
let g:airline_enable_branch    = 1
let g:airline_enable_syntastic = 1
let g:airline_detect_modified  = 1
let g:airline_detect_paste     = 1
let g:airline_powerline_fonts  = 1

" タブラインにもairlineを適用
let g:airline#extensions#tabline#enabled = 1
" （タブが一個の場合）バッファのリストをタブラインに表示する機能をオフ
let g:airline#extensions#tabline#show_buffers = 0
" 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
let g:airline#extensions#tabline#tab_nr_type = 1
" タブに表示する名前（fnamemodifyの第二引数）
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}
" Plugin: vim-anzu {{{
" TODO: 通常検索と同じくfoldも自動で開かれるようになったら有効にする
"nmap n nzz<Plug>(anzu-update-search-status)
"nmap N Nzz<Plug>(anzu-update-search-status)
"nmap * <Plug>(anzu-star)
"nmap # <Plug>(anzu-sharp)
"" ESC2回押しで検索ハイライトを消去
"nmap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><Plug>(anzu-clear-search-status)
"" format = (該当数/全体数)
"let g:anzu_status_format = "(%i/%l)"

"" for vim-airline
"" vim-anzuの表示を statuslineに
"let g:airline_section_c = '%F %{anzu#search_status()}'
"" whitespace無効
"let g:airline#extensions#whitespace#enabled = 0
" }}}
" Plugin: alpaca_powertabline {{{
let g:alpaca_powertabline_enable = 1
" }}}
" Plugin: calendar.vim {{{
let g:calendar_wruler = '日 月 火 水 木 金 土 '
let g:calendar_weeknm = 1 " WK01
" }}}
" Plugin: taglist.vim {{{
if has('path_extra')
  nnoremap <silent> tl :<C-u>Tlist<CR>
  let g:Tlist_Exit_OnlyWindow = 1 " Closable When last window is taglist
  let g:Tlist_WinWidth = 40
  let g:Tlist_Enable_Fold_Column = 2
  "let g:Tlist_Process_File_Always = 1
  "let g:Tlist_Show_One_File = 1
endif
" }}}
" Plugin: submode.vim {{{
" Reside window
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
" }}}
" Plugin: context_filetype.vim {{{
let g:context_filetype#filetypes = {
  \ 'perl6' : [{
  \   'start' : 'Q:PIR\s*{',
  \   'end' : '}',
  \   'filetype' : 'pir',
  \ }],
  \ 'vim' : [{
  \   'start' : '^\s*python <<\s*\(\h\w*\)',
  \   'end' : '^\1',
  \   'filetype' : 'python',
  \ }],
  \ 'markdown': [{
  \   'start' : '^\s*```\s*\(\h\w*\)',
  \   'end' : '^\s*```$',
  \   'filetype' : '\1',
  \ }],
  \}
" }}}
" Plugin: indent-guides {{{
" INFO: auto highlight indent-space.
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" }}}
" Plugin: matchit.vim {{{
" INFO: Extended % command.
"if filereadable($HOME . '/macros/matchit.vim')
if filereadable(s:bundle_dir . '/matchit.zip/plugin/matchit.vim')
  runtime macros/matchit.vim
  let b:match_words = 'if:endif'
  let b:match_ignorecase = 1
endif
" }}}
" Plugin: vim-textmanip {{{
xmap <C-j> <Plug>(Textmanip.move_selection_down)
xmap <C-k> <Plug>(Textmanip.move_selection_up)
xmap <C-h> <Plug>(Textmanip.move_selection_left)
xmap <C-l> <Plug>(Textmanip.move_selection_right)
" copy selected text-object.
vmap <M-d> <Plug>(Textmanip.duplicate_selection_v)
"}}}
" Plugin: vim-emoji {{{
silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif
" }}}
" Plugin: visualstar.vim {{{
" search extended plugin.
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N
" }}}
" Plugin: alignta {{{
vnoremap <silent> > :Alignta =><CR>

" @todo add json type
" ex.) 'hoge':     jojo
"      'jojolion': jojo
let g:unite_source_alignta_preset_arguments = [
  \ ["Align at '='",  '=>\='],
  \ ["Align at ':'",  '01 :'],
  \ ["Align at '|'",  '|'   ],
  \ ["Align at ')'",  '0 )' ],
  \ ["Align at ']'",  '0 ]' ],
  \ ["Align at '}'",  '}'   ],
  \]

let s:comment_leadings = '^\s*\("\|#\|/\*\|//\|<!--\)'
let g:unite_source_alignta_preset_options = [
  \ ["Justify Left",      '<<' ],
  \ ["Justify Center",    '||' ],
  \ ["Justify Right",     '>>' ],
  \ ["Justify None",      '==' ],
  \ ["Shift Left",        '<-' ],
  \ ["Shift Right",       '->' ],
  \ ["Shift Left  [Tab]", '<--'],
  \ ["Shift Right [Tab]", '-->'],
  \ ["Margin 0:0",        '0'  ],
  \ ["Margin 0:1",        '01' ],
  \ ["Margin 1:0",        '10' ],
  \ ["Margin 1:1",        '1'  ],
  \
  \ 'v/' . s:comment_leadings,
  \ 'g/' . s:comment_leadings,
  \]
unlet s:comment_leadings
" }}}
" Plugin: QuickRun, Quicklaunch & xUnit {{{
let g:quickrun_config = get(g:, 'quickrun_config', {})
"nnoremap <silent> <Leader>r :<C-u>QuickRun -runner vimproc:90 -split 'rightbelow 50vsp'<CR>
nnoremap <silent> <Leader>r :<C-u>QuickRun -runner vimproc:updatetime=10 -split 'rightbelow 50vsp'<CR>

let b:quickrun_config = {
  \   'runner/vimproc' : 90,
  \   'runner/vimproc/updatetime' : 90,
  \ }
let g:quickrun_config = {
  \   '_' : {
  \     'runner/vimproc' : 90,
  \     'runner/vimproc/updatetime' : 90,
  \     'outputter' : 'buffer',
  \   },
  \   'run/vimproc' : {
  \     'exec' : '%s:p:r %a',
  \     'runner' : 'vimproc',
  \     'outputter' : 'buffer',
  \   },
  \   'ruby' : {
  \     'command' : 'irb',
  \     'cmdopt' : '--simple-prompt',
  \     'runner' : 'process_manager',
  \     'runner/process_manager/load' : "load '%s'",
  \     'runner/process_manager/prompt' : '>> ',
  \   },
  \   'ruby.rspec' : {
  \     'command' : "rspec -l %{line('.')}",
  \   },
  \   'php.phpunit' : {
  \     'command' : 'phpunit',
  \   },
  \   'phpunit.php' : {
  \     'command' : 'phpunit',
  \   },
  \   'javascript' : {
  \     'command' : 'phantomjs',
  \   },
  \ }
if exists('g:sphinx_build_bin')
  let g:quickrun_config['rst'] = {
    \     'command': g:sphinx_build_bin,
    \     'hook/sphinx/enable' : 1,
    \     'cmdopt': '-b html',
    \ }
endif
if has('mac')
  " TODO: Sikuli 起動は引数渡さねば??
  "let g:quickrun_config['python.sikuli'] = {
  "  \   'command': '/Applications/Sikuli-IDE.app/sikuli-ide.sh',
  "  \ }
endif
" TODO: Add QuickRun's syntax for xUnit family
"autocmd BufAdd,BufNew,BufNewFile,BufRead [quickrun output] set syntax=xUnit
" }}}
" Plugin: TweetVim {{{
let g:tweetvim_config_dir  = s:tmpdir . '/tweetvim'
let g:tweetvim_include_rts = 1
let g:tweetvim_open_buffer_cmd = 'split -winheight=12 edit!'
nnoremap <silent> ts :<C-u>TweetVimSay<Cr>
" unite mapping
nnoremap <silent> tt :<C-u>Unite tweetvim<Cr>
" }}}
" Plugin: jscomplatete.vim {{{
let g:jscomplete_use = ['dom']
" }}}
" Plugin: dbext.vim {{{
let g:dbext_default_history_file = s:tmpdir . '/dbext_sql_history.sql'
" }}}
" Plugin: Emmet.vim (Replaced from zenconding.vim) {{{
let g:user_emmet_mode = 'a'
let g:user_emmet_leader_key = '<c-y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \  'lang' : 'ja',
  \  'html' : {
  \    'filters' : 'html',
  \    'indentation' : ' '
  \  },
  \  'perl' : {
  \    'indentation' : '  ',
  \    'aliases' : {
  \      'req' : "require '|'"
  \    },
  \    'snippets' : {
  \      'use' : "use strict\nuse warnings\n\n",
  \      'w' : "warn \"${cursor}\";",
  \    },
  \  },
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'html,c',
  \  },
  \  'css' : {
  \    'filters' : 'fc',
  \  },
  \  'javascript' : {
  \    'snippets' : {
  \      'jq' : "$(function() {\n\t${cursor}${child}\n});",
  \      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
  \      'fn' : "(function() {\n\t${cursor}\n})();",
  \      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
  \    },
  \  },
  \ 'haml': {
  \   'extends': 'html',
  \ }
  \ }
"}}}
" Plugin: neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><S-Space> neocomplete#start_manual_complete()
inoremap <expr> <S-Space> neocomplete#start_manual_complete()
inoremap <expr> <C-q> neocomplete#cancel_popup()

let g:neocomplete#max_list = 30
let g:neocomplete#max_keyword_width = 30
let g:neocomplete#auto_completion_start_length = 4
let g:neocomplete#manual_completion_start_length = 4
let g:neocomplete#min_keyword_length = 5
"let g:neocomplete#enable_ignore_case = 'ignorecase'
let g:neocomplete#enable_smart_case = 'infercase'
let g:neocomplete#enable_insert_char_pre = 1 " Really??
let g:neocomplete#data_directory = s:tmpdir . '/neocomplete'
let g:neocomplete#use_vimproc = 1

let g:neocomplete#enable_auto_select = 1
if exists('g:pached_vimjp_issue_385')
  set completeopt+=noselect
  let g:neocomplete#enable_complete_select = 1
endif

"if !exists('g:neocomplete#same_filetypes')
  "let g:neocomplete#same_filetypes = {}
"endif
"let g:neocomplete#same_filetypes.twig = 'twig'

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" }}}
" Plugin: neosnippet {{{
let g:neosnippet#snippets_directory =
  \ s:bundle_dir . 'neocomplcache-snippets-complete/autoload/neocomplcache/sources/snippets_complete'
  \ .','. $HOME . '/.vim/snippets'
  " TODO: Update phpunit snippet for neosnippet
  "\ .','. s:bundle_dir . '/vim-phpunit-snippets/snippets'
  "\ .','. s:bundle_dir . '/neocomplcache-phpunit-snippet/autoload/neocomplcache/sources/snippets_complete'

nmap <silent> <C-l> <Plug>(neosnippet_expand_or_jump)
imap <silent> <C-l> <Plug>(neosnippet_expand_or_jump)
smap <silent> <C-l> <Plug>(neosnippet_expand_or_jump)
"imap <silent> <C-s> <Plug>(neocomplcache_start_unite_complete)
imap <silent> <C-s> <Plug>(neosnippet_start_unite_snippet)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}
" Plugin: vim-rooter {{{
silent! nmap <silent> <unique> gh <Plug>RooterChangeToRootDirectory
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = [
  \   '.git/', '.hg/',
  \   'Gemfile', 'Rakefile', 'Guardfile',
  \   'Vagrantfile',
  \   'composer.json',
  \   'build.xml',
  \   'build.gradle',
  \ ]
let g:rooter_change_directory_for_non_project_files = 0
" }}}
" Plugin: vim-vcs {{{
let g:vcs#config_log_file = s:tmpdir . '/vcs'
" }}}
" Plugin: vim-fugitive {{{
" Gstatus
"    * Gstatus上の変更のあったファイルにカーソルを合わせた状態で
"        Dで:Gdiff起動(差分表示)
"        -でstageとunstageの切り替え
"        pでパッチを表示
"        Enterでファイル表示
"        Cでcommit
"    * :help Gstatus
nnoremap <Leader>gb :<C-u>Gblame<CR>
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gD :<C-u>Gdiff --cached<CR>
nnoremap <Leader>gs :<C-u>Gstatus<CR>
nnoremap <Leader>ga :<C-u>Gwrite<CR>
nnoremap <Leader>gA :<C-u>Gwrite <cfile><CR>
nnoremap <Leader>gc :<C-u>Gcommit<CR>
"}}}
" Plugin: vimfiler {{{
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_split_action        = 'left'
  "let g:vimfiler_execute_file_list   = 'vim'
  let g:vimfiler_ignore_pattern = '^.*\%(.git\|.DS_Store\|.idea\|.iml\)$'
  let g:vimfiler_edit_action         = 'open'
  let g:vimfiler_sort_type           = 'filename'
  let g:vimfiler_time_format         = "%y-%m-%d %H:%M"
  " Note: This variable works in file source.
  "let g:vimfiler_enable_auto_cd      = 1
  let g:vimfiler_data_directory      = s:tmpdir . '/vimfiler'
  let g:vimfiler_time_format         = "%y-%m-%d %H:%M"

  " Enable file operation commands.
  "let g:vimfiler_safe_mode_by_default = 0

  " Like Textmate icons.
  let g:vimfiler_tree_leaf_icon = ' '
  let g:vimfiler_tree_opened_icon = '▾'
  let g:vimfiler_tree_closed_icon = '▸'
  let g:vimfiler_file_icon = '-'
  let g:vimfiler_marked_file_icon = '*'

  if has('win32')
    let g:unite_kind_file_use_trashbox = s:tmpdir . '/vimfiler_trashbox'
  endif

  "augroup StartupWithVimFiler " {{{
  "  autocmd!
  "  autocmd VimEnter * VimFiler
  "    \ -buffer-name=explorer -split -simple -winwidth=40 -toggle -no-quit
  "    \ -auto-cd=1
  "augroup END " }}}
endfunction
nnoremap : :<C-u>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
augroup VimFilerUniteAction " {{{
  autocmd!
  autocmd FileType vimfiler call unite#custom_default_action('directory', 'lcd')
augroup END " }}}
" }}}
" Plugin: vimshell {{{
"let s:bundle = neobundle#get('vimshell')
"function! s:bundle.hooks.on_source(bundle)
  let g:vimshell_temporary_directory = s:tmpdir . '/.vimshell'
  "let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", \\"(%s)-[%b|%a]")'
  let g:vimshell_enable_smart_case = 1
  let g:vimshell_enable_auto_slash = 1
  let g:vimshell_max_command_history = 200
  let g:vimshell_max_list = 15
  let g:vimshell_split_height = 22
  let g:vimshell_split_command = 'split'

  " almost paste from vimshll-examples
  " Initialize execute file list.
  let g:vimshell_execute_file_list = {}
  "call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
  let g:vimshell_execute_file_list['rb'] = 'ruby'
  let g:vimshell_execute_file_list['pl'] = 'perl'
  let g:vimshell_execute_file_list['py'] = 'python'
  let g:vimshell_execute_file_list['php'] = 'php'
  let g:vimshell_execute_file_list['git'] = 'git'
  "call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

  "let g:vimshell_user_prompt = 'fnamemodify(getcwd(), \\":~")'
  "let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", \\"(%s)-[%b|%a]")'
  let g:my_host_prompt = stridx(hostname(), '.') > 0
    \ ? hostname()[ : stridx(hostname(), '.') - 1]
    \ : hostname()
  if has('win32') || has('win64')
    " Display user name on Windows.
    "let g:vimshell_prompt = $USERNAME." % "
    let g:vimshell_user_prompt = printf(
      \ '"%s\n┌[" .$USERNAME."@".%s. "]" ." - ". "[" .%s. "]"'
      \ , '"☁ ". fnamemodify(getcwd(), ":p:h")'
      \ , 'g:my_host_prompt'
      \ , 'fnamemodify(getcwd(), ":~")'
      \ )
  else
    " Display user name on Linux.
    " TODO: $USER . hostname() の省略系を表示できるようにする
    let g:vimshell_user_prompt = printf(
      \ '"┌[" .$USER."@".%s. "]" ." - ". "[" .%s. "]"'
      \ , 'g:my_host_prompt'
      \ , 'fnamemodify(getcwd(), ":~")'
      \ )

    "call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
    call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
    let g:vimshell_execute_file_list['zip'] = 'zipinfo'
    call vimshell#set_execute_file('tgz,gz', 'gzcat')
    call vimshell#set_execute_file('tbz,bz2', 'bzcat')
  endif
  let g:vimshell_prompt = '└[☁ ] '
  "let g:vimshell_right_prompt = 'fnamemodify(getcwd(), ":p:h")'

  augroup VimshellFileTypeDetect
    autocmd!
    autocmd FileType vimshell
      \  call vimshell#altercmd#define('g', 'git')
      \| call vimshell#altercmd#define('h', 'hg')
      \| call vimshell#altercmd#define('i', 'iexe')
      \| call vimshell#altercmd#define('l', 'll')
      \| call vimshell#altercmd#define('a', 'ls -al')
      \| call vimshell#altercmd#define('ll', 'ls -l')
      \| call vimshell#altercmd#define('la', 'ls -al')
      \| call vimshell#altercmd#define('cl', 'clear')
      \| call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpWd')
  augroup END

  function! MyChpWd(args, context)
    call vimshell#execute('ls')
  endfunction
"endfunction
" }}}
" Plugin: unite.vim {{{
let g:unite_data_directory =
  \ get(g:, 'local_unite_data_directory', s:tmpdir . '/unite')

let g:unite_enable_start_insert = 1
" Save session automatically.
" For unite-session.
" Load session automatically.
let g:unite_source_session_enable_auto_save = 1
"autocmd VimEnter * UniteSessionLoad
" window options
let g:unite_winheight             = 20
let g:unite_split_rule            = 'below'
let g:unite_source_file_mru_limit = 120
let g:unite_update_time           = 256
" mru options
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_limit           = 200
" history options
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit  = 100
" color options
let g:unite_cursor_line_highlight = 'PmenuSel'
"let g:unite_abbr_highlight       = 'TabLine'
" aliases
let g:unite_source_alias_aliases = get(g:, 'unite_source_alias_aliases', {})
let g:unite_source_alias_aliases.workspace = {
  \ 'source': 'file',
  \ 'args':   "$HOME/workspace",
  \ }
let g:unite_source_alias_aliases.workspace_rec = {
  \ 'source': 'file_rec',
  \ 'args':   "$HOME/workspace",
  \ }

" ignore match patterns (Default: autoload/unite/source/file.vim)
let g:unite_source_file_ignore_pattern =
  \ '^\%(/\|\a\+:/\)$\|\%(^\|/\)\.\.\?$\|\~$\|\.\%(o|exe|dll|bak|sw[po]|vimundo|app|iml|\)$'
let g:unite_source_directory_mru_ignore_pattern =
  \ '\%(^\|/\)\.\%(hg\|git\|bzr\|svn\|vimundo\|idea\)\%($\|/\)\|^\%(\\\\\|/mnt/\|/media/\|/Volumes/\)'
let g:unite_source_file_rec_ignore_pattern =
  \ '\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|bak\|sw[po]\|vimundo\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'

"call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
"call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
"call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)
"call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
"call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
"call unite#set_substitute_pattern('file', '^\\', '~/*')
"call unite#set_substitute_pattern('file', '^;v', '~/.vim/*')
"call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/*"')
"call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
"call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
"call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
"call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)

nnoremap <C-p> :<C-u>Unite file_mru<CR>
nnoremap <C-n> :<C-u>Unite buffer_tab<CR>
"nnoremap <C-b> :<C-u>UniteBookmarkAdd<Space>
" }}}
" Plugin: unite.vim >> source menus {{{
let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})
let g:unite_source_menu_menus.shortcut =
  \ {
  \   'description' : 'My shortcut',
  \   'command_candidates' : [
  \     ['edit vimrc', 'edit $MYVIMRC'],
  \     ['edit vimrc.local', 'edit $MYVIMRC_LOCAL'],
  \     ['edit gvimrc', 'edit $MYGVIMRC'],
  \     ['edit gvimrc.local', 'edit $MYGVIMRC_LOCAL'],
  \     ['edit zshrc', 'edit $HOME/.zshrc'],
  \     ['edit zshrc.local', 'edit $HOME/.zshrc.local'],
  \   ],
  \ }
let g:unite_source_menu_menus.interactive_mode =
  \ {
  \   'description': 'Mode of interactive programming languages',
  \   'command_candidates': [
  \     ['ruby', 'VimShellInteractive ruby'],
  \     ['python', 'VimShellInteractive python'],
  \   ],
  \ }
let g:unite_source_menu_menus.git =
  \ {
  \   'description' : '            gestionar repositorios git
  \                            ⌘ [espacio]g',
  \ }
let g:unite_source_menu_menus.git.command_candidates =
  \ [
  \   [
  \     '▷ tig                                              [unite]t',
  \     'Unite tig -no-start-insert -winheight=20'
  \   ],
  \   [
  \     '▷ git status        (Fugitive)                     <Leader>gs',
  \     'Gstatus'
  \   ],
  \   [
  \     '▷ git diff          (Fugitive)                     <Leader>gd',
  \     'Gsdiff'
  \   ],
  \   [
  \     '▷ git diff --cached (Fugitive)                     <Leader>gD',
  \     'Gsdiff --cached'
  \   ],
  \   [
  \     '▷ git commit        (Fugitive)                     <Leader>gc',
  \     'Gcommit'
  \   ],
  \   [
  \     '▷ git blame         (Fugitive)',
  \     'Gblame'
  \   ],
  \   [
  \     '▷ git push          (Fugitive, salida por buffer)',
  \     'Git! push'
  \   ],
  \   [
  \     '▷ git pull          (Fugitive, salida por buffer)',
  \     'Git! pull'
  \   ],
  \   [
  \     '▷ git stage         (Fugitive)',
  \     'Gwrite'
  \   ],
  \   [
  \     '▷ git checkout      (Fugitive)',
  \     'Gread'
  \   ],
  \   [
  \     '▷ git rm            (Fugitive)',
  \     'Gremove'
  \   ],
  \   [
  \     '▷ git mv            (Fugitive)',
  \     'exe "Gmove " input("destino: ")'
  \   ],
  \   [
  \     '▷ git prompt        (Fugitive, salida por buffer)',
  \     'exe "Git! " input("comando git: ")'
  \   ],
  \   [
  \     '▷ git cd            (Fugitive)',
  \     'Gcd'
  \   ],
  \   [
  \     '▷ help git status   (Fugitive)',
  \     'help Gstatus'
  \   ],
  \ ]

" The prefix key.
"nnoremap [menu] <Nop>
"xnoremap [menu] <Nop>
"nmap x [menu]
"xmap x [menu]
"nnoremap <silent>[menu]l :Unite menu<Cr>
"nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<Cr>
"nnoremap <silent>[menu]s :Unite -silent -start-insert menu:shortcut<Cr>
"nnoremap <silent>[menu]i :Unite -silent -start-insert menu:interactive_mode<Cr>

nnoremap <silent><M-l> :Unite menu<Cr>
nnoremap <silent><M-g> :Unite -silent -start-insert menu:git<Cr>
nnoremap <silent><M-s> :Unite -silent -start-insert menu:shortcut<Cr>
nnoremap <silent><M-i> :Unite -silent -start-insert menu:interactive_mode<Cr>
nnoremap <silent><D-l> :Unite menu<Cr>
nnoremap <silent><D-g> :Unite -silent -start-insert menu:git<Cr>
nnoremap <silent><D-s> :Unite -silent -start-insert menu:shortcut<Cr>
nnoremap <silent><D-i> :Unite -silent -start-insert menu:interactive_mode<Cr>
" For CUI mode
nmap <ESC>l <M-l>
nmap <ESC>g <M-g>
nmap <ESC>s <M-s>
nmap <ESC>i <M-i>
" }}}
" Plugin: unite-tag {{{
let g:unite_tig_default_line_count = 80
"nnoremap <silent> <C-]> :<C-u>Unite -immediately -no-start-insert tags:<C-r>=expand('<cword>')<CR><CR>
autocmd BufEnter *
  \ if empty(&buftype)
  \   | nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR> |
  \ endif
" }}}
" Plugin: unite-sf2 {{{
" NOTE: unite-sf2 avairables is depends local environment.
"let g:unite_source_sf2_root_dir = $HOME . '/workspace/sandbox/Studies/symfony-standard'
"let g:unite_source_sf2_bundles = get(g:, 'unite_source_sf2_bundles', {})
" }}}
" Plugin: unite-grep {{{
let g:unite_source_grep_default_opts = '-Hn'  " By the default
let g:unite_source_grep_recursive_opt = '-R'  " By the default
" }}}
" Plugin: vim-ref & ref-unite {{{
let g:ref_cache_dir = s:tmpdir . '/ref_cache'
" TODO: Pydocも日本語の使えるようにしなくては
nnoremap <F2> :<C-u>Ref<Space>
if exists('g:local_config["ref_phpmanual_path"]')
  let g:ref_phpmanual_path = g:local_config['ref_phpmanual_path']
else
  let g:ref_phpmanual_cmd = 'w3m -dump %s'
endif
if exists('g:local_config["ref_jquery_path"]')
  let g:ref_jquery_path = g:local_config['ref_jquery_path']
else
  let g:ref_jquery_cmd = 'w3m -dump %s'
endif
if has('mac')
  let g:ref_alc_cmd = 'lynx -dump -display_charset=' . &encoding . ' -nonumbers %s'
endif
"let g:ref_refe_cmd = '/usr/bin/refe'

" webdict
let g:ref_source_webdict_sites = {
  \   'weblio': {
  \     'url': 'http://ejje.weblio.jp/content/%s',
  \     'keyword_encoding': 'utf-8',
  \     'cache': 1,
  \   },
  \   'wikipedia:ja': 'http://ja.wikipedia.org/wiki/%s',
  \ }
" 出力に対するフィルタ。最初の数行を削除している。
function! g:ref_source_webdict_sites.weblio.filter(output)
  return join(split(a:output, "\n")[18 :], "\n")
endfunction
let g:ref_source_webdict_sites.default = 'weblio'

" My ref filetype mapping
let g:ref_cmd_filetype_map = {
  \   'python': 'pydoc',
  \   'perl':   'perldoc',
  \   'php':    'php',
  \ }
" \   'php.phpunit' : 'phpunit',
" }}}
" Forked Plugin: vim-php-cs-fixer {{{
let g:php_cs_fixer_default_mapping = 1                     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_path            = "/usr/sbin/php-cs-fixer/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level           = "all"                 " which level ?
let g:php_cs_fixer_config          = "default"             " configuration
"let g:php_cs_fixer_php_path        = "php"                 " Path to PHP
let g:php_cs_fixer_fixers_list     = ""                    " List of fixers
let g:php_cs_fixer_dry_run         = 0                     " Call command with dry-run option
let g:php_cs_fixer_use_sudo         = 1                     " Call command with dry-run option
" }}}
" My Plugin: vim-multiple-switcher {{{
"let g:multiple_switcher_no_default_key_maps = 1
nnoremap <silent> ,p :<C-u>call multiple_switcher#switch('paste')<CR>
nnoremap <silent> ,e :<C-u>call multiple_switcher#switch('expandtab')<CR>
nnoremap <silent> ,w :<C-u>call multiple_switcher#switch('wrap')<CR>
vnoremap <silent> ,n :<C-u>call multiple_switcher#switch('number')<CR>
" }}}
" My Plugin: vim-sunday {{{
let g:sunday_pairs = [
  \ ['light', 'dark'],
  \ ['extends', 'implements'],
  \ ['assert', 'depends', 'dataProvider', 'expectedException', 'group', 'test'],
  \ ['pick', 'squash', 'edit', 'reword', 'fixup', 'exec'],
  \ ]
" }}}
" # [unite] Mappings "{{{
" The prefix key.
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap e [unite]
xmap e [unite]

nnoremap <silent> [unite]u :<C-u>Unite resume source<CR>

nnoremap <silent> [unite]f :<C-u>UniteWithCurrentDir
  \ -buffer-name=files buffer bookmark file<CR>
"nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]F :<C-u>Unite file_rec<CR>
nnoremap <silent> [unite]w :<C-u>Unite workspace
  \ -no-split -buffer-name=files buffer bookmark file<CR>
nnoremap <silent> [unite]W :<C-u>Unite workspace_rec
  \ -no-split -buffer-name=files buffer bookmark file -input=!vendor <CR>
nnoremap <silent> [unite]a :<C-u>Unite alignta:options<CR>
xnoremap <silent> [unite]a :<C-u>Unite alignta:arguments<CR>
nnoremap <silent> [unite]m :<C-u>Unite mark<CR>
nnoremap <silent> [unite]M :<C-u>Unite menu<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]B :<C-u>Unite bookmark -default-action=vimshell<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tig -no-start-insert -no-quit -no-split<CR>
"nnoremap <silent> [unite]t :<C-u>Unite tig -no-start-insert -no-quit -winheight=12<CR>
nnoremap <silent> [unite]T :<C-u>Unite -buffer-name=search line
  \ -winheight=10 -no-quit<CR>todo\\|fixme\\|warn\\|hackme<ESC>
" for current buffer
nnoremap <silent> [unite]g :<C-u>Unite grep:%:-iR:<CR>
" for all buffer
nnoremap <silent> [unite]G :<C-u>Unite grep:$:-iR:<CR>
nnoremap <silent> [unite]l :<C-u>Unite line -no-split -winheight=20<CR>
nnoremap <silent> [unite]c :<C-u>Unite colorscheme -auto-preview<CR>
nnoremap <silent> [unite]h :<C-u>Unite history/command<CR>
nnoremap <silent> [unite]p :<C-u>Unite process -no-split<CR>
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]s :<C-u>Unite snippet<CR>
nnoremap <silent> [unite]n :<C-u>Unite neobundle/install:! -no-start-insert -auto-quit<CR>
nnoremap <silent> [unite]N :<C-u>Unite neobundle/install -no-start-insert -auto-quit<CR>
" NOTE: @ftplugin, <Leader>r is :Unite ref/$filetype
"       if @ftplugin is nothing, default map is :Unite ref/
"nnoremap <silent> [unite]r :<C-u>Unite<Space>ref/
nmap <silent> [unite]r <Plug>(ref_filetype_complete)

nnoremap <silent> ?  :<C-u>Unite -buffer-name=search line -winheight=10 -no-quit<CR>

"nnoremap <Leader>S :<C-u>Unite<Space>sf2/
"nnoremap <Leader>sb :<C-u>Unite sf2/bundles<CR>
"nnoremap <Leader>sc :<C-u>Unite sf2/app/config<CR>
"}}}
" # <Leader> Mappings "{{{
nnoremap <silent><Leader><Leader> f<Space>
" change just before buffer
nnoremap <silent> <Leader>a :<C-u>b#<CR>
nnoremap <silent> ,b :<C-u>b#<CR>
" open-browser.vim
nmap <Leader>o <Plug>(openbrowser-smart-search)
" vimshell
nnoremap <silent> <Leader>s :<C-u>VimShell<CR>
nnoremap <silent> <Leader>vs :<C-u>VimShell<CR>
nnoremap <silent> <Leader>vS :<C-u>VimShellPop<CR>
" vimfiler
nnoremap <Leader>vf :<C-u>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
" Quickhl
nmap <silent> <Leader>m <Plug>(quickhl-toggle)
xmap <silent> <Leader>m <Plug>(quickhl-toggle)
nmap <silent> <Leader>M <Plug>(quickhl-reset)
xmap <silent> <Leader>M <Plug>(quickhl-reset)
nmap <silent> <Leader>j <Plug>(quickhl-match)

" TweetVim
nnoremap <silent> <Leader>t  :TweetVimHomeTimeline<CR>
nnoremap <silent> <Leader>tl :TweetVimHomeTimeline<CR>
nnoremap <silent> <Leader>ts :TweetVimSay<CR>
" }}}
