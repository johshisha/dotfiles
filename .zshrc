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

export PYENV_ROOT=$HOME/.pyenv
if [ -d "$PYENV_ROOT" ]; then
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
fi

alias ls='ls'
alias ll='ls -l'
alias la='ls -la'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'

alias check='/home/dl-box/study/.package/check/check.sh'
alias chmodsh='/home/dl-box/study/.package/chmod.sh'
alias mfile='/home/dl-box/study/.package/do_matlab/do_matlab.sh'


# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '[%b]'
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


function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

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


#autojump
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh

#---- path ----

#cuda
#export PATH=/usr/local/cuda/bin:$PATH
#export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:$DYLD_LIBRARY_PATH
#export C_INCLUDE_PATH="/Developer/NVIDIA/CUDA-7.0/samples/common/inc"
#export CPLUS_INCLUDE_PATH="/Developer/NVIDIA/CUDA-7.0/samples/common/inc"


#VLFeat
export PATH=/Developer/vlfeat-0.9.20/bin/maci64:$PATH
export MANPATH=/Developer/vlfeat-0.9.20/src:$MANPATH



#path
export CAFFE_ROOT=~/study/.package/caffe/
export PYTHONPATH=~/study/.package/caffe/python/:$PYTHONPATH

export MATLAB_PATH=/usr/local/MATLAB/R2015a/bin/glnxa64/:$MATLAB_PATH


