if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi
NOTFOUND="/usr/share/doc/pkgfile/command-not-found.bash"
[[ -f $NOTFOUND ]] && source $NOTFOUND

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export EDITOR=vim
export VISUAL=vim
#export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'gvim'; else echo 'vim'; fi)"
[[ -d /usr/share/themes/Numix-DarkBlue ]] && export GTK_THEME=Numix-DarkBlue || export GTK_THEME=Adwaita:dark # For gtk3
GTK_OVERLAY_SCROLLING=0 # Disable overlay scrollbars in gtk3. >_<
if [[ -n $DISPLAY ]]; then BROWSER=xdg-open; else BROWSER=elinks; fi

# Custom aliases
LSPARAMS='--group-directories-first --time-style=long-iso --color=auto -F'
alias sudo='sudo '
[[ -n ${commands[acp]} ]] && alias cp='acp -gi' || alias cp='cp -i' # advcp w/progress bar, confirm overwrite
[[ -n ${commands[amv]} ]] && alias mv='amv -gi' || alias mv='mv -i' # advcp w/progress bar, confirm overwrite
[[ -n ${commands[dfc]} ]] && alias df=dfc || alias df='df -h'
alias free='free -h'                        # Show sizes in MB
alias vim="stty stop '' -ixoff; vim"        # Fix <c-s> terminal hang
alias ed='vim'
alias u='cd ..'
alias ll=ls\ -lh\ $LSPARAMS
alias la=ls\ -ah\ $LSPARAMS
alias l.='ls $LSPARAMS -hd .[^.]*'          # List .dirs
alias lsd="ls --group-directories-first --time-style=long-iso --color=auto -F *(-/DN)" # List dirs & symlinks to dirs
alias lsg=ls\ -hal\ $LSPARAMS\ '| grep -i --color=auto' # ls grep
alias new=ls\ -hlt\ $LSPARAMS\ '| grep -v "^total" | head' 
alias old=ls\ -hltr\ $LSPARAMS\ '| grep -v "^total" | head' 
alias psg='ps -efw | grep -v grep | grep --color=auto $*' # ps grep
alias pst='ps -ef --sort=pcpu | tail'       # Most cpu use
alias psm='ps -ef --sort=vsize | tail'      # Most mem use
alias mc='mc -b' 
alias mnt='mount | column -t'
alias lsblk='lsblk -o +FSTYPE,LABEL,UUID'
alias dmesg='dmesg --color=always'
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
cdl () { cd "$*" && ls -hal --group-directories-first --time-style=long-iso --color=auto -F; } # cd and list
genpw () { head /dev/urandom | uuencode -m - | sed -n 2p | cut -c1-${1:-16}; }
alarm () { sleep $*; mpv --loop=inf /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga }
wk () { kill $(ps -ef | grep '.exe' | grep -v 'Do.exe\|KeePass\|TeamViewer\|gvfs\|grep' | awk '{print $2}') } # wine kill
wk9 () { kill -9 $(ps -ef | grep '.exe' | grep -v 'Do.exe\|KeePass\|TeamViewer\|gvfs\|grep' | awk '{print $2}') } # wine kill -9
fwh () { file $(which $*) } # file which
lg () { sudo grep --color=auto -ir $* /var/log/* } # log grep
err () { cat "$*"|grep -E --line-buffered --color=auto 'ERROR|error|CRITICAL|WARN|$' } # search a logfile for issues
errt () { tail -f "$*"|grep -E --line-buffered --color=auto 'ERROR|error|CRITICAL|WARN|$' } # watch a logfile for issues

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# prompt
PS1='[\u@\h \W]\$ '
