# syntax=docker/dockerfile:1

# The build helper maps DISTRO to the matching base image.
ARG DISTRO=arch
ARG BASE_IMAGE=archlinux:base-devel

FROM ${BASE_IMAGE} AS development
ARG DISTRO

RUN case "$DISTRO" in \
  arch) \
  pacman -Syu --noconfirm --needed \
  clang cmake curl direnv fd fzf gdb git go lldb luarocks mold \
  neovim ninja npm python ripgrep ruby rubygems rust stow tmux unzip wget zsh \
  && pacman -Scc --noconfirm \
  ;; \
  alpine) \
  apk add --no-cache \
  bash build-base clang clang-extra-tools cmake curl direnv fd fzf \
  gdb git go linux-headers lldb luarocks mold neovim ninja npm \
  python3 ripgrep rust ruby cargo stow tmux unzip wget zsh \
  ;; \
  *) echo "Unsupported distro: $DISTRO" >&2; exit 2 ;; \
  esac

ENV HOME=/root \
  SHELL=/bin/zsh \
  ZSH_CUSTOM=/root/.oh-my-zsh/custom


RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" \
  && git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" \
  && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" \
  && git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git "$ZSH_CUSTOM/plugins/zsh-vi-mode" \
  && git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions" \
  && git clone --depth=1 https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"

# Include local changes instead of cloning only what has already been pushed.
COPY . /opt/dotfiles
WORKDIR /opt/dotfiles

RUN stow --target="$HOME" .

# Fetch plugins and run their build hooks now, rather than on first startup.
RUN nvim --headless "+Lazy! sync" "+qa"

RUN nvim --headless "+lua dofile('/opt/dotfiles/docker/bootstrap-mason.lua')"

WORKDIR /workspace
CMD ["/bin/zsh"]
