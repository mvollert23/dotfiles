### Prompt pre-init
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Zinit package manager
# Setup Zinit package manager to manage Zsh plugins.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

### Plugins
# Add Powerlevel10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Command syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# Auto completions for commands
zinit light zsh-users/zsh-completions
# Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# Suggestions based on command history
zinit light zsh-users/zsh-autosuggestions
bindkey '^f' autosuggest-accept

# Use fzf for autocompletion menu
zinit light Aloxaf/fzf-tab

# Vim mode for editing command line.
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# Give suggestions for aliases to be used.
zinit light MichaelAquilina/zsh-you-should-use

### Oh-my-zsh plugins
# Git aliases
zinit snippet OMZP::git
# Sudo plugin, type <ESC><ESC> to run the last command with sudo
zinit snippet OMZP::sudo
# Command-not-found-plugin, to suggest what to install for missing commands
zinit snippet OMZP::command-not-found

### Zsh options
# Case insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colors for completion
LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
# As we use fzf for the completion menu, disable zsh completion menu.
zstyle ':completion:*' menu no
# Use fzf for cd navigation
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

### History setup
# Setup Global History for all zsh shells.
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# Navigate throug history
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


### Some environment variables
# Environment variables
export CLICOLOR=1

### Utilities
# Enable fzf for fuzzy file searching if fzf is installed.
# Note: ZVM (Zsh Vim Mode) uses some keybindings that conflict with fzf.
#   To ensore FZF sets its bindings effectfully,
#   we need to set up fzf after ZVM is initialized.
function zvm_after_init() {
    if command -v fzf 2>&1 >/dev/null
    then
        source <(fzf --zsh)
    else
        echo "fzf not found, skipping fzf setup"
    fi
}
# Enable zoxide for directory jumping, if zoxide is installed.
if command -v zoxide 2>&1 >/dev/null
then
    eval "$(zoxide init zsh)"
else
    echo "zoxide not found, skipping zoxide setup"
fi
# Setup eza as ls replacement if eza is installed.
if command -v  eza 2>&1 >/dev/null
then
    alias ls='eza'
    alias ll='eza -la'
else
    echo "eze not found, skipping eza setup"
    alias ls='ls --color'
    alias ll='ls -la'
fi

### Prompt post-init
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

