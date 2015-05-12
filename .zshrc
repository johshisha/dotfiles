# 補完
# for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
# 補完機能を有効にする
autoload -Uz compinit
compinit -u

autoload -Uz colors
colors


export PYENV_ROOT=$HOME/.pyenv
if [ -d "$PYENV_ROOT" ]; then
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:?/} brew"
fi

alias ls='ls'
alias ll='ls -l'
alias la='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# prompt
PROMPT="${fg[green]}[%c]${reset_color} %# "
RPROMPT="$(branch-status-check)"

function branch-status-check {
  local prefix branchname suffix
  # .gitの中だから除外
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  branchname=`get-branch-name`
  # ブランチ名が無いので除外
  if [[ -z $branchname ]]; then
    return
  fi
  prefix=`get-branch-status` #色だけ返ってくる
  suffix='%{'${reset_color}'%}'
  # echo '['${prefix}${branchname}${suffix}']'
  echo ${prefix}${branchname}${suffix}
}

function get-branch-name {
  # gitディレクトリじゃない場合のエラーは捨てます
  echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}

function get-branch-status {
  local res color
  output=`git status --short 2> /dev/null`
  if [ -z "$output" ]; then
    res=':' # status Clean
    color='%{'${fg[green]}'%}'
  elif [[ $output =~ "[\n]?\?\? " ]]; then
    res='?:' # Untracked
    color='%{'${fg[yellow]}'%}'
  elif [[ $output =~ "[\n]? M " ]]; then
    res='M:' # Modified
    color='%{'${fg[red]}'%}'
  else
    res='A:' # Added to commit
    color='%{'${fg[cyan]}'%}'
  fi
  # echo ${color}${res}'%{'${reset_color}'%}'
  echo ${color} # 色だけ返す
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo 'Hg' && return
  echo '○'
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# History
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_nodups
setopt hist_reduce_blanks

# History Search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

zstyle ':completion:*:default' menu select=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


