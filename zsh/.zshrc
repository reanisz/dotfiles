export PATH=~/usr/bin/:$PATH
source ~/.zshrc.local

autoload -U compinit
compinit

#PROMPT="%n@%m:%~%# "
PROMPT="%n:%~%# "
RPROMPT="[%~]"
RPROMPT=""

HISTFILE=~/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

setopt auto_pushd
setopt correct
setopt list_packed

bindkey -e

#autoload predict-on
#predict-on

autoload -U compinit
compinit

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'



alias ls="ls -G" # --color"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias j="autojump"
#source ~/.autojump/etc/profile.d/autojump.zsh

#bindkey "^P" up-line-or-history
#bindkey "^N" down-line-or-history

# コマンド履歴検索
 autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

stty stop undef

zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

source ~/.zsh/incr*.zsh

zmodload -i zsh/mathfunc

function ggr() {
    local str opt
    if [ $ != 0 ]
    then
        for i in $*
        do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}
function ejje() {
    local str opt
    if [ $ != 0 ]
    then
        for i in $*
        do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
    fi
    w3m +50 http://ejje.weblio.jp/content/$str
}

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"
export PATH=~/.plenv/shims:$PATH

alias tmux='tmux -2'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

function powerline_precmd() {
  export PS1="$(python2 ~/.zsh/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
}
function install_powerline_precmd() {
  for s in "${precmd_functions[@]}" ; do
      if [ "$s" = "powerline_precmd" ] ; then
          return
      fi
  done
  precmd_functions+=(powerline_precmd)
}
# install_powerline_precmd
