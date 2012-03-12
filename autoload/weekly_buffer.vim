function! weekly_buffer#open()
  execute '7new ' . get(g:, 'weekly_buffer', weekly_buffer#getBuffer())
endfunction

" TODO: command使ってWinHeight引数で指定する処理を入れたい、かも
"       function! s:open_weekly_buffer()
"       command! -nargs=1 OpenweeklyBuffer call s:open_weekly_buffer(<q-args>)
function! weekly_buffer#getBuffer() "{{{
  let today = strftime('%Y%m%d')
  let day_of_week = strftime('%w')  " Son. = 0, Mon. = 1, Tue. = 2 ...
  if day_of_week == 0 || day_of_week == 6
    let start_week = today - day_of_week + 1
    let end_week   = today - day_of_week + 5
  else
    " FIXME: たぶん土日は何か変えたかったのかな？
    let start_week = today - day_of_week + 1
    let end_week   = today - day_of_week + 5
  endif

  return g:local_config['weekly_buffer_dir'] .'/'. start_week .'_'. end_week
endfunction "}}}
