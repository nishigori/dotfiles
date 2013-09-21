set nocompatible           " be iMproved
filetype plugin indent off " required!!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
" unite source {{{
NeoBundle 'Shougo/unite.vim'

NeoBundle 'Shougo/unite-outline'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'osyo-manga/unite-quickrun_config'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'tacroe/unite-mark'
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
NeoBundle 'alpaca-tc/alpaca_powertabline'
"NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'bling/vim-bufferline'
NeoBundle 'bling/vim-airline'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/current-func-info.vim'
NeoBundle 'vim-scripts/trinity.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/TagHighlight'
" }}}
" Syntax {{{
NeoBundle 'scrooloose/syntastic'
" neocomplete requires vim 7.3.885 or above.
NeoBundle 'Shougo/neocomplete', {
  \ 'depends' : 'Shougo/context_filetype.vim',
  \ 'vim_version' : '7.3.885'
  \ }
" }}}
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
" }}}
" Text operation {{{
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'smartchr'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 't9md/vim-textmanip'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'visualstar.vim'
NeoBundle 'vim-scripts/matchparenpp'
NeoBundle 'h1mesuke/vim-alignta'
" }}}
" Marker {{{
"NeoBundle 'vim-scripts/ShowMarks'
"NeoBundle 'vim-scripts/number-marks'
" }}}
" Colorsheme & Font {{{
NeoBundle 'nanotech/jellybeans.vim'
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
NeoBundle 'peaksea'
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
NeoBundle 'vim-scripts/Headlights'
NeoBundle 'vim-scripts/copypath.vim'
NeoBundle 'mattn/calendar-vim'
NeoBundle 'vim-scripts/submode'
NeoBundle 'thinca/vim-openbuf'
" }}}
" ref, help {{{
NeoBundle 'thinca/vim-ref'
" }}}
" Joke {{{
NeoBundle 'mattn/unite-nyancat'
NeoBundle 'mhinz/vim-startify'
" }}}
" VCS {{{
NeoBundle 'tpope/vim-fugitive'
"NeoBundleLazy 'Shougo/vim-vcs', {
  "\   'depends' : 'thinca/vim-openbuf',
  "\   'autoload' : {'functions' : 'vcs#info', 'commands' : 'Vcs'},
  "\ }
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
" HTML {{{
NeoBundleLazy 'othree/html5.vim'
autocmd FileType html NeoBundleSource html5.vim
" }}}
" CSS {{{
NeoBundleLazy 'vim-scripts/css3'
autocmd FileType css NeoBundleSource css3
" }}}
" Markdown {{{
NeoBundle 'mattn/mkdpreview-vim'
autocmd FileType markdown NeoBundleSource mkdpreview-vim
" }}}
" reST {{{
NeoBundleLazy 'jtriley/vim-rst-headings'
autocmd FileType python,rest,rst NeoBundleSource vim-rst-headings
NeoBundleLazy 'heavenshell/vim-quickrun-hook-sphinx'
autocmd FileType rst NeoBundleSource vim-quickrun-hook-sphinx
" }}}
" JavaScript {{{
NeoBundle 'teramako/jscomplete-vim'
autocmd FileType javascript,js NeoBundleSource jscomplete-vim
NeoBundleLazy 'basyura/jslint.vim'
autocmd FileType javascript,js NeoBundleSource vim-ref-jquery
NeoBundle 'vim-scripts/JSON.vim'
autocmd FileType javascript,json NeoBundleSource JSON.vim
" }}}
" Ruby {{{
NeoBundle 'vim-ruby/vim-ruby'
" need ruby-debug-ide19
" $ gem install ruby-debug-ide19
"NeoBundle 'astashov/vim-ruby-debugger'
"autocmd FileType ruby
  "\ NeoBundleSource 'tpope/rails.vim'
" @see http://qiita.com/items/839f4b9e07cf7f341835
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
" VimScript {{{
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundleLazy 'dsummersl/vimunit'
autocmd FileType vim NeoBundleSource vimunit
"NeoBundleLazy 'ujihisa/vital.vim'
" }}}
" Nginx {{{
autocmd FileType nginx NeoBundleSource 'chase/nginx.vim'
NeoBundleLazy 'nishigori/neocomplcache-nginx-snippet'
autocmd FileType nginx NeoBundleSource 'neocomplcache-nginx-snippet'
" }}}
" My Plugins {{{
NeoBundle 'nishigori/vim-multiple-switcher'
NeoBundle 'nishigori/vim-sunday'
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

filetype plugin indent on " required!


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
