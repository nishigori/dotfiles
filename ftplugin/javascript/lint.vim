"# Closure Linter
" INFO:
"   - Google JavaScript Style Guide
"   -- http://google-styleguide.googlecode.com/svn/trunk/javascriptguide.xml
"   - Closure Linter
"   -- http://code.google.com/intl/ja/closure/utilities/docs/linter_howto.html
" INSTALL:
"   - Mac
"   -- $ sudo (pip|easy_install) install http://closure-linter.googlecode.com/files/closure_linter-latest.tar.gz
let g:gjslint_path = '/usr/local/bin/gjslint'
" use: vim-quickrun
let g:quickrun_config['javascript'] = { 'command' : g:gjslint_path }
"setlocal makeprg=
"setlocal errorformat=
autocmd! BufWritePost *.js :call ClosureLint()
function! ClosureLint()
  let result = system(g:gjslint_path .' '. expand('%:p'))
  echo result
endfunction

"# jslint.vim
" INFO:
"   - jslint.vim
"   -- https://github.com/hallettj/jslint.vim.git
"   - JavaScript interpreter
"   -- It's needed JS interpreter (SpiderMoney|Rhino|node.js)

" let g:JSLintHighlightErrorLine = 0
" function! s:javascript_filetype_settings()
"   autocmd BufLeave     <buffer> call jslint#clear()
"   autocmd BufWritePost <buffer> call jslint#check()
"   autocmd CursorMoved  <buffer> call jslint#message()
" endfunction
" autocmd FileType javascript call s:javascript_filetype_settings()
