setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

auto BufWritePre *.go Fmt

augroup GoFmt
  autocmd!
  autocmd BufWritePre *.go Fmt
augroup END
