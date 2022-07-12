# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM="xterm-256color"

### PATHS
if [ -d "$HOME/.bin" ] ;
then export PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
then export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ] ;
then export PATH="$HOME/.yarn/bin:$PATH"
fi

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=500000
export SAVEHIST=$HISTSIZE
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export FuzzyFinder="fzf"

setopt +o nonotify                              # Wait until job is executed
umask 077                                       # Read/write/execution permission new files
setopt hist_save_no_dups hist_ignore_dups       # eliminate duplicate entries in history
setopt correctall                               # enable auto correction
setopt autopushd pushdignoredups                # auto push dir into stack and and don’t duplicate them
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY
bindkey -e                                      # emacs mode, the default

autoload -U promptinit
promptinit
printf "\e[5 q" > $TTY

if [ -f "$HOME/.zsh_alias" ]; then
source "$HOME/.zsh_alias"
else
print "404: $HOME/.zsh_alias not found."
fi

[ ! -f "$HOME/.zinit/bin/zinit.zsh" ] && mkdir -p ~/.zinit && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# export DISABLE_AUTO_TITLE='true'

source /home/hvicente/.config/broot/launcher/bash/br

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# eval "$(starship init zsh)"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
