FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm git tmux zsh bottom tar unzip zip gzip wget

RUN \
  git clone --depth=1 https://github.com/hvicente/dotfiles ~/repo/dotfiles

# ZSH
RUN \
  chsh -s /usr/bin/zsh && \
  ln -s /root/repo/dotfiles/.zshrc ~/.zshrc

SHELL ["/usr/bin/zsh", "-c"]
RUN source ~/.zshrc
