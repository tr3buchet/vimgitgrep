# vimgitgrep
plugin to add some custom grep commands for bouncing around a git repo in vim

# install
use [vundle](https://github.com/gmarik/Vundle.vim)

or copy contents of repo plugin directory to your vim plugins directory
```
cp plugin/gr3p.vim ~/.vim/plugin/
```

# configure
put something similar to the following in your `.vimrc`
```
nmap <silent> <F2> :call Gr3p()<cr>
nmap <silent> <F3> :call GitGr3p(0)<cr>
nmap <silent> <F4> :call ToggleLList()<cr>
nmap <silent> <A-Up> :lprevious<cr>
nmap <silent> <A-Down> :lnext<cr>
nmap <silent> <A-Left> :call GoBackSearch()<cr>
nmap <silent> <A-Right> :call GitGr3p(1)<cr>
```
