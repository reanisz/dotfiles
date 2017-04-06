if &compatible
    set compatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:toml_path = fnamemodify(expand('<sfile>'), ':h')

if dein#load_state(expand('~/.cache/dein/'))
    call dein#begin(expand('~/.cache/dein/'))

    call dein#load_toml(s:toml_path.'/dein.toml')
    if has('nvim')
        call dein#load_toml(s:toml_path.'/dein-nvim.toml')
    else
        call dein#load_toml(s:toml_path.'/dein-vim.toml')
    endif

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
