# Options
setopt correct                                              # Auto correct mistakes
setopt numericglobsort                                      # Sort filenames numerically when it makes sense
setopt appendhistory                                        # Immediately append history instead of overwriting
setopt histignorealldups                                    # If a new command is a duplicate, remove the older one
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                          # automatically find new executables in path 
setopt SHARE_HISTORY                                        # Share history between sessions
setopt prompt_subst                                         # enable substitution for prompt

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh/cache

# Custom variables
export EDITOR="$(if [[ -n $DISPLAY ]]; then echo 'gvim'; else echo 'vim'; fi)"
export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'gvim'; else echo 'vim'; fi)"
export SOCKS_VERSION=5
export SDL_AUDIODRIVER=pulse
[[ -d /usr/share/themes/Numix-DarkBlue/ ]] && export GTK_THEME=Numix-DarkBlue || export GTK_THEME=Adwaita:dark # For gtk3
GTK_OVERLAY_SCROLLING=0 # Disable overlay scrollbars in gtk3. >_<
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
WORDCHARS=${WORDCHARS//\/[&.;]}                             # Don't consider certain characters part of the word

bindkey -e
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit colors
compinit
colors

# Custom aliases
alias sudo='sudo '
[[ -f /usr/sbin/acp ]] && alias cp='acp -g'  # advcp w/progress bar
[[ -f /usr/sbin/amv ]] && alias mv='amv -g'  # advcp w/progress bar
[[ ! -f /usr/sbin/acp ]] && alias cp='cp -i' # Confirm before overwriting something
alias df='df -h'                             # Human-readable sizes
alias free='free -m'                         # Show sizes in MB
alias vim="stty stop '' -ixoff ; vim"        # Fix <c-s> terminal hang
alias ed='vim'
alias u='cd ..'
alias ll='ls -l' 
alias la='ls -a' 
alias l.='ls -d .[^.]*' # List .dirs
alias lsd='ls -ld *(-/DN)' # List dirs & symlinks to dirs
alias lsg='ls -hal | grep -i --color=auto' # ls grep
alias new='ls -hlt | grep -v "^total" | head' 
alias old='ls -ltr | grep -v "^total" | head' 
alias psg='ps -efw | grep -v grep | grep --color=auto $*' # ps grep
alias pst='ps -ef --sort=pcpu | tail' # Most cpu use
alias psm='ps -ef --sort=vsize | tail' # Most mem use
alias mc='mc -b' 
alias mnt='mount | column -t'
alias powertop='sudo powertop' 
alias mpv='mpv -fs -af scaletempo --really-quiet --speed=1.5'
alias lp='lsof -Pnl +M -i4' # lsof ports
alias np='netstat -ptunl|egrep -vi unix\|-' # netstat ports
alias big='du -sh * | sort -hr' 
alias bh='big | head' 
alias todo='$VISUAL ~/Documents/todo/'
alias wpi='strings -e l' # Windows program info
alias isp='whois $(curl -s ifconfig.me) | grep -v "^#\|^%"'
alias pip='curl -s ifconfig.me' # Public ip
#alias pip='dig +short myip.opendns.com @resolver1.opendns.com' # Public ip
alias tts='xsel | text2wave | mpv -af scaletempo --speed=1.7 -'
alias grab='ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq ~/Videos/screengrab.mpg'
#alias grab='ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -r 30 -s `xdpyinfo | grep "dimensions:"|awk "{print $2}"` -i :0.0 -acodec pcm_s16le screengrab.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 screengrab.mp4'
alias jerr='journalctl -p3 -xb' # Journalctl errors this boot

# Functions
mcd() { mkdir "$1" && cd "$1"; } # make dir and cd
fnd () { find . -iname \*$*\* | less } # find
cdl () { cd "$*" && ls -halt; } # cd and list
genpw () { head /dev/urandom | uuencode -m - | sed -n 2p | cut -c1-${1:-16}; }
alarm () { sleep $*; mpv --loop=inf /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga }
wk () { kill $(ps -ef | grep '.exe' | grep -v 'Do.exe\|KeePass\|TeamViewer\|gvfs\|grep' | awk '{print $2}') } # wine kill
wk9 () { kill -9 $(ps -ef | grep '.exe' | grep -v 'Do.exe\|KeePass\|TeamViewer\|gvfs\|grep' | awk '{print $2}') } # wine kill -9
fwh () { file $(which $*) } # file which
lg () { sudo grep --color=auto -ir $* /var/log/* } # log grep
err () { cat "$*"|grep -E --line-buffered --color=auto 'ERROR|error|CRITICAL|WARN|$' } # search a logfile for issues
errt () { tail -f "$*"|grep -E --line-buffered --color=auto 'ERROR|error|CRITICAL|WARN|$' } # watch a logfile for issues

# Pacman-based distros:
[[ -f ~/.zpac.zsh ]] && source ~/.zpac.zsh
# Deb-based distros:
[[ -f ~/.zubuntu.zsh ]] && source ~/.zubuntu.zsh

# Personal:
#==========
# Desktop-only stuff:
[[ -f ~/.zdesk.zsh ]] && source ~/.zdesk.zsh
# Laptop-only stuff:
[[ -f ~/.zlap.zsh ]] && source ~/.zlap.zsh
# Personal custom aliases, functions:
[[ -f ~/.zalias.zsh ]] && source ~/.zalias.zsh

# Key bindings
#=============
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
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
bindkey "\e[3~" delete-char # Del

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

# Phil's custom prompt
# http://aperiodic.net/phil/prompt/prompt.txt
# Bender apm fix
# https://gist.github.com/bender-the-greatest/802e33cc20d0685c33715c3b8d035af5
source ~/.zprompt.zsh

# zsh-syntax-highlighting and autosuggestion
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/zsh-autosuggestions/zsh-autosuggestions.zsh
