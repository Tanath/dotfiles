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
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                         # automatically find new executables in path
zstyle ':completion:*' auto-description 'specify: %d'      # Describe options not described by completion functions (with one argument)
zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' completer _expand _complete         # Can be used to control completer
zstyle ':completion:*' group-name ''                       # Name of tag for matches used as name of group. All different types of matches displayed separately
zstyle ':completion:*' menu select                         # Completion menu
#zstyle ':completion:*' menu select=5                       # Only show if more than num
zstyle ":completion:*:descriptions" format "%B%d%b"
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling: current selection at %p%s
setopt magic_equal_subst                                   # Do file completion on <value> in foo=<value>

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh/cache

bindkey -e
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit colors
compinit
colors
# Completion for kitty
(( $+commands[kitty] )) && kitty + complete setup zsh | source /dev/stdin

# Add zsh help. Alt+h after command.
autoload -Uz run-help
unalias run-help 2>/dev/null
alias help=run-help
autoload -Uz run-help-{git,ip,openssl,p4,sudo,svk,svn} promptinit
promptinit

HISTFILE=~/.zhistory
HISTSIZE=12000
SAVEHIST=12000
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word

# Phil's custom prompt
# http://aperiodic.net/phil/prompt/prompt.txt
# Bender apm fix
# https://gist.github.com/bender-the-greatest/802e33cc20d0685c33715c3b8d035af5
[[ -f ~/.zprompt.zsh ]] && source ~/.zprompt.zsh

# zsh-syntax-highlighting and autosuggestion
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Custom aliases
if [[ -x "`whence -p dircolors`" ]]; then
    eval `dircolors`
	LSPARAMS=(-CFh --group-directories-first --time-style=long-iso --color=always)
else
	LSPARAMS=(-CFh --group-directories-first --time-style=long-iso)
fi
echo | grep --color=auto '' >/dev/null 2>&1 && GPARAM='--color=auto' || GPARAM=''
(( $+commands[sudo] )) && alias sudo='sudo '
(( $+commands[acp] )) && alias cp='acp -gi' || alias cp='cp -i' # advcp w/progress bar, confirm overwrite
(( $+commands[amv] )) && alias mv='amv -gi' || alias mv='mv -i' # advcp w/progress bar, confirm overwrite
(( $+commands[dfc] )) && alias df=dfc || alias df='df -h'
alias dmesg='dmesg -H --color=always'
(( $+commands[systemctl] )) && alias svc='systemctl'       # Services
(( $+commands[fzf] )) && alias fm='fzf -m'                 # fzf multi-select
(( $+commands[fzf] )) && alias dmf='dmesg | fm +s'         # Search dmesg output with fzf.
(( $+commands[fzf] )) && alias o='xdg-open "$(fzf)"'       # Find a file with fzf and open it.
(( $+commands[fzf] )) && alias psf='ps -ef | fm'           # Use fzf to find and output a process.
alias free='free -h'                                       # Show sizes in MB
alias vim="stty stop '' -ixoff; vim"                       # Avoid <c-s> terminal hang. <c-q> resumes.
alias vimdiff="stty stop '' -ixoff; vimdiff"               # Avoid <c-s> terminal hang. <c-q> resumes.
alias ed='vim'
alias u='cd ..'
ls () { command ls $LSPARAMS "$@" | less -RFX }
alias ll=ls\ -l\ $LSPARAMS
alias la=ls\ -a\ $LSPARAMS
alias l.=ls\ $LSPARAMS\ -d\ '.[^.]*'                       # List .dirs
alias lsd=ls\ $LSPARAMS\ '*(-/DN)'                         # List dirs & symlinks to dirs
alias lz='ll -rS'                                          # sort by size
alias lt='ll -rT'                                          # sort by date
alias lx='ll -BX'                                          # sort by ext
alias lsg=ls\ -al\ $LSPARAMS\ '| grep -i '$GPARAM          # ls grep
alias new=ls\ -lt\ $LSPARAMS\ '| grep -v "^total" | head'
alias old=ls\ -ltr\ $LSPARAMS\ '| grep -v "^total" | head'
alias psg='ps -efw | grep -v grep | grep '$GPARAM' $*'     # ps grep
alias pst='ps -ef --sort=pcpu | tail'                      # Most cpu use
alias psm='ps -ef --sort=vsize | tail'                     # Most mem use
alias mc='mc -b'
alias mnt='mount | column -t'
alias lsblk='lsblk -f'
alias powertop='sudo powertop'
alias lp='lsof -Pnl +M -i4'                                # lsof ports
alias ssp='ss -ptunl|egrep -vi unix\|-'                    # ss ports
(( $+commands[fzf] )) && alias spf='ss -ptunl|egrep -vi unix|fm' # pipe to fzf (ss port find)
alias big='du -sh * | sort -hr'
alias bh='big | head'
alias jerr='journalctl -p3 -xb'                            # Journalctl errors this boot
alias wpi='strings -e l'                                   # Windows program info
alias isp='whois $(curl -s ifconfig.me) | grep -v "^#\|^%"'
alias ipa='curl -s ifconfig.me'                            # Public ip
#alias ipa='dig +short myip.opendns.com @resolver1.opendns.com'  # Public ip
alias hibp='(echo -n "Password: "; read -s pw; curl -s https://api.pwnedpasswords.com/range/$(echo -n $pw | shasum | cut -b 1-5) | grep $(echo -n $pw | shasum | cut -b 6-40 | tr a-f A-F))'
alias map='telnet mapscii.me'
alias tts='xsel | text2wave | mpv --af=scaletempo --speed=1.7 -'
alias grab='ffmpeg -f x11grab -s wxga -i :0.0 -qscale 0 ~/Videos/screengrab-'\`date\ +%H-%M-%S\`'.mpg'
#alias grab='ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -s `xdpyinfo | grep "dimensions:"|awk "{print $2}"` -i :0.0 -acodec pcm_s16le screengrab-'\`date\ +%H-%M-%S\`'.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 screengrab-'`date +%H-%M-%S`'.mp4'

# Misc functions
mcd () { mkdir "$1" && cd "$1" }                           # make dir and cd
fnd () { find . -iname \*$*\* | less }                     # find
cdl () { cd "$*" && ls -al $LSPARAMS }                     # cd and list
(( $+commands[ag] )) && lg () { sudo ag $* /var/log/ } || lg () { sudo grep $GPARAM -ir $* /var/log/* } # log grep
(( $+commands[ag] )) && vq () { vim -q <(ag "$*") } || vq () { vim -q <(grep -i "$*") }
(( $+commands[fzf] )) && lf () { locate -i "$@" | fm }     # locate & print from fzf multi-select
(( $+commands[mpv] )) && alarm () { sleep $*; mpv --loop=inf /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga }
(( $+commands[mpv] )) && mya () { mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*" }
genpw () { LC_ALL=C tr -dc '!-~' </dev/urandom | fold -w 20 | head -n 10 }
fwh () { file =$1 }                                        # file which

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

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

