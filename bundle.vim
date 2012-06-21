" Bundle
set nocompatible           " be iMproved
filetype plugin indent off " required!!
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
" unite source {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'h1mesuke/unite-outline'
"NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'mattn/unite-nyancat'
NeoBundle 'mattn/unite-advent_calendar'
NeoBundle 'mattn/unite-remotefile'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'pasela/unite-webcolorname'
" }}}
" buffer, tag {{{
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Shougo/vimshell'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/current-func-info.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/TagHighlight'
NeoBundle 'sudo.vim'
"NeoBundle 'Shougo/echodoc'
" }}}
" syntax {{{
" TODO: edit a php syntastic
"NeoBundle 'scrooloose/syntastic' " auto syntax checker
" }}}
" complete, snippet {{{
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'thinca/vim-ambicmd'
NeoBundle 'mattn/salaryman-complete-vim'
NeoBundle 'neco-look'
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
NeoBundle 'vim-scripts/Align'
NeoBundle 'h1mesuke/vim-alignta'
"NeoBundle 'tyru/operator-star.vim'
" NOTE: yankring dependence suck key map.
"       using unite history/yank
"NeoBundle 'richleland/vim-yankring'
" }}}
" marks {{{
"NeoBundle 'vim-scripts/ShowMarks'
"NeoBundle 'vim-scripts/number-marks'
" }}}
" color sheme & font {{{
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
NeoBundle 'vim-scripts/darkZ'
NeoBundle 'vim-scripts/pyte'
NeoBundle 'vim-scripts/github-theme'
NeoBundle 'vim-scripts/Atom'
NeoBundle 'vim-scripts/Gravity'
" }}}
" browse {{{
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/urilib.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'basyura/TweetVim'
" evervim 重すぎ
"NeoBundle 'kakkyz81/evervim.git'
" }}}
" VCS {{{
NeoBundle 'Shougo/vim-vcs'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/gist-vim'
NeoBundle 'vim-scripts/gitv'
"NeoBundle 'thinca/vim-ft-svn_diff'
" }}}
" DB {{{
NeoBundle 'mattn/vdbi-vim'
" INFO: dbext.vim' latest version is into the vim.org.
"       http://vim.sourceforge.net/scripts/script.php?script_id=356
"NeoBundle 'vim-scripts/dbext.vim'
"NeoBundle 'xenoterracide/sql_iabbr'
" }}}
" debug, backend {{{
if has('python')
  NeoBundle 'vim-scripts/Gundo'
endif
NeoBundle 'Shougo/vimproc'
"NeoBundle 'ujihisa/vital.vim'
" }}}
" ref, help {{{
NeoBundle 'thinca/vim-ref'
" }}}
" filetype {{{
"" HTML
NeoBundle 'othree/html5.vim'
"" CSS
NeoBundle 'vim-scripts/css3'
"" Markdown
NeoBundle 'mattn/mkdpreview-vim'
"" JavaScript
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'basyura/jslint.vim'
NeoBundle 'soh335/vim-ref-jquery'
"" PHP
NeoBundle 'arnaud-lb/vim-php-namespace'
NeoBundle 'beyondwords/vim-twig'
"" Ruby
" need ruby-debug-ide19
" $ gem install ruby-debug-ide19
"NeoBundle 'astashov/vim-ruby-debugger'
autocmd FileType ruby
  \ NeoBundleSource 'vim-scripts/rails.vim'
"" Python
NeoBundle 'vim-scripts/python.vim--Vasiliev'
NeoBundle 'jtriley/vim-rst-headings'
"" Clojure
autocmd FileType clojure
  \ NeoBundleSource 'https://bitbucket.org/kotarak/vimclojure', {'type': 'hg'}
"" JavaScript
NeoBundle 'vim-scripts/JSON.vim'
"" Vim
NeoBundle 'dsummersl/vimunit'
"" Another
NeoBundle 'chase/nginx.vim'
" }}}
" Utility {{{
" FIXME: vim-template, そのうち使う
"NeoBundle 'thinca/vim-template'
NeoBundle 'vim-scripts/Headlights'
NeoBundle 'vim-scripts/copypath.vim'
NeoBundle 'mattn/calendar-vim'
NeoBundle 'vim-scripts/submode'
NeoBundle 'mattn/learn-vimscript'
NeoBundle 'mattn/salaryman-complete-vim'
NeoBundle 'thinca/vim-openbuf' " depends vim-vcs
" }}}
" My Plugins {{{
NeoBundle 'nishigori/vim-symfony'
NeoBundle 'nishigori/vim-multiple-switcher'
NeoBundle 'nishigori/vim-sunday'
NeoBundle 'nishigori/vim-php-dictionary'
NeoBundle 'nishigori/vim-php-cs-fixer'
NeoBundle 'nishigori/unite-sf2'
NeoBundle 'nishigori/phpfolding.vim'
NeoBundle 'nishigori/neocomplcache-phpunit-snippet'
NeoBundle 'nishigori/neocomplcache-nginx-snippet'
" Beta
"NeoBundle 'nishigori/vim-phpunit-snippets'
"NeoBundle 'nishigori/vim-twig-matchit'
" }}}

filetype plugin indent on " required!
