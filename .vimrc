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
if has('vim_starting')
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
set nofixendofline
set virtualedit+=block         " Block-select to the end of the line for blockwise Visual mode.
set shortmess+=filmnrxoOtT     " Avoid all the hit-enter prompts
set title
set completeopt=menuone        " A comma separated list of options
set scrolloff=10               " Typewriter mode = keep current line in the center
set formatoptions+=mM          " This is a sequence of letters
set visualbell t_vb=           " no bell
if !exists('g:vscode')
  set ambiwidth=double
endif

let mapleader = " "

" Like nmap 'D' and 'C'
nnoremap Y y$

" TODO: いる？
if has('nvim')
  let g:python_host_prog='/opt/homebrew/bin/python3'
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
let MYVIM_FEATURES_TINY = 0 | lockvar MYVIM_FEATURES_TINY
let MYVIM_FEATURES_HUGE = 1 | lockvar MYVIM_FEATURES_HUGE
let g:myvim_features = get(g:, 'myvim_features', 0)

" Quick start my vimrc
nnoremap <silent> e. :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> eS :<C-u>source $MYVIMRC<CR>
let $MYVIMRC_LOCAL = $HOME . (has('nvim') ? '/.config/nvim/init.local.vim' : '/.vimrc.local')
if filereadable(expand($MYVIMRC_LOCAL))
  " INFO: Read more .vimrc.local.dist
  source $MYVIMRC_LOCAL
endif
" }}}

" # dein {{{
let s:dein_dir = s:cache_home . (has('nvim') ? '/nvim/dein' : '/dein')

if MYVIM_FEATURES_HUGE >= g:myvim_features
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
    call dein#add('NLKNguyen/papercolor-theme', { 'merged': 0 })
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
set synmaxcol=2000
set nospell
set list
" - tab: タブ文字, trail: 行末スペース, eol: 改行文字, extends: 行末短縮, precedes: 行頭短縮, nbsp: 空白文字
if !exists('g:vscode')
  set listchars=tab:»-,extends:>,precedes:<,eol:↲,nbsp:%,trail:-,nbsp:>
endif
set relativenumber
set number
set numberwidth=4
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
" }}}
" # Color Scheme {{{
set t_Co=256
if has("termguicolors")
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  colorscheme tender
endif

" Add cursorline at the current window.
augroup cch
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" highlighting target of long line.
if exists('&colorcolumn')
  set colorcolumn=+1
  "nnoremap <silent> <Leader>l :<C-u>set<Space>spell!<Space>list!<Space>colorcolumn=-1<CR>
  nnoremap <silent> <Leader>l :<C-u>set<Space>list!<Space>colorcolumn=-1<CR>
endif

" }}}
" # Alt Key {{{
" By Sir.thinca http://d.hatena.ne.jp/thinca/20101215/1292340358
if has('unix') && !has('gui_running')
  " TODO: もう必要ない？
  " Use meta keys in console.
  "function! s:use_meta_keys()  " {{{2
  "  for i in map(
  "    \   range(char2nr('a'), char2nr('z'))
  "    \ + range(char2nr('A'), char2nr('Z'))
  "    \ + range(char2nr('0'), char2nr('9'))
  "    \ , 'nr2char(v:val)')
  "    " <ESC>O do not map because used by arrow keys.
  "    if i != 'O'
  "      execute 'nmap <ESC>' . i '<M-' . i . '>'
  "    endif
  "  endfor
  "endfunction  " }}}2

  "call s:use_meta_keys()
  "map <NUL> <C-Space>
  "map! <NUL> <C-Space>
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
" }}}
" # Copy & Paste {{{
"set paste " When you're setting paste, can't use inoremap extend ;-<
if !has('nvim')
  set clipboard=unnamed,autoselect
endif
if has('clipboard')
  " For Ubuntu "+y not * (;h clipboard)
  vnoremap <C-c> "+y
  " Paste
  vnoremap <C-v> d"+P
  cnoremap <C-v> <C-R>+
  inoremap <C-v> <ESC>"+pa
endif
" }}}
" # Insert {{{
inoremap \| \|\|<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
inoremap \|\| \|
inoremap "" "
inoremap '' '
inoremap `` `
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>

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
" }}}
" # IME Control {{{
" <ESC> insert mode, IME off
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <C-@> <ESC>:set iminsert=0<CR>
inoremap <silent> <C-]> <ESC>:set iminsert=0<CR>
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
augroup InsModeAu
  autocmd!
  autocmd InsertEnter,CmdwinEnter * set noimdisable
  autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END
" }}}
" # Moving Cursole {{{
augroup MovementPreviousSaveLine
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$")
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

" .bash like
" but up-down mapped j-k
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
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
" }}}
" # Window {{{
" FIXME: When setted winmin(height|width), errored unite-outline
"set winminheight=8
"set winminwidth=20
"set winfixheight
"set winfixwidth
set splitright    " Default vsplit, left
set splitbelow    " Default split, top
set noequalalways " Minimize Window Size
" }}}
" # Buffer {{{
" Inspaired @taku-o's Kwdb.vim
com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn
nnoremap <silent> <Leader>d :<C-u>:Kwbd<CR>
" }}}
" # Fold, View {{{
nnoremap <Leader>f za
if !has('nvim')
  set foldcolumn=4
  " INFO: foldlevel moved to each fplugin
  "set foldlevel=0
  set fillchars+=fold:-
endif
" Don't save options.
set viewoptions-=options
" }}}
" # Directory {{{
set autochdir
augroup AutoChDir
  autocmd!
  au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
augroup END
" Change directory. vim-users.jp Hack #69
nnoremap <silent> cd :<C-u>CD<CR>
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
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
" # Spell {{{
" @see https://github.com/vim-jp/vimdoc-ja/blob/master/doc/spell.jax
"set spell
"set spelllang=en,cjk
"if empty('&spellfile')
  "set spellfile="$HOME/.vim/spell/en.utf-8.add"
"endif
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
" # NeoVim loading key {{{
if has('nvim')
  source ~/.gvimrc
endif
" }}}

" Plugins
if MYVIM_FEATURES_HUGE >= g:myvim_features
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
  call add(g:increment_activator_filetype_candidates['_'], ['standard', 'io1', 'io2', 'gp2', 'gp3'])
  let g:increment_activator_filetype_candidates['php'] = [
    \   ['private', 'protected', 'public'],
    \   ['extends', 'implements'],
    \   ['assert', 'depends', 'dataProvider', 'expectedException', 'group', 'test'],
    \ ]
  let g:increment_activator_filetype_candidates['vim'] = [
    \   ['nnoremap', 'xnoremap', 'inoremap', 'vnoremap', 'cnoremap', 'onoremap'],
    \   ['nmap', 'xmap', 'imap', 'vmap', 'cmap', 'omap'],
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
  endif

  nnoremap : :<C-u>VimFilerExplorer -buffer-name=explorer
    \ -split -direction=topleft -simple -winwidth=35 -project -auto-cd -no-quit -find<CR>

  call vimfiler#custom#profile('default', 'context', {
    \ 'safe' : 0,
    \ 'edit_action': 'open',
    \ 'sort_type': 'filename',
    \ })

  nnoremap <Leader>vf :<C-u>VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
  " }}}
  " Plugin: neomru {{{
  let g:neomru#file_mru_limit = 1024
  let g:neomru#filename_format = ':p:~'
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
  if executable('rg')
    let g:unite_source_grep_command = '5g'
    let g:unite_source_grep_default_opts = '--color never'
    let g:unite_source_rec_async_command =
      \ ['ag', '--color never']
  endif
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

  nnoremap <silent> [unite]B :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]C :<C-u>Unite colorscheme -auto-preview -split -winheight=10 -start-insert<CR>
  nnoremap <silent> [unite]G :<C-u>Unite grep:$:-iR:<CR>
  "nnoremap <silent> [unite]N :<C-u>Unite
  nnoremap <silent> [unite]T :<C-u>Unite -buffer-name=search line
    \ -wrap -winheight=10 -no-quit<CR>todo\\|fixme\\|warn\\|hackme<ESC>
  nnoremap <silent> [unite]W :<C-u>Unite workspace_rec -buffer-name=bookmark file -input=!vendor <CR>

  " }}}
  " Plugin: vim-markdown {{{
  "let g:vim_markdown_folding_level = 2
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_no_extensions_in_markdown = 1
  " }}}
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
    \ ])
  " }}}
  " Plugin: PreserveNoEOL {{{
  "setlocal noeol | let b:PreserveNoEOL = 1
  let b:PreserveNoEOL = 1
  let g:PreserveNoEOL = 1
  " }}}
  " Plugin: lightline.vim {{{
  if !exists('g:vscode')
    let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'active': {
      \   'left': [ ['mode', 'paste'], ['fugitive', 'git_relative_dir'], ['ctrlpmark'] ],
      \   'right': [ ['syntastic', 'lineinfo'], ['fileformat', 'fileencoding', 'filetype'], ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'git_relative_dir': 'MyGitFileName',
      \   'mode': 'LightlineMode',
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

    function! MyGitFileName()
      " x/x/x/dotfiles
      let git_worktree = finddir('.git/..', expand('%:p:h').';')
      if empty(git_worktree) || winwidth(0) < 120
        return MyFilename()
      endif

      " Hidden parent dir of git-root
      return substitute(expand('%:p'), fnamemodify(git_worktree, ':p:h:h') . '/', '', '')
    endfunction

    function! MyFilename()
      let fname = expand('%:t')
      return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyModified()
      return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyFugitive()
      try
        if exists('*fugitive#head') && expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler'
          let _ = fugitive#head()
          return strlen(_) ? '⭠ ' . _ : ''
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

    function! LightlineMode()
      return expand('%:t') =~# '^__Tagbar__' ? 'Tagbar':
        \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
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
  endif
  " }}}
  " Plugin: alpaca_powertabline {{{
  if !exists('g:vscode')
    let g:alpaca_powertabline_enable = 1
  endif
  " }}}
  " Plugin: accelerated-smooth-scroll {{{
  let g:ac_smooth_scroll_du_sleep_time_msec = 1
  let g:ac_smooth_scroll_fb_sleep_time_msec = 1
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
  " Plugin: vim-textmanip {{{
  let g:textmanip_enable_mappings = get(g:, 'textmanip_enable_mappings', 0)
  xmap <C-j> <Plug>(Textmanip.move_selection_down)
  xmap <C-k> <Plug>(Textmanip.move_selection_up)
  xmap <C-h> <Plug>(Textmanip.move_selection_left)
  xmap <C-l> <Plug>(Textmanip.move_selection_right)
  " copy selected text-object.
  vmap <M-d> <Plug>(Textmanip.duplicate_selection_v)
  "}}}
  " Plugin: visualstar.vim {{{
  " search extended plugin.
  map * <Plug>(visualstar-*)N
  map # <Plug>(visualstar-#)N
  " }}}
  " Plugin: vim-lsp around {{{
  if empty(globpath(&rtp, 'autoload/lsp.vim'))
    finish
  endif

  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
  endfunction

  augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END
  command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

  let g:lsp_diagnostics_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 0
  let g:asyncomplete_popup_delay = 200
  let g:lsp_text_edit_enabled = 1
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
  " My Plugin: vim-multiple-switcher {{{
  "let g:multiple_switcher_no_default_key_maps = 1
  nnoremap <silent> ,p :<C-u>call multiple_switcher#switch('paste')<CR>
  nnoremap <silent> ,e :<C-u>call multiple_switcher#switch('expandtab')<CR>
  nnoremap <silent> ,w :<C-u>call multiple_switcher#switch('wrap')<CR>
  vnoremap <silent> ,n :<C-u>call multiple_switcher#switch('number')<CR>
  " }}}

  " # <Leader> Mappings "{{{
  nnoremap <silent><Leader><Leader> f<Space>
  nnoremap <silent> <Leader>s :<C-u>terminal<CR>
  " change just before buffer
  nnoremap <silent> <Leader>a :<C-u>b#<CR>
  nnoremap <silent> ,b :<C-u>b#<CR>
  " open-browser.vim
  nmap <Leader>o <Plug>(openbrowser-smart-search)
  " Quickhl
  nmap <silent> <Leader>m <Plug>(quickhl-toggle)
  xmap <silent> <Leader>m <Plug>(quickhl-toggle)
  nmap <silent> <Leader>M <Plug>(quickhl-reset)
  xmap <silent> <Leader>M <Plug>(quickhl-reset)
  nmap <silent> <Leader>j <Plug>(quickhl-match)
  " }}}

  " # <cmd> (<D-) Mappings "{{{

  nnoremap <D-1> :<C-u>VimFilerExplorer -buffer-name=explorer
    \ -split -direction=topleft -simple -winwidth=35 -toggle -project -auto-cd -no-quit -find<CR>
  autocmd FileType vimfiler nmap <buffer> <ESC> <Plug>(vimfiler_switch_to_other_window)
  autocmd FileType vimfiler nmap <buffer> <D-1> <Plug>(vimfiler_close)
  autocmd FileType vimfiler nmap <buffer> <D-r> <Plug>(vimfiler_rename_file)

  " }}}
endif

" Hook loaded vimrc
if exists("*LoadedHookVIMRC")
  call LoadedHookVIMRC()
endif
