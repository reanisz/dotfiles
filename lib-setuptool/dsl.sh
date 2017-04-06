#!/bin/sh

exec_cmd(){
    if [ $print_cmd = 1 ] ; then
        echo -e "\e[36m$@\e[m"
    fi
    if [ $dry_run != 1 ] ; then
        eval $@
    fi
}

warning(){
    printf "\033[33mWarning: $@\033[m\n"
}

error(){
    printf "\033[31mError: $@\033[m\n"
}

note(){
    printf "\033[34mNote: $@\033[m\n"
}

init_target(){
    target_name=$1
    setup_targets+=( $target_name )
}

make_symlink(){
    from=$dotfiles_root/$1
    to=$home_root/$2
    if [ ! -f $to -a ! -L $to ] ; then
        exec_cmd ln -s $from $to
    else
        if [ "$force_exec" = 1 ] ; then
            warning "$to is already exists."
            exec_cmd rm $to
            exec_cmd ln -s $from $to
        else
            error "$to is already exists."
        fi
    fi
}
remove_symlink(){
    from=$dotfiles_root/$1
    to=$home_root/$2
    if [ -L $to ] ; then
        exec_cmd rm $to
    else
        if [ "$force_exec" = 1 ] ; then
            warning "$to is not symbolic-link."
            exec_cmd rm $to
        else
            error "$to is not symbolic-link."
        fi
    fi
}

make_copy(){
    from=$dotfiles_root/$1
    to=$home_root/$2
    if [ ! -f $to ] ; then
        exec_cmd cp $from $to
    else
        if [ "$force_exec" = 1 ] ; then
            warning "$to is already exists."
            exec_cmd cp $from $to
        else
            error "$to is already exists."
        fi
    fi
}

remove_copy(){
    from=$dotfiles_root/$1
    to=$home_root/$2
    if diff -q $from $to >/dev/null ; then
        exec_cmd rm $to
    else
        if [ "$force_exec" = 1 ] ; then
            warning "$to is different from $from."
            exec_cmd rm $to
        else
            error "$to is different from $from."
        fi
    fi
}

make_file(){
    to=$home_root/$1
    if [ ! -f $to ] ; then
        exec_cmd touch $to
    else
        note "file $to is already exists."
    fi
}

remove_file(){
    to=$home_root/$1
    # Nothing to do
}

make_directory(){
    to=$home_root/$1
    if [ ! -d $to ] ; then
        exec_cmd mkdir -p $to
    else
        note "directory $to is already exists."
    fi
}

remove_directory(){
    to=$home_root/$1
    # Nothing to do
}

symlink(){
    case $command in
        setup)
            eval make_symlink $1 $2
            ;;
        clean)
            eval remove_symlink $1 $2
            ;;
        *)
            ;;
    esac
}
copy(){
    case $command in
        setup)
            eval make_copy $1 $2
            ;;
        clean)
            eval remove_copy $1 $2
            ;;
        *)
            ;;
    esac
}
file(){
    case $command in
        setup)
            eval make_file $1 $2
            ;;
        clean)
            eval remove_file $1 $2
            ;;
        *)
            ;;
    esac
}
directory(){
    case $command in
        setup)
            eval make_directory $1 $2
            ;;
        clean)
            eval remove_directory $1 $2
            ;;
        *)
            ;;
    esac
}

