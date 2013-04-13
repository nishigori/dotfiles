" Vim syntax file
" Language:    xUnit
" Maintainer:  Takuya Nishigori <nishigori.tak@gmail.com>
" Last Change: 2011-12-18
" Remark: Included by the vimshell syntax.

" Note: This syntax file is other syntax superset for vim-quickrun.

if version < 700
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match

syntax match xUnitTestFailure /FAILURES.*/
syntax match xUnitTestSuccess /OK.*/

hi def link xUnitTestFailure ColorColumn
hi def link xUnitTestSuccess MatchParen


let b:current_syntax = 'xunit_quickrun'


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab:
