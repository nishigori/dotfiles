" first set path
setlocal path+=**

if !exists('g:my_config_use_plugin') || !g:my_config_use_plugin
  finish
endif

let g:neocomplcache_vim_completefuncs =
  \ get(g:, 'neocomplcache_vim_completefuncs', {})
"let g:neocomplcache_vim_completefuncs.Symfony = 'symfony#complete'

" TODO: available for vimfiler
" TODO: available @Template annnotation
" jump to a twig view in symfony
function! s:SfJumpToView()
    mark C
    normal! ]M
    let end = line(".")
    normal! [m
    try
        call search('\v[^.:]+\.html\.twig', '', end)
        normal! gf
    catch
        normal! g`C
        echohl WarningMsg | echomsg "Template file not found" | echohl None
    endtry
endfunction
com! SfJumpToView call s:SfJumpToView()

" create a mapping only in a Controller file
autocmd BufEnter *Controller.php nmap <buffer><leader>v :SfJumpToView
