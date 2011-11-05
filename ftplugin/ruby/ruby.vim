" OMNI COMPLETE
let g:rubycomplete_buffer_loading  =  1
let g:rubycomplete_classes_in_global  =  1
let g:rubycomplete_rails  =  1

" :h ruby
let ruby_fold = 1
let ruby_no_comment_fold = 1
let ruby_operators  =  1
let ruby_space_errors = 1

" RubyLint
autocmd BufWritePost *.rb :call RubyLint()
nmap ,l :call RubyLint()<CR>

function RubyLint()
	let result  =  system( &ft . ' -c ' . bufname(""))
	echo result
endfunction
