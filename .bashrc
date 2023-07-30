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
#alias ls='ls --color=auto'
alias ls='exa --icons --group-directories-first'
alias xterm='alacritty'
export WINIT_X11_SCALE_FACTOR=1.0
PS1='\[\e[1m\][\[\e[92m\]\d \[\e[39m\]- \[\e[93m\]\t\[\e[39m\]][\[\e[91m\]\u\[\e[39m\]@\[\e[94m\]\h\[\e[39m\]][\[\e[96m\]\w\[\e[39m\]]\n\[\e[92m\]\$ \[\e[0m\]'
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
