FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm git tmux zsh bottom tar unzip zip gzip wget exa bat broot lua

# to set password -p "$(openssl passwd -1 hvicente)"
# RUN useradd -rm -d /home/hvicente -s /bin/bash -g root -u 1001 hvicente
# USER hvicente
# WORKDIR /home/hvicente

RUN \
  git clone --depth=1 https://github.com/hvicente/dotfiles ~/repo/dotfiles

# ZSH
RUN \
  chsh -s /usr/bin/zsh && \
  ln -s /root/repo/dotfiles/.zshrc ~/.zshrc && \
  ln -s /root/repo/dotfiles/.zsh_alias ~/.zsh_alias && \
  ln -s /root/repo/dotfiles/.zsh-theme/edge-dark.zsh ~/.zsh-theme
RUN git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
# RUN curl -sS https://starship.rs/install.sh > starship && \
#   chmod +x starship && \
#   ./starship --yes

SHELL ["/usr/bin/zsh", "-c"]
RUN curl https://get.volta.sh | bash
RUN source ~/.zshrc
RUN zsh -i -c -- 'zinit module build; @zinit-scheduler burst || true '

RUN /root/.volta/bin/volta install node@16

ENV TZ Europe/Madrid
