" vim: set fletype=vim fdm=marker ts=2 sw=2 sts=0 expandtab:

" # runtimepath {{{
if has('vim_starting')
  " INFO: .vimrc unifies vimrc
  "       .vim   unifies vimfiles
  set runtimepath^=$HOME/.vim
  set runtimepath+=$HOME/.vim/after
endif
"set shell=/opt/homebrew/bin/zsh
"let $PATH = join([
"      \ '/opt/homebrew/bin',
"      \ '/opt/homebrew/sbin',
"      \ $GOPATH . '/bin',
"      \ $HOME . '/.anyenv/envs/goenv/shims',
"      \ $HOME . '/.anyenv/envs/pyenv/shims',
"      \ $HOME . '/.anyenv/envs/nodenv/shims',
"      \ $HOME . '/.anyenv/envs/tfenv/bin',
"      \ $PATH,
"      \ ], ':')
" }}}
" # Basic "{{{
"filetype plugin indent on
set nocompatible               " Use Vim defaults (much better!)
set showcmd                    " Highliting bracket set.
set hidden                     " Enable open new file, when while editing other file.
set autoread                   " When a file has been detected to have been changed outside
set history=511
set viminfo='20,\"150          " Read/write a .viminfo file, don't store more than 50 lines of registers
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set fixendofline               " Written <EOL> when saved
set virtualedit+=block         " Block-select to the end of the line for blockwise Visual mode.
set shortmess+=filmnrxoOtT     " Avoid all the hit-enter prompts
set title
set emoji
set completeopt=menuone        " A comma separated list of options
set scrolloff=10               " Typewriter mode = keep current line in the center
set formatoptions+=mM          " This is a sequence of letters
set visualbell t_vb=           " no bell
set splitright                 " Default vsplit, left
set splitbelow                 " Default split, top
set noequalalways              " Minimize Window Size

" Like nmap 'D' and 'C'
nnoremap Y y$
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

" Quick start my vimrc
let $MYVIMRC = resolve(expand($MYVIMRC))
nnoremap <silent> e. :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> eS :<C-u>source $MYVIMRC<CR>
let $MYVIMRC_LOCAL = $HOME . (has('nvim') ? '/.config/nvim/init.local.vim' : '/.vimrc.local')
if filereadable(expand($MYVIMRC_LOCAL))
  " INFO: Read more .vimrc.local.dist
  source $MYVIMRC_LOCAL
endif
" }}}

" # dein {{{
if &compatible
  set nocompatible
endif

let s:dein_dir = s:cache_home . (has('nvim') ? '/nvim/dein' : '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " TextOperation:
  call dein#add('nishigori/increment-activator')

  " Utility:
  call dein#add('tyru/open-browser.vim')
  call dein#add('tyru/urilib.vim')
  call dein#add('LeafCage/yankround.vim')

  " Treesitter:
  if has('nvim')
    call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
  endif

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" Install if declared plugins is not installed
if dein#check_install()
  call dein#install()
endif
" }}}

" # Syntax {{{
set synmaxcol=2000
set nospell
set list
" - tab: タブ文字, trail: 行末スペース, eol: 改行文字, extends: 行末短縮, precedes: 行頭短縮, nbsp: 空白文字
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
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
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

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
" # Status Bar {{{
set ruler
set showcmd
set showmode
set cmdheight=2
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

" Search cursor words
nnoremap * *N
vmap * <Plug>(visualstar-*)N

if executable("rg")
  let &grepprg = 'rg --vimgrep --hidden > /dev/null'
  set grepformat=%f:%l:%c:%m
endif
" }}}
" # Copy & Paste {{{
"set paste " When you're setting paste, can't use inoremap extend ;-<
if has('nvim')
  set clipboard=unnamed
else
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
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
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
vnoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
vnoremap <C-n> <Down>
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
" # Fold, View {{{
nnoremap <Leader>f za
" Don't save options.
set viewoptions-=options
" }}}
" # Dictionary {{{
set dictionary=$HOME/.vim/dict/default.dict
" }}}

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
nnoremap <silent> <D-t><D-t> :<C-u>edit $HOME/TODO.rst<CR>
nnoremap <silent> <M-t><M-t> :<C-u>edit $HOME/TODO.rst<CR>
" }}}
" Plugin: vim-rooter {{{
let g:rooter_manual_only = 1
let g:rooter_resolve_links = 1
let g:rooter_cd_cmd = 'lcd'
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git/', '.hg/']

command! GH execute ":lcd " . FindRootDirectory()
nnoremap <silent> gh :<C-u>GH<CR> :<C-u>pwd<CR>
" }}}
" Plugin: vim-markdown {{{
"let g:vim_markdown_folding_level = 2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_no_extensions_in_markdown = 1
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
" My Plugin: vim-multiple-switcher {{{
"let g:multiple_switcher_no_default_key_maps = 1
nnoremap <silent> ,p :<C-u>call multiple_switcher#switch('paste')<CR>
nnoremap <silent> ,e :<C-u>call multiple_switcher#switch('expandtab')<CR>
nnoremap <silent> ,w :<C-u>call multiple_switcher#switch('wrap')<CR>
vnoremap <silent> ,n :<C-u>call multiple_switcher#switch('number')<CR>
" }}}

" # <Leader> Mappings "{{{
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

" Hook loaded vimrc
if exists("*LoadedHookVIMRC")
  call LoadedHookVIMRC()
endif

