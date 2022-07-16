FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm git \
  tmux \
  zsh \
  bottom \
  unzip \
  zip \
  wget \
  exa \
  bat \
  broot \
  lazygit \
  lua \
  make \
  gcc \
  ripgrep \
  tmux \
  fzf \
  nnn \
  gdb \
  fd \
  automake \
  autoconf \
  cmake \
  python \
  python-pip \
  xsel
#skim #like fzf

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
RUN source ~/.zshrc
RUN /root/.volta/bin/volta install yarn@latest

# Tmux
RUN \
  git clone --depth=1 https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm && \
  cp ~/repo/dotfiles/.tmux.conf ~ && \
  ln -s /root/repo/dotfiles/.tmux/tmuxline ~/.tmux/tmuxline
RUN \
  tmux start-server && \
  tmux new-session -d && \
  sleep 1 && \
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh && \
  tmux kill-server

# nvim
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN tar xf nvim-linux64.tar.gz
RUN mkdir -p $HOME/.local/bin
RUN ln -s /nvim-linux64/bin/nvim /root/.local/bin/nvim
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN mkdir ~/.config
RUN ln -s /root/repo/dotfiles/nvim ~/.config/nvim
RUN \
  root/.local/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' && \
  root/.local/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
# DAP
RUN \
  mkdir -p ~/dev/microsoft && \
  git clone https://github.com/microsoft/vscode-node-debug2.git ~/dev/microsoft/vscode-node-debug2 && \
  cd ~/dev/microsoft/vscode-node-debug2 && \
  /root/.volta/bin/npm install && \
  NODE_OPTIONS=--no-experimental-fetch /root/.volta/bin/npm run build

# root/.local/bin/nvim --headless +"TSInstallSync all" +qall

ENV TZ Europe/Madrid
