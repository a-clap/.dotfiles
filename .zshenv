# aliases
alias vim=nvim
alias l='exa -l --icons --git -a'
alias lt='exa --tree --level=2 --long --icons --git'

export ZVM_VI_EDITOR=nvim
export EDITOR=nvim
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$EDITOR

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export PATH=$PATH:$HOME/bin

# zig
export PATH=$PATH:/usr/local/zig

# rust
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if [ -f $HOME/.zshenv_user ]; then
    source $HOME/.zshenv_user
fi

