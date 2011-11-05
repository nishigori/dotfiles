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
      \ }

for [key, value] in items(b:need_directories)
  if !isdirectory(value)
    " FUTURE: When account has no permission, echo error.
    call mkdir(value)
  endif
endfor

" Note: そもそもsymbolic linksは他のスクリプトでいい気がする。。。
"       git cloneも含め、ね

"let b:need_symbolic_links = {
      "\ 'vimrc'   : $HOME . '',
      "\ 'gvimrc'  : $HOME . ''
      "\ 'vimshrc' : $HOME . '',
      "\ 'gtd_dir' : $HOME . '/Dropbox/.gtd',
      "\ }

"let b:rc_local_list = {
      "\ 'vimrc.local'  : $HOME . '/workspace/dotfiles/.vimrc.local.sample',
      "\ 'gvimrc.local' : $HOME . '/workspace/dotfiles/.gvimrc.local.sample',
      "\ }


" TODO: VimScript上でshellコマンド使う方法を調べる
"       has('win32') の処理も付け加える
"       git clone 'nishigori/dotfiles'
"       add Vundle plugin


" vim:set fdm=marker ts=2 sw=2 sts=0 expandtab filetype=vim:
