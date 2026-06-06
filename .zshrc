# ===================== Zinit (Plugin Manager) =====================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

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
eval "$(~/.local/bin/oh-my-posh init zsh --config ~/.config/ohmyposh/custom.toml)"

# ===================== History Settings =====================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
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
# --- PATH ---
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/gbdk/bin"

# --- Env Variables ---
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

# ===================== Custom fonctions =====================
# Create a file and his path
mkfile() {
    for file in "$@"; do
        mkdir -p "$(dirname "$file")" && touch "$file"
    done
}

# ===================== NVIM config =====================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Keep the last folder location on new tab
function osc7_cwd() {
    printf '\033]7;file://%s%s\033\\' "$HOSTNAME" "$PWD"
}
precmd_functions+=(osc7_cwd)
