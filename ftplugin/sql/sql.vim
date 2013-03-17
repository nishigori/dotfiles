let g:quickrun_config = get(g:, 'quickrun_config', {})
"let g:quickrun_config['sql'] =
  "\ 'command' : 'mysql',
  "\ 'exec'    : ['%c %o < %s'],
  "\ 'cmdopt'  : '%{MakeMySQLCommandOptions()}',
  "\ }

" gist: 1527068
function! MakeMySQLCommandOptions() " {{{
  let g:mysql_config_host = get(g:, 'mysql_config_host', input('host> '))
  let g:mysql_config_port = get(g:, 'mysql_config_port', input('port> '))
  let g:mysql_config_user = get(g:, 'mysql_config_user', input('user> '))
  let g:mysql_config_pass = get(g:, 'mysql_config_pass', inputsecret('password> '))
  let g:mysql_config_db   = get(g:, 'mysql_config_db',   input('database> '))

  let options = []
  if !empty(g:mysql_config_user)
    call add(options, '-u ' . g:mysql_config_user)
  endif
  if !empty(g:mysql_config_host)
    call add(options, '-h ' . g:mysql_config_host)
  endif
  if !empty(g:mysql_config_pass)
    call add(options, '-p' . g:mysql_config_pass)
  endif
  if !empty(g:mysql_config_port)
    call add(options, '-P ' . g:mysql_config_port)
  endif
  "if !empty(g:mysql_config_otheropts)
    "call add(options, g:mysql_config_otheropts)
  "endif

  call add(options, g:mysql_config_db)
  return join(options, ' ')
endfunction " }}}
