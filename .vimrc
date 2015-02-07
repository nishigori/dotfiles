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

set helplang=ja,en
set keywordprg=:help
nnoremap <silent> <C-h> :<C-u>help<Space><C-r><C-w><CR>

let mapleader = " "
" }}}
" # Local Dependency {{{
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
endif

let s:tmpdir = exists('g:local_config["tmp_dir"]')
  \ ? g:local_config['tmp_dir']
  \ : $HOME
" }}}

" # Bundles {{{
if g:my_config_use_plugin && !exists('g:loaded_neobundle')
  let s:bundle_dir = $HOME . '/.vim/bundle'

  set nocompatible           " be iMproved
  filetype plugin indent off " required!!

  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  " Required:
  call neobundle#begin(expand('~/.vim/bundle/'))

  " Let NeoBundle manage NeoBundle
  " Required:
  NeoBundleFetch 'Shougo/neobundle.vim'

  " unite source {{{
  NeoBundle 'Shougo/unite.vim'

  NeoBundle 'Shougo/neomru.vim'
  NeoBundle 'Shougo/unite-outline'
  NeoBundle 'thinca/vim-unite-history'
  NeoBundle 'osyo-manga/unite-quickrun_config'
  NeoBundle 'ujihisa/unite-locate'
  NeoBundleLazy 'tsukkee/unite-tag',
    \ {
    \   'depends' : ['Shougo/unite.vim'],
    \   'autoload' : {
    \     'unite_sources' : ['tag', 'tag/file', 'tag/include'],
    \   }
    \ }
  NeoBundle 'tacroe/unite-mark'
  NeoBundle 'basyura/unite-converter-file-directory'
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'sgur/unite-git_grep'
  NeoBundle 'Kocha/vim-unite-tig'
  NeoBundle 'tsukkee/unite-help'
  " http://kmnk.blogspot.jp/2013/01/git-unite-unite-source.html
  "NeoBundle 'kmnk/vim-unite-giti'
  NeoBundle 'pasela/unite-webcolorname'
  NeoBundle 'ujihisa/unite-gem'
  NeoBundleLazy 'nishigori/unite-sf2', { 'depends' : 'Shougo/unite.vim' }
  autocmd FileType php NeoBundleSource unite-sf2
  " }}}
  " Debug, Backend {{{
  if has('python')
    NeoBundle 'vim-scripts/Gundo'
  endif
  " Require `brew install rmtrash`
  NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }
  " }}}
  " Projects {{{
  NeoBundle 'airblade/vim-rooter'
  " }}}
  " Shell {{{
  NeoBundleLazy 'Shougo/vimshell',{
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : {
    \   'commands' : [{ 'name' : 'VimShell',
    \                   'complete' : 'customlist,vimshell#complete'},
    \                 'VimShellExecute', 'VimShellInteractive',
    \                 'VimShellTerminal', 'VimShellPop'],
    \   'mappings' : ['<Plug>(vimshell_switch)'],
    \ }}
  NeoBundle 'sudo.vim'
  " }}}
  " Explorer, Filer {{{
  NeoBundleLazy 'Shougo/vimfiler', {
    \ 'depends' : 'Shougo/unite.vim',
    \ 'autoload' : {
    \    'commands' : [{ 'name' : 'VimFiler',
    \                    'complete' : 'customlist,vimfiler#complete' },
    \                  'VimFilerExplorer',
    \                  'Edit', 'Read', 'Source', 'Write'],
    \    'mappings' : ['<Plug>(vimfiler_switch)'],
    \    'explorer' : 1,
    \ }
    \ }
  NeoBundle 'vim-scripts/SrcExpl'
  NeoBundle 'vim-scripts/Source-Explorer-srcexpl.vim'
  " }}}
  " Buffer, Tag {{{
  "NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
  "NeoBundle 'alpaca-tc/alpaca_powertabline'
  "NeoBundle 'bling/vim-airline'
  NeoBundle 'itchyny/lightline.vim'

  NeoBundle 'vim-scripts/PreserveNoEOL'

  NeoBundle 'bling/vim-bufferline'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'vim-scripts/current-func-info.vim'
  NeoBundle 'vim-scripts/trinity.vim'
  NeoBundle 'vim-scripts/taglist.vim'
  NeoBundle 'vim-scripts/TagHighlight'
  NeoBundleLazy 'alpaca-tc/alpaca_tags',
    \ {
    \   'rev': 'v2.0',
    \   'depends': 'Shougo/vimproc',
    \   'autoload' : {
    \     'commands': ['TagsUpdate', 'TagsSet', 'TagsBundle'],
    \   }
    \ }
  NeoBundle 'osyo-manga/vim-anzu'
  " }}}
  " Syntax {{{
  NeoBundle "scrooloose/syntastic", {
    \ "build": {
    \   "mac": ["pip install flake8", "npm -g install coffeelint"],
    \   "unix": ["pip install flake8", "npm -g install coffeelint"],
    \ }}
  " neocomplete requires vim 7.3.885 or above.
  NeoBundle 'Shougo/neocomplete', {
    \ 'depends' : 'Shougo/context_filetype.vim',
    \ 'vim_version' : '7.3.885'
    \ }
  " }}}
  NeoBundle 'Shougo/neosnippet-snippets'
  " Complete, Snippet {{{
  "NeoBundle 'Shougo/neocomplcache'
  "call neobundle#config('neocomplcache', {
  "\ 'lazy' : 1,
  "\ 'autoload' : {
  "\     'insert' : 1,
  "\ }})
  NeoBundle 'Shougo/neosnippet', '', 'default'
  call neobundle#config('neosnippet', {
    \ 'lazy' : 1,
    \ 'autoload' : {
    \ 'insert' : 1,
    \ 'filetypes' : 'snippet',
    \ 'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
    \ }})
  NeoBundle 'thinca/vim-ambicmd'
  NeoBundleLazy 'alpaca-tc/vim-endwise.git',
    \ {
    \   'autoload' : { 'insert' : 1 },
    \ }
  " }}}
  " Text operation {{{
  NeoBundle 'vim-scripts/matchit.zip'
  NeoBundleLazy 'mattn/emmet-vim'
  autocmd FileType html NeoBundleSource emmet-vim
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'smartchr'
  NeoBundle 'scrooloose/nerdcommenter'
  NeoBundle 't9md/vim-textmanip'
  "NeoBundle 't9md/vim-quickhl', { 'depends' : 'tyru/operator-star.vim' }
  NeoBundle 'visualstar.vim'
  NeoBundle 'vim-scripts/matchparenpp'
  NeoBundle 'h1mesuke/vim-alignta'
  " TODO: If multiple-cursor is active updating, it'll be enabled
  "NeoBundle 'terryma/vim-multiple-cursors'
  " }}}
  " Marker {{{
  "NeoBundle 'vim-scripts/ShowMarks'
  "NeoBundle 'vim-scripts/number-marks'
  " }}}
  " Colorsheme & Font {{{
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'itchyny/landscape.vim'
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'tomasr/molokai'
  NeoBundle 'jpo/vim-railscasts-theme'

  NeoBundle 'ujihisa/mrkn256.vim'
  NeoBundle 'desert256.vim'
  NeoBundle 'wombat256.vim'
  " :colorscheme wombat256mod
  NeoBundle 'xoria256.vim'
  NeoBundle 'vim-scripts/calmar256-lightdark.vim'

  NeoBundle 'Diablo3'
  NeoBundle 'candycode.vim'
  NeoBundle 'jonathanfilip/vim-lucius'
  NeoBundle 'vim-scripts/darkZ'
  NeoBundle 'vim-scripts/highlights-for-radiologist'

  NeoBundle 'thinca/vim-fontzoom'
  " }}}
  " Browse {{{
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'tyru/urilib.vim'
  NeoBundle 'mattn/webapi-vim'
  NeoBundle 'basyura/twibill.vim'
  NeoBundle 'basyura/bitly.vim'
  " }}}
  " Utility {{{
  " FIXME: vim-template, そのうち使う
  "NeoBundle 'thinca/vim-template'
  "NeoBundle 'vim-scripts/Headlights'
  NeoBundle 'vim-scripts/copypath.vim'
  "NeoBundle 'mattn/calendar-vim'
  NeoBundle 'itchyny/calendar.vim'
  NeoBundle 'kana/vim-submode'
  NeoBundle 'thinca/vim-openbuf'
  if !has('win32') && !has('mac')
    " Linux only
    NeoBundle 'gist:koron/5992868:', {
      \ 'name': 'pyibus.vim',
      \ 'script_type': 'plugin' }
  endif
  " }}}
  " ref, help {{{
  NeoBundle 'thinca/vim-ref'
  " }}}
  " Joke {{{
  NeoBundle 'mattn/unite-nyancat'
  NeoBundle 'mhinz/vim-startify'
  NeoBundle 'junegunn/vim-emoji'
  " }}}
  " VCS {{{
  " NOTE: disabled cause revision:2c8461d is crashed multibyte encoding.
  "NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }

  " TODO: require vim-powerline, change using plugin for show branch status
  NeoBundle 'yomi322/vim-gitcomplete', { 'depends' : 'Shougo/vimshell' }
  NeoBundle 'sudo.vim'
  " }}}
  " DB {{{
  "NeoBundle 'mattn/vdbi-vim'
  " INFO: dbext.vim' latest version is into the vim.org.
  "       http://vim.sourceforge.net/scripts/script.php?script_id=356
  "NeoBundle 'vim-scripts/dbext.vim'
  "NeoBundle 'xenoterracide/sql_iabbr'
  " }}}
  " filetype {{{
  " HTML {{{
  "NeoBundleLazy 'othree/html5.vim'
  "autocmd FileType html NeoBundleSource html5.vim
  " }}}
  " CSS|SCSS|SASS|LESS {{{
  NeoBundleLazy 'vim-scripts/css3'
  autocmd FileType css NeoBundleSource css3
  NeoBundleLazy 'tpope/vim-haml'
  autocmd FileType haml,scss,scss NeoBundleSource vim-haml
  " }}}
  " Markdown {{{
  "NeoBundle 'mattn/mkdpreview-vim'
  "autocmd FileType markdown NeoBundleSource mkdpreview-vim
  NeoBundle 'tpope/vim-markdown'
  autocmd FileType markdown NeoBundleSource vim-markdown
  " }}}
  " reST {{{
  NeoBundleLazy 'jtriley/vim-rst-headings'
  autocmd FileType python,rest,rst NeoBundleSource vim-rst-headings
  NeoBundleLazy 'heavenshell/vim-quickrun-hook-sphinx'
  autocmd FileType rst NeoBundleSource vim-quickrun-hook-sphinx
  " }}}
  " JSON {{{
  NeoBundle 'elzr/vim-json'
  autocmd FileType javascript,json NeoBundleSource vim-json
  " }}}
  " JavaScript {{{
  NeoBundleLazy 'basyura/jslint.vim'
  autocmd FileType javascript,js NeoBundleSource vim-ref-jquery
  " }}}
  " Ruby {{{
  " need ruby-debug-ide19
  " $ gem install ruby-debug-ide19
  "NeoBundle 'astashov/vim-ruby-debugger'
  "autocmd FileType ruby
  "\ NeoBundleSource 'tpope/rails.vim'
  " @see http://qiita.com/items/839f4b9e07cf7f341835
  NeoBundleLazy 'tpope/vim-rbenv'
  autocmd FileType ruby NeoBundleSource vim-rbenv
  NeoBundleLazy 'rhysd/neco-ruby-keyword-args'
  autocmd FileType ruby NeoBundleSource neco-ruby-keyword-args
  NeoBundleLazy 'ruby-matchit' " TODO: Need fork, cause no use ftplugin ;(
  autocmd FileType ruby NeoBundleSource ruby-matchit
  NeoBundleLazy 'ujihisa/unite-rake', { 'depends' : 'Shougo/unite.vim' }
  autocmd FileType ruby NeoBundleSource unite-rake
  NeoBundleLazy 'rhysd/unite-ruby-require.vim'
  autocmd FileType ruby NeoBundleSource unite-ruby-require
  NeoBundleLazy 'basyura/unite-rails'
  autocmd FileType ruby,rails NeoBundleSource unite-rails
  "NeoBundle 'rhysd/vim-textobj-ruby' " TODO: occurred unknown error
  " }}}
  " Python {{{
  NeoBundleLazy 'vim-scripts/python.vim--Vasiliev'
  autocmd FileType python,django NeoBundleSource python.vim--Vasiliev
  NeoBundleLazy 'hynek/vim-python-pep8-indent', {
    \ "autoload": {"insert": 1, "filetypes": ["python", "python3", "djangohtml"]}}
  NeoBundleLazy "davidhalter/jedi-vim", {
    \ "autoload": {
    \   "filetypes": ["python", "python3", "djangohtml"],
    \ },
    \ "build": {
    \   "mac": "pip install jedi",
    \   "unix": "pip install jedi",
    \ }}
  let s:hooks = neobundle#get_hooks("jedi-vim")
  function! s:hooks.on_source(bundle)
    " jediにvimの設定を任せると'completeopt+=preview'するので
    " 自動設定機能をOFFにし手動で設定を行う
    let g:jedi#auto_vim_configuration = 0
    " 補完の最初の項目が選択された状態だと使いにくいためオフにする
    let g:jedi#popup_select_first = 0
    " quickrunと被るため大文字に変更
    let g:jedi#rename_command = '<Leader>R'
    " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
    "let g:jedi#goto_assignments_command = '<Leader>G'
  endfunction
  NeoBundle 'jmcantrell/vim-virtualenv'
  "NeoBundlelazy 'mitsuhiko/vim-jinja'
  "autocmd FileType python,jinja NeoBundleSource vim-jinja
  " }}}
  " PHP {{{
  NeoBundleLazy 'arnaud-lb/vim-php-namespace'
  autocmd FileType php NeoBundleSource vim-php-namespace
  NeoBundleLazy 'beyondwords/vim-twig'
  autocmd FileType php,twig.html,html.twig NeoBundleSource vim-twig
  " }}}
  " Groovy {{{
  NeoBundleLazy 'nobeans/unite-grails'
  autocmd FileType groovy NeoBundleSource unite-grails
  " }}}
  " Clojure {{{
  NeoBundleLazy 'https://bitbucket.org/kotarak/vimclojure', {'type': 'hg'}
  autocmd FileType clojure NeoBundleSource vimclojure
  " }}}
  " Haskell {{{
  NeoBundleLazy 'ujihisa/ref-hoogle'
  autocmd FileType haskell NeoBundleSource ref-hoogle
  NeoBundle 'ujihisa/unite-haskellimport', { 'depends' : 'Shougo/unite.vim' }
  autocmd FileType haskell NeoBundleSource unite-haskellimport
  " }}}
  " Erlang {{{
  NeoBundleLazy 'jimenezrick/vimerl'
  autocmd FileType erlang NeoBundleSource vimerl
  " }}}
  " Go/golang {{{
  " Require `go get -u github.com/nsf/gocode`
  NeoBundleLazy 'Blackrush/vim-gocode'
  autocmd FileType go NeoBundleSource vim-gocode
  NeoBundleLazy 'nsf/gocode', {
    \   'rtp' : 'vim',
    \   'autoload' : { 'filetypes' : 'go' },
    \ }
  NeoBundleLazy 'golang/lint', { 'rtp': 'misc/vim' }
  autocmd FileType go NeoBundleSource lint
  " }}}
  " Scheme, scm {{{
  " gauche
  NeoBundle 'aharisu/vim_goshrepl'
  NeoBundle 'aharisu/vim-gdev'
  " }}}
  " Puppet {{{
  NeoBundle 'rodjek/vim-puppet'
  " }}}
  " VimScript {{{
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " }}}
  " }}}
  " Nginx {{{
  autocmd FileType nginx NeoBundleSource 'chase/nginx.vim'
  NeoBundleLazy 'nishigori/neocomplcache-nginx-snippet'
  autocmd FileType nginx NeoBundleSource 'neocomplcache-nginx-snippet'
  " }}}
  " Docker {{{
  NeoBundle 'ekalinin/Dockerfile.vim'
  " }}}
  " My Plugins {{{
  NeoBundle 'nishigori/vim-multiple-switcher'
  NeoBundle 'nishigori/increment-activator'
  NeoBundleLazy 'nishigori/vim-php-dictionary'
  autocmd FileType php NeoBundleSource vim-php-dictionary
  NeoBundleLazy 'nishigori/vim-php-cs-fixer'
  autocmd FileType php NeoBundleSource vim-php-cs-fixer
  NeoBundleLazy 'nishigori/phpfolding.vim'
  autocmd FileType php NeoBundleSource phpfolding.vim
  NeoBundleLazy 'nishigori/neocomplcache-phpunit-snippet'
  autocmd FileType php NeoBundleSource neocomplcache-phpunit-snippet
  "NeoBundle 'nishigori/vim-composer'
  " Beta
  "NeoBundle 'nishigori/vim-phpunit-snippets'
  "NeoBundle 'nishigori/vim-twig-matchit'
  " }}}

  if filereadable(expand($HOME . '/.vim/bundle.vim.local'))
    source $HOME/.vim/bundle.vim.local
  endif

  call neobundle#end()

  filetype plugin indent on " required!

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  "NeoBundleCheck
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

  augroup ZenSpace
    autocmd!
    autocmd ColorScheme * highlight ZenSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
    autocmd FileType * match ZenSpace /　\|\s\+$/
    autocmd FileType txt match ZenSpace /\s\+$/
    autocmd FileType git,rst match ZenSpace //
    autocmd FileType unite,vimshell,vimfiler,calendar,startify match ZenSpace //
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

nnoremap w e
nnoremap W E
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

" Plugins
if !g:my_config_use_plugin
  echo "INFO: g:my_config_use_plugin is 0 or not defined. and no reading plugin settings"
  finish " ここまで読んだらお前は死ぬ
endif
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
" Plugin: vimproc {{{
"let g:vimproc_dll_path = s:bundle_dir . '/vimproc/autoload'
" }}}
" Plugin: PreserveNoEOL {{{
"setlocal noeol | let b:PreserveNoEOL = 1
let b:PreserveNoEOL = 1
let g:PreserveNoEOL = 1
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
if !has('gui_macvim')
  let g:airline_powerline_fonts  = 1
endif

" タブラインにもairlineを適用
let g:airline#extensions#tabline#enabled = 1
" （タブが一個の場合）バッファのリストをタブラインに表示する機能をオフ
let g:airline#extensions#tabline#show_buffers = 0
" 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
let g:airline#extensions#tabline#tab_nr_type = 1
" タブに表示する名前（fnamemodifyの第二引数）
let g:airline#extensions#tabline#fnamemod = ':t'
" }}}
" Plugin: lightline.vim {{{
let g:lightline = {
  \ 'colorscheme': 'landscape',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
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

"" for vim-airline
"" vim-anzuの表示を statuslineに
"let g:airline_section_c = '%F %{anzu#search_status()}'
"" whitespace無効
"let g:airline#extensions#whitespace#enabled = 0
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
" Plugin: vim-markdown {{{
let g:vim_markdown_initial_foldlevel = 2
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
  \ }

" TODO: Add QuickRun's syntax for xUnit family
"autocmd BufAdd,BufNew,BufNewFile,BufRead [quickrun output] set syntax=xUnit
" }}}
" Plugin: TweetVim {{{
let g:tweetvim_tweet_per_page = 30
let g:tweetvim_config_dir  = s:tmpdir . '/tweetvim'
let g:tweetvim_include_rts = 1
let g:tweetvim_open_buffer_cmd = 'split -winheight=12 edit!'
nnoremap <silent> ts :<C-u>TweetVimSay<Cr>
" unite mapping
nnoremap <silent> tt :<C-u>Unite tweetvim<Cr>
" }}}
" Plugin: dbext.vim {{{
let g:dbext_default_history_file = s:tmpdir . '/dbext_sql_history.sql'
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
" }}}
" Plugin: neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 39
let g:neocomplete#max_keyword_width = 64
let g:neocomplete#auto_completion_start_length = 4
let g:neocomplete#manual_completion_start_length = 4
let g:neocomplete#min_keyword_length = 4
"let g:neocomplete#enable_ignore_case = 'ignorecase'
let g:neocomplete#enable_smart_case = 'infercase'
"let g:neocomplete#enable_camel_case = 0
"let g:neocomplete#disable_auto_complete = 0
let g:neocomplete#enable_cursor_hold_i = 0
let g:neocomplete#cursor_hold_i_time = 300
let g:neocomplete#enable_insert_char_pre = 1 " Really??
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#enable_auto_delimiter = 0
let g:neocomplete#enable_fuzzy_completion = 1
"let g:neocomplete#enable_multibyte_completion = 0
"let g:neocomplete#lock_buffer_name_pattern = ''
"let g:neocomplete#lock_iminsert = 0
let g:neocomplete#data_directory = s:tmpdir . '/neocomplete'
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


inoremap <expr><S-Space> neocomplete#start_manual_complete()

" Plugin key-mappings.
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplete#close_popup()
"inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible()
  \ ? neocomplete#close_popup()."\<Space>" : "\<Space>"
" Enable omni completion.

let g:neocomplete#sources#omni#functions
  \ = get(g:, 'neocomplete#sources#omni#functions', {})

try
  set completeopt-=noselect
  set completeopt+=noinsert
  let g:neocomplete#enable_auto_select = 1
  let g:neocomplete#enable_complete_select = 1
catch /^Vim\%((\a\+)\)\=:E474/
  " when the patch isn't applied
endtry

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" popup highlight
highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

" scheme for SICP
let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
vmap <CR> <Plug>(gosh_repl_send_block)
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
" Plugin: vim-multiple-cursors {{{
let g:multi_cursor_start_key = 'm'
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
  let g:vimfiler_ignore_pattern = '^.*\%(.git\|.DS_Store\|.idea\|.iml\|.pyc\|.tox\|__pycache__\|.ruby-version\)$'
  let g:vimfiler_edit_action         = 'open'
  let g:vimfiler_sort_type           = 'filename'
  let g:vimfiler_time_format         = "%y-%m-%d %H:%M"
  let g:vimfiler_enable_auto_cd      = 1
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
nnoremap : :<C-u>VimFilerExplorer -buffer-name=explorer
  \ -split -simple -winwidth=35 -project -auto-cd -no-quit -find<CR>
"augroup VimFilerUniteAction " {{{
  "autocmd!
  "autocmd FileType vimfiler call unite#custom_default_action('directory', 'lcd')
"augroup END " }}}
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

let g:unite_enable_short_source_names = 1

let g:unite_prompt = '☁  '

" For unite-session Save & Load session automatically.
let g:unite_source_session_enable_auto_save = 1

" window options
let g:unite_source_file_mru_limit = 511

" mru options
let g:unite_source_file_mru_filename_format = ':p:~'
let g:unite_source_directory_mru_ignore_pattern =
  \ '\%(^\|/\)\.\%(hg\|git\|bzr\|svn\|vimundo\|idea\|pyc\)\%($\|/\)\|^\%(\\\\\|/mnt/\|/media/\|/Volumes/\)'

" history options
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit  = 50

" color options
let g:unite_cursor_line_highlight = 'PmenuSel'
"let g:unite_abbr_highlight       = 'TabLine'
" }}}
" Plugin: unite.vim >> key mappings {{{
augroup UniteBufferKeyMappings
  autocmd!
  autocmd FileType unite call s:define_unite_keymaps()
augroup END
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

nnoremap <C-p> :<C-u>Unite file_mru<CR>
nnoremap <C-n> :<C-u>Unite buffer bookmark<CR>
"nnoremap <C-b> :<C-u>UniteBookmarkAdd<Space>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() "{{{
  " Overwrite settings.

  imap <buffer> q      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  imap <buffer><expr> j unite#smart_map('j', '')
  imap <buffer> <TAB>   <Plug>(unite_select_next_line)
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  imap <buffer> '     <Plug>(unite_quick_match_default_action)
  nmap <buffer> '     <Plug>(unite_quick_match_default_action)
  imap <buffer><expr> x
    \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
  nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
  nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
  imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
  nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
  nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
  nnoremap <silent><buffer><expr> l
    \ unite#smart_map('l', unite#do_action('default'))

  let unite = unite#get_current_unite()
  if unite.profile_name ==# 'search'
    nnoremap <silent><buffer><expr> r     unite#do_action('replace')
  else
    nnoremap <silent><buffer><expr> r     unite#do_action('rename')
  endif

  nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
  nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
    \ empty(unite#mappings#get_current_filters()) ?
    \ ['sorter_reverse'] : [])

  " Runs "split" action by <C-s>.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
endfunction "}}}

" find
let g:unite_source_find_default_opts = '-L' " Follow symlinks

" grep & async
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--follow --nocolor --nogroup --hidden -g ""'
  let g:unite_source_grep_recursive_opt = ''

  let g:unite_source_rec_async_command =
    \ 'ag --follow --nocolor --nogroup --hidden -g ""'
elseif executable('ack')
  let g:unite_source_grep_command = 'ack'
  let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
  let g:unite_source_grep_recursive_opt = ''

  let g:unite_source_rec_async_command = 'ack -f --nofilter'
endif
" }}}
" Plugin: unite.vim >> custom >> profile {{{
call unite#custom#profile('default', 'context', {
  \ 'prompt_direction': 'top',
  \ 'start_insert': 1,
  \ 'direction': 'below',
  \ 'winheight': '25',
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
call unite#custom#profile('files', 'substitute_patterns', {
  \ 'pattern': '^;r',
  \ 'subst': '\=$VIMRUNTIME."/"',
  \ 'priority': 1,
  \ })
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
call unite#custom#profile('files', 'substitute_patterns', {
  \ 'pattern': '\\\@<! ',
  \ 'subst': '\\ ',
  \ 'priority': -20,
  \ })
call unite#custom#profile('files', 'substitute_patterns', {
  \ 'pattern': '\\ \@!',
  \ 'subst': '/',
  \ 'priority': -30,
  \ })
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
" }}}
" Plugin: unite.vim >> custom >> aliases / sources {{{
let g:unite_source_alias_aliases = get(g:, 'unite_source_alias_aliases', {})
let g:unite_source_alias_aliases.workspace = {
  \ 'source': 'file',
  \ 'args':   "$HOME/workspace",
  \ }
let g:unite_source_alias_aliases.workspace_rec = {
  \ 'source': 'file_rec',
  \ 'args':   "$HOME/workspace",
  \ }

call unite#custom#source(
  \   'file',
  \   'ignore_pattern',
  \   '^\%(/\|\a\+:/\)$\|\%(^\|/\)\.\.\?$\|\~$\|\.\%(o|exe|dll|bak|sw[po]|vimundo|app|iml|gif|jpg|jpeg|png|pyc|\)$'
  \ )
call unite#custom#source(
  \   'file,file_rec,file_rec/async',
  \   'ignore_pattern',
  \   join([
  \     '\%(^\|/\)\.$\|\~$',
  \     '\.\%(o\|exe\|dll\|sw[po]\|vimundo\|pyc\)$',
  \     '\%(^\|/\)\.\%(hg\|git\|bzr\|svn\|idea\)\%($\|/\)',
  \   ], '\|')
  \ )

call unite#custom#source(
  \ 'file_rec,file_mru,file_rec,file_rec/async',
  \ 'converters',
  \ ['converter_file_directory']
  \ )
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
  \     '▷ git diff (vertical) (Fugitive)                   <Leader>gd',
  \     'Gvdiff'
  \   ],
  \   [
  \     '▷ git diff          (Fugitive)                     <Leader>gd',
  \     'Gsdiff'
  \   ],
  \   [
  \     '▷ git diff --cached (vertical) (Fugitive)          <Leader>gD',
  \     'Gsdiff --cached'
  \   ],
  \   [
  \     '▷ git diff --cached (Fugitive)                     <Leader>gD',
  \     'Gsdiff --cached'
  \   ],
  \   [
  \     '▷ git commit        (Fugitive)                     <Leader>gc',
  \     'Gcommit --verbose'
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
" Plugin: alpaca_tags {{{
let g:alpaca_tags#config = get(g:, 'alpaca_tags#config', {
  \   '_': '-R --exclude=".git*" --sort=yes',
  \ })
" }}}
" Plugin: unite-tag {{{
let g:unite_tig_default_line_count = 80
nnoremap <silent> <C-]> :<C-u>Unite -immediately -no-start-insert tags:<C-r>=expand('<cword>')<CR><CR>
autocmd BufEnter *
  \ if empty(&buftype)
  \   | nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR> |
  \ endif
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
  \   'chef': {
  \     'url': 'http://docs.opscode.com/resource_%s.html',
  \   },
  \ }
" 出力に対するフィルタ。最初の数行を削除している。
function! g:ref_source_webdict_sites.weblio.filter(output)
  return join(split(a:output, "\n")[18 :], "\n")
endfunction
let g:ref_source_webdict_sites.default = 'weblio'

let g:ref_cmd_filetype_map = get(g:, 'ref_cmd_filetype_map', {})
" }}}
" My Plugin: vim-multiple-switcher {{{
"let g:multiple_switcher_no_default_key_maps = 1
nnoremap <silent> ,p :<C-u>call multiple_switcher#switch('paste')<CR>
nnoremap <silent> ,e :<C-u>call multiple_switcher#switch('expandtab')<CR>
nnoremap <silent> ,w :<C-u>call multiple_switcher#switch('wrap')<CR>
vnoremap <silent> ,n :<C-u>call multiple_switcher#switch('number')<CR>
" }}}
" My Plugin: IncrementActivator {{{
let g:increment_activator_filetype_candidates = get(g:, 'increment_activator_filetype_candidates', {
  \   '_': [
  \     ['light', 'dark'],
  \     ['pick', 'squash', 'edit', 'reword', 'fixup', 'exec'],
  \     ['previous', 'current', 'next'],
  \     ['ぬるぽ', 'ガッ'],
  \     ['=', ':='],
  \     ['true', 'false'],
  \     ['月','火','水','木','金','土','日'],
  \   ],
  \ })
" }}}

" external patches
if exists('+breakindent')
  set breakindent
endif


"" Each filetype (not on ftplugin but define require first on vimrc)

" VimScript {{{
let g:increment_activator_filetype_candidates['vim'] = [
  \   ['nnoremap', 'xnoremap', 'inoremap', 'vnoremap', 'cnoremap', 'onoremap'],
  \   ['nmap', 'xmap', 'imap', 'vmap', 'cmap', 'omap'],
  \   ['NeoBundle', 'NeoBundleLazy'],
  \   ['Home', 'End', 'Left', 'Right', 'Delete'],
  \   ['has', 'has_key', 'exists'],
  \ ]
" }}}
" go/golang {{{

" RSS:
" - http://kaworu.jpn.org/vim/vimのGo開発環境

" https://github.com/majutsushi/tagbar/wiki#google-go
let g:tagbar_type_go = {
  \   'ctagstype': 'go',
  \   'kinds': [
  \     'p:package',
  \     'f:function',
  \     'v:variables',
  \     't:type',
  \     'c:const',
  \   ],
  \ }

let g:increment_activator_filetype_candidates.go = [
  \   ['true', 'false', 'iota', 'nil'],
  \   ['print', 'println'],
  \   ['byte', 'complex64', 'complex128'],
  \   ['int', 'int8', 'int16', 'int32', 'int64'],
  \   ['uint', 'uint8', 'uint16', 'uint32', 'uint64'],
  \   ['float32', 'float64'],
  \   ['interface', 'struct'],
  \ ]

let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
let g:neocomplete#sources#omni#functions.go =  'gocomplete#Complete'
" }}}
" scheme {{{
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

" }}}
" Python {{{
let g:syntastic_python_checkers = ['flake8']
let g:ref_cmd_filetype_map['python'] = 'pydoc'

" For jedi-vim
" TODO: fixme {{{

""let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
"let g:jedi#auto_vim_configuration = 0

"autocmd FileType python setlocal omnifunc=jedi#completions
"let g:jedi#completions_enabled = 0
"let g:jedi#auto_vim_configuration = 0
"let g:neocomplete#force_omni_input_patterns.python =
  "\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  "}}}
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
" Ruby {{{
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

let g:user_emmet_settings['haml'] = {
  \   'extends': 'html',
  \ }

let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}
" Cucumber {{{
let g:increment_activator_filetype_candidates['cucumber'] = [
  \   ['Given', 'And', 'When', 'Then'],
  \ ]
" }}}
" JavaScript {{{
let g:alpaca_tags#config['js'] = '-R --languages=+js'
let g:quickrun_config['javascript'] = {
  \   'command' : 'phantomjs',
  \ }

let g:user_emmet_settings['javascript'] = {
  \   'snippets' : {
  \     'jq': "$(function() {\n\t${cursor}${child}\n});",
  \     'jq:each': "$.each(arr, function(index, item)\n\t${child}\n});",
  \     'fn': "(function() {\n\t${cursor}\n})();",
  \     'tm': "setTimeout(function() {\n\t${cursor}\n}, 100);",
  \   },
  \ }

" plugin jscomplatete.vim
let g:jscomplete_use = ['dom']
" }}}
" Perl {{{
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

let g:ref_cmd_filetype_map.perl = 'perldoc'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
" PHP {{{
" NOTE: unite-sf2 avairables is depends local environment.
"let g:unite_source_sf2_root_dir = $HOME . '/workspace/sandbox/Studies/symfony-standard'
"let g:unite_source_sf2_bundles = get(g:, 'unite_source_sf2_bundles', {})
" (forked) vim-php-cs-fixer
let g:php_cs_fixer_default_mapping = 1                     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_path            = "/usr/sbin/php-cs-fixer/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level           = "all"                 " which level ?
let g:php_cs_fixer_config          = "default"             " configuration
"let g:php_cs_fixer_php_path        = "php"                 " Path to PHP
let g:php_cs_fixer_fixers_list     = ""                    " List of fixers
let g:php_cs_fixer_dry_run         = 0                     " Call command with dry-run option
let g:php_cs_fixer_use_sudo         = 1                     " Call command with dry-run option

let g:increment_activator_filetype_candidates['php'] = [
  \   ['private', 'protected', 'public'],
  \   ['extends', 'implements'],
  \   ['assert', 'depends', 'dataProvider', 'expectedException', 'group', 'test'],
  \ ]

let g:ref_cmd_filetype_map['php'] = 'php'

let g:quickrun_config['php.phpunit'] = { 'command': 'phpunit' }
let g:quickrun_config['phpunit.php'] = { 'command': 'phpunit' }

let g:user_emmet_settings['perl'] = {
  \  'extends': 'html',
  \  'filters': 'html,c',
  \ }
" }}}
" HTML {{{
let g:user_emmet_settings['html'] = {
  \   'filters' : 'html',
  \   'indentation' : ' '
  \ }
" }}}
" CSS / SCSS / LESS {{{
let g:user_emmet_settings['css'] = {
  \  'filters': 'fc',
  \ }
" }}}

" # [unite] Mappings "{{{
" The prefix key.
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap e [unite]
xmap e [unite]

nnoremap <silent> [unite]u :<C-u>Unite resume source<CR>

nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file
  \ -wrap -buffer-name=files buffer bookmark file<CR>
nnoremap <silent> [unite]F :<C-u>Unite file_rec<CR>
nnoremap <silent> [unite]w :<C-u>Unite workspace
  \ -no-split -buffer-name=bookmark<CR>
nnoremap <silent> [unite]W :<C-u>Unite workspace_rec
  \ -no-split -buffer-name=bookmark file -input=!vendor <CR>
nnoremap <silent> [unite]a :<C-u>Unite alignta:options<CR>
xnoremap <silent> [unite]a :<C-u>Unite alignta:arguments<CR>
nnoremap <silent> [unite]m :<C-u>Unite mark<CR>
nnoremap <silent> [unite]M :<C-u>Unite menu<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]B :<C-u>Unite bookmark -default-action=vimshell<CR>
nnoremap <silent> [unite]d
  \ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tig -no-start-insert -no-quit -no-split<CR>
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