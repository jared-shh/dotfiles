# ~/.zshrc — Jared Grimes / Wispr
# Guarded throughout: safe to source before the tools below are installed.

# --- Homebrew ---------------------------------------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- Node via fnm -----------------------------------------------------------
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# --- pnpm -------------------------------------------------------------------
export PNPM_HOME="$HOME/Library/pnpm"
[[ ":$PATH:" == *":$PNPM_HOME:"* ]] || export PATH="$PNPM_HOME:$PATH"

# --- Local bins -------------------------------------------------------------
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# --- Editor -----------------------------------------------------------------
if command -v code >/dev/null 2>&1; then
  export EDITOR="code --wait"
  export VISUAL="$EDITOR"
else
  export EDITOR="vim"
fi

# --- History ----------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY INC_APPEND_HISTORY

# --- Completion -------------------------------------------------------------
autoload -Uz compinit && compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# --- Git branch in prompt ---------------------------------------------------
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{242}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{cyan}%1~%f${vcs_info_msg_0_} %F{green}❯%f '

# --- Aliases ----------------------------------------------------------------
alias ll='ls -lah'
alias gs='git status -sb'
alias gd='git diff'
alias gco='git checkout'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -20'
alias ..='cd ..'
alias ...='cd ../..'

# Open the current repo on GitHub
alias repo='gh repo view --web'

. "$HOME/.local/bin/env"

# Added by Devin
export PATH="$HOME/.codeium/windsurf/bin:$PATH"
