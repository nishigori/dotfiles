" # Initialize {{{
" ## Dependency Operating System {{{2
if has('win32')
  " INFO: .vimrc unifies vimrc
  "       .vim   unifies vimfiles
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
endif
" }}}
" ## Dependency vimrc.local "{{{2
let s:vimbundle = ''
if !filereadable(expand($HOME. '/.vimrc.local'))
  set directory= backupdir= viewdir=
  if has('persistent_undo')
    set undodir=
  endif

else
  " INFO: Read .vimrc.local.sample
  source $HOME/.vimrc.local

  if exists('g:dependency_local_lists')
    let $MYVIMRC = g:dependency_local_lists['dotfiles_dir'] . '/.vimrc'
    if has_key(g:dependency_local_lists, 'plugin-manager')
      let s:vimbundle = g:dependency_local_lists['plugin-manager']
    endif

    set swapfile
    set backup
  endif
endif " }}}
" }}}
" # Plugin Manager {{{
if s:vimbundle == 'neobundle'
  " ## neobundle.vim {{{2
  set nocompatible
  filetype off
  if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim.git
    call neobundle#rc()
  endif
  " unite source {{{3
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'h1mesuke/unite-outline'
  NeoBundle 'Sixeight/unite-grep'
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'ujihisa/unite-font'
  NeoBundle 'thinca/vim-unite-history'
  NeoBundle 'tacroe/unite-mark'
  NeoBundle 'tsukkee/unite-help'
  " }}}
  " buffer, tag {{{3
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'ujihisa/vimshell-ssh'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'vim-scripts/current-func-info.vim'
  NeoBundle 'vim-scripts/taglist.vim'
  NeoBundle 'sudo.vim'
  "NeoBundle 'Shougo/echodoc'
  " }}}
  " complete, snippet {{{3
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'nishigori/neocomplcache_phpunit_snippet'
  NeoBundle 'thinca/vim-ambicmd'
  "NeoBundle 'neco-look'
  " }}}
  " text operation {{{3
  NeoBundle 'mattn/zencoding-vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'smartchr'
  NeoBundle 'scrooloose/nerdcommenter'
  NeoBundle 't9md/vim-textmanip'
  NeoBundle 'visualstar.vim'
  NeoBundle 'vim-scripts/matchit.zip'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'nishigori/vim-sunday'
  "NeoBundle 'tyru/operator-star.vim'
  " NOTE: yankring dependence suck key map.
  "NeoBundle 'richleland/vim-yankring'
  " }}}
  " marks {{{3
  "NeoBundle 'vim-scripts/ShowMarks'
  "NeoBundle 'vim-scripts/number-marks'
  " }}}
  " ref, help {{{3
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'soh335/vim-ref-jquery'
  " }}}
  " filetype {{{3
  NeoBundle 'basyura/jslint.vim'
  NeoBundle 'jtriley/vim-rst-headings'
  NeoBundle 'nishigori/phpfolding.vim'
  NeoBundle 'nishigori/vim-twig'
  NeoBundle 'heavenshell/unite-sf2'
  NeoBundle 'vim-scripts/css3'
  NeoBundle 'beyondwords/vim-twig'
  NeoBundle 'https://bitbucket.org/kotarak/vimclojure'
  " }}}
  " color sheme & font {{{3
  NeoBundle 'vim-scripts/molokai'
  NeoBundle 'desert256.vim'
  NeoBundle 'wombat256.vim'
  " :colorscheme wombat256mod
  NeoBundle 'Diablo3'
  NeoBundle 'candycode.vim'
  NeoBundle 'xoria256.vim'
  NeoBundle 'ujihisa/mrkn256.vim'
  NeoBundle 'vim-scripts/Lucius'
  NeoBundle 'peaksea'
  NeoBundle 'thinca/vim-fontzoom'
  NeoBundle 'altercation/vim-colors-solarized'
  " }}}
  " dictionary {{{3
  NeoBundle 'nishigori/vim-php-dictionary'
  " }}}
  " browse {{{3
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'vim-scripts/TwitVim.git'
  " evervim 重すぎ
  "NeoBundle 'kakkyz81/evervim.git'
  " }}}
  " VCS {{{3
  "NeoBundle 'Shougo/vim-vcs'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'mattn/gist-vim'
  "NeoBundle 'thinca/vim-ft-svn_diff'
  " }}}
  " xUnit {{{3
  "NeoBundle 'vimUnit'
  "NeoBundle 'pyunit'
  "NeoBundle 'toggle_unit_tests'
  " WARNING: Needless phpunit plugin, because defalut key-mapping is suck!!
  "NeoBundle 'phpunit'
  " }}}
  " DB {{{3
  " INFO: dbext.vim' latest version is into the vim.org.
  "       http://vim.sourceforge.net/scripts/script.php?script_id=356
  NeoBundle 'vim-scripts/dbext.vim'
  " }}}
  " debug, backend {{{3
  NeoBundle 'Shougo/vimproc'
  "NeoBundle 'ujihisa/vital.vim'
  " }}}
  " tools {{{3
  NeoBundle 'mattn/calendar-vim'
  NeoBundle 'vim-scripts/submode'
  " }}}
  filetype plugin on
  filetype indent on
  " }}}
elseif s:vimbundle == 'pathogen'
  " ## pathogen.vim {{{2
  " INFO: https://github.com/tpope/vim-pathogen.git
  "       Cause, It's has dependency (HTTP Proxy etc..) on the work.
  call pathogen#runtime_append_all_bundles()
  call pathogen#helptags()
  " }}}
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
" # Encoding {{{
" Note: Kaoriya MacVim is needless encoding.
if !has('gui_macvim') || !has('kaoriya')
  " INFO: If encode is fixed, :e ++enc = {encoding-name}
  set encoding=utf-8
  set fileencodings=utf-8,euc-jp,shitjis,iso-2022-jp,latin1
endif
" }}}
" # Syntax {{{
if has('syntax')
  " zg (z-good), zw (z-warning)
  syntax enable
  set synmaxcol=1500
  setlocal nospell

  set list
  " - tab: タブ文字, trail: 行末スペース, eol: 改行文字, extends: 行末短縮, precedes: 行頭短縮, nbsp: 空白文字
  set listchars=tab:»-,extends:>,precedes:<,eol:↲,nbsp:%,trail:-,nbsp:>

  " POD bug (version 7.3?)
  autocmd BufEnter * :syntax sync fromstart

  " whitespaceEOL on highlight via. gunyara. alias lists[trail]
  highlight WhitespaceEOL ctermbg=red guibg=red
  match WhitespaceEOL /s+$/

  if has('mac')
    set noimdisableactivate
    highlight ZenkakuSpace gui=underline guibg=DarkBlue cterm=underline ctermfg=LightBlue
    match ZenkakuSpace /　/
  else
    augroup ZenkakuSpace "{{{
      autocmd!
      autocmd VimEnter,BufEnter * call ZenkakuSpace()
    augroup END "}}}
    function! ZenkakuSpace() "{{{
      highlight ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=red
      silent! match ZenkakuSpace /　/
    endfunction "}}}
  endif

  set number
  set numberwidth=4
  if version >= 703
    nnoremap <silent> ,n :<C-u>ToggleNumber<Cr>
    vnoremap <silent> ,n :<C-u>ToggleNumber<Cr>
    command! -nargs=0 ToggleNumber call ToggleNumberOption()
    function! ToggleNumberOption() " {{{
      if &number
        set relativenumber
      else
        set number
        "set number numberwidth-=1
      endif
    endfunction " }}}
  endif
endif
" }}}
" # Indent {{{
set autoindent
set expandtab " replaced Tab with Indent
"setlocal ts=4 sw=4 sts=0 " [ts: Tab's space, sw: autoIndent's space, sts: replaced <Tab> space]
set tabstop=4
set shiftwidth=4
set softtabstop=0
inoremap <C-=> <Esc>==i
" }}}
" # Basic {{{
"filetype plugin indent on
set nocompatible              " Use Vim defaults (much better!)
set showcmd                   " Highliting bracket set.
set hidden                    " Enable open new file, when while editing other file.
set autoread
set history=255
set viminfo='20,\"50          " Read/write a .viminfo file, don't store more than 50 lines of registers
set backspace=indent,eol,start" Allow backspacing over everything in insert mode
set ambiwidth=double
set virtualedit+=block        " Block-select to the end of the line for blockwise Visual mode.

" help
set helplang=ja,en
nnoremap <C-h><C-h> :<C-u>help<Space>
nnoremap <silent> <C-h> :<C-u>help<Space><C-r><C-w><CR>

set title
"function! s:titlestring() "{{{2
  "if exists('t:cwd')
    "return t:cwd . ' (tab)'
  "elseif haslocaldir()
    "return getcwd() . ' (local)'
  "else
    "return getcwd()
  "endif
"endfunction "}}}
"let &titlestring = '%{SandboxCallOptionFn("titlestring")}'

" <Leader>
let mapleader = " "
" }}}
" # Filetype Detect {{{
augroup FiletypeDetect
  au! BufRead,BufNewFile,BufWinEnter *.mine       setfiletype mine
  au! BufRead,BufNewFile,BufWinEnter *.xyz        setfiletype drawing
  au! BufRead,BufNewFile,BufWinEnter *.tt         setfiletype html
  au! BufRead,BufNewFile,BufWinEnter *.txt        setfiletype txt
  au! BufRead,BufNewFile,BufWinEnter *.phl        setfiletype html.php
  au! BufRead,BufNewFile,BufWinEnter *.pht        setfiletype html.php
  au! BufRead,BufNewFile,BufWinEnter *Test.php    setfiletype php.phpunit
  au! BufRead,BufNewFile,BufWinEnter *sikuli/*.py setfiletype python.sikuli
  au! BufRead,BufNewFile,BufWinEnter,BufReadPre *quickrun\ output*        set syntax=vimshell
  au! BufRead,BufNewFile /etc/httpd/conf/*,/etc/httpd/conf.d/* setfiletype apache
  au! BufRead,BufNewFile,BufWinEnter *vimperatorrc*,*.vimp     setfiletype vimperator
  au! BufRead,BufNewFile,BufWinEnter *muttatorrc*,*.muttator   setfiletype muttator
augroup END

" SQL
let g:sql_type_default = 'mysql'
" }}}
" # Color Scheme {{{
set t_Co=256
let g:solarized_termcolors = 256  " CASE: g:colors_name is solarized
colorscheme diablo3
set background=dark
highlight StatusLine term=NONE cterm=NONE ctermfg=white ctermbg=black
" add cursorline at the current window.
augroup cch
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
highlight CursorLine ctermbg=black guibg=black
highlight CursorColumn ctermbg=black guibg=black

let apache_version = '2.0' " apache highliting

" highlighting target of long line.
if exists('&colorcolumn')
  set colorcolumn=+1
  "nnoremap <silent> <Leader>l :<C-u>set<Space>spell!<Space>list!<Space>colorcolumn=-1<Cr>
  nnoremap <silent> <Leader>l :<C-u>set<Space>list!<Space>colorcolumn=-1<Cr>
endif

"# HIGHLIGHT_CURRENT_LINE
nnoremap <silent> <Leader>hs :<C-u>HighlightCurrentLine Search<Cr>
nnoremap <silent> <Leader>hd :<C-u>HighlightCurrentLine DiffAdd<Cr>
nnoremap <silent> <Leader>he :<C-u>HighlightCurrentLine Error<Cr>
nnoremap <silent> <Leader>H :<C-u>UnHighlightCurrentLine<Cr>
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
  endfunction  " }}}

  call s:use_meta_keys()
  map <NUL> <C-Space>
  map! <NUL> <C-Space>

  " stopped job
  nnoremap <silent> gZZ :set t_te = t_ti = <Cr>:quit<Cr>:set t_te& t_ti&<Cr>
  nnoremap <silent> gsh :set t_te = t_ti = <Cr>:st<Cr>:set t_te& t_ti&<Cr>
  nnoremap <silent> gst :set t_te = t_ti = <Cr>:st<Cr>:set t_te& t_ti&<Cr>
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
let g:hi_insert = 'hi StatusLine gui=None guifg=Black guibg=Yellow cterm=None ctermfg=Black ctermbg=Yellow'
  " highlight Normal ctermbg=Black ctermfg=White
" }}}
" # <Tab> {{{
set showtabline=1 " :h tabline
nnoremap tn :<C-u>tabnew<Space>
nnoremap <silent> <Tab> :<C-u>tabnext<Cr>
nnoremap <silent> <S-Tab> :<C-u>tabprevious<Cr>
" }}}
" # Search {{{
set hlsearch    " Highlight search option
set incsearch   " typed so far, matches
set ignorecase
set smartcase   " Override ignorecase option (search contains upper case).
set nowrapscan  " Searches nowrap around.

nnoremap * *N
nnoremap # #N
" regex pattern
nnoremap \ /^
" }}}
" # Copy & Paste {{{
" Like nmap 'D' and 'C'
nnoremap Y y$
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
" 括弧を自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap `` ``<LEFT>

cnoremap { {}<LEFT>
cnoremap [ []<LEFT>
cnoremap ( ()<LEFT>
cnoremap "" ""<LEFT>
cnoremap '' ''<LEFT>

" Support Input Date
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')
" }}}
" # IME Control {{{
" <ESC> insert mode, IME off
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <C-]> <ESC>:set iminsert=0<Cr>
inoremap <ESC> <ESC>:set iminsert=0<Cr>
"IME状態に応じたカーソル色を設定
if has('multi_byte_ime')
  highlight Cursor guifg=#000d18 guibg=#8faf9f gui=bold
  highlight CursorIM guifg=NONE guibg=#ecbcbc
endif
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END
" }}}
" # Moving Cursole {{{
nnoremap j gj
nnoremap k gk
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
cnoremap <C-e> <END>
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
vnoremap <silent>gc :<C-u>normal gc<Cr>
onoremap <silent>gc :<C-u>normal gc<Cr>

" vim-users.jp Hack #214
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

" Only do this part, when compiled with support for autocommands
augroup redhat  "{{{2
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END "}}}
" }}}
" # Quick Start $MYVIMRC {{{
nnoremap <silent> e. :<C-u>edit $MYVIMRC<Cr>
nnoremap <silent> es :<C-u>source $MYVIMRC<Cr>
" }}}
" # Window, Buffer {{{
set splitright  " Default vsplit, left
set splitbelow  " Default split, top

" vim-users.jp Hack #42
nnoremap <silent> <C-w>h <C-w>h:call <SID>good_width()<Cr>
nnoremap <silent> <C-w>l <C-w>l:call <SID>good_width()<Cr>
nnoremap <silent> <C-w>H <C-w>H:call <SID>good_width()<Cr>
nnoremap <silent> <C-w>L <C-w>L:call <SID>good_width()<Cr>
function! s:good_width()  "{{{2
  if winwidth(0) < 84 && expand('%') != '__Tag_List__' && expand('%') != '[quickrun output]'
    vertical resize 84
  endif
endfunction "}}}

nnoremap <silent> <Leader>b :<C-u>bnext<Cr>
nnoremap <silent> <Leader>B :<C-u>bprevious<Cr>

" inspaired @taku-o's Kwdb.vim
:com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn 
nnoremap <silent> <Leader>d :<C-u>:Kwbd<Cr>
" }}}
" # Fold, View {{{
nnoremap <Leader>f za
set foldcolumn=4
" NOTE: foldlevel moved to fplugin
"setlocal foldlevel=0
setlocal fillchars+=fold:-
if expand('%') !~ 'vim\|php'
  " Save fold settings. More Vim-user.jp Hack #84
  autocmd BufWritePost * mkview
  autocmd BufRead * silent loadview
  " Don't save options.
  set viewoptions-=options
endif
if has('win32')
  set viewoptions+=unix
endif
" }}}
" # Directory {{{
" カレントディレクトリをファイルと同じディレクトリに移動
" set autochdir
augroup AUTOCHDIR
  autocmd!
  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
augroup END
" Change directory. vim-users.jp Hack #69
nnoremap <silent> CD :<C-u>CD<Cr>
nnoremap <silent> gu :<C-u>GU<Cr>
nnoremap <silent> gU :<C-u>GUH<Cr>
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
command! -nargs=? -complete=dir -bang GU  call s:ChangeCurrentDir('../', '<bang>') 
command! -nargs=? -complete=dir -bang GUH  call s:ChangeCurrentDir('$HOME', '<bang>') 
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
" TODO: <Up>と重なってるため別マップを考えなくては
"inoremap <silent> <C-k> <C-x><C-k>
" }}}
" # Ctags {{{
if has('path_extra') && &filetype !~ 'zsh\|conf'
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
" TODO: I Want to use sometime ...
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
" omni_complete, completed ftplugin
inoremap <silent> <C-o> <C-x><C-o>
" }}}
" # Undo persistence {{{
if has('persistent_undo')
  " NOTE: When declare au for persistent_undo, no set undofile
  "       :help persistent-undo
  augroup UNDO_PERSISTENCE
    au BufReadPost * call ReadUndo()
    au BufWritePost * call WriteUndo()
  augroup END

  function! ReadUndo()  "{{{2
    let undo_file = substitute(expand('%:p'), '\/\|\\', '\_', 'g')
    if filereadable(&undodir .'/'. undo_file)
      execute 'rundo' &undodir.'/'.undo_file
    endif
  endfunction "}}}
  function! WriteUndo() "{{{2
    if !isdirectory(&undodir)
      call mkdir(&undodir)
    endif
    let undo_file = substitute(expand('%:p'), '\/\|\\', '\_', 'g')
    execute 'wundo' &undodir.'/'.undo_file
  endfunction "}}}
endif
" }}}
" # Weekly Buffer {{{
" Use weekly buffer for GTD tool.
if has_key(g:dependency_local_lists, 'weekly_buffer_dir')
  let g:local#weekly_buffer_dir = g:dependency_local_lists['weekly_buffer_dir']
  nnoremap <silent> <S-t><S-t> :<C-u>OpenweeklyBuffer<Cr>
  command! -nargs=0 OpenweeklyBuffer call OpenweeklyBuffer()
  function! OpenweeklyBuffer() "{{{2
    if !exists('g:weekly_buffer')
      let today = strftime('%Y%m%d')
      let day_of_week = strftime('%w')  " Son. = 0, Mon. = 1, Tue. = 2 ...
      if day_of_week == 0 || day_of_week == 6
        let start_week = today - day_of_week + 1
        let end_week   = today - day_of_week + 5
      else
        " TODO: たぶん土日は何か変えたかったのかな？あとで確認
        let start_week = today - day_of_week + 1
        let end_week   = today - day_of_week + 5
      endif

      let g:weekly_buffer = g:local#weekly_buffer_dir .'/'. start_week .'_'. end_week
    endif

    execute '7new ' . g:weekly_buffer
  endfunction " }}}
  " TODO: command使ってWinHeight引数で指定する処理を入れたい、かも
  "       s:の関数名に変える(<SID>の理解が必要)
  "function! s:open_weekly_buffer()
  "command! -nargs=1 OpenweeklyBuffer call s:open_weekly_buffer(<q-args>)
endif
" }}}
" # Plugin
" ## visualstar.vim {{{
" search extended plugin.
if exists('g:loaded_visualstar')
  map * <Plug>(visualstar-*)N
  map # <Plug>(visualstar-#)N
endif
" }}}
" ## matchit.vim {{{
" INFO: Extended % command.
"if filereadable($HOME . '/macros/matchit.vim')
if filereadable($HOME . '/.vim/bundle/matchit.zip/plugin/matchit.vim')
  runtime macros/matchit.vim
  let b:match_words = 'if:endif'
  let b:match_ignorecase = 1
endif
" }}}
" ## indent-guides {{{
" INFO: auto highlight indent-space.
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" }}}
" ## taglist.vim {{{
if has('path_extra')
  nnoremap <silent> tl :<C-u>Tlist<Cr>
  let Tlist_Exit_OnlyWindow = 1       "taglistのウィンドーが最後のウィンドーならばVimを閉じる
  let Tlist_WinWidth = 40
  let Tlist_Enable_Fold_Column = 3
  let Tlist_Process_File_Always = 1
  " let Tlist_Show_One_File = 1       "現在編集中のソースのタグしか表示しない
endif
" }}}
" ## vimshell {{{
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1
let g:vimshell_enable_auto_slash = 1
let g:vimshell_max_command_history = 200
let g:vimshell_max_list = 15
let g:vimshell_split_height = 18
let g:vimshell_split_command = 'split'

" almost paste from vimshll-examples
" Initialize execute file list.
let g:vimshell_execute_file_list = {}
call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
let g:vimshell_execute_file_list['rb'] = 'ruby'
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['py'] = 'python'
let g:vimshell_execute_file_list['php'] = 'php'
let g:vimshell_execute_file_list['git'] = 'git'
call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1

if has('win32') || has('win64')
  " Display user name on Windows.
  let g:vimshell_prompt = $USERNAME." % "
else
  " Display user name on Linux.
  let g:vimshell_prompt = $USER." % "

  call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
  call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
  let g:vimshell_execute_file_list['zip'] = 'zipinfo'
  call vimshell#set_execute_file('tgz,gz', 'gzcat')
  call vimshell#set_execute_file('tbz,bz2', 'bzcat')
endif

autocmd FileType vimshell
\ call vimshell#altercmd#define('g', 'git')
\| call vimshell#altercmd#define('i', 'iexe')
\| call vimshell#altercmd#define('l', 'll')
\| call vimshell#altercmd#define('ll', 'ls -l')
\| call vimshell#altercmd#define('a', 'ls -al')
\| call vimshell#altercmd#define('la', 'ls -al')
\| call vimshell#altercmd#define('cl', 'clear')
\| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

function! g:my_chpwd(args, context)
  call vimshell#execute('ls')
endfunction

autocmd FileType int-* call s:interactive_settings()
function! s:interactive_settings()
endfunction
" }}}
" ## vimfiler {{{
let g:vimfiler_sort_type = 'name'
let g:vimfiler_as_default_explorer = 1

"let g:vimfiler_trashbox_directory = $HOME . '/tmp/vim/vimfiler_transhbox'
" }}}
" ## neocomplcache {{{
let g:neocomplcache_temporary_dir = $HOME . '/tmp/vim/neocom'

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_menu_width = 20
let g:neocomplcache_auto_completion_start_length = 4
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 5
let g:neocomplcache_enable_smart_case = 1
" -を入力すると候補横の数字で選択可になる
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_max_list = 50
" dictionary
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default'    : '',
  \ 'vimshell'   : $HOME . '/.vim/dict/.vimshell.dict',
  \ 'java'       : $HOME . '/.vim/dict/java.dict',
  \ 'c'          : $HOME . '/.vim/dict/c.dict',
  \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
  \ 'php'        : $HOME . '/.vim/bundle/vim-php-dictionary/dict/PHP.dict',
  \ 'phpunit'    : $HOME . '/.vim/bundle/vim-php-dictionary/dict/PHP.dict,' . $HOME . '/.vim/dict/phpunit.dict',
  \ 'python'     : $HOME . '/.vim/dict/python.dict',
  \ 'pyunit'     : $HOME . '/.vim/dict/python.dict,' . $HOME . '/.vim/dict/pyunit.dict',
  \ }

" xUnit filetype dict
" g:neocomplcache_dictionary_filetype_listsに辞書を複数していするか、
" g:neocomplcache_same_filetype_listsで相互互換指定する必要がある。
"let g:neocomplcache_same_filetype_lists = {
  "\ 'phpunit' : 'php',
  "\ }

" 補完を選択後popupを閉じる
imap <expr><C-y> neocomplcache#close_popup()
imap <C-s> <Plug>(neocomplcache_start_unite_snippet)
imap <C-u> <Plug>(neocomplcache_start_unite_complete)
" }}}
" ## neocomplcache_snippet_complete {{{
nmap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
imap <silent> <C-s> <Plug>(neocomplcache_start_unite_complete)

" 一時的
nnoremap <Leader>ns :<C-u>NeoComplCacheEditSnippets<Cr>
" }}}
" ## unite.vim {{{
let g:unite_data_directory = $HOME . '/tmp/vim/unite'

let g:unite_winheight = 12
let g:unite_source_file_mru_limit = 120
let g:unite_update_time = 150
" For optimize.
let g:unite_source_file_mru_filename_format = ''
"let g:unite_update_time = 1000
" ignore match patterns (Default: autoload/unite/source/file.vim)
let g:unite_source_file_ignore_pattern = '^\%(/\|\a\+:/\)$\|\%(^\|/\)\.\.\?$\|\~$\|\.\%(o|exe|dll|bak|sw[po]\|vimundo\)$'
let g:unite_source_file_mru_ignore_pattern = '\~$\|\.\%(o\|exe\|dll\|bak\|sw[po]\|vimundo\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)\|^\%(\\\\\|/mnt/\|/media/\|/Volumes/\)'
let g:unite_source_directory_mru_ignore_pattern = '\%(^\|/\)\.\%(hg\|git\|bzr\|svn\|vimundo\)\%($\|/\)\|^\%(\\\\\|/mnt/\|/media/\|/Volumes/\)'
let g:unite_source_file_rec_ignore_pattern = '\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|bak\|sw[po]\|vimundo\)$\|\%(^\|/\)\.\%(hg\|git\|bzr\|svn\)\%($\|/\)'

call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^\\', '~/*')
call unite#set_substitute_pattern('file', '^;v', '~/.vim/*')
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/*"')
call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)

nnoremap U :<C-u>Unite<Space>
nnoremap <C-p> :<C-u>Unite file_mru<Cr>
nnoremap <C-n> :<C-u>Unite buffer_tab -start-insert<Cr>
nnoremap <C-b> :<C-u>UniteBookmarkAdd<Space>
" }}}
" ## unite-tag {{{
"nnoremap <silent> <C-]> :<C-u>Unite -immediately -no-start-insert tags:<C-r>=expand('<cword>')<Cr><Cr>
autocmd BufEnter *
      \   if empty(&buftype)
      \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<Cr>
      \|  endif
" }}}
" ## unite-sf2 {{{
let g:unite_source_sf2_bundles = {
    \ 'EloquentBoxbarHelloBundle'  : 'Eloquent/Boxbar/HelloBundle',
    \ 'EloquentBoxbarUserBundle'   : 'Eloquent/Boxbar/UserBundle',
    \ 'EloquentBoxbarCompanyBundle': 'Eloquent/Boxbar/CompanyBundle',
    \ }
" }}}
" ## vim-ref & ref-unite {{{
" TODO: Pydocも日本語の使えるようにしなくては
nnoremap <F2> :<C-u>Ref<Space>
if exists('g:dependency_local_lists["ref_phpmanual_path"]')
  let g:ref_phpmanual_path = g:dependency_local_lists['ref_phpmanual_path']
else
  let g:ref_phpmanual_cmd = 'w3m -dump %s'
endif
if exists('g:dependency_local_lists["ref_jquery_path"]')
  let g:ref_jquery_path = g:dependency_local_lists['ref_jquery_path']
else
  let g:ref_jquery_cmd = 'w3m -dump %s'
endif
if has('mac')
  let g:ref_alc_cmd = 'lynx -dump -display_charset=' . &encoding . ' -nonumbers %s'
endif
" }}}
" ## TwitVim {{{
if has('python') && !has('gui_macvim')
  let twitvim_enable_python = 1
endif
if has('ruby') && !has('mac')
  " MacVim with ruby, unknown crash.
  let twitvim_enable_ruby = 1
endif
if has('mac')
  let twitvim_browser_cmd = 'open -a firefox'
"elseif has('win32')
  "let twitvim_browser_cmd = 'firefox'
else
  let twitvim_browser_cmd = 'firefox'
endif
nnoremap <silent><F8> :<C-u>RefreshTwitter<Cr>
" }}}
" ## QuickRun, Quicklaunch & xUnit {{{
nnoremap <silent> <Leader>r :<C-u>QuickRun -runner vimproc:90 -split 'rightbelow 50vsp'<Cr>
if has('clientserver')
"if has('clientserver') && !empty(v:servername)
  let b:quickrun_config = {
  \   'runner/vimproc' : 90,
  \   'runner/vimproc/updatetime' : 90,
  \ }
  let g:quickrun_config = {
  \   '_' : {
  \     'runner/vimproc' : 90,
  \     'runner/vimproc/updatetime' : 90,
  \     'outputter' : 'buffer',
  \     'splist' : '{"rigitbelow 50vsp"}',
  \   },
  \   'run/vimproc' : {
  \     'exec' : '%s:p:r %a',
  \     'runner' : 'vimproc',
  \     'outputter' : 'buffer',
  \   },
  \   'ruby.rspec' : {
  \     'command' : "spec -l {line('.')",
  \   },
  \   'php.phpunit' : {
  \     'command' : 'phpunit',
  \   },
  \ }
endif
if has('mac')
  let g:quickrun_config['php.phpunit'] = {
  \   'command' : '/usr/local/Cellar/php/5.3.8/bin/phpunit',
  \ }
  " TODO: Sikuli 起動は引数渡さねば??
  "let g:quickrun_config['python.sikuli'] = {
  "\     'command' : '/Applications/Sikuli-IDE.app/sikuli-ide.sh',
  "\   }
elseif has('win32')
else  " Linux
  let g:quickrun_config['php.phpunit'] = { 'command' : 'phpunit' }
endif
" TODO: Add QuickRun's syntax for xUnit
"autocmd BufAdd,BufNew,BufNewFile,BufRead [quickrun output] set syntax=xUnit
" }}}
" ## vim-textmanip {{{
" It's moved selected test-object.
" TODO: snippet's imap dependency check.
xmap <C-j> <Plug>(Textmanip.move_selection_down)
xmap <C-k> <Plug>(Textmanip.move_selection_up)
xmap <C-h> <Plug>(Textmanip.move_selection_left)
xmap <C-l> <Plug>(Textmanip.move_selection_right)

" copy selected text-object.
vmap <M-d> <Plug>(Textmanip.duplicate_selection_v)
"}}}
" ## zencoding{{{
let g:user_zen_expandabbr_key = '<C-z>'
let g:user_zen_settings = {
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
      \ }
"}}}
" ## vim-fugitive {{{
" Gstatus
"    * Gstatus上の変更のあったファイルにカーソルを合わせた状態で
"        Dで:Gdiff起動(差分表示)
"        -でstageとunstageの切り替え
"        pでパッチを表示
"        Enterでファイル表示
"    :Gstatusの画面上で
"        Cでcommit
"    * help ：Gstatus
nnoremap <Leader>gb :<C-u>Gblame<Cr>
nnoremap <Leader>gd :<C-u>Gdiff<Cr>
nnoremap <Leader>gs :<C-u>Gstatus<Cr>
nnoremap <Leader>ga :<C-u>Gwrite<Cr>
nnoremap <Leader>gA :<C-u>Gwrite <cfile><Cr>
nnoremap <Leader>gc :<C-u>Gcommit<Cr>
"}}}
" ## vim-ambicmd {{{
" FIXME: <Space>打つと何故かバックスラッシュ入る
"cnoremap <expr> <Space> ambicmd#expand('\<Space>')
" }}}
" ## toggle.vim {{{
"let g:toggle_pairs = {
      "\ 'extends' : 'implements',
      "\ 'implements' : 'extends',
        "\   '@assert'            : '@depends',
        "\   '@depends'           : '@dataProvider',
        "\   '@dataProvider'      : '@expectedException',
        "\   '@expectedException' : '@group',
        "\   '@group'             : '@test',
        "\   '@test'              : '@assert',
      "\ }
"augroup xUnitToggle  "{{{2
  "au! BufRead,BufNewFile,BufWinEnter *Test.*
        "\ let g:toggle_pairs = {
        "\   'assertArrayHasKey'    : 'assertArrayNotHasKey',
        "\   'assertArrayNotHasKey' : 'assertArrayHasKey',
        "\   'assertClassHasAttribute'    : 'assertClassNotHasAttribute',
        "\   'assertClassNotHasAttribute' : 'assertClassHasAttribute',
        "\   'assertClassHasStaticAttribute'    : 'assertClassNotHasStaticAttribute',
        "\   'assertClassNotHasStaticAttribute' : 'assertClassHasStaticAttribute',
        "\   'assertContains'    : 'assertNotContains',
        "\   'assertNotContains' : 'assertContains',
        "\   'assertAttributeContains'    : 'assertAttributeNotContains',
        "\   'assertAttributeNotContains' : 'assertAttributeContains',
        "\   'assertContainsOnly'    : 'assertNotContainsOnly',
        "\   'assertNotContainsOnly' : 'assertContainsOnly',
        "\   'assertAttributeContainsOnly'    : 'assertAttributeNotContainsOnly',
        "\   'assertAttributeNotContainsOnly' : 'assertAttributeContainsOnly',
        "\   'assertEmpty'    : 'assertNotEmpty',
        "\   'assertNotEmpty' : 'assertEmpty',
        "\   'assertAttributeEmpty'    : 'assertAttributeNotEmpty',
        "\   'assertAttributeNotEmpty' : 'assertAttributeEmpty',
        "\   'assertEquals'    : 'assertNotEquals',
        "\   'assertNotEquals' : 'assertEquals',
        "\   'assertAttributeEquals'    : 'assertAttributeNotEquals',
        "\   'assertAttributeNotEquals' : 'assertAttributeEquals',
        "\   'assertFileEquals'    : 'assertFileNotEquals',
        "\   'assertFileNotEquals' : 'assertFileEquals',
        "\   'assertFileExists'    : 'assertFileNotExists',
        "\   'assertFileNotExists' : 'assertFileExists',
        "\   'assertInstanceOf'    : 'assertNotInstanceOf',
        "\   'assertNotInstanceOf' : 'assertInstanceOf',
        "\   'assertAttributeInstanceOf'    : 'assertAttributeNotInstanceOf',
        "\   'assertAttributeNotInstanceOf' : 'assertAttributeInstanceOf',
        "\   'assertInternalType'    : 'assertNotInternalType',
        "\   'assertNotInternalType' : 'assertInternalType',
        "\   'assertAttributeInternalType'    : 'assertAttributeNotInternalType',
        "\   'assertAttributeNotInternalType' : 'assertAttributeInternalType',
        "\   'assertNull'    : 'assertNotNull',
        "\   'assertNotNull' : 'assertNull',
        "\   'assertObjectHasAttribute'    : 'assertObjectNotHasAttribute',
        "\   'assertObjectNotHasAttribute' : 'assertObjectHasAttribute',
        "\   'assertRegExp'    : 'assertNotRegExp',
        "\   'assertNotRegExp' : 'assertRegExp',
        "\   'assertStringMatchesFormat'    : 'assertStringNotMatchesFormat',
        "\   'assertStringNotMatchesFormat' : 'assertStringMatchesFormat',
        "\   'assertStringMatchesFormatFile'    : 'assertStringNotMatchesFormatFile',
        "\   'assertStringNotMatchesFormatFile' : 'assertStringMatchesFormatFile',
        "\   'assertSame'    : 'assertNotSame',
        "\   'assertNotSame' : 'assertSame',
        "\   'assertAttributeSame'    : 'assertAttributeNotSame',
        "\   'assertAttributeNotSame' : 'assertAttributeSame',
        "\   'assertStringEndsWith'    : 'assertStringEndsNotWith',
        "\   'assertStringEndsNotWith' : 'assertStringEndsWith',
        "\   'assertStringEqualsFile'    : 'assertStringNotEqualsFile',
        "\   'assertStringNotEqualsFile' : 'assertStringEqualsFile',
        "\   'assertStringStartsWith'    : 'assertStringStartsNotWith',
        "\   'assertStringStartsNotWith' : 'assertStringStartsWith',
        "\   'assertTag'    : 'assertNotTag',
        "\   'assertNotTag' : 'assertTag',
        "\   'assertAttributeType'    : 'assertAttributeNotType',
        "\   'assertAttributeNotType' : 'assertAttributeType',
        "\   'assertXmlFileEqualsXmlFile'    : 'assertXmlFileNotEqualsXmlFile',
        "\   'assertXmlFileNotEqualsXmlFile' : 'assertXmlFileEqualsXmlFile',
        "\   'assertXmlStringEqualsXmlFile'    : 'assertXmlStringNotEqualsXmlFile',
        "\   'assertXmlStringNotEqualsXmlFile' : 'assertXmlStringEqualsXmlFile',
        "\   'assertXmlStringEqualsXmlString'    : 'assertXmlStringNotEqualsXmlString',
        "\   'assertXmlStringNotEqualsXmlString' : 'assertXmlStringEqualsXmlString',
        "\ }
  " Not into removed PHPUnit 3.6 functions. (ex. asertType, assertNotType)
"augroup END "}}}
" }}}
" ## vim-sunday {{{
let g:sunday_pairs = [
  \ ['extends', 'implements'],
  \ ['assert', 'depends', 'dataProvider', 'expectedException', 'group', 'test'],
  \ ]
" }}}
" ## calendar.vim {{{
let g:calendar_wruler = '日 月 火 水 木 金 土 '
let g:calendar_weeknm = 1 " WK01
" }}}
" ## dbext.vim {{{
let g:dbext_default_history_file = $HOME . '/tmp/vim/dbext_sql_history.sql'
" }}}
" ## submode.vim (Reside Window) {{{
function! s:resizeWindow()
  call submode#enter_with('winsize', 'n', '', 'mws', '<Nop>')
  call submode#leave_with('winsize', 'n', '', '<Esc>')

  let curwin = winnr()
  wincmd j | let target1 = winnr() | exe curwin "wincmd w"
  wincmd l | let target2 = winnr() | exe curwin "wincmd w"


  execute printf("call submode#map ('winsize', 'n', 'r', 'j', '<C-w>%s')", curwin == target1 ? "-" : "+")
  execute printf("call submode#map ('winsize', 'n', 'r', 'k', '<C-w>%s')", curwin == target1 ? "+" : "-")
  execute printf("call submode#map ('winsize', 'n', 'r', 'h', '<C-w>%s')", curwin == target2 ? ">" : "<")
  execute printf("call submode#map ('winsize', 'n', 'r', 'l', '<C-w>%s')", curwin == target2 ? "<" : ">")
endfunction

nmap <C-w>R ;<C-u>call <SID>resizeWindow()<CR>mws
" }}}
" # <Leader> Mappings For Plugins {{{
" change just before buffer
nnoremap <silent> <Leader>a :<C-u>b#<Cr>
" open-browser.vim
nmap <Leader>o <Plug>(openbrowser-smart-search)
" vimshell
nnoremap <silent> <Leader>vs :<C-u>VimShell<Cr>
nnoremap <silent> <Leader>vS :<C-u>VimShellPop<Cr>
" vimfiler
nnoremap <Silent> <Leader>vf :<C-u>VimFilerSplit<Cr>
nnoremap <Silent> <Leader>vF :<C-u>VimFiler<Cr>
" unite-sources
nnoremap <silent> <Leader>uF :<C-u>Unite file_rec -start-insert<Cr>
nnoremap <silent> <Leader>uf :<C-u>Unite file -start-insert<Cr>
nnoremap <silent> <Leader>um :<C-u>Unite mark<Cr>
nnoremap <silent> <Leader>uM :<C-u>Unite mapping<Cr>
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark -default-action=cd<Cr>
nnoremap <silent> <Leader>uB :<C-u>Unite buffer<Cr>
nnoremap <silent> <Leader>uu :<C-u>Unite resume source -start-insert<Cr>
nnoremap <silent> <Leader>uo :<C-u>Unite outline<Cr>
nnoremap <silent> <Leader>ug :<C-u>Unite grep:%:-iHRn<Cr>
nnoremap <silent> <Leader>ul :<C-u>Unite line<Cr>
nnoremap <silent> <Leader>uc :<C-u>Unite colorscheme<Cr>
nnoremap <silent> <Leader>uh :<C-u>Unite history/command -start-insert<Cr>
nnoremap <silent> <Leader>us :<C-u>Unite snippet<Cr>
nnoremap <silent> <Leader>un :<C-u>Unite neobundle/install:!<Cr>
nnoremap <silent> <Leader>uN :<C-u>Unite neobundle/install<Cr>
" NOTE: @ftplugin, <Leader>r is :Unite ref/$filetype
"       if @ftplugin is nothing, default map is :Unite ref/
nnoremap <Leader>ur :<C-u>Unite<Space>ref/

nnoremap <Leader>S :<C-u>Unite<Space>sf2/
nnoremap <Leader>sb :<C-u>Unite sf2/bundles<Cr>
nnoremap <Leader>sc :<C-u>Unite sf2/app/config<Cr>
" }}}


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
