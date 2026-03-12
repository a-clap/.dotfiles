FROM archlinux:base-devel-20260308.0.497099

RUN pacman -Syu --noconfirm
RUN pacman --noconfirm -S \
  asio \
  boost \
  cmake \
  curl  \
  direnv \
  fd \
  fmt  \
  fontconfig \
  fzf \
  gcc \
  git \
  go \
  gtest \
  lazygit \
  lua51 \
  luarocks \
  mold \
  net-snmp \
  ninja \
  npm \
  nvim \
  python \
  qt6-declarative \
  ripgrep \
  ruby  \
  rust \
  spdlog \
  stow \
  tmux \
  ttf-dejavu \
  unzip \
  wayland \
  wget \
  zsh

RUN mkdir -p "$HOME"/.tmux/plugins

RUN git clone https://github.com/a-clap/.dotfiles /opt/dotfiles
WORKDIR /opt/dotfiles

RUN stow --target="$HOME" .

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

ENV HOME=/root
ENV ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

RUN git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k" && \
  git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode "${ZSH_CUSTOM}/plugins/zsh-vi-mode" && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" && \
  git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm

WORKDIR $HOME

RUN chsh -s /usr/bin/zsh
ENV SHELL=/usr/bin/zsh

RUN pacman --noconfirm -S \
  qt6-declarative \
  net-snmp
