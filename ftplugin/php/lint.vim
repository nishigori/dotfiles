" PHP Lint
" Syntax check. cmd :make
"setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
autocmd BufWritePost *.php :call PHPLint()
nnoremap <silent> ,l :call PHPLint()<CR>
function! PHPLint() "{{{
  if &filetype != 'php'
    return
  endif
  let result   = system('php -l ' . expand('%:p'))
  let headPart = strpart(result, 0, 32)
  if headPart !~ 'No syntax errors'
    echo headPart
  endif
endfunction "}}}
