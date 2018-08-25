# 補完
# for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath) 
# 補完機能を有効にする
autoload -Uz compinit
compinit -u

#補完で小文字大文字マッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz colors
colors

# pyenv and virtualenv
export PYENV_ROOT=$HOME/.pyenv
if [ -d "$PYENV_ROOT" ]; then
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# rbenv
export RBENV_ROOT=$HOME/.rbenv
if [ -d "$RBENV_ROOT" ]; then
  export PATH=$RBENV_ROOT/bin:$PATH
  eval "$(rbenv init -)"
fi

# alias
alias ls='ls'
alias ll='ls -l'
alias la='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "*"
zstyle ':vcs_info:git:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '[%b]%c%u'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
      psvar=()
          LANG=en_US.UTF-8 vcs_info
              [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
RPROMPT="%1(v|%F{green}%1v%f|)"

#prompt
PROMPT="%{${fg[green]}%}[%c]%{${reset_color}%}"

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# History
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_nodups
setopt hist_reduce_blanks

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# History Search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

zstyle ':completion:*:default' menu select=1
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#---- path ----

# Golang
export GOPATH=$HOME/go/third-party:$HOME/go/my-project
export PATH=$HOME/go/third-party/bin:$PATH

