if &compatible
    set compatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'

if dein#load_state(expand('~/.cache/dein/'))
    call dein#begin(expand('~/.cache/dein/'))

    call dein#load_toml(s:toml_file)

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
