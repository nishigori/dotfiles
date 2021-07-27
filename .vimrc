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
if has('gui_macvim')
  set shell=/opt/homebrew/bin/zsh
  let $GOPATH = '/Users/tak/go/1.16.6'
  let $PATH = join([
        \ '/opt/homebrew/bin',
        \ '/opt/homebrew/sbin',
        \ $GOPATH . '/bin',
        \ $HOME . '/.anyenv/envs/goenv/shims',
        \ $HOME . '/.anyenv/envs/pyenv/shims',
        \ $HOME . '/.anyenv/envs/nodenv/shims',
        \ $HOME . '/.anyenv/envs/tfenv/bin',
        \ $PATH,
        \ ], ':')
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
if !exists('g:vscode')
  set ambiwidth=double
endif
set splitright                 " Default vsplit, left
set splitbelow                 " Default split, top
set noequalalways              " Minimize Window Size

let mapleader = " "

" Like nmap 'D' and 'C'
nnoremap Y y$
" }}}
" # Font "{{{
if has('nvim')
  set guifont=Hack\ Nerd\ Font:h14,\ Ricty\ Discord\ for\ Powerline:h14,\ Ricty:h14,\ Monaco:h14
  set printfont=Hack\ Nerd\ Font:h14,\ Ricty\ Discord\ for\ Powerline:h14,\ Ricty:h14,\ Monaco:h14
else
  set printfont=Hack\ Nerd\ Font:h14,\ Ricty\ Discord\ for\ Powerline:h14,\ Ricty:h14,\ Monaco:h14
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
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('vim-scripts/smartchr')
  call dein#add('itchyny/vim-cursorword')
  call dein#add('thinca/vim-zenspace')
  call dein#add('vim-scripts/matchit.zip')
  call dein#add('mattn/webapi-vim')
  call dein#add('nishigori/increment-activator')
  call dein#add('haya14busa/incsearch.vim')

  " Utility:
  call dein#add('nishigori/vim-multiple-switcher')
  call dein#add('tyru/open-browser.vim')
  call dein#add('tyru/urilib.vim')
  call dein#add('itchyny/vim-parenmatch')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('LeafCage/yankround.vim')
  call dein#add('airblade/vim-rooter')

  " FileType:
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('elzr/vim-json', { 'lazy': 1, 'on_ft': 'json' })
  call dein#add('cespare/vim-toml', { 'lazy': 1, 'on_ft': 'toml' })
  call dein#add('godlygeek/tabular', { 'lazy': 1, 'on_ft': 'markdown' })
  call dein#add('plasticboy/vim-markdown', { 'depends': 'tabular', 'lazy': 1, 'on_ft': 'markdown' })
  call dein#add('jtriley/vim-rst-headings', { 'lazy': 1, 'on_ft': [['python', 'rst', 'rest']] })
  call dein#add('ekalinin/Dockerfile.vim', { 'lazy': 1, 'on_ft': [['docker', 'Dockerfile']] })
  call dein#add('puppetlabs/puppet-syntax-vim', { 'lazy': 1, 'on_ft': 'puppet' })
  call dein#add('rdolgushin/groovy.vim', { 'lazy': 1, 'on_ft': 'groovy' })
  call dein#add('hashivim/vim-terraform', { 'lazy': 1, 'on_ft': [['tf', 'tfvars', 'terraform']] })
  call dein#add('rust-lang/rust.vim', { 'lazy': 1, 'on_ft': [['rs', 'rlib']] })

  " ColorSchemes:
  "call dein#add('jacoborus/tender.vim', { 'merged': 0 })
  "call dein#source('tender.vim')
  call dein#add('cocopon/iceberg.vim', { 'merged': 0 })
  call dein#source('iceberg.vim')
  call dein#add('lifepillar/vim-solarized8')
  colorscheme solarized8_high
  autocmd vimenter * ++nested colorscheme solarized8_high

  " Treesitter:
  if has('nvim')
    call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
  endif

  " Fzf:
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  "call dein#add('junegunn/fzf.vim')
  call dein#add('yuki-yano/fzf-preview.vim', { 'rev': 'release/rpc' })
  " TODO: いつかnvim onlyになったら入れ替える https://github.com/nvim-telescope/telescope.nvim
  "call dein#add('nvim-lua/popup.nvim')
  "call dein#add('nvim-lua/plenary.nvim')
  "call dein#add('nvim-telescope/telescope.nvim')

  " Coc:
  " Ref: https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#using-deinvim
  " Install: vim -c 'CocInstall -sync coc-explorer coc-fzf-preview coc-git coc-go coc-json coc-tsserver |q'
  call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release', 'build': 'yarn install --frozen-lockfile' })
  call dein#add('antoinemadec/coc-fzf', { 'depends': 'fzf.vim', 'merged': 0, 'rev': 'release' })

  if !exists('g:vscode')
    call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
    call dein#add('itchyny/lightline.vim')
    call dein#add('osyo-manga/vim-anzu', { 'depends': 'lightline.vim' })
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
if !exists('g:vscode')
  set listchars=tab:»-,extends:>,precedes:<,eol:↲,nbsp:%,trail:-,nbsp:>
endif
set signcolumn=number
set relativenumber
set number
set numberwidth=4
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

set background=dark

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
" Search current word
nnoremap * *N

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

" Plugin: coc.nvim {{{
let g:coc_global_extensions = ['coc-json', 'coc-fzf-preview', 'coc-explorer', 'coc-git']

nnoremap <silent> <C-h> :<C-u>call CocAction('doHover')<CR>
nmap <silent> <D-r> <Plug>(coc-rename)

" coc-go
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" }}}
" Plugin: Fzf > https://github.com/junegunn/fzf {{{
if has('mac')
  set rtp+=/opt/homebrew/opt/fzf
endif
let g:fzf_layout = { 'down': '30%' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"}}}
" Plugin: Fzf > https://github.com/yuki-yano/fzf-preview.vim {{{
" The theme used in the bat preview
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'ansi'

let g:fzf_preview_git_files_command   = 'git ls-files --exclude-standard | while read line; do if [[ ! -L $line ]] && [[ -f $line ]]; then echo $line; fi; done'
let g:fzf_preview_floating_window_rate = 0.85
let g:fzf_preview_fzf_preview_window_option = 'up:30%'
let g:fzf_preview_use_dev_icons = 1
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
" No specify ripgrep for fzf-preview, It's already '&grepprg' changed to ripgrep
" https://www.reddit.com/r/vim/comments/j87z9u/fzf_ripgrep_is_it_possible_to_omit_file_paths/
"let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=never --sort=path'
let g:fzf_preview_lines_command = 'bat --color=always --plain --number'
let g:fzf_preview_default_fzf_options = {
      \ '--reverse': v:true,
      \ '--preview-window': 'wrap',
      \ '--exact': v:true,
      \ '--no-sort': v:true,
      \ }

nnoremap <silent> <C-p> :<C-u>CocCommand fzf-preview.MruFiles<CR>
nnoremap <silent> <C-n> :<C-u>CocCommand fzf-preview.FromResources buffer project_mrw<CR>
nnoremap <silent> <C-e> :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> el :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort<CR>
nnoremap <silent> eG :<C-u>CocCommand fzf-preview.ProjectGrep .<CR>
nnoremap          eg :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
nnoremap <silent> ey :<C-u>CocCommand fzf-preview.Yankround<CR>
nnoremap <silent> ef :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> ep :<C-u>execute 'CocCommand fzf-preview.DirectoryFiles '.FindRootDirectory()<CR>
nnoremap <silent> <D-S-n> :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>

" TODO: どういうものか調べる
"nnoremap <silent> <fzf-p><C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
" Select references from coc.nvim (only coc extensions)
":CocCommand fzf-preview.CocReferences
" Open the PR corresponding to the selected line (Required [GitHub cli](https://github.com/cli/cli))
":CocCommand fzf-preview.BlamePR
" Definitions: => 定義元にジャンプっぽい
" Select type definitions from coc.nvim (only coc extensions)
":CocCommand fzf-preview.CocTypeDefinitions
" Select implementations from coc.nvim (only coc extensions)
":CocCommand fzf-preview.CocImplementations
" }}}
" Plugin: coc.nvim > coc-explorer {{{
nnoremap <silent> : :<C-u>CocCommand explorer --toggle<CR>
" Intellij Like Commands
nnoremap <silent> <D-1> :<C-u>CocCommand explorer --toggle<CR>
" TODO: Intellij likeにしたい
"autocmd FileType explorer nmap <buffer> <ESC> <Plug>(vimfiler_switch_to_other_window)
"autocmd FileType explorer nmap <buffer> <D-r> <Plug>(vimfiler_rename_file)
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
" Plugin: lightline.vim {{{
if !exists('g:vscode')
  let g:lightline = {
    \ 'colorscheme': 'iceberg',
    \ 'active': {
    \   'left': [ ['mode', 'paste'], ['git_relative_dir'], ['ctrlpmark'] ],
    \   'right': [ ['lineinfo'], ['fileformat', 'fileencoding', 'filetype'], ['coc'] ]
    \ },
    \ 'component_function': {
    \   'coc': 'coc#status',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'git_relative_dir': 'MyGitFileName',
    \   'mode': 'LightlineMode',
    \   'ctrlpmark': 'CtrlPMark',
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
" Plugin: matchit.vim {{{
" INFO: Extended % command.
"if filereadable($HOME . '/macros/matchit.vim')
if filereadable(s:dein_dir . '/repos/matchit.zip/plugin/matchit.vim')
  runtime macros/matchit.vim
  let b:match_words = 'if:endif'
  let b:match_ignorecase = 1
endif
" }}}
" Plugin: https://github.com/hashivim/vim-terraform {{{
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
let g:terraform_fold_sections = 0
let g:hcl_align = 1
let g:hcl_fold_sections = 0
" }}}
" Plugin: https://github.com/editorconfig/editorconfig-vim {{{
au FileType gitcommit let b:EditorConfig_disable = 1
au FileType gitrebase let b:EditorConfig_disable = 1
"}}}
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
" My Plugin: vim-multiple-switcher {{{
"let g:multiple_switcher_no_default_key_maps = 1
nnoremap <silent> ,p :<C-u>call multiple_switcher#switch('paste')<CR>
nnoremap <silent> ,e :<C-u>call multiple_switcher#switch('expandtab')<CR>
nnoremap <silent> ,w :<C-u>call multiple_switcher#switch('wrap')<CR>
vnoremap <silent> ,n :<C-u>call multiple_switcher#switch('number')<CR>
" }}}
" Plugin: github.com/ryanoasis/vim-devicons {{{
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
"}}}
" DarkPoweredPlugins: deol (terminal) {{{
if has('nvim')
  nnoremap <silent> <Leader>s :<C-u>Deol -split=floating<CR>
else
  nnoremap <silent> <Leader>s :<C-u>Deol<CR>
endif
tnoremap <ESC> <C-\><C-n>
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
