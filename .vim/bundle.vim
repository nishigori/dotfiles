if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
" unite source {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'ujihisa/unite-gem'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'mattn/unite-nyancat'
NeoBundle 'mattn/unite-remotefile'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'pasela/unite-webcolorname'
NeoBundle 'Kocha/vim-unite-tig'
" }}}
" projects {{{
NeoBundle 'airblade/vim-rooter'
" }}}
" buffer, tag {{{
NeoBundle 'Lokaltog/vim-powerline'
NeoBundleLazy 'Shougo/vimshell',{
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell',
  \                   'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)'],
  \ }}
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
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/current-func-info.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/trinity.vim'
NeoBundle 'vim-scripts/SrcExpl'
NeoBundle 'vim-scripts/Source-Explorer-srcexpl.vim'
NeoBundle 'vim-scripts/TagHighlight'
NeoBundle 'sudo.vim'
" }}}
" syntax {{{
NeoBundle 'scrooloose/syntastic'
" }}}
" complete, snippet {{{
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
" text operation {{{
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'smartchr'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 't9md/vim-textmanip'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'visualstar.vim'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'vim-scripts/matchparenpp'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'h1mesuke/vim-alignta'
" }}}
" marks {{{
"NeoBundle 'vim-scripts/ShowMarks'
"NeoBundle 'vim-scripts/number-marks'
" }}}
" color sheme & font {{{
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
" browse {{{
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/urilib.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/bitly.vim'
" }}}
" VCS {{{
NeoBundleLazy 'Shougo/vim-vcs', {
  \   'depends' : 'thinca/vim-openbuf',
  \   'autoload' : {'functions' : 'vcs#info', 'commands' : 'Vcs'},
  \ }
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/gist-vim'
NeoBundle 'vim-scripts/gitv'
" }}}
" DB {{{
"NeoBundle 'mattn/vdbi-vim'
" INFO: dbext.vim' latest version is into the vim.org.
"       http://vim.sourceforge.net/scripts/script.php?script_id=356
"NeoBundle 'vim-scripts/dbext.vim'
"NeoBundle 'xenoterracide/sql_iabbr'
" }}}
" debug, backend {{{
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
"NeoBundle 'ujihisa/vital.vim'
" }}}
" ref, help {{{
NeoBundle 'thinca/vim-ref'
" }}}
" filetype {{{
"" HTML
NeoBundleLazy 'othree/html5.vim'
autocmd FileType html NeoBundleSource html5.vim
"" CSS
NeoBundleLay 'vim-scripts/css3'
autocmd FileType css NeoBundleSource css3
"" Markdown
NeoBundle 'mattn/mkdpreview-vim'
autocmd FileType markdown NeoBundleSource mkdpreview-vim
"" JavaScript
NeoBundle 'teramako/jscomplete-vim'
autocmd FileType javascript,js NeoBundleSource jscomplete-vim
NeoBundleLazy 'basyura/jslint.vim'
autocmd FileType javascript,js NeoBundleSource vim-ref-jquery
"" PHP
NeoBundleLazy 'arnaud-lb/vim-php-namespace'
autocmd FileType php NeoBundleSource vim-php-namespace
NeoBundleLazy 'beyondwords/vim-twig'
autocmd FileType php,twig.html,html.twig NeoBundleSource vim-twig
"" Ruby
" need ruby-debug-ide19
" $ gem install ruby-debug-ide19
"NeoBundle 'astashov/vim-ruby-debugger'
"autocmd FileType ruby
  "\ NeoBundleSource 'vim-scripts/rails.vim'
" @see http://qiita.com/items/839f4b9e07cf7f341835
NeoBundleLazy 'ujihisa/unite-rake', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'rhysd/unite-ruby-require.vim'
NeoBundle 'rhysd/neco-ruby-keyword-args'
"NeoBundle 'rhysd/vim-textobj-ruby' " TODO: occurred unknown error
NeoBundle 'ruby-matchit' " TODO: Need fork, cause no use ftplugin ;(
"" Python
NeoBundleLazy 'vim-scripts/python.vim--Vasiliev'
autocmd FileType python,django NeoBundleSource python.vim--Vasiliev
NeoBundleLazy 'jtriley/vim-rst-headings'
autocmd FileType python,rest,rst NeoBundleSource vim-rst-headings
"" Clojure
NeoBundleLazy 'https://bitbucket.org/kotarak/vimclojure', {'type': 'hg'}
autocmd FileType clojure NeoBundleSource vimclojure
"" Haskell
"autocmd FileType haskell NeoBundle 'ujihisa/ref-hoogle'
NeoBundleLazy 'ujihisa/ref-hoogle'
autocmd FileType haskell NeoBundleSource ref-hoogle
"" JavaScript
NeoBundle 'vim-scripts/JSON.vim'
autocmd FileType javascript,json NeoBundleSource JSON.vim
"" Another
autocmd FileType nginx NeoBundleSource 'chase/nginx.vim'
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
