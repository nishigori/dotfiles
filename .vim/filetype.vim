augroup FiletypeDetect
  " setfiletype:  different settings and syntax files to be loaded
  " set filetype: overwrite
  au! BufRead,BufNewFile *.md         setfiletype markdown
  au! BufRead,BufNewFile *.json*      setfiletype json
  au! BufRead,BufNewFile *.mine       setfiletype mine
  au! BufRead,BufNewFile *.xyz        setfiletype drawing
  au! BufRead,BufNewFile *.tt         setfiletype html
  au! BufRead,BufNewFile *.txt        setfiletype txt
  au! BufRead,BufNewFile *.xml.*      setfiletype xml
  au! BufRead,BufNewFile *.php*       setfiletype php
  au! BufRead,BufNewFile *.go         setfiletype go
  au! BufRead,BufNewFile *.phl        setfiletype php.html
  au! BufRead,BufNewFile *.pht        setfiletype php.html
  au! BufRead,BufNewFile *.md.*       set filetype=markdown
  au! BufRead,BufNewFile *.gradle     set filetype=groovy
  au! BufRead,BufNewFile *.snip*      set filetype=snippet
  au! BufRead,BufNewFile *Test.php    set filetype=phpunit.php
  au! BufRead,BufNewFile *.json.twig  set filetype=json.twig
  au! BufRead,BufNewFile *.html.twig  set filetype=html.twig
  au! BufRead,BufNewFile Capfile      set filetype=ruby
  au! BufRead,BufNewFile Gemfile      set filetype=ruby
  au! BufRead,BufNewFile Guardfile    set filetype=ruby
  au! BufRead,BufNewFile Vagrantfile  set filetype=ruby
  "au! BufRead,BufNewFile,BufWinEnter *sikuli/*.py setfiletype python.sikuli
  au! BufRead,BufNewFile */nginx/*,*nginx.conf    setfiletype nginx
  au! BufRead,BufNewFile /etc/httpd/conf/*,/etc/httpd/conf.d/*,/etc/apache/*,*.conf setfiletype apache
  au! BufRead,BufNewFile *vimperatorrc*,*.vimp   setfiletype vimperator
  au! BufRead,BufNewFile *muttatorrc*,*.muttator setfiletype muttator
  au! BufRead,BufNewFile */bundle/*/doc/*        setfiletype help
augroup END
