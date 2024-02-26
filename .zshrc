# Exit if not interactive shell
[[ -o interactive ]] || return

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Options
setopt correct                                             # Auto correct mistakes
setopt numericglobsort                                     # Sort filenames numerically when it makes sense
setopt appendhistory                                       # Immediately append history instead of overwriting
setopt histignorealldups                                   # If a new command is a duplicate, remove the older one
setopt sharehistory                                        # Share history between sessions
setopt hist_ignore_space                                   # Omit commands starting with a space from history
setopt menucomplete
setopt prompt_subst                                        # enable substitution for prompt
setopt auto_resume # Commands w/o arguments will first try to resume suspended programs of the same name.
setopt extendedglob
#setopt autocd                                              # CD automatically when path to dir is entered
setopt no_flow_control                                     # Turns off C-S/C-Q flow control
ttyctl -f                                                  # Avoid <c-s> frozen terminal. <c-q> should resume.
setopt no_beep
setopt no_multios
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' auto-description 'specify: %d'      # Describe options not described by completion functions (with one argument)
zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' completer _expand _complete         # Can be used to control completer
zstyle ':completion:*' group-name ''                       # Name of tag for matches used as name of group. All different types of matches displayed separately
zstyle ':completion:*' menu select                         # Completion menu
#zstyle ':completion:*' menu select=5                       # Only show if more than num
zstyle ":completion:*:descriptions" format "%B%d%b"
#eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling: current selection at %p%s
setopt magic_equal_subst                                   # Do file completion on <value> in foo=<value>
zstyle ':completion:*' rehash true                         # Check for new binaries when doing completion
(( $+commands[eza] )) \
    && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath' \
    && zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --color=always --icons $realpath' \
    && zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always --icons $realpath'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh/cache

# zplug
[[ -f ~/.zplug.zsh ]] && source ~/.zplug.zsh

# Fzf
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# Make Vi mode transitions faster
export KEYTIMEOUT=20

## Set up vi mode & shortcuts:
# Add alt+. to vi mode
bindkey -v '\e.' insert-last-word
bindkey "\M." insert-last-word

bindkey "^R" history-incremental-search-backward
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
## See man zshzle; bindkeys -M main, bindkeys -M viins

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit colors
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
colors
(( $+commands[zoxide] )) \
    && eval "$(zoxide init --cmd cd zsh)" \
    || echo "Zoxide missing. Install:\ncurl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash"
# Completion for kitty
(( $+commands[kitty] )) && kitty + complete setup zsh | source /dev/stdin

# up/down takes existing text into account
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Add zsh help. Alt+h after command.
autoload -Uz run-help
unalias run-help 2>/dev/null
alias help=run-help
alias h=run-help
#autoload -Uz run-help-{git,ip,openssl,p4,sudo,svk,svn} promptinit
#promptinit

# zsh-syntax-highlighting and autosuggestion
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Personal custom aliases, functions
[[ -f ~/.zalias.zsh ]] && source ~/.zalias.zsh
# Pacman-based distros
[[ -f ~/.zpac.zsh ]] && source ~/.zpac.zsh
# Deb-based distros
[[ -f ~/.zubuntu.zsh ]] && source ~/.zubuntu.zsh
# Desktop-only stuff
[[ -f ~/.zdesk.zsh ]] && source ~/.zdesk.zsh
# Laptop-only stuff
[[ -f ~/.zlap.zsh ]] && source ~/.zlap.zsh
# Mobile-only stuff
[[ -f ~/.zmobile.zsh ]] && source ~/.zmobile.zsh

# Key bindings
#=============
bindkey "\e[1~" beginning-of-line                # Home
bindkey "\e[4~" end-of-line                      # End
bindkey "\e[5~" beginning-of-history             # PageUp
bindkey "\e[6~" end-of-history                   # PageDown
bindkey "\e[2~" quoted-insert                    # Ins
bindkey "\e[3~" delete-char                      # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete             # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line                # Home
bindkey "\e[8~" end-of-line                      # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# for guake
bindkey "\eOF" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "\e[3~" delete-char                      # Del
# up/down takes existing text into account
bindkey '^[[A'  up-line-or-beginning-search      # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search    # Arrow down
bindkey '^[OB'  down-line-or-beginning-search

# Color man pages
#export LESS_TERMCAP_mb=$'\E[01;32m'
#export LESS_TERMCAP_md=$'\E[01;32m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;47;34m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[01;36m'
#export LESS=-r

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
