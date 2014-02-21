vimgitgrep
==========

plugin to add some custom grep commands for bouncing around a git repo in vim


configure
==========
nmap <silent> <F2> :call Gr3p()<cr>
nmap <silent> <F3> :call GitGr3p(0)<cr>
nmap <silent> <F4> :call ToggleLList()<cr>
nmap <silent> <A-Up> :lprevious<cr>
nmap <silent> <A-Down> :lnext<cr>
nmap <silent> <A-Left> :call GoBackSearch()<cr>
nmap <silent> <A-Right> :call GitGr3p(1)<cr>
