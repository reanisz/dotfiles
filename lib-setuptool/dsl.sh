#!/bin/sh

echo_indent=0

push_indent(){
    echo_indent=$(( echo_indent + 1 ))
}
pop_indent(){
    echo_indent=$(( echo_indent - 1 ))
}

echo_indent(){
    local i="$echo_indent"
    while [[ $i != 0 ]]
    do
        echo -n "  "
        i=$(( i - 1 ))
    done
}

exec_cmd(){
    if [ $print_cmd = 1 ] ; then
        echo_cmd "$@"
    fi
    if [ $dry_run != 1 ] ; then
        eval "$@"
    fi
}

echo_msg(){
    echo_indent
    echo "$@"
}

echo_cmd(){
    echo_indent
    printf "\033[36m"
    echo -n $@
    printf "\033[m\n"
}

warning(){
    echo_indent
    printf "\033[33mWarning: $@\033[m\n"
}

error(){
    echo_indent
    printf "\033[31mError: $@\033[m\n"
}

note(){
    echo_indent
    printf "\033[34mNote: $@\033[m\n"
}

debug(){
    echo_indent
    printf "\033[32mDebug: $@\033[m\n"
}

init_target(){
    target_name="$1"
    setup_targets+=( $target_name )
}

warn_or_error(){
    if [[ "$force_exec" = 1 ]] ; then
        warning "$@"
    else
        error "$@"
    fi
}

make_symlink(){
    local from="$dotfiles_root/$1"
    local to="$home_root/$2"

    local allow_exec=1
    local overwrite=0

    if [[ -L "$to" ]] ; then
        local link=`readlink $to`
        if [[ "$link" = "$from" ]] ; then
            note "symlink $to is already exists."
            allow_exec=0
        else
            if [ "$force_exec" = 1 ] ; then
                overwrite=1
                exec_cmd rm "$to"
            else
                error "cannot make symlink at $to. (already exists some symlink)"
                allow_exec=0
            fi
        fi
    elif [[ -f "$to" ]] ; then
        if [ "$force_exec" = 1 ] ; then
            overwrite=1
            exec_cmd rm "$to"
        else
            error "cannot make symlink at $to. (already exists some file)"
            allow_exec=0
        fi
    fi
    if [[ "$allow_exec" = 1 ]] ; then
        if [[ "$overwrite" = 1 ]] ; then
            warning "$to is over written."
        fi
        exec_cmd ln -s "$from" "$to"
    fi
}
remove_symlink(){
    local from="$dotfiles_root/$1"
    local to="$home_root/$2"
    local invalid=0

    if [[ -L "$to" ]] ; then
        local link=`readlink $to`
        if [[ "$link" != "$from" ]] ; then
            invalid=1
        fi
    elif [[ -f "$to" ]] ; then
        invalid=1
    fi
    if [[ "$invalid" = 1 ]] ; then
        warn_or_error "$to is invalid."
    fi
    if [[ "$invalid" = 0 || "$force_exec" = 1 ]] ; then
        exec_cmd rm "$to"
    fi
}

make_copy(){
    local from="$dotfiles_root/$1"
    local to="$home_root/$2"
    if [ ! -f "$to" ] ; then
        exec_cmd cp "$from" "$to"
    else
        if [ "$force_exec" = 1 ] ; then
            warning "$to is already exists."
            exec_cmd cp "$from" "$to"
        else
            error "$to is already exists."
        fi
    fi
}

remove_copy(){
    local from="$dotfiles_root/$1"
    local to="$home_root/$2"
    if diff -q "$from" "$to" >/dev/null ; then
        exec_cmd rm "$to"
    else
        if [ "$force_exec" = 1 ] ; then
            warning "$to is different from $from."
            exec_cmd rm "$to"
        else
            error "$to is different from $from."
        fi
    fi
}

make_file(){
    local to="$home_root/$1"
    if [ ! -f $to ] ; then
        exec_cmd touch "$to"
    else
        note "file $to is already exists."
    fi
}

remove_file(){
    local to="$home_root/$1"
    # Nothing to do
}

make_directory(){
    local to="$home_root/$1"
    if [ ! -d $to ] ; then
        exec_cmd mkdir -p "$to"
    else
        note "directory $to is already exists."
    fi
}

remove_directory(){
    to="$home_root/$1"
    # Nothing to do
}

make_github(){
    local to="$home_root/$2"
    local url="https://github.com/$1"
    if [ ! -d $to ] ; then
        exec_cmd git clone $url "$to"
    else
        now_repo=`git -C "$to" remote get-url origin`
        if [[ "$now_repo" == "$url" ]]; then
            exec_cmd git -C "$to" pull
        else
            error "directory $to is already exists."
        fi
    fi
}

remove_github(){
    local to="$home_root/$2"
    local url="https://github.com/$1"
    if [ ! -d $to ] ; then
        note "Nothing to do."
    else
        now_repo=`git -C "$to" remote get-url origin`
        if [[ "$now_repo" == "$url" ]]; then
            exec_cmd rm -rf "$to"
        else
            error "directory $to is not $2."
        fi
    fi
}

symlink(){
    case "$command" in
        setup)
            eval make_symlink "$1" "$2"
            ;;
        clean)
            eval remove_symlink "$1" "$2"
            ;;
        *)
            ;;
    esac
}
copy(){
    case "$command" in
        setup)
            eval make_copy "$1" "$2"
            ;;
        clean)
            eval remove_copy "$1" "$2"
            ;;
        *)
            ;;
    esac
}
file(){
    case "$command" in
        setup)
            eval make_file "$1" "$2"
            ;;
        clean)
            eval remove_file "$1" "$2"
            ;;
        *)
            ;;
    esac
}
directory(){
    case "$command" in
        setup)
            eval make_directory "$1" "$2"
            ;;
        clean)
            eval remove_directory "$1" "$2"
            ;;
        *)
            ;;
    esac
}

github(){
    case "$command" in
        setup)
            eval make_github "$1" "$2"
            ;;
        clean)
            eval remove_github "$1" "$2"
            ;;
        *)
            ;;
    esac
}

