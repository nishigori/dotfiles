set nocompatible           " be iMproved
filetype plugin indent off " required!!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
" Core {{{
NeoBundle 'Shougo/unite.vim'
" }}}
" unite source {{{
NeoBundle 'thinca/vim-unite-history', { 'depends' : 'Shougo/unite.vim' }
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
" Command {{{
NeoBundle 'ujihisa/unite-locate', { 'depends' : 'Shougo/unite.vim' }
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
NeoBundle 'h1mesuke/unite-outline', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/current-func-info.vim'
NeoBundle 'vim-scripts/trinity.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/TagHighlight'
NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }
" }}}
" Syntax {{{
NeoBundle 'scrooloose/syntastic'
" }}}
" Complete, Snippet {{{
NeoBundle 'Shougo/neocomplcache'
"call neobundle#config('neocomplcache', {
  "\ 'lazy' : 1,
  "\ 'autoload' : {
  "\     'insert' : 1,
  "\ }})
NeoBundle 'Shougo/neosnippet'
"call neobundle#config('neosnippet', {
  "\ 'lazy' : 1,
  "\ 'autoload' : {
  "\     'insert' : 1,
  "\ }})
NeoBundle 'thinca/vim-ambicmd'
" }}}
" Text operation {{{
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'mattn/zencoding-vim'
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
NeoBundle 'tacroe/unite-mark', { 'depends' : 'Shougo/unite.vim' }
"NeoBundle 'vim-scripts/ShowMarks'
"NeoBundle 'vim-scripts/number-marks'
" }}}
" Colorsheme & Font {{{
NeoBundle 'ujihisa/unite-colorscheme', { 'depends' : 'Shougo/unite.vim' }
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
NeoBundle 'mattn/unite-nyancat', { 'depends' : 'Shougo/unite.vim' }
" }}}
" ref, help {{{
NeoBundle 'thinca/vim-ref'
NeoBundle 'tsukkee/unite-help', { 'depends' : 'Shougo/unite.vim' }
" }}}
" VCS {{{
NeoBundle 'tpope/vim-fugitive'
" http://kmnk.blogspot.jp/2013/01/git-unite-unite-source.html
"NeoBundle 'kmnk/vim-unite-giti'
"NeoBundleLazy 'Shougo/vim-vcs', {
  "\   'depends' : 'thinca/vim-openbuf',
  "\   'autoload' : {'functions' : 'vcs#info', 'commands' : 'Vcs'},
  "\ }
NeoBundle 'sgur/unite-git_grep', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'Kocha/vim-unite-tig', { 'depends' : 'Shougo/unite.vim' }
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
NeoBundle 'pasela/unite-webcolorname', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'vim-scripts/css3'
autocmd FileType css NeoBundleSource css3
" }}}
" Markdown {{{
NeoBundle 'mattn/mkdpreview-vim'
autocmd FileType markdown NeoBundleSource mkdpreview-vim
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
NeoBundle 'ujihisa/unite-gem', { 'depends' : 'Shougo/unite.vim' }
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
NeoBundleLazy 'jtriley/vim-rst-headings'
autocmd FileType python,rest,rst NeoBundleSource vim-rst-headings
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
"@todo FIXME: invalid completefunc for neocom into vim-symfony
"NeoBundle 'nishigori/vim-symfony'
NeoBundle 'nishigori/vim-multiple-switcher'
NeoBundle 'nishigori/vim-sunday'
NeoBundleLazy 'nishigori/vim-php-dictionary'
autocmd FileType php NeoBundleSource vim-php-dictionary
NeoBundleLazy 'nishigori/vim-php-cs-fixer'
autocmd FileType php NeoBundleSource vim-php-cs-fixer
NeoBundleLazy 'nishigori/unite-sf2', { 'depends' : 'Shougo/unite.vim' }
autocmd FileType php NeoBundleSource unite-sf2
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
