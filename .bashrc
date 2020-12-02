[[ $- != *i* ]] && return

if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi
NOTFOUND="/usr/share/doc/pkgfile/command-not-found.bash"
[[ -f $NOTFOUND ]] && source $NOTFOUND

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell checkwinsize cmdhist dotglob expand_aliases extglob histappend hostcomplete nocaseglob

HISTSIZE=10000
HISTFILESIZE=${HISTSIZE}
HISTCONTROL=ignoreboth
# Custom environment variables
command -v vim >/dev/null 2>&1 \
    && export VISUAL=vim
command -v less >/dev/null 2>&1 \
    && export VISUAL=less
export COLUMNS                            # Remember columns for subprocesses.
command -v vim >/dev/null 2>&1 \
    && export SYSTEMD_EDITOR=vim
export SOCKS_VERSION=5
export SDL_AUDIODRIVER=pulse
#[[ -d /usr/share/themes/Numix-DarkBlue/ ]] && export GTK_THEME=Numix-DarkBlue || export GTK_THEME=Adwaita:dark # For gtk3
[[ -d /usr/share/themes/Menda-Dark/ ]] \
    && export GTK_THEME=Menda-Dark \
    || export GTK_THEME=Adwaita:dark      # For gtk3
[[ -d /usr/share/themes/Numix-DarkBlue ]] \
    && export GTK_THEME=Numix-DarkBlue \
    || export GTK_THEME=Adwaita:dark      # For gtk3
# This may break some apps, like Dropbox device linking? Get url from ps.
if [[ -n $DISPLAY ]]; then
	export BROWSER=xdg-open
	export GTK_OVERLAY_SCROLLING=0        # Disable overlay scrollbars in gtk3. >_<
else
	command -v w3m >/dev/null 2>&1 \
	    && export BROWSER=w3m \
	    || export BROWSER=elinks
fi
if [[ $TERM == 'xterm-kitty' ]]; then
    command -v kitty >/dev/null 2>&1 \
        && source <(kitty + complete setup bash)
fi
if [[ -x "`type dircolors`" ]]; then
    eval `dircolors`
	command -v vivid >/dev/null 2>&1 \
        && export LS_COLORS="$(vivid generate molokai)"
	LSPARAMS='-CFh --group-directories-first --time-style=long-iso --color=always'
else
	LSPARAMS='-CFh --group-directories-first --time-style=long-iso'
fi
#alias ls='ls $LSPARAMS'
echo | grep --color=always '' >/dev/null 2>&1 \
    && GPARAM='--color=always' \
    || GPARAM=''

# Personal custom aliases, functions
[[ -f ~/.balias.bsh ]] && source ~/.balias.bsh
# Pacman-based distros
[[ -f ~/.bpac.bsh ]] && source ~/.bpac.bsh
# Deb-based distros
[[ -f ~/.bubuntu.bsh ]] && source ~/.bubuntu.bsh
# Desktop-only stuff
[[ -f ~/.bdesk.bsh ]] && source ~/.bdesk.bsh
# Laptop-only stuff
[[ -f ~/.blap.bsh ]] && source ~/.blap.bsh
# Mobile-only stuff
[[ -f ~/.bmobile.bsh ]] && source ~/.bmobile.bsh

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# Check for zer0prompt. Needs folder moved to ~ after cloning.
#if [[ -f ~/zer0prompt/zer0prompt.sh ]]; then
#	source ~/zer0prompt/zer0prompt.sh
#	zer0prompt
#	unset zer0prompt

# Use Starship prompt, or install it, or use fallback.
command -v starship >/dev/null 2>&1 \
    && eval "$(starship init bash)" \
    || curl -fsSL https://starship.rs/install.sh | bash \
    || PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\]:\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]-\[\e[33m\]\d\[\e[m\]-\[\e[33m\]\A\[\e[m\]\[\e[36m\]-\[\e[m\]\`parse_git_branch\`> "
    # || PS1='[\u@\h \W]\$ '

# Custom aliases
command -v sudo >/dev/null 2>&1 && alias sudo='sudo '
command -v acp >/dev/null 2>&1 \
    && alias cp='acp -gi' \
    || alias cp='cp -i' # advcp w/progress bar, confirm overwrite
command -v amv >/dev/null 2>&1 \
    && alias mv='amv -gi' \
    || alias mv='mv -i' # advcp w/progress bar, confirm overwrite
command -v dfc >/dev/null 2>&1 \
    && alias df=dfc \
    || alias df='df -h'
command -v systemctl >/dev/null 2>&1 && alias sc='systemctl'    # Services
command -v fzf >/dev/null 2>&1 \
    && alias fm='fzf -m --tac' \
    && alias dmf='dmesg | fm +s' \
    && alias o='xdg-open "$(fzf)"' \
    && alias psf='ps -ef | fm'
alias free='free -h'                                            # Show sizes in MB
alias vim="stty stop '' -ixoff; vim"                            # Fix <c-s> terminal hang
alias vimdiff="stty stop '' -ixoff; vimdiff"                    # Avoid <c-s> terminal hang. <c-q> resumes.
alias ed='vim'
alias u='cd ..'
alias uu='cd ../..'
command -v exa >/dev/null 2>&1 \
    && alias ll='exa -Flhs=type' \
    || alias ll=ls\ -l\ $LSPARAMS
command -v exa >/dev/null 2>&1 \
    && alias la='exa -Fahs=type' \
    || alias la=ls\ -a\ $LSPARAMS
command -v exa >/dev/null 2>&1 \
    && alias lla='exa -Falhs=type' \
    || alias lla=ls\ -la\ $LSPARAMS
command -v exa >/dev/null 2>&1 \
    && alias lz='exa -Fhs=size' \
    || alias lz='ll -rS'
command -v exa >/dev/null 2>&1 \
    && alias lt='exa -Fhs=modified' \
    || alias lt='ll -rT'
command -v exa >/dev/null 2>&1 \
    && alias lx='exa -Fhs=type' \
    || alias lx='ll -BX'                                           # sort by ext
alias l.='ls $LSPARAMS -d .[^.]*'                               # List .dirs
alias lsd=ls\ $LSPARAMS\ '*(-/DN)'                              # List dirs & symlinks to dirs
alias lsg=ls\ -al\ $LSPARAMS\ '| grep -i --color=always'        # ls grep
alias new=ls\ -lt\ $LSPARAMS\ '| grep -v "^total" | head'
alias old=ls\ -ltr\ $LSPARAMS\ '| grep -v "^total" | head'
alias psg='ps -efw | grep -v grep | grep '$GPARAM' $*'          # ps grep
alias pst='ps -ef --sort=pcpu | tail'                           # Most cpu use
alias psm='ps -ef --sort=vsize | tail'                          # Most mem use
alias mc='mc -b'
alias mnt='mount | column -t'
alias lsblk='lsblk -f'
alias dmesg='dmesg --color=always'
alias tg='topgrade'
alias powertop='sudo powertop'
alias mpv='mpv -fs -af scaletempo --really-quiet --speed=1.5'
alias lp='lsof -Pnl +M -i4'                 # lsof ports
alias ssp='ss -ptunl|egrep -vi unix\|-'     # ss ports
alias big='du -sh * | sort -hr'
alias bh='big | head'
alias jerr='journalctl -p3 -xb'             # Journalctl errors this boot
alias wpi='strings -e l'                    # Windows program info
alias isp='whois $(curl -sSL ifconfig.me) | grep -v "^#\|^%"'
alias ipa='curl -sSL ifconfig.me'           # Public ip
#alias ipa='dig +short myip.opendns.com @resolver1.opendns.com' # Public ip
alias hibp='(echo -n "Password: "; read -s pw; curl -sSL https://api.pwnedpasswords.com/range/$(echo -n $pw | shasum | cut -b 1-5) | grep $(echo -n $pw | shasum | cut -b 6-40 | tr a-f A-F))'
alias map='telnet mapscii.me'
alias tts='xsel | text2wave | mpv -af scaletempo --speed=1.7 -'
alias grab='ffmpeg -f x11grab -s wxga -i :0.0 -qscale 0 ~/Videos/screengrab-'\`date\ +%H-%M-%S\`'.mpg'
#alias grab='ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -s `xdpyinfo | grep "dimensions:"|awk "{print $2}"` -i :0.0 -acodec pcm_s16le screengrab-'\`date\ +%H-%M-%S\`'.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 screengrab-'\`date\ +%H-%M-%S\`'.mp4'

# Functions
ls () { command ls $LSPARAMS "$@" | less -RFX; }
mkcd () { mkdir "$1" && cd "$1"; }          # make dir and cd
fnd () { find . -iname \*$*\* | less; }     # find
cdl () { cd "$*" && ls -al $LSPARAMS; }     # cd and list
command -v ag >/dev/null 2>&1 \
    && lg () { sudo ag $* /var/log/; } \
    || lg () { sudo grep $GPARAM -ir $* /var/log/*; } # log grep
command -v fzf >/dev/null 2>&1 \
    && lf () { locate -i "$@" | fm +s; }    # locate & print from fzf multi-select
command -v mpv >/dev/null 2>&1 \
    && alarm () { sleep $*; mpv --loop=inf /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga; }
vq () { vim -q <(ag "$*"); }
mya () { mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"; }
genpw () { LC_ALL=C tr -dc '!-~' </dev/urandom | fold -w 20 | head -n 10; }
wk () { kill $(ps -ef | grep '.exe' | grep -v 'Do.exe\|KeePass\|TeamViewer\|gvfs\|grep' | awk '{print $2}'); } # wine kill
wk9 () { kill -9 $(ps -ef | grep '.exe' | grep -v 'Do.exe\|KeePass\|TeamViewer\|gvfs\|grep' | awk '{print $2}'); } # wine kill -9
fwh () { file $(which $*); } # file which

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
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi;
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
            echo "$0: file is unreadable: '$i'" >&2
            continue
        fi
        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
		    *.tar)
                   c=(bsdtar xvf);;
		    *.iso)
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
            *)     echo "$0: unrecognized file extension: '$i'" >&2
                   continue;;
        esac
        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e";
}

ghc () {
  [[ -z "$1" ]] && echo "need 'user/repo'" && return 1
  git clone git://github.com/"$1".git
  cd `echo "$1" | sed 's/^.*\///'`
  echo cd `pwd`;
}
