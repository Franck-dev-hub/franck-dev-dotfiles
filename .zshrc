# ===================== Zinit (Plugin Manager) =====================
# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-/home/franck/.local/share}/zinit/zinit.git"

# Download Zinit if it's not already installed
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ===================== Plugins =====================
# Syntax highlighting, completions, autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# ===================== Prompt =====================
# Oh My Posh prompt configuration
setopt transient_rprompt
# Initialize Oh My Posh with custom config
eval "$(/usr/bin/oh-my-posh init zsh --config /home/franck/.config/ohmyposh/custom.toml)"

# ===================== History Settings =====================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# ===================== Completion & Key Bindings =====================
# Load completions
autoload -U compinit && compinit

# Up/Down arrow: search history for lines beginning with current input
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Tab completion and color settings
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
bindkey '^I' expand-or-complete
bindkey "^[[3~" delete-char

# ===================== Auto Start =====================
# --- Load hidden env variables ---
if [ -f ~/.env ]; then
    set -a
    source ~/.env
    set +a
fi

# --- Env var for lcc ---
export PATH=$PATH:/opt/gbdk/bin

# ===================== Custom functions =====================
# --- Make a file and his path ---
mkfile() {
	for file in "$@"; do
		mkdir -p "$(dirname "$file")" && touch "$file"
	done
}

# ===================== Aliases =====================
# --- Vim ---
alias n="nvim"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# --- Terminal ---
alias ll="ls -Alh"
alias ls="lsd --group-dirs first"
alias fibo="${HOME}/.config/waybar/scripts/fibo.sh"
alias tab="sc-im -l /usr/share/sc-im/themes/f-seeker.sc"

# --- Git/Github ---
alias gs="clear && git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gac="git add . && git commit"
alias gacm="git add . && git commit -m"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gp="git push"
alias gpf="git push -f"
alias gcanf="git commit --amend --no-edit && git push -f"
alias gd="git diff"
alias gds="git diff --stat"

# --- Docker Compose ---
alias dcd="docker compose down"
alias dcb="docker compose build"
alias dcu="docker compose up"
alias dc-reset="docker compose down && docker compose build --no-cache && docker compose up -d"
alias dcs="docker compose ps"

# --- Holberton (C/Valgrind) ---
# Bash
alias shbang="echo "#\!/usr/bin/bash" | tee -ii *.sh"
# C
alias gcch="gcc -Wall -pedantic -Werror -Wextra -std=gnu89"
alias val="clear && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all"
alias cbetty="clear && betty *"
# Python
alias pcs="pycodestyle"
alias pybang="echo "#\!/usr/bin/env\ python3" | tee -ii *.py"
# JS
alias jsbang="echo "#\!/usr/bin/node" | tee -ii *.js"
alias ssa="semistandard *.js"
alias ssf="semistandard --fix"

# --- Love2D ---
alias lov="love ./"

# --- Fastfetch ---
alias ff="fastfetch"
alias ffm="fastfetch --config ${HOME}/.config/fastfetch/start.jsonc"

# --- Webcam ---
alias webcam="gst-launch-1.0 v4l2src device=/dev/video0 ! image/jpeg,width=1280,height=720 ! jpegdec ! videoconvert ! autovideosink"
alias qr="zbarcam"

# --- Configs ---
alias zshrc="n ${HOME}/.zshrc"
alias cursor="find /usr/share/icons ${HOME}/.local/share/icons ${HOME}/.icons -type d -name "cursors""
alias hypr="n ${HOME}/.config/hypr/hyprland.conf"
alias lock="n ${HOME}/.config/hypr/hyprlock.conf"
alias idle="n ${HOME}/.config/hypr/hypridle.conf"
alias bar="n ${HOME}/.config/waybar/config.jsonc"
alias notif="n ${HOME}/.config/mako/config"
alias custom-launcher="n ${HOME}/.config/hypr/scripts/rofi-file-manager.sh"
alias display="nwg-look"
alias tableur="n /usr/share/sc-im/themes/f-seeker.sc"
alias wall="${HOME}/.config/hypr/scripts/random_wallpaper.sh"

# --- Help ---
alias help="clear && ${HOME}/.config/hypr/scripts/help/help"
alias help-battery="clear && ${HOME}/.config/hypr/scripts/help/help-battery"
alias help-blue="clear && ${HOME}/.config/hypr/scripts/help/help-blue"
alias help-config="clear && ${HOME}/.config/hypr/scripts/help/help-config"
alias help-disk="clear && ${HOME}/.config/hypr/scripts/help/help-disk"
alias help-docker="clear && ${HOME}/.config/hypr/scripts/help/help-docker"
alias help-firewall="clear && ${HOME}/.config/hypr/scripts/help/help-firewall"
alias help-git="clear && ${HOME}/.config/hypr/scripts/help/help-git"
alias help-hardware="clear && ${HOME}/.config/hypr/scripts/help/help-hardware"
alias help-monitor="clear && ${HOME}/.config/hypr/scripts/help/help-monitor"
alias help-terminal="clear && ${HOME}/.config/hypr/scripts/help/help-terminal"
alias help-webcam="clear && ${HOME}/.config/hypr/scripts/help/help-webcam"
alias help-wifi="clear && ${HOME}/.config/hypr/scripts/help/help-wifi"
