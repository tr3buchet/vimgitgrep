let s:search_locations = []

" add current position to g:search_locations
fun AddSearch()
    call add(s:search_locations, [expand('%:p'), getpos('.')])
endfun

" perform call and go to first result if found, open location list if multiple are found
fun DoSearch(grepcall)
    let l:findings = split(system(a:grepcall), '\n')
    if len(l:findings) > 0
        call AddSearch()
        silent lexpr l:findings
        if len(l:findings) > 1
            lopen
            wincmd p
        endif
    endif
endfun

" rgrep for word under cursor
fun Gr3p()
    let l:grepcall = 'grep -rn ' . expand('<cword>') . ' ./'
    call DoSearch(l:grepcall)
endfun

" if def git grep for class def or = definition of word under cursor
" if not def git grep for word under cursor
fun GitGr3p(def)
    let l:ecw = expand('<cword>')
    let l:gitroot = system('git rev-parse --show-toplevel')
    if v:shell_error
        echo "not a git repo"
        return 0
    endif
    if a:def
        let l:grepfor = '-e "class ' . l:ecw . '\(" --or -e "' . 'def ' . l:ecw . '\(" --or -e "^(\s*|.*\.)' . l:ecw . ' = "'
    else
        let l:grepfor = l:ecw
    endif
    let l:grepcall = 'git grep -E --full-name --line-number ' . l:grepfor
    execute "cd" l:gitroot
    call DoSearch(l:grepcall)
endfun

" return to previous search, if you are at the previous search already,
" return to the previous previous search
fun GoBackSearch()
    if len(s:search_locations) > 0
        let l:llactive = LListActive()
        if l:llactive    
            " location list is active, switch to regular window before starting
            wincmd p
        endif
        if s:search_locations[-1] == [expand('%:p'), getpos('.')]
            " we're in the same location as the last search, so move to older search
            call remove(s:search_locations, -1)
            if len(s:search_locations) > 0
                " move back to previous search
                silent lolder
            else
                " out of search locations, close list
                lclose
            endif
        endif
        if len(s:search_locations) > 0
            " go to the location of previous search
            let s:gotofile = s:search_locations[-1][0]
            execute "e" s:gotofile
            call setpos('.', s:search_locations[-1][1])
        endif
    endif
endfun

" check if location list is active
fun LListActive()
    redir => l:bufferslist | silent buffers | redir END
    let l:locationlistidx = stridx(l:bufferslist, 'Location List')
    let l:activeidx = stridx(l:bufferslist, '%a')
    return l:activeidx + 7 == l:locationlistidx
endfun

" check if location list is open
fun LListOpen()
    redir => bufferslist | silent buffers | redir END
    if stridx(bufferslist, 'Location List') == -1
        return 0
    else
        return 1
    endif
endfun

" close location list if open
" open location list if closed
fun ToggleLList()
   if LListOpen()
        lclose
    else
        lopen
    endif
endfun
