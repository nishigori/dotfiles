function! lint#ruby() " {{{
  let ruby_bin = get(g:, 'ruby_bin', 'ruby')
  let result = system( ruby_bin . ' -c ' . bufname(''))
  if result !~ 'Syntax OK'
    echo result
  endif
endfunction " }}}
function! lint#php() "{{{
  let result   = system('php -l ' . expand('%:p'))
  let result = strpart(result, 0, 32)
  if result !~ 'No syntax errors'
    echo result
  endif
endfunction "}}}
function! lint#js_closure() "{{{
  let cmd = get(g:, 'gjslint_path', system('which gjslint'))
  if cmd !~ 'not found'
    echo system(cmd . ' ' . expand('%:p'))
  endif
endfunction "}}}
function! lint#python() "{{{
  let cmd = get(g:, 'python_path', system('which python'))
  if cmd !~ 'not found'
    echo system(cmd . ' ' . expand('%:p'))
  endif
endfunction " }}}
function! lint#python3() "{{{
  if !exists('g:python3_path')
    echo system(cmd . ' ' . expand('%:p'))
  endif
endfunction "}}}


" vim:set fdm=marker:
