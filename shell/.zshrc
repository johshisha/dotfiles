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

# gh
eval "$(gh completion -s zsh)"

# -------------------------------------------------
# プラグイン有効化
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# -------------------------------------------------

# -------------------------------------------------
# peco
# ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
  if (($+zle_bracketed_paste)); then
    print $zle_bracketed_paste[2]
  fi
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
fi

# ctrl + f で過去に移動したことのあるディレクトリを選択できるようにする。
function peco-cdr () {
    local selected_dir="$(cdr -l | sed -E 's/^[0-9]+ *//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^f' peco-cdr
# -------------------------------------------------

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
