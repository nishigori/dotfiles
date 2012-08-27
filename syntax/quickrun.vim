if exists('b:current_syntax')
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'quickrun'
endif

syntax case ignore

" Python unittest {{{
syntax match ok /\s\(ok\|pass\(ed\|\>\)\)/
syntax match fail /fail\(s\|ed\|ures!\|ures\|ure\|:\|\>\)/
syntax match errors /^error\|\.\serror/
syntax match assert /assertionerror:/
syntax match pyendpass /\s(\d\+\s\(tests\|test\)\spassed)/
syntax match pyendfail /\d\+\s\(failed\(,\|\>\)\|error\)/

highlight ok ctermfg=DarkGreen guifg=DarkGreen guibg=White
highlight fail ctermfg=DarkRed guifg=DarkRed guibg=White
highlight errors ctermfg=DarkRed guifg=DarkRed guibg=White
highlight assert ctermfg=DarkRed guifg=DarkRed guibg=White

highlight pyendpass ctermfg=DarkGreen guifg=DarkGreen guibg=White
highlight pyendfail ctermfg=DarkRed guifg=DarkRed guibg=White
" }}}
"
" PHP {{{
syntax match phpendpass /(\d\+\stest,\s\d\+\sassertion)/
syntax match phpendfail /tests:\s\d\+,\sassertions:\s\d\+,\s\(failures\|errors\):\s\d\+\(,\s\(failures\|errors\):\s\d\+.\|.\)/

highlight phpendpass ctermfg=DarkGreen guifg=DarkGreen guibg=White
highlight phpendfail ctermfg=DarkRed guifg=DarkRed guibg=White
highlight phpbarok ctermfg=DarkGreen guifg=DarkGreen guibg=White
highlight phpbarfail ctermfg=DarkRed guifg=DarkRed guibg=White
" }}}

" Perl {{{
syntax match plendfail /\(^result:\sfail\|^failed\s\d\+\/\d\+\ssubtests\|^#\sLooks\slike\syou\sfailed\s\d\+\stest\sof\s\d\+\.\)/
syntax match plendpass /\(^result:\spass\|^all\stests\ssuccessful\.\)/

highlight plendpass ctermfg=DarkGreen guifg=DarkGreen guibg=White
highlight plendfail ctermfg=DarkRed guifg=DarkRed guibg=White
highlight plfailstatus ctermfg=DarkRed guifg=DarkRed guibg=White
" }}}


" unlet b:current_syntax
let b:current_syntax = 'quickrun'

if main_syntax == 'quickrun'
  unlet main_syntax
endif
