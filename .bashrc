#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/user-dirs.dirs
export XDG_MENU_PREFIX="arch-"
export PATH="~/.local/bin":$PATH
export TERMINAL="alacritty"
export TERMCMD="alacritty"
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
alias ls='ls --color=auto'
alias xterm='alacritty'
export WINIT_X11_SCALE_FACTOR=1.0
#alias alacritty='WINIT_X11_SCALE_FACTOR=1.0 alacritty'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[1;97m\e[7m\][\d \t]\[\e[1;33m\][\u]\[\e[1;32m\]@\[\e[1;34m\][\h]\[\e[27m\]\n[\W] \[\e[1;32m\]\$\[\e[0m\] '

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

neofetch
