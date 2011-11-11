" Note: This script is first impression Vim.
"       Automatically prepares a configuration that is required.
"       If anyone want to call this script, please hit code on Vim.
"           :source {$directory}/startup.vim

let b:need_directories = {
      \ 'home_tmpdir' : $HOME . '/tmp',
      \ 'vim_tmpdir'  : $HOME . '/tmp/vim',
      \ 'swapdir'     : $HOME . '/tmp/vim/swaps',
      \ 'backupdir'   : $HOME . '/tmp/vim/backups',
      \ 'viewdir'     : $HOME . '/tmp/vim/view',
      \ 'undo'        : $HOME . '/tmp/vim/undo',
      \ 'unite'       : $HOME . '/tmp/vim/unite',
      \ 'neocom'      : $HOME . '/tmp/vim/neocom',
      \ }

for [key, dir] in items(b:need_directories)
  if !isdirectory(dir)
    " FUTURE: When account has no permission, echo error.
    call mkdir(dir)
  endif
endfor


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
