# Custom aliases & function
if [[ -x "`whence -p dircolors`" ]]; then
    LSPARAMS=(-CFh --group-directories-first --time-style=long-iso --color=always)
else
    LSPARAMS=(-CFh --group-directories-first --time-style=long-iso)
fi
echo | grep --color=auto '' >/dev/null 2>&1 && GPARAM='--color=auto' || GPARAM=''
(( $+commands[sudo] )) && alias sudo='sudo '
(( $+commands[acp] )) \
    && alias cp='acp -gi' \
    || alias cp='cp -i'                    # advcp w/progress bar, confirm overwrite
(( $+commands[amv] )) \
    && alias mv='amv -gi' \
    || alias mv='mv -i'                    # advcp w/progress bar, confirm overwrite
(( $+commands[dfc] )) \
    && alias df=dfc \
    || alias df='df -h'
alias dmesg='dmesg -H --color=always'
(( $+commands[systemctl] )) \
    && alias sc='systemctl'
(( $+commands[fzf] )) \
    && alias fm='fzf -m --tac' \
    && alias dmf='dmesg | fm +s' \
    && alias o='xdg-open "$(fzf)"' \
    && alias psf='ps -ef | fm' \
    && alias spf='ss -ptunl|egrep -vi unix | fm'
(( $+commands[fzf] )) \
    && lf () { locate -i "$@" | fm +s }
alias free='free -h'                                       # Show sizes in MB
alias vim="stty stop '' -ixoff; vim"                       # Avoid <c-s> terminal hang. <c-q> resumes.
alias vimdiff="stty stop '' -ixoff; vimdiff"               # Avoid <c-s> terminal hang. <c-q> resumes.
alias vd='vimdiff'
alias v=vim
alias ed='vim'
alias u='cd ..'
alias uu='cd ../..'                                        # Up twice or to /
# ls () { command ls $LSPARAMS "$@" | less -RFX }
if (( $+commands[exa] )); then
    alias ls='exa -Fhs=type --icons'
    alias ll='exa -Flhs=type --icons'                      # List long
    alias la='exa -Fahs=type --icons'                      # List all
    alias lla='exa -Falhs=type --icons'                    # List all long
    alias lz='exa -Flhs=size --icons'                      # List by size
    alias lt='exa -Flhs=modified --icons'                  # List by time
    alias lx='exa -Fhs=type --icons'                       # List by type
else
    alias ls="ls ${LSPARAMS} "$@" | less -RFX"
    alias ll="\ls -l ${LSPARAMS} "$@" | less -RFX"         # List long. TODO
    alias la="\ls -a ${LSPARAMS} "$@" | less -RFX"         # List all
    alias lla="\ls -la ${LSPARAMS} "$@" | less -RFX"       # List all long
    alias lz="\ls -lrS "$@" | less -RFX"                   # List by size
    alias lt="\ls -lrT "$@" | less -RFX"                   # List by time
    alias lx="\ls -lBX "$@" | less -RFX"                   # sort by ext
    alias l.="\ls ${LSPARAMS} -d .[^.]*"                   # List .dirs
    alias lsd="\ls ${LSPARAMS} *(-/DN)"                    # List dirs & symlinks to dirs
fi
(( $+commands[exa] )) \
    && alias new='exa -Flhrs=modified --icons' \
    && alias old='exa -Flhs=modified --icons' \
    || alias new=ls\ -lt\ $LSPARAMS\ '| grep -v "^total" | head' \
    && alias old=ls\ -ltr\ $LSPARAMS\ '| grep -v "^total" | head'
alias psg='ps -efw | grep -v grep | grep '$GPARAM' $*'     # ps grep
alias pst='ps -ef --sort=pcpu | tail'                      # Most cpu use
alias psm='ps -ef --sort=vsize | tail'                     # Most mem use
(( $+commands[topgrade] )) && alias tg='topgrade'
alias mc='mc -b'
alias mnt='mount | column -t'
alias lsblk='lsblk -f'
alias powertop='sudo powertop'
alias lp='ss -np4'                                         # lsof ports
#alias lp='lsof -Pnl +M -i4'                                # lsof ports
alias ssp='ss -ptunl|egrep -vi unix\|-'                    # ss ports
alias big='du -sh * | sort -hr'
alias bh='big | head'
alias t='cat .todo | less -RFX'
alias vt='vim .todo'
alias gpl='git pull'
alias gcm='git commit -am'
alias gps='git push'
alias jerr='journalctl -eaxp4 -b'                          # Journalctl errors this boot
alias wpi='strings -e l'                                   # Windows program info
alias isp='whois $(curl -s ifconfig.me) | grep -v "^#\|^%"'
alias ipa='curl -s ifconfig.me'                            # Public ip
#alias ipa='dig +short myip.opendns.com @resolver1.opendns.com'  # Public ip
alias hibp='(echo -n "Password: "; read -s pw; curl -s https://api.pwnedpasswords.com/range/$(echo -n $pw | shasum | cut -b 1-5) | grep $(echo -n $pw | shasum | cut -b 6-40 | tr a-f A-F))'
alias tts='xsel | text2wave | mpv --af=scaletempo --speed=1.7 -'
alias grab='ffmpeg -f x11grab -s wxga -i :0.0 -qscale 0 ~/Videos/screengrab-'\`date\ +%H-%M-%S\`'.mpg'
#alias grab='ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -s `xdpyinfo | grep "dimensions:"|awk "{print $2}"` -i :0.0 -acodec pcm_s16le screengrab-'\`date\ +%H-%M-%S\`'.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 screengrab-'`date +%H-%M-%S`'.mp4'
alias map='telnet mapscii.me'
alias wttr='curl wttr.in/hamilton'
(( $+commands[zathura] )) \
    && alias pdfs='lsof | grep "\.pdf" | grep zathura | sed "s/\s\+/ /g" | cut --complement -d" " -f-8'
#alias wtf='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
(( $+commands[youtube-dl] )) \
    && alias ytnp='youtube-dl --no-playlist' \
    && alias yta='youtube-dl -x --add-metadata --embed-thumbnail' \
    && yt () { youtube-dl -c -f 18/22 $* }
alias rserv='ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => 8001, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"'
alias avfix='sudo sysctl -w kernel.shmmax=100000000'
(( $+commands[deadbeef] )) \
    && alias dbp='deadbeef --nowplaying "%a - %t | %e/%l\"'
alias dp='xclip -o | curl -s -F "content=<-" https://dpaste.com/api/' # selection to dpaste
alias dpc='xclip -o -sel clip | curl -s -F "content=<-" https://dpaste.com/api/' # clipboard to dpaste
lsg () { ls -Fhal | grep -i $GPARAM "$*" }                 # ls grep
mcd () { mkdir "$1" && cd "$1" }                           # make dir and cd
fnd () { find . -iname \*$*\* | less -RFX }                # find
(( $+commands[exa] )) \
    && cdl () { cd "$*" && exa -Flhs=type --icons } \
    || cdl () { cd "$*" && ls -al $LSPARAMS }              # cd and list
(( $+commands[ag] )) \
    && vq () { vim -q <(ag "$*") } \
    && lg () { sudo ag -C $* /var/log/ } \
    || vq () { vim -q <(grep -i "$*") } \
    && lg () { sudo grep $GPARAM -ir $* /var/log/* }
(( $+commands[mpv] )) \
    && alarm () { sleep $1; mpv --loop=inf /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga } \
    && mya () { mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*" }
    aw () { local url="https://wiki.archlinux.org/index.php?title=Special%3ASearch&search=$*"; exo-open "$url" }
genpw () { LC_ALL=C tr -dc '!-~' </dev/urandom | fold -w 20 | head -n 10 }
mkpw () { head -c 24 /dev/urandom | base64 }
fwh () { file =$1 }                                        # file which
rgf () {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}
