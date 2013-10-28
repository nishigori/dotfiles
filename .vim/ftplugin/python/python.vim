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

" # PLUGIN
if !exists('g:my_config_use_plugin') || !g:my_config_use_plugin
  setlocal omnifunc=pythoncomplete#Complete
  finish
endif

" ## unite-ref {{{
nnoremap <silent> [unite]r :<C-u>Unite ref/pydoc<CR>
" }}}

