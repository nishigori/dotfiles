setlocal omnifunc=javascriptcomplete#CompleteJS

setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0

"" imspire kana@TimeInterMedia Corp.
"setlocal conceallevel=2
"syntax keyword javaScriptLambda function conceal cchar=λ
highlight clear Conceal
highlight link Conceal Identifier
highlight link javaScriptLambda Identifier

" taglist.vim
if has('path_extra')
  " JavaScriptの表示対象を変更
  let g:tlist_javascript_settings = 'javascript;c:class;m:method;f:function'
endif


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
