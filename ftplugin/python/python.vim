setlocal omnifunc=pythoncomplete#Complete
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"setlocal encoding=utf-8
setlocal textwidth=80
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal smarttab
setlocal nosmartindent
setlocal commentstring=\ #\ %s
"setlocal foldlevel=0

let g:python_highlight_all = 1

"nnoremap <F12> :!/usr/lib/python2.4/pdb.py %<CR>
autocmd BufWritePost *.py :call lint#python()

" # PLUGIN
" ## unite-ref {{{
nnoremap <silent> ,R :<C-u>Unite ref/pydoc<CR>
" }}}

