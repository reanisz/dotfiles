"英和辞書
command! -nargs=1 EDict :echo system("edict -v '<args>'")

nnoremap <C-K> :EDict <C-R><C-W><CR>
nnoremap ,<C-K> :EDict <C-R><C-W>

vnoremap <C-K> "wy:EDict <C-R>w<CR>
vnoremap ,<C-K> "wy:EDict <C-R>w

