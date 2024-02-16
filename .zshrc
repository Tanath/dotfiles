# Exit if not interactive shell
[[ -o interactive ]] || return

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
setopt extendedglob
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
#eval "$(dircolors -b)"
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

HISTFILE=~/.zhistory
HISTSIZE=12000
SAVEHIST=12000
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word

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

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

# fuzzy ag open with line number
vg() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# fuzzy ag open, incl. hidden, with line number
vgh() {
  local file
  local line

  read -r file line <<<"$(ag --hidden --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# fuzzy ag open, incl. hidden, no recurse, with line number
vgr() {
  local file
  local line

  read -r file line <<<"$(ag -n --hidden --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

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

fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

fp () {
    open=xdg-open
    ag -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
    | cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null $open > /dev/null 2> /dev/null
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
