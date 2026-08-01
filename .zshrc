# ===================== Zinit (Plugin Manager) =====================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ===================== Plugins =====================
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# ===================== Set audio output volume (ear protection) =====================
# wpctl set-volume @DEFAULT_AUDIO_SINK@ 60%

# ===================== Prompt =====================
setopt transient_rprompt
eval "$(~/.local/bin/oh-my-posh init zsh --config ~/.config/ohmyposh/custom.toml)"

# Populate POSH_DOCKER (running/stopped/down counts for ohmyposh)
function set_poshcontext() {
    export POSH_DOCKER="$(~/.config/ohmyposh/docker-status.sh 2>/dev/null)"
}

# ===================== History =====================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# ===================== Completion & Key Bindings =====================
autoload -U compinit && compinit

# Up/Down arrow: search history by prefix
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A"  up-line-or-beginning-search
bindkey "^[OA"  up-line-or-beginning-search
bindkey "^[[B"  down-line-or-beginning-search
bindkey "^[OB"  down-line-or-beginning-search

# Tab / Suppr
bindkey '^I'      expand-or-complete
bindkey "^[[3~"   delete-char

# Completion style
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# ===================== Path =====================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/gbdk/bin"
export PATH=~/.npm-global/bin:$PATH

# ===================== Nvim =====================
export VISUAL=nvim
export EDITOR=nvim

# ===================== Env Variables =====================
if [ -f ~/.env ]; then
    set -a
    source ~/.env
    set +a
fi

# ===================== Colors =====================
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ===================== Aliases =====================
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# ===================== Nvm =====================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Keep the last folder location on new tab
function osc7_cwd() {
    printf '\033]7;file://%s%s\033\\' "$HOSTNAME" "$PWD"
}
precmd_functions+=(osc7_cwd)

# ===================== SSH Agent & Keyring =====================
if [ -x /usr/bin/ksshaskpass ]; then
    # KDE Plasma (KWallet)
    export SSH_ASKPASS="/usr/bin/ksshaskpass"
elif [ -x /usr/bin/ssh-askpass ]; then
    # GNOME (Gnome Keyring)
    export SSH_ASKPASS="/usr/bin/ssh-askpass"
elif [ -x /usr/libexec/openssh/gnome-ssh-askpass ]; then
    export SSH_ASKPASS="/usr/libexec/openssh/gnome-ssh-askpass"
fi

export SSH_ASKPASS_REQUIRE="prefer"

# Start ssh agent if not active
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Auto load key if not in agent
if ssh-add -l 2>&1 | grep -q "The agent has no identities"; then
    ssh-add -k ~/.ssh/id_ed25519 </dev/null &>/dev/null
fi
