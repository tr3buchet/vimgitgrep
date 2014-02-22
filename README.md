# vimgitgrep
this is my first go on a vim plugin, so let me know if I did anything silly. I wanted something that worked like ctags to dig into functions and subfunctions and what not for code exploration, but having to keep a ctags index up to date. it's useful if you want to find where a python word is defined or find all occurrences of a word. so far only searching for python definitions is supported. the general git grep and grep functionality will work for anything though.

# install
use [vundle](https://github.com/gmarik/Vundle.vim)

or copy contents of repo plugin directory to your vim plugins directory
```
cp plugin/gr3p.vim ~/.vim/plugin/
```

# configure
put something similar to the following in your `.vimrc`, using whatever keys make you happy
```
nmap <silent> <F2> :call Gr3p()<cr>
nmap <silent> <F3> :call GitGr3p(0)<cr>
nmap <silent> <F4> :call ToggleLList()<cr>
nmap <silent> <A-Up> :lprevious<cr>
nmap <silent> <A-Down> :lnext<cr>
nmap <silent> <A-Left> :call GoBackSearch()<cr>
nmap <silent> <A-Right> :call GitGr3p(1)<cr>
```

# functions
##### `GitGr3p(0)`
perform a fairly standard `git grep` of word under cursor setting vim's current working directory to the repo root.

##### `GitGr3p(1)`
perform a `git grep` looking for Python definitions of word under cursor and ignoring the rest and setting vim's current working directory to the repo root. this is the ctags style functionality.

Example matches with `flibbertigibbet` under the cursor.
```
class flibbertigibbet(object):
def flibbertigibbet(self, doge):
flibbertigibbet = 'doge'
self.flibbertigibbet = 'doge'
obj.flibbertigibbet = 'doge'
```

##### `Gr3p()`
perform a standard recursive `grep` from the current vim's working directory.

##### `GoBackSearch()`
return to the location of the previous search. if cursor is already at the location of the previous search, it will return to the search before and restore the search list as well. using this you can return to the location of your original search.

##### `ToggleLList()`
open or close the location list of results depending on its current state
