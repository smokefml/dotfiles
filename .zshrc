# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tiamat/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
##########################
####### My configs #######
##########################
# Source external files
## Hikari is a set of cofigurations
source ~/.config/zsh/hikari
## pacman hook for persistent rehash
source ~/.zsh/pacman_update.zsh
## pacman command not found handler
source ~/.zsh/pacman_cmd_not_found.zsh
## ssh-agent
#source ~/.zsh/ssh-agent.zsh
## Aliases
if [[ -r ~/.aliasrc ]]; then
  . ~/.aliasrc
fi
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help
autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn
## Autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Functions
#autoload chpwd namedir
# NEARCOLOR MODULE
# [[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
# Titlebar
if [[ "${TERM}" != "" && "${TERM}" == "alacritty" ]]
then
    precmd()
    {
        # output on which level (%L) this shell is running on.
        # append the current directory (%~), substitute home directories with a tilde.
        # "\a" bell (man 1 echo)
        # "print" must be used here; echo cannot handle prompt expansions (%L)
        print -Pn "\e]0;$(id --user --name)@$(hostname): zsh[%L] %~\a"
    }

    preexec()
    {
        # output current executed command with parameters
        echo -en "\e]0;$(id --user --name)@$(hostname): ${1}\a"
    }
fi
# Prompt theme
## Load promptinit
#autoload -Uz promptinit && promptinit
## Load the theme
#prompt fire yellow red blue black white blue
source ~/.zsh/spaceship-vi-mode/spaceship-vi-mode.plugin.zsh
source /usr/lib/spaceship-prompt/spaceship.zsh

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

unsetopt auto_pushd
export PATH=$PATH:/home/tiamat/.spicetify
