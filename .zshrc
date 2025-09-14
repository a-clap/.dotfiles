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

fpath+=~/.zfunc
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U compinit
compinit -i

bindkey -v
bindkey jj vi-cmd-mode

eval "$(direnv hook zsh)"

source ~/.fzf.zsh
source ~/.fzf/shell/key-bindings.zsh
source <(fzf --zsh)

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
