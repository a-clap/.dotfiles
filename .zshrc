# p10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zvm_after_init_commands+=('[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh')
plugins=(
  fzf
  git
  history-substring-search
  z
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# p10k
fpath+=~/.zfunc
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# SSH connection editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi

autoload -U compinit
compinit -i

# VI mode
bindkey -v
bindkey jj vi-cmd-mode

function command_exist() {
  cmd=$1
  command -v "$cmd" 1>/dev/null 2>/dev/null
}

# paths
for maybe in /usr/local/go/bin $HOME/go/bin/ /usr/local/zig/; do
  if [[ -d "$maybe" ]]; then
    export PATH=$PATH:"$maybe"
  fi
done

# Utils
# cargo
if [[ -d "$HOME/.cargo" ]]; then
  . "$HOME/.cargo/env"
fi

# direnv
command_exist direnv && eval "$(direnv hook zsh)"

# pyenv
PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT ]]; then
  export PYENV_ROOT="$PYENV_ROOT"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"

function nvims() {
  items=("default" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"

ZSHRC_LOCAL=$HOME/.zshrc.local
[[ -e $ZSHRC_LOCAL ]] && . "$ZSHRC_LOCAL"
