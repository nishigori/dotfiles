setlocal omnifunc=phpcomplete#CompletePHP

" Basic {{{
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal foldlevelstart=2      " open buffer's foldlevel

let g:php_sql_query = 1           " highlight SQL into the strings
let g:php_htmlInStrings = 1       " highlight HTML into the strings
"let g:php_folding = 1             " enable folding of Class & function
let g:php_parent_error_close = 1  " highlight error compatible [], ()
"let php_noShortTags = 1         " disable PHP's short tag

inoremap <C-r><C-r> PHP_EOL
" }}}
" Linter {{{
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
"autocmd BufWritePost *.php :call lint#php()
nnoremap <silent> ,l :call lint#php()<CR>
" Syntax check. cmd :make
"setlocal makeprg=php\ -l\ %
" }}}

" Add semicolon for line end
function! IsEndSemicolon()  "{{{
  let c = getline(".")[col("$")-2]
  if c != ';'
    return 1
  else
    return 0
  endif
endfunction "}}}
inoremap <expr>;; IsEndSemicolon() ? "<C-O>$;<CR>" : "<C-O>$<CR>"

" Array literal complete Vim-users.jp Hack#156
" FEATURE: PHP5.4.x~ is enable using Array literal.
inoremap <buffer><expr> [ <SID>php_smart_bracket(<SID>last_char())
inoremap <buffer><expr> ] smartchr#one_of(']', ')')
function! s:last_char() "{{{
  return matchstr(getline('.'), '.', col('.')-2)
endfunction "}}}
function! s:php_smart_bracket(last_char) "{{{
  if a:last_char == '['
    return "\<BS>("
  elseif a:last_char =~ '\w\|]'
    return '[]'
  else
    return 'array()'
  endif
endfunction "}}}

" Plugin: unite-ref
nnoremap <silent> <Leader>ur :<C-u>Unite ref/phpmanual<CR>

" Plugin: smartchr
inoremap <expr> = smartchr#one_of('=', ' = ', ' === ', ' == ')
inoremap <expr> > smartchr#one_of('>', ' => ', '=>')
inoremap <expr> ! smartchr#one_of('!', ' !== ', ' != ', '!')


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
