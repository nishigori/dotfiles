" Basic
setlocal textwidth=80
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=0
setlocal expandtab

" Input
"" Plugin: smartchr
inoremap <expr> = smartchr#one_of(' = ', ' == ', '=', '==', ' = ')
inoremap <expr> # smartchr#one_of('# ', '#=> ', '#', '# ')
inoremap <expr> < smartchr#one_of('<', ' << ', '<<', '<')
inoremap <expr> > smartchr#one_of('>', ' => ', '=>')
inoremap <expr> ! smartchr#one_of('!', ' != ', ' !~ ', '!=', '!~','!')

" OMNI COMPLETE
"let g:rubycomplete_buffer_loading    = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails             = 1

" :h ruby
let g:ruby_fold            = 1
let g:ruby_no_comment_fold = 1
"let g:ruby_operators       = 1
let g:ruby_space_errors    = 1

" RubyLint
autocmd BufWritePost *.rb :call lint#ruby()
nmap ,l :call lint#ruby()<CR>

if !exists('g:my_config_use_plugin') || !g:my_config_use_plugin
  finish
endif

" Ref/refe
nnoremap <Leader> [unite]r :<C-u>Unite<Space>ref/refe -default-action=split<Cr>

