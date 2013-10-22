setlocal omnifunc=phpcomplete#CompletePHP

setlocal expandtab
setlocal autoindent
setlocal smartindent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=0

let g:php_sql_query = 1      " 文字列中のSQLをハイライト
let g:php_htmlInStrings = 1  " 文字列中のHTMLをハイライトする

if !exists('g:my_config_use_plugin') || !g:my_config_use_plugin
  finish
endif

" ## unite-ref {{{
nnoremap <silent> [unite]r :<C-u>Unite ref/phpmanual<CR>
" }}}
