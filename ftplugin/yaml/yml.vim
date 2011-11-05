setlocal omnifunc=phpcomplete#CompletePHP

setlocal expandtab
setlocal autoindent
setlocal smartindent
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

let php_sql_query = 1      " 文字列中のSQLをハイライト
let php_htmlInStrings = 1  " 文字列中のHTMLをハイライトする

" ## unite-ref {{{
nnoremap <silent> ur :<C-u>Unite ref/phpmanual<CR>
" }}}
