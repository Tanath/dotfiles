# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Options
setopt correct                                             # Auto correct mistakes
setopt numericglobsort                                     # Sort filenames numerically when it makes sense
setopt appendhistory                                       # Immediately append history instead of overwriting
setopt histignorealldups                                   # If a new command is a duplicate, remove the older one
setopt sharehistory                                        # Share history between sessions
setopt menucomplete
setopt prompt_subst                                        # enable substitution for prompt
setopt auto_resume # Commands w/o arguments will first try to resume suspended programs of the same name.
#setopt autocd                                              # CD automatically when path to dir is entered
setopt no_flow_control                                     # Turns off C-S/C-Q flow control
ttyctl -f                                                  # Avoid <c-s> frozen terminal. <c-q> should resume.

# Completions
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive tab completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' auto-description 'specify: %d'      # Describe options not described by completion functions (with one argument)
zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' completer _expand _complete         # Can be used to control completer
zstyle ':completion:*' group-name ''                       # Name of tag for matches used as name of group. All different types of matches displayed separately
zstyle ':completion:*' menu select                         # Completion menu
#zstyle ':completion:*' menu select=5                       # Only show if more than num
zstyle ":completion:*:descriptions" format "%B%d%b"
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling: current selection at %p%s
setopt magic_equal_subst                                   # Do file completion on <value> in foo=<value>
zstyle ':completion:*' rehash true                         # Check for new binaries when doing completion
(( $+commands[exa] )) \
    && zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always --icons $realpath' \
    && zstyle ':fzf-tab:complete:exa:*' fzf-preview 'exa -1 --color=always --icons $realpath' \
    && zstyle ':fzf-tab:complete:ls:*' fzf-preview 'exa -1 --color=always --icons $realpath'

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

#bindkey -e
# Add alt+. to vi mode
bindkey -v '\e.' insert-last-word
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit colors
compinit
colors
# Completion for kitty
(( $+commands[kitty] )) && kitty + complete setup zsh | source /dev/stdin

# up/down takes existing text into account
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Add zsh help. Alt+h after command.
autoload -Uz run-help
unalias run-help 2>/dev/null
alias help=run-help
alias h=run-help
#autoload -Uz run-help-{git,ip,openssl,p4,sudo,svk,svn} promptinit
#promptinit

HISTFILE=~/.zhistory
HISTSIZE=12000
SAVEHIST=12000
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word

# Phil's custom prompt
# http://aperiodic.net/phil/prompt/prompt.txt
# Bender apm fix
# https://gist.github.com/bender-the-greatest/802e33cc20d0685c33715c3b8d035af5
#[[ -f ~/.zprompt.zsh ]] && source ~/.zprompt.zsh

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

todo () {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi
    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        >> $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read "?Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

# x - archive extractor
# usage: x <file>
x () {
    local c e i
    (($#)) || return
    for i; do
        c=''
        e=1
        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi
        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
            *.(tar|iso))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *.deb) c=(ar x);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac
        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

# github clone by 'user/repo'
ghc () {
  [[ -z "$1" ]] && echo "need 'user/repo'" && return 1
  git clone git://github.com/"$1".git
  cd `echo "$1" | sed 's/^.*\///'`
  echo cd `pwd`
}

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
bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
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
