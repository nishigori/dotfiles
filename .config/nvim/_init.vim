if exists('g:vscode')
  source ~/.config/nvim/vscode.vim
else
  source ~/.vimrc
endif

highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {
      'ruby',
      'toml',
      'c_sharp',
      'vue',
    }
  },
  indent = {
    enable = true
  }
}
EOF
