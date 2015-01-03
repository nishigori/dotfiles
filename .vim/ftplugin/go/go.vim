setlocal noexpandtab

auto BufWritePre *.go Fmt

augroup GoFmt
  autocmd!
  autocmd BufWritePre *.go Fmt
augroup END
