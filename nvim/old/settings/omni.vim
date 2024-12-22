set completeopt=menu,preview,menuone " 補完表示設定

" TabでOmni補完及びポップアップメニューの選択
function InsertTabWrapper(is_shift)
    if pumvisible()
        return a:is_shift ? "\<C-p>" : "\<C-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ 'k|<|/' " htmlで補完できるように<,/でもOmni補完
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return a:is_shift ? "\<C-p>" : "\<C-n>"
    else
        return "\<C-x>\<C-o>"
    endif
endfunction

inoremap <tab> <C-r>=InsertTabWrapper(0)<CR>
" Shift-Tabはうまくいかないようだ
inoremap <S-tab> <C-r>=InsertTabWrapper(1)<CR>

function OmniCancelEsc()
    return pumvisible() ? "\<C-e>" : "\<esc>"
endfunction

" inoremap <esc> <C-r>=OmniCancelEsc()<CR>

function Omnijk(key)
    if !pumvisible()
        return a:key == "j" ? "\<C-j>" : "\<C-k>"
    endif
    return a:key=="j" ? "\<C-n>" : "\<C-p>"
endfunction

inoremap <C-j> <C-r>=Omnijk("j")<CR>
inoremap <C-k> <C-r>=Omnijk("k")<CR>

" 補完
function OmniNul()
    return "\<C-n>"
    if !pumvisible()
        return "\<C-n>\<C-p>"
    endif
    return "\<C-n>"
endfunction

inoremap <Nul> <C-r>=OmniNul()<CR>

" CRでOmni確定
function InsertCrWrapper()
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" inoremap <CR> <C-r>=InsertCrWrapper()<CR>

autocmd InsertCharPre * :call Omnijk("j")
