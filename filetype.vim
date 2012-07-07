augroup filetypedetect
  au! BufRead,BufNewFile *.md*        setfiletype markdown
  au! BufRead,BufNewFile *.json       setfiletype json
  au! BufRead,BufNewFile *.mine       setfiletype mine
  au! BufRead,BufNewFile *.xyz        setfiletype drawing
  au! BufRead,BufNewFile *.tt         setfiletype html
  au! BufRead,BufNewFile *.txt        setfiletype txt
  au! BufRead,BufNewFile *.phl        setfiletype php.html
  au! BufRead,BufNewFile *.pht        setfiletype php.html
  "au! BufRead,BufNewFile *.twig       setfiletype twig
  au! BufRead,BufNewFile *.twig       set ft=html.twig
  au! BufRead,BufNewFile *Test.php    set ft=php.phpunit
  "au! BufRead,BufNewFile,BufWinEnter *sikuli/*.py setfiletype python.sikuli
  au! BufRead,BufNewFile */nginx/*,*nginx.conf    setfiletype nginx
  au! BufRead,BufNewFile /etc/httpd/conf/*,/etc/httpd/conf.d/*,/etc/apache/*,*.conf
        \ setfiletype apache
  au! BufRead,BufNewFile *vimperatorrc*,*.vimp   setfiletype vimperator
  au! BufRead,BufNewFile *muttatorrc*,*.muttator setfiletype muttator
  au! BufRead,BufNewFile */bundle/*/doc/*        setfiletype help
augroup END
