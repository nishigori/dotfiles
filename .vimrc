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
" vim: set fletype=vim fdm=marker ts=2 sw=2 sts=0 expandtab:

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
if !has('nvim') && (!has('gui_macvim') || !has('kaoriya'))
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
set autoread                   " When a file has been detected to have been changed outside
set history=511
set viminfo='20,\"150           " Read/write a .viminfo file, don't store more than 50 lines of registers
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set ambiwidth=double
set virtualedit+=block         " Block-select to the end of the line for blockwise Visual mode.
set shortmess+=filmnrxoOtT     " Avoid all the hit-enter prompts
set title
set completeopt=menuone        " A comma separated list of options
set scrolloff=10               " Typewriter mode = keep current line in the center
set formatoptions+=mM          " This is a sequence of letters
set visualbell t_vb=           " no bell

set helplang=ja,en
set keywordprg=:help
nnoremap <silent> <C-h> :<C-u>help<Space><C-r><C-w><CR>

let mapleader = " "

if has('nvim')
    let g:python_host_prog='/usr/local/bin/python3'
endif
" }}}
" # Directory Settings {{{
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:cache_dir = s:cache_home . 'vim'
if !isdirectory(s:cache_dir)
  call system('mkdir -p ' . s:cache_dir . '/{swap,backup,view,undo}')
endif

set backup swapfile

" Not use white space into the statement (Suck!!)
set directory=~/.cache/vim/swap
set backupdir=~/.cache/vim/backup
set viewdir=~/.cache/vim/view
if has('persistent_undo')
  set undodir=~/.cache/vim/undo
endif
" }}}
" # Local Dependency {{{
set nobackup noswapfile

" Like vim ./configure --with-features
let MYVIM_FEATURES_TINY   = 0 | lockvar MYVIM_FEATURES_TINY
let MYVIM_FEATURES_SMALL  = 1 | lockvar MYVIM_FEATURES_SMALL
let MYVIM_FEATURES_NORMAL = 3 | lockvar MYVIM_FEATURES_NORMAL
let MYVIM_FEATURES_BIG    = 3 | lockvar MYVIM_FEATURES_BIG
let MYVIM_FEATURES_HUGE   = 4 | lockvar MYVIM_FEATURES_HUGE

let g:myvim_features = get(g:, 'myvim_features', MYVIM_FEATURES_TINY)

let $MYVIMRC_LOCAL = $HOME . '/.vimrc.local'
if filereadable(expand($MYVIMRC_LOCAL))
  " INFO: Read more .vimrc.local.dist
  source $MYVIMRC_LOCAL

  let $MYVIMRC = g:local_config['dotfiles_dir'] . '/.vimrc'
  " Quick start my vimrc
  nnoremap <silent> e. :<C-u>edit $MYVIMRC<CR>
  nnoremap <silent> eS :<C-u>source $MYVIMRC<CR>

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
endif

" }}}

" # dein {{{
if exists('g:nyaovim_version')
  let s:dein_dir = s:cache_home . '/nyaovim/dein'
elseif has('nvim')
  let s:dein_dir = s:cache_home . '/nvim/dein'
else
  let s:dein_dir = s:cache_home . '/dein'
endif

if MYVIM_FEATURES_BIG >= g:myvim_features
  if &compatible
    set nocompatible
  endif

  " reset augroup
  augroup MyAutoCmd
    autocmd!
  augroup END

  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif
  let &runtimepath = s:dein_repo_dir .",". &runtimepath

  let s:toml_file = '~/.config/dein/plugins.toml'
  let s:toml_file_local = '~/.config/dein/plugins.local.toml'
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    if filereadable(s:toml_file_local)
      call dein#load_toml(s:toml_file_local)
    endif

    call dein#load_toml(s:toml_file)
    call dein#add('godlygeek/tabular')
    call dein#add('plasticboy/vim-markdown', { 'lazy' : 1, 'on_ft': ['markdown', 'mkd'] })

    " ColorScheme(s)
    " script_type = 'colors'
    "call dein#add('mhartington/oceanic-next', { 'merged': 0 })
    call dein#add('jacoborus/tender.vim', { 'merged': 0 })
    call dein#source('tender.vim')
    "call dein#add('Diablo3',                  { 'merged': 0 })
    "call dein#add('w0ng/vim-hybrid',          { 'merged': 0 })
    "call dein#add('itchyny/landscape.vim',    { 'merged': 0 })
    "call dein#add('ujihisa/mrkn256.vim',      { 'merged': 0 })
    "call dein#add('wombat256.vim',            { 'merged': 0 }) # :colorscheme wombat256mod 
    "call dein#add('xoria256.vim',             { 'merged': 0 })
    "call dein#add('candycode.vim',            { 'merged': 0 })
    "call dein#add('jonathanfilip/vim-lucius', { 'merged': 0 })
    "call dein#add('vim-scripts/darkZ',        { 'merged': 0 })

    call dein#end()
    call dein#save_state()
  endif

  " Install if declared plugins is not installed
  if dein#check_install()
    call dein#install()
  endif

  filetype plugin indent on
  syntax enable

endif
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

  if v:version >= 703
    set relativenumber
  endif
  set number
  set numberwidth=4
endif

set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>

" highlight each language in markdown
" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
\  'css',
\  'go',
\  'javascript',
\  'js=javascript',
\  'json=javascript',
\  'ruby',
\  'sass',
\  'xml',
\  'erlang',
\]
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
if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  colorscheme tender
else
  "colorscheme desert
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

let g:loaded_matchparen = 1

nnoremap * *N
nnoremap # #N
" regex pattern
nnoremap \ /^
" }}}
" # Copy & Paste {{{
"set paste " When you're setting paste, can't use inoremap extend ;-<
if has('clipboard')
  if !has('nvim')
    " https://github.com/neovim/neovim/wiki/FAQ#something-broke-after-updating-to-a-newer-version
    set clipboard=unnamed,autoselect
  endif

  " Copy
  " For Ubuntu "+y not * (;h clipboard)
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
cnoremap \|\| \|<LEFT>
cnoremap "" ""<LEFT>
cnoremap '' ''<LEFT>
cnoremap `` ``<LEFT>

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
"inoremap <C-k> <Up>
"inoremap <C-j> <Down>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
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
" # Spell {{{
" @see https://github.com/vim-jp/vimdoc-ja/blob/master/doc/spell.jax
"set spell
"set spelllang=en,cjk
"if empty('&spellfile')
  "set spellfile="$HOME/.vim/spell/en.utf-8.add"
"endif
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
" Under the $VIMRUNTIME {{{
" plugin/matchparen.vim
let g:loaded_matchparen = 1
" ftplugin/gitrebase.vim
autocmd FileType gitrebase nnoremap <buffer>p :<C-u>Pick<CR>
autocmd FileType gitrebase nnoremap <buffer>s :<C-u>Squash<CR>
autocmd FileType gitrebase nnoremap <buffer>e :<C-u>Edit<CR>
autocmd FileType gitrebase nnoremap <buffer>r :<C-u>Reword<CR>
autocmd FileType gitrebase nnoremap <buffer>f :<C-u>Fixup<CR>
" }}}
" Under the $VIMRUNTIME {{{
function! s:StartMyVimMode()
  set nocompatible           " be iMproved
  filetype plugin indent off " required!!

  NeoBundle 'vim-jp/vital.vim'
  NeoBundle 'h1mesuke/vim-benchmark'

  filetype plugin indent on " required!
endfunction
command! -nargs=0 MyVimHackMode call s:StartMyVimMode()
" }}}
" # NeoVim loading key {{{
if has('nvim')
  source ~/.gvimrc
endif
" }}}

" Plugins
if MYVIM_FEATURES_BIG >= g:myvim_features
  " My Plugin: IncrementActivator {{{
  let g:increment_activator_filetype_candidates = get(g:, 'increment_activator_filetype_candidates', {})
  let g:increment_activator_filetype_candidates['_'] = [
    \   ['light', 'dark'],
    \   ['pick', 'squash', 'edit', 'reword', 'fixup', 'exec'],
    \   ['previous', 'current', 'next'],
    \   ['ぬるぽ', 'ガッ'],
    \   ['=', ':='],
    \   ['true', 'false'],
    \   ['月','火','水','木','金','土','日'],
    \ ]
  " For AWS
  call add(g:increment_activator_filetype_candidates['_'], ['dedicated', 'default'])
  call add(g:increment_activator_filetype_candidates['_'], ['standard', 'io1', 'gp2'])
  let g:increment_activator_filetype_candidates['php'] = [
    \   ['private', 'protected', 'public'],
    \   ['extends', 'implements'],
    \   ['assert', 'depends', 'dataProvider', 'expectedException', 'group', 'test'],
    \ ]
  let g:increment_activator_filetype_candidates['vim'] = [
    \   ['nnoremap', 'xnoremap', 'inoremap', 'vnoremap', 'cnoremap', 'onoremap'],
    \   ['nmap', 'xmap', 'imap', 'vmap', 'cmap', 'omap'],
    \   ['NeoBundle', 'NeoBundleLazy'],
    \   ['Home', 'End', 'Left', 'Right', 'Delete'],
    \   ['has', 'has_key', 'exists'],
    \ ]
  let g:increment_activator_filetype_candidates.go = [
    \   ['true', 'false', 'iota', 'nil'],
    \   ['print', 'println'],
    \   ['byte', 'complex64', 'complex128'],
    \   ['int', 'int8', 'int16', 'int32', 'int64'],
    \   ['uint', 'uint8', 'uint16', 'uint32', 'uint64'],
    \   ['float32', 'float64'],
    \   ['interface', 'struct'],
    \ ]
  let g:increment_activator_filetype_candidates['cucumber'] = [
    \   ['Given', 'And', 'When', 'Then'],
    \ ]
  " }}}
  " My Plugin: Project TODO {{{
  nnoremap <silent> <S-t><S-t> :call OpenMyToDo()<CR>
  function! OpenMyToDo()
    execute 'e ' . unite#util#path2project_directory(
      \ unite#util#substitute_path_separator(getcwd())
      \ ) . '/TODO.rst'
  endfunction
  nnoremap <silent> <D-t><D-t> :<C-u>edit $HOME/TODO.rst<CR>
  nnoremap <silent> <M-t><M-t> :<C-u>edit $HOME/TODO.rst<CR>
  " }}}
  " Plugin: QuickRun, Quicklaunch & xUnit {{{
  let g:quickrun_config = get(g:, 'quickrun_config', {})
  nnoremap <silent> <Leader>r :<C-u>QuickRun<CR>

  " Stop quickrun
  nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

  " Close quickrun buffer
  nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>

  let b:quickrun_config = {
    \   'runner' : 'vimproc',
    \   'runner/vimproc/updatetime' : 60,
    \ }
  let g:quickrun_config = {
    \   '_' : {
    \     'runner' : 'vimproc',
    \     'runner/vimproc/updatetime' : 60,
    \     'outputter/error/success' : 'buffer',
    \     'outputter/error/error' : 'quickfix',
    \     'outputter/buffer/close_on_empty' : 1,
    \     'hook/time/enable': 1,
    \     'outputter/buffer/split': 'rightbelow 50vsp',
    \     'outputter/buffer/running_mark': 'just running quickrun ...',
    \   },
    \   'run/vimproc' : {
    \     'exec' : '%s:p:r %a',
    \     'runner' : 'vimproc',
    \     'outputter' : 'buffer',
    \   },
    \ }
  let g:quickrun_config['ruby'] = {
    \   'command' : 'irb',
    \   'cmdopt' : '--simple-prompt',
    \   'runner' : 'process_manager',
    \   'runner/process_manager/load' : "load '%s'",
    \   'runner/process_manager/prompt' : '>> ',
    \ }
  let g:quickrun_config['ruby.rspec'] = {
    \   'command' : "rspec",
    \   'cmdopt': 'bundle exec',
    \   'exec': '%o %c %s',
    \ }
  let g:quickrun_config['javascript'] = {
    \   'command' : 'phantomjs',
    \ }
  let g:quickrun_config['scheme/gauche'] = {
    \   'command': 'gosh',
    \   'exec': '%c %o %s:p %a',
    \   'hook/eval/template': '(display (begin %s))',
    \ }
  let g:quickrun_config['scheme/mzscheme'] = {
    \   'command': 'mzscheme',
    \   'exec': '%c %o -f %s %a',
    \ }
  let g:quickrun_config['scheme'] = {
    \   'type': executable('gosh')     ? 'scheme/gauche':
    \           executable('mzscheme') ? 'scheme/mzscheme': '',
    \ }
  let g:quickrun_config['php.phpunit'] = { 'command': 'phpunit' }
  let g:quickrun_config['phpunit.php'] = { 'command': 'phpunit' }
  let g:quickrun_config['lua'] = { 'command': 'luajit' }

  " TODO: Add QuickRun's syntax for xUnit family
  "autocmd BufAdd,BufNew,BufNewFile,BufRead [quickrun output] set syntax=xUnit
  " }}}
  " Plugin: vim-rooter {{{
  silent! nmap <silent> <unique> gh <Plug>RooterChangeToRootDirectory

  let g:rooter_manual_only = 0

  let g:rooter_use_lcd = 1
  let g:rooter_patterns = [
    \   '.git/', '.hg/',
    \   'Makefile', 'setup.py', 'Rakefile', 'build.xml', 'build.gradle',
    \   'requirements.txt', 'Gemfile', 'composer.json',
    \   'README', 'README.txt', 'README.rst', 'README.md', 'README.mkd', 'README.markdown',
    \   'Guardfile',
    \   'Vagrantfile',
    \ ]
  let g:rooter_change_directory_for_non_project_files = 0
  " }}}
  " Plugin: vimfiler {{{
  if dein#tap('vimfiler')
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_ignore_pattern = [
      \ '^\.git$', '^\.svn$', '^\.hg$',
      \ '^\.DS_Store$', '^\.localized$',
      \ '^\.idea$', '^.*\.iml$',
      \ '^.*\.pyc$', '^\.tox$', '^\__pycache__$',
      \ '^\.ruby-version$',
      \ '^.*\.phar$',
      \ '^.*\.o$',
      \ ]
    let g:vimfiler_data_directory      = s:cache_dir . '/vimfiler'
    let g:vimfiler_time_format         = "%y-%m-%d %H:%M"

    " Like Textmate icons.
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = '-'
    let g:vimfiler_marked_file_icon = '*'

    if has('win32')
      let g:unite_kind_file_use_trashbox = s:cache_dir . '/vimfiler_trashbox'
    endif

  endif

  nnoremap : :<C-u>VimFilerExplorer -buffer-name=explorer
    \ -split -direction=topleft -simple -winwidth=45 -project -auto-cd -no-quit -find<CR>

  call vimfiler#custom#profile('default', 'context', {
    \ 'safe' : 0,
    \ 'edit_action': 'open',
    \ 'sort_type': 'filename',
    \ })

  nnoremap <Leader>vf :<C-u>VimFiler -buffer-name=explorer -split -simple -winwidth=45 -toggle -no-quit<CR>
  " }}}
  " Plugin: neomru {{{
  let g:neomru#file_mru_limit = 1024
  let g:neomru#filename_format = ':p:~'
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
  " Plugin: unite.vim {{{
  let g:unite_data_directory =
    \ get(g:, 'local_unite_data_directory', s:cache_dir . '/unite')

  let g:unite_prompt = '☁  '

  " history options
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_history_yank_limit  = 50

  " color options
  let g:unite_cursor_line_highlight = 'PmenuSel'
  "let g:unite_abbr_highlight       = 'TabLine'
  " }}}
  " Plugin: unite.vim >> key mappings {{{

  " >> unite-source: find
  let g:unite_source_find_default_opts = '-L' " Follow symlinks
  " >> unite-source: grep & async
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--follow --nocolor --nogroup --hidden -g ""'
    let g:unite_source_grep_recursive_opt = ''

    "let g:unite_source_rec_async_command = 'ack -f --nofilter'
    let g:unite_source_rec_async_command =
      \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '""']
  elseif executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
  endif
  " >> unite-source: custom > profile
  call unite#custom#profile('default', 'context', {
    \ 'prompt_direction': 'top',
    \ 'start_insert': 1,
    \ 'short_source_names': 1,
    \ 'wrap': 1,
    \ 'split': 0,
    \ })
  call unite#custom#profile('files', 'substitute_patterns', {
    \ 'pattern' : '[[:alnum:]]',
    \ 'subst' : '\0',
    \ 'priority' : 100,
    \ })
  call unite#custom#profile('files', 'substitute_patterns', {
    \ 'pattern': '\$\w\+',
    \ 'subst': '\=eval(submatch(0))',
    \ 'priority': 200,
    \ })
  call unite#custom#profile('files', 'substitute_patterns', {
    \ 'pattern': '^@@',
    \ 'subst': '\=fnamemodify(expand("#"), ":p:h")."/"',
    \ 'priority': 2,
    \ })
  call unite#custom#profile('files', 'substitute_patterns', {
    \ 'pattern': '^@',
    \ 'subst': '\=getcwd()."/*"',
    \ 'priority': 1,
    \ })
  "call unite#custom#profile('files', 'substitute_patterns', {
    "\ 'pattern': '^;r',
    "\ 'subst': '\=$VIMRUNTIME."/"',
    "\ 'priority': 1,
    "\ })
  call unite#custom#profile('files', 'substitute_patterns', {
    \ 'pattern' : '^\~',
    \ 'subst' : substitute(
    \     unite#util#substitute_path_separator($HOME),
    \           ' ', '\\\\ ', 'g'),
    \ 'priority' : -100,
    \ })
  call unite#custom#profile('files', 'substitute_patterns', {
    \ 'pattern' : '\.\{2,}\ze[^/]',
    \ 'subst' : "\\=repeat('../', len(submatch(0))-1)",
    \ 'priority' : 10000,
    \ })
  " INFO: Not using cause I hope to match rule like flie_mru
  "call unite#custom#profile('files', 'substitute_patterns', {
    "\ 'pattern': '\\\@<! ',
    "\ 'subst': '\\ ',
    "\ 'priority': -20,
    "\ })
  "call unite#custom#profile('files', 'substitute_patterns', {
    "\ 'pattern': '\\ \@!',
    "\ 'subst': '/',
    "\ 'priority': -30,
    "\ })
  if has('win32') || has('win64')
    call unite#custom#profile('files', 'substitute_patterns', {
      \ 'pattern': '^;p',
      \ 'subst': 'C:/Program Files/',
      \ 'priority': 1,
      \ })
    call unite#custom#profile('files', 'substitute_patterns', {
      \ 'pattern': '^;v',
      \ 'subst': '~/vimfiles/',
      \ 'priority': 1,
      \ })
  else
    call unite#custom#profile('files', 'substitute_patterns', {
      \ 'pattern': '^;v',
      \ 'subst': '~/.vim/',
      \ 'priority': 1,
      \ })
  endif
  " >> unite-source: custom > aliases
  let g:unite_source_alias_aliases = get(g:, 'unite_source_alias_aliases', {})
  let g:unite_source_alias_aliases.workspace = {'source': 'file', 'args': "$HOME/workspace"}
  let g:unite_source_alias_aliases.workspace_rec = {'source': 'file_rec', 'args': "$HOME/workspace"}
  let s:unite_ignore_file_extention_regex = '\.\%(' . join([
    \   'o',
    \   'exe', 'dll', 'app',
    \   'zip', 'tar\.gz',
    \   'sw[po]', 'vimundo',
    \   'iml', 'idea',
    \   'gif', 'jpg', 'jpeg', 'png',
    \   'svn', 'git', 'bzr', 'hg',
    \   '__pycache__', 'pyc', 'egg', 'egg-info',
    \ ]) . '\)$'
  call unite#custom#source(
    \   'file,neomu/file',
    \   'ignore_pattern',
    \   join([
    \     '^\%(/\|\a\+:/\)$\|\%(^\|/\)\.\.\?$\|\~$',
    \     s:unite_ignore_file_extention_regex,
    \   ], '\|')
    \ )
  call unite#custom#source(
    \   'file,file_rec,file_rec/async',
    \   'ignore_pattern',
    \   join([
    \     '\%(^\|/\)\.$\|\~$',
    \     '\%(^\|/\)\.\%(hg\|git\|bzr\|svn\|idea\)\%($\|/\)',
    \     s:unite_ignore_file_extention_regex,
    \   ], '\|')
    \ )
  call unite#custom#source(
    \ 'buffer,file_rec,file_mru,file_rec,file_rec/async',
    \ 'converters',
    \ ['converter_file_directory']
    \ )


  " keymaps
  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
  nmap e [unite]
  xmap e [unite]

  function! s:define_unite_keymaps() " {{{
    nmap <buffer> <ESC><ESC> <Plug>(unite_exit)
    imap <buffer> <C-q> <Plug>(unite_exit)

    nmap <buffer> <C-p> k
    nmap <buffer> <C-n> j

    nmap <silent><buffer> <C-w> <Plug>(unite_delete_backward_word)
    imap <silent><buffer> <C-w> <Plug>(unite_delete_backward_word)
    inoremap <silent><buffer> <C-d> <Delete>
    inoremap <silent><buffer> <C-b> <Left>
    inoremap <silent><buffer> <C-f> <Right>

    nnoremap <silent><buffer><expr> <C-j> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-j> unite#do_action('split')
    nnoremap <silent><buffer><expr> <C-l> unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <C-l> unite#do_action('vsplit')
  endfunction " }}}
  augroup UniteBufferKeyMappings
    autocmd!
    autocmd FileType unite call s:define_unite_keymaps()
  augroup END
  function! s:unite_my_settings() "{{{
    " Overwrite settings.
    imap <buffer> <S-z>     <Plug>(unite_exit)
    nmap <buffer> <S-z>     <Plug>(unite_exit)
    imap <buffer> <D-z>     <Plug>(unite_exit)
    nmap <buffer> <D-z>     <Plug>(unite_exit)
    imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
    imap <buffer> '         <Plug>(unite_quick_match_default_action)
    nmap <buffer> '         <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> j   unite#smart_map('j', '')
    imap <buffer><expr> x   unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> x         <Plug>(unite_quick_match_choose_action)
    nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
    imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)

    let s:unite_map_r_action = unite#get_current_unite().profile_name ==# 'search' ? 'replace' : 'rename'
    nnoremap <silent><buffer><expr> l   unite#smart_map('l', unite#do_action('default'))
    nnoremap <silent><buffer><expr> cd  unite#do_action('lcd')
    nnoremap <silent><buffer><expr> r   unite#do_action(s:unite_map_r_action)
  endfunction "}}}
  autocmd FileType unite call s:unite_my_settings()
  nnoremap <C-p> :<C-u>Unite file_mru<CR>
  nnoremap <C-n> :<C-u>Unite buffer bookmark<CR>
  nnoremap <D-b> :<C-u>Unite bookmark<CR>
  "nnoremap <C-b> :<C-u>UniteBookmarkAdd<Space>

  nnoremap <silent> [unite]u :<C-u>Unite resume source<CR>
  nnoremap <silent> ?  :<C-u>Unite -buffer-name=search line -winheight=10 -no-quit<CR>

  xnoremap <silent> [unite]a :<C-u>Unite alignta:arguments<CR>
  nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir file -buffer-name=files buffer bookmark file<CR>
  nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer bookmark file<CR>
  nnoremap <silent> [unite]f :<C-u>Unite file_rec/async -buffer-name=files file<CR>
  " for current buffer
  nnoremap <silent> [unite]g :<C-u>Unite grep:%:-iR:<CR>
  nnoremap <silent> [unite]h :<C-u>Unite history/command<CR>
  nnoremap <silent> [unite]l :<C-u>Unite line -no-split -winheight=20<CR>
  nnoremap <silent> [unite]m :<C-u>Unite menu<CR>
  nnoremap <silent> [unite]M :<C-u>Unite mark<CR>
  "nnoremap <silent> [unite]n :<C-u>Unite
  nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]p :<C-u>UniteWithProjectDir file_rec/async -buffer-name=files buffer bookmark file<CR>
  nnoremap <silent> [unite]s :<C-u>Unite snippet<CR>
  nnoremap <silent> [unite]t :<C-u>Unite tig -no-start-insert -no-quit -no-split<CR>
  nnoremap <silent> [unite]w :<C-u>Unite workspace -buffer-name=bookmark<CR>
  nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>

  nnoremap <silent> [unite]B :<C-u>Unite bookmark -default-action=vimshell<CR>
  nnoremap <silent> [unite]C :<C-u>Unite colorscheme -auto-preview -split -winheight=10 -start-insert<CR>
  nnoremap <silent> [unite]G :<C-u>Unite grep:$:-iR:<CR>
  "nnoremap <silent> [unite]N :<C-u>Unite
  nnoremap <silent> [unite]T :<C-u>Unite -buffer-name=search line
    \ -wrap -winheight=10 -no-quit<CR>todo\\|fixme\\|warn\\|hackme<ESC>
  nnoremap <silent> [unite]W :<C-u>Unite workspace_rec -buffer-name=bookmark file -input=!vendor <CR>

  " }}}
  " ReStructedText / Sphinx {{{
  if exists('g:sphinx_build_bin')
    let g:quickrun_config['rst'] = {
      \     'command': g:sphinx_build_bin,
      \     'hook/sphinx/enable' : 1,
      \     'cmdopt': '-b html',
      \ }
  endif
  " }}}
  " Plugin: vim-markdown {{{
  let g:vim_markdown_folding_level = 2
  " }}}
  " Plugin: tagvar {{{
  nnoremap <silent> tl :TagbarToggle<CR>
  " }}}
endif

if MYVIM_FEATURES_HUGE >= g:myvim_features
  " Plugin: vim-startify {{{
  let g:startify_files_number = 15
  "let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions']
  let g:startify_list_order = ['bookmarks', 'files', 'sessions']
  let g:startify_bookmarks = get(g:, 'startify_bookmarks', [
    \ '~/.ssh/config',
    \ '~/.vimrc',
    \ '~/.vimrc.local',
    \ '~/.gvimrc',
    \ '~/.gvimrc.local',
    \ '~/.vim/bundle.vim.local',
    \ ])
  " }}}
  " Plugin: PreserveNoEOL {{{
  "setlocal noeol | let b:PreserveNoEOL = 1
  let b:PreserveNoEOL = 1
  let g:PreserveNoEOL = 1
  " }}}
  " Plugin: lightline.vim {{{
  let g:lightline = {
    \ 'colorscheme': 'tender',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], ['venv'], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode',
    \   'ctrlpmark': 'CtrlPMark',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ }


  let g:virtualenv_stl_format = 'venv@%n'

  function! MyModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    return &ft !~? 'help' && &readonly ? '⭤' : ''
  endfunction

  function! MyFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
      \ fname == '__Tagbar__' ? g:lightline.fname :
      \ fname =~ '__Gundo\|NERD_tree' ? '' :
      \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
      \ &ft == 'unite' ? unite#get_status_string() :
      \ &ft == 'vimshell' ? vimshell#get_status_string() :
      \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
      \ ('' != fname ? fname : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyFugitive()
    try
      if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
        let mark = '⭠ '  " edit here for cool mark
        let _ = fugitive#head()
        return strlen(_) ? mark._ : ''
      endif
    catch
    endtry
    return ''
  endfunction

  function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
  endfunction

  function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! MyMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
      \ fname == 'ControlP' ? 'CtrlP' :
      \ fname == '__Gundo__' ? 'Gundo' :
      \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
      \ fname =~ 'NERD_tree' ? 'NERDTree' :
      \ &ft == 'unite' ? 'Unite' :
      \ &ft == 'vimfiler' ? 'VimFiler' :
      \ &ft == 'vimshell' ? 'VimShell' :
      \ winwidth(0) > 60 ? lightline#mode() : ''
  endfunction

  function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
      call lightline#link('iR'[g:lightline.ctrlp_regex])
      return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
        \ , g:lightline.ctrlp_next], 0)
    else
      return ''
    endif
  endfunction

  let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusFunc_1',
    \ 'prog': 'CtrlPStatusFunc_2',
    \ }

  function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
  endfunction

  function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
  endfunction

  let g:tagbar_status_func = 'TagbarStatusFunc'

  function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
  endfunction

  augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp call s:syntastic()
  augroup END
  function! s:syntastic()
    SyntasticCheck
    call lightline#update()
  endfunction

  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
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
  " }}}
  " Plugin: alpaca_powertabline {{{
  let g:alpaca_powertabline_enable = 1
  " }}}
  " Plugin: accelerated-smooth-scroll {{{
  let g:ac_smooth_scroll_du_sleep_time_msec = 1
  let g:ac_smooth_scroll_fb_sleep_time_msec = 1
  " }}}
  " Plugin: calendar.vim {{{
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1

  let g:calendar_diary = '~/.cache/vim/calendar_vim_diary'
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
  " Plugin: syntastic {{{
  "let g:syntastic_debug = 1
  "let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list=1
  let g:syntastic_error_symbol='✗'
  let g:syntastic_mode_map =
    \ {
    \   'mode': 'active',
    \   'active_filetypes': [
    \     'php',
    \     'perl',
    \     'ruby',
    \     'haskell',
    \     'go',
    \     'xml',
    \     'vim',
    \   ],
    \   'passive_filetypes': [
    \     'zsh',
    \     'html',
    \   ],
    \ }

  let g:syntastic_quiet_messages = get(g:, 'syntastic_quiet_messages', {})
  let g:syntastic_quiet_messages = {
    \   "!level": "errors",
    \   "type": "style",
    \   "file:p": ['\m.rst$', '\m\c\.h$']
    \ }

  let g:syntastic_python_checkers = ['flake8']
  if has('mac')
    let g:syntastic_python_python_exec = '/usr/local/bin/python'
  endif
  " }}}
  " Plugin: matchit.vim {{{
  " INFO: Extended % command.
  "if filereadable($HOME . '/macros/matchit.vim')
  if filereadable(s:dein_dir . '/repos/matchit.zip/plugin/matchit.vim')
    runtime macros/matchit.vim
    let b:match_words = 'if:endif'
    let b:match_ignorecase = 1
  endif
  " }}}
  " Plugin: vim-go {{{
  let g:go_get_update = 0

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_interfaces = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  " }}}
  " Plugin: jedi-vim {{{
  let g:jedi#auto_vim_configuration = 0

  autocmd FileType python setlocal omnifunc=jedi#completions
  let g:jedi#completions_enabled = 0
  let g:jedi#auto_vim_configuration = 0
  if dein#tap('jedi-vim')
    " jediにvimの設定を任せると'completeopt+=preview'するので
    " 自動設定機能をOFFにし手動で設定を行う
    let g:jedi#auto_vim_configuration = 0
    " 補完の最初の項目が選択された状態だと使いにくいためオフにする
    let g:jedi#popup_select_first = 0
    " quickrunと被るため大文字に変更
    let g:jedi#rename_command = '<Leader>R'
    " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
    "let g:jedi#goto_assignments_command = '<Leader>G'
  endif
  " }}}
  " Plugin: vim-textmanip {{{
  let g:textmanip_enable_mappings = get(g:, 'textmanip_enable_mappings', 0)
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
  " Plugin: TweetVim {{{
  let g:tweetvim_tweet_per_page = 30
  let g:tweetvim_config_dir  = s:cache_dir . '/tweetvim'
  let g:tweetvim_include_rts = 1
  let g:tweetvim_open_buffer_cmd = 'split -winheight=12 edit!'
  nnoremap <silent> ts :<C-u>TweetVimSay<Cr>
  " unite mapping
  nnoremap <silent> tt :<C-u>Unite tweetvim<Cr>
  " }}}
  " Plugin: dbext.vim {{{
  let g:dbext_default_history_file = s:cache_dir . '/dbext_sql_history.sql'
  " }}}
  " Plugin: surround.vim {{{
  nmap ,( csw(
  nmap ,) csw)
  nmap ,{ csw{
  nmap ,} csw}
  nmap ,[ csw[
  nmap ,] csw]
  nmap ,' csw'
  nmap ," csw"
  " }}}
  " Plugin: Emmet.vim (Replaced from zenconding.vim) {{{
  let g:user_emmet_mode = 'a'
  let g:user_emmet_leader_key = '<c-y>'
  let g:use_emmet_complete_tag = 1
  let g:user_emmet_settings = get(g:, 'user_emmet_settings', {'lang' : 'ja'})
  let g:user_emmet_settings['html'] = {
    \   'filters' : 'html',
    \   'indentation' : ' '
    \ }
  let g:user_emmet_settings['haml'] = {
    \   'extends': 'html',
    \ }
  let g:user_emmet_settings['css'] = {
    \  'filters': 'fc',
    \ }
  let g:user_emmet_settings['javascript'] = {
    \   'snippets' : {
    \     'jq': "$(function() {\n\t${cursor}${child}\n});",
    \     'jq:each': "$.each(arr, function(index, item)\n\t${child}\n});",
    \     'fn': "(function() {\n\t${cursor}\n})();",
    \     'tm': "setTimeout(function() {\n\t${cursor}\n}, 100);",
    \   },
    \ }
  let g:user_emmet_settings['perl'] = {
    \  'extends': 'html',
    \  'filters': 'html,c',
    \ }
  let g:user_emmet_settings['perl'] = {
    \   'indentation': '  ',
    \   'aliases': {
    \     'req': "require '|'"
    \   },
    \   'snippets' : {
    \     'use': "use strict\nuse warnings\n\n",
    \     'w': "warn \"${cursor}\";",
    \   },
    \ }


  " }}}
  " Plugin: neocomplete {{{
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_auto_select = 0
  try
    set completeopt-=noselect
    set completeopt+=noinsert
    let g:neocomplete#enable_auto_select = 0
  catch /^Vim\%((\a\+)\)\=:E474/
    " when the patch isn't applied
  endtry
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#max_list = 39
  let g:neocomplete#max_keyword_width = 64
  let g:neocomplete#auto_completion_start_length = 4
  let g:neocomplete#manual_completion_start_length = 4
  let g:neocomplete#min_keyword_length = 4
  "let g:neocomplete#enable_camel_case = 0
  "let g:neocomplete#disable_auto_complete = 0
  let g:neocomplete#enable_cursor_hold_i = 0
  let g:neocomplete#cursor_hold_i_time = 300
  let g:neocomplete#enable_insert_char_pre = 1 " Really??
  let g:neocomplete#enable_auto_delimiter = 0
  let g:neocomplete#enable_fuzzy_completion = 1
  "let g:neocomplete#enable_multibyte_completion = 0
  "let g:neocomplete#lock_iminsert = 0
  let g:neocomplete#data_directory = s:cache_dir . '/neocomplete'
  let g:neocomplete#keyword_patterns = get(g:, 'neocomplete#keyword_patterns', {})
  let g:neocomplete#force_omni_input_patterns =
    \ get(g:, 'neocomplete#force_omni_input_patterns', {})
  "let g:neocomplete#same_filetypes = {}
  "let g:neocomplete#text_mode_filetypes = 0
  "let g:neocomplete#text_mode_filetypes = 'ctags'
  "let g:neocomplete#ctags_arguments
  "let g:neocomplete#delimiter_patterns = {}
  let g:neocomplete#sources = get(g:, 'neocomplete#sources', {})
  let g:neocomplete#release_cache_time = 900
  " let g:neocomplete#tags_filter_patterns
  let g:neocomplete#use_vimproc = 1
  let g:neocomplete#ignore_composite_filetypes = {
    \ 'ruby.spec' : 'ruby'
    \ }
  "let g:neocomplete#skip_auto_completion_time
  let g:neocomplete#fallback_mappings = []
  " Enable omni completion.
  let g:neocomplete#sources#omni#functions = get(g:, 'neocomplete#sources#omni#functions', {})
  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif

  let g:neocomplete#force_omni_input_patterns.python =
    \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
  let g:neocomplete#sources#omni#functions.go =  'gocomplete#Complete'
  let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  " scheme for SICP
  let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
  vmap <CR> <Plug>(gosh_repl_send_block)

  " popup highlight
  highlight Pmenu ctermbg=8 guibg=#606060
  highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
  highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

  " Plugin key-mappings.
  inoremap <silent><expr><C-g>  neocomplete#undo_completion()
  inoremap <silent><expr><C-l>  neocomplete#complete_common_string()
  inoremap <silent><expr><C-q>  neocomplete#cancel_popup()
  inoremap <silent><expr><S-Space> neocomplete#start_manual_complete()
  if has('gui_runnig')
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  endif

  " <CR>: close popup and save indent.
  function! s:my_cr_function()
    "return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  " }}}
  " Plugin: neosnippet {{{
  " TODO: clear snippets_directory
  "let g:neosnippet#snippets_directory =
  "  \ s:dein_dir . 'neocomplcache-snippets-complete/autoload/neocomplcache/sources/snippets_complete'
  "  \ .','. $HOME . '/.vim/snippets'

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
  " Plugin: vim-multiple-cursors {{{
  let g:multi_cursor_start_key = 'm'
  " }}}
  " Plugin: jscomplatete.vim {{{
  let g:jscomplete_use = ['dom']
  " }}}
  " Plugin: vim-vcs {{{
  let g:vcs#config_log_file = s:cache_dir . '/vcs'
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
  " Plugin: vimshell {{{
  "function! s:bundle.hooks.on_source(bundle)
    let g:vimshell_temporary_directory = s:cache_dir . '/.vimshell'
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
      "call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
      let g:vimshell_execute_file_list['zip'] = 'zipinfo'
      "call vimshell#set_execute_file('tgz,gz', 'gzcat')
      "call vimshell#set_execute_file('tbz,bz2', 'bzcat')
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
  " Plugin: alpaca_tags {{{
  let g:alpaca_tags#config = get(g:, 'alpaca_tags#config', {})
  let g:alpaca_tags#config['js'] = '-R --languages=+js'
  let g:alpaca_tags#config['ruby'] = '--langmap=RUBY:.rb --exclude="*.js" --exclude=".git*'
  augroup AlpacaTagsRubyBundler
    autocmd!
    if exists(':Tags')
      autocmd BufWritePost Gemfile AlpacaTagsBundle
      "autocmd BufEnter * TagsSet
      " 毎回保存と同時更新する場合はコメントを外す
      " autocmd BufWritePost * TagsUpdate
    endif
  augroup END
  "let g:alpaca_tags#config = get(g:, 'alpaca_tags#config', {
    "\   '_': '-R --exclude=".git*" --sort=yes',
    "\ 'default' : '--languages=-css,scss,html,js,JavaScript',
    "\ 'js' : '--languages=+js',
    "\ '-js' : '--languages=-js,JavaScript',
    "\ 'vim' : '--languages=+Vim,vim',
    "\ 'php' : '--languages=+php --php-types=c+f+d',
    "\ '-vim' : '--languages=-Vim,vim',
    "\ '-style': '--languages=-css,scss,js,JavaScript,html',
    "\ 'scss' : '--languages=+scss --languages=-css',
    "\ 'css' : '--languages=+css',
    "\ 'java' : '--languages=+java $JAVA_HOME/src',
    "\ 'ruby': '--languages=+Ruby',
    "\ 'coffee': '--languages=+coffee',
    "\ '-coffee': '--languages=-coffee',
    "\ 'bundle': '--languages=+Ruby',
    "\ 'go': '--langdef=Go --langmap=Go:.go'
    "\   . ' --regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/d,func/'
    "\   . ' --regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,type/',
    "\ 'python': '--python-kinds=-iv --exclude="build" --exclude=".venv" --exclude="dist"',
    "\ 'erlang': '--languages=erlang --file-scope=no',
    "\ })

  "" This variable is options for debug.
  "let g:alpaca_tags#console = {'report' : 1}

  "augroup AlpacaTags
    "autocmd!
    "if exists(':AlpacaTags')
      ""autocmd BufWritePost Gemfile AlpacaTagsBundle
      "autocmd BufWritePost * AlpacaTagsUpdate
    "endif
  "augroup END

  "autocmd BufEnter * AlpacaTagsSet
  augroup MyAutoSetCtagPath
    autocmd!
    au BufEnter * execute ":set tags="
      \ . unite#util#path2project_directory(unite#util#substitute_path_separator(getcwd()))
      \ . '/tags'
      "\ . escape(unite#util#path2project_directory(unite#util#substitute_path_separator(getcwd())), ' ')
  augroup END
  " }}}
  " Plugin: unite-tag {{{
  let g:unite_source_tag_max_name_length = 25
  let g:unite_source_tag_max_fname_length = 80
  let g:unite_source_tag_strict_truncate_string = 1
  let g:unite_source_tag_show_location = 1
  let g:unite_source_tag_show_fname = 1

  augroup MyUniteTag
    autocmd!
    autocmd BufEnter * if empty(&buftype) | nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR> | endif
    " http://qiita.com/kazu0620/items/d7da3047daed04fc5eba
    autocmd BufEnter * if empty(&buftype) |  nnoremap <buffer> <C-t> :<C-u>Unite jump<CR> | endif
  augroup END
  " }}}
  " Plugin: unite-tig {{{
  let g:unite_tig_default_line_count = 80
  " }}}
  " Plugin: unite-grep {{{
  let g:unite_source_grep_default_opts = '-Hn'  " By the default
  let g:unite_source_grep_recursive_opt = '-R'  " By the default
  " }}}
  " Plugin: unite.vim >> source menus {{{
  let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})
  let g:unite_source_menu_menus.shortcut = {
    \ 'description' : 'My shortcut',
    \ 'command_candidates' : [
    \   ['edit vimrc', 'edit $MYVIMRC'],
    \   ['edit vimrc.local', 'edit $MYVIMRC_LOCAL'],
    \   ['edit gvimrc', 'edit $MYGVIMRC'],
    \   ['edit gvimrc.local', 'edit $MYGVIMRC_LOCAL'],
    \   ['edit zshrc', 'edit $HOME/.zshrc'],
    \   ['edit zshrc.local', 'edit $HOME/.zshrc.local'],
    \ ]}
  let g:unite_source_menu_menus.interactive_mode = {
    \ 'description': 'Mode of interactive programming languages',
    \ 'command_candidates': [
    \   ['ruby', 'VimShellInteractive ruby'],
    \   ['python', 'VimShellInteractive python'],
    \ ]}
  let g:unite_source_menu_menus.git = {
    \ 'description': 'Gestionar repositorios git  ⌘ [espacio]g',
    \ 'command_candidates': [
    \   ['▷ tig                                              [unite]t',   'Unite tig -no-start-insert -winheight=20'],
    \   ['▷ git status        (Fugitive)                     <Leader>gs', 'Gstatus'],
    \   ['▷ git diff (vertical) (Fugitive)                   <Leader>gd', 'Gvdiff'],
    \   ['▷ git diff          (Fugitive)                     <Leader>gd', 'Gsdiff'],
    \   ['▷ git diff --cached (vertical) (Fugitive)          <Leader>gD', 'Gsdiff --cached'],
    \   ['▷ git diff --cached (Fugitive)                     <Leader>gD', 'Gsdiff --cached'],
    \   ['▷ git commit        (Fugitive)                     <Leader>gc', 'Gcommit --verbose'],
    \   ['▷ git blame         (Fugitive)',                                'Gblame'],
    \   ['▷ git push          (Fugitive, salida por buffer)',             'Git! push'],
    \   ['▷ git pull          (Fugitive, salida por buffer)',             'Git! pull'],
    \   ['▷ git stage         (Fugitive)',                                'Gwrite'],
    \   ['▷ git checkout      (Fugitive)',                                'Gread'],
    \   ['▷ git rm            (Fugitive)',                                'Gremove'],
    \   ['▷ git mv            (Fugitive)',                                'exe "Gmove " input("destino: ")'],
    \   ['▷ git prompt        (Fugitive, salida por buffer)',             'exe "Git! " input("comando git: ")'],
    \   ['▷ git cd            (Fugitive)',                                'Gcd'],
    \   ['▷ help git status   (Fugitive)',                                'help Gstatus'],
    \ ]}

  nnoremap <silent><M-l> :Unite menu<Cr>
  nnoremap <silent><M-g> :Unite -silent -start-insert menu:git<Cr>
  nnoremap <silent><M-s> :Unite -silent -start-insert menu:shortcut<Cr>
  nnoremap <silent><M-i> :Unite -silent -start-insert menu:interactive_mode<Cr>
  nnoremap <silent><D-l> :Unite menu<Cr>
  nnoremap <silent><D-g> :Unite -silent -start-insert menu:git<Cr>
  nnoremap <silent><D-s> :Unite -silent -start-insert menu:shortcut<Cr>
  nnoremap <silent><D-i> :Unite -silent -start-insert menu:interactive_mode<Cr>
  if !has('gui_running')
    nmap <ESC>l <M-l>
    nmap <ESC>g <M-g>
    nmap <ESC>s <M-s>
    nmap <ESC>i <M-i>
  endif
  " }}}
  " My Plugin: vim-multiple-switcher {{{
  "let g:multiple_switcher_no_default_key_maps = 1
  nnoremap <silent> ,p :<C-u>call multiple_switcher#switch('paste')<CR>
  nnoremap <silent> ,e :<C-u>call multiple_switcher#switch('expandtab')<CR>
  nnoremap <silent> ,w :<C-u>call multiple_switcher#switch('wrap')<CR>
  vnoremap <silent> ,n :<C-u>call multiple_switcher#switch('number')<CR>
  " }}}

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
endif

" Hook loaded vimrc
if exists("*LoadedHookVIMRC")
  call LoadedHookVIMRC()
endif
