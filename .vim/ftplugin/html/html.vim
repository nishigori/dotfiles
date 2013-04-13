setlocal omnifunc=htmlcomplete#CompleteHTML

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

setlocal autoindent
setlocal smartindent

autocmd FileType html
  \ setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/



"  vim:set foldmethod=marker filetype=vim :
