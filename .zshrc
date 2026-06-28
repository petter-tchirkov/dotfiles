### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### Init completion
autoload -Uz compinit; compinit

### Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

### Vi mode bindings
bindkey -v
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

### ENV
export MANPAGER="nvim +Man!"
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export QT_QPA_PLATFORMTHEME="gtk2"
export PATH=.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
# export ALL_PROXY=socks5://127.0.0.1:1080
# export HTTPS_PROXY=http://127.0.0.1:1087

### History configuration
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

### Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

### Aliases
alias ls='ls -la --color'
alias vim='nvim'
alias c='clear'
alias grep='grep --color=auto'
alias l='lazygit'
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias galdl="gallery-dl --limit-rate 10M"
alias kr="keyd reload"
alias km="keyd monitor"
alias ld="lazydocker"
alias pt="~/.config/hypr/scripts/proton-tui"
alias swc="nvim ~/.config/swayimg/init.lua"
alias hcfg="nvim ~/.config/hypr/hyprland.conf"
alias ncfg="nvim ~/.config/nvim/init.lua"

### CWD for Yazi
function d() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function yazi_zed() {
	local tmp="$(mktemp -t "yazi-chooser.XXXXX")"
	yazi "$@" --chooser-file="$tmp"

	local opened_file="$(cat -- "$tmp" | head -n 1)"
	zeditor -- "$opened_file"

	rm -f -- "$tmp"
	exit
}

### Start Starship
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/theonlyvoivod/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

