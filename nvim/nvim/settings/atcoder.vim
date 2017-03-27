function! Test(file)
    let bufname = "TEST-RESULT-" . a:file
    let bn = bufwinnr(bufnr(l:bufname))
    if bn == -1
        new 
        setlocal buftype=nofile
        setlocal noswapfile
        setlocal bufhidden=wipe
        exec("file! " . l:bufname)
    else
        exec(l:bn . "wincmd w")
        exec("%delete")
    endif
    let result = system("atcoder test " . a:file)
    call append('.', split(l:result, '\n'))
endfunction

function! Submit(file)
    let result = system("atcoder submit " . a:file)
    echo "done."
endfunction

command Test :call Test(expand("%:r"))
nnoremap Q :<C-u>Test <CR>

command Submit :call Submit(expand("%:r"))

