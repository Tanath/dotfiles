## Custom aliases & functions.

# Disable globbing for these commands as they do their own.
alias find='noglob find'

## Common utils.
echo | grep --color=auto '' >/dev/null 2>&1 && GPARAM='--color=auto' || GPARAM=''
(( $+commands[sudo] )) \
    && alias sudo='sudo ' \
    && alias se=sudoedit
(( $+commands[systemctl] )) \
    && alias sc='systemctl' \
    && alias jerr='journalctl -eaxp4 -b'                   # Journalctl errors this boot
(( $+commands[fzf] )) \
    && alias fm='fzf -m --tac' \
    && alias o='xdg-open "$(fzf)"'
alias dp='xclip -o | curl -s -F "content=<-" https://dpaste.com/api/' # selection to dpaste
alias dpc='xclip -o -sel clip | curl -s -F "content=<-" https://dpaste.com/api/' # clipboard to dpaste
function 0x() {
    if [[ -z $1 ]]; then
        echo "Missing file name."
    else
        curl -F "file=@$1" https://0x0.st
    fi
}

## Navigation.
if [[ -x "`whence -p dircolors`" ]]; then
    LSPARAMS=(-CFh --group-directories-first --time-style=long-iso --color=always)
else
    LSPARAMS=(-CFh --group-directories-first --time-style=long-iso)
fi
# ls () { command ls $LSPARAMS "$@" | less }
alias z=cd
(( $+commands[fzf] )) \
    && alias fcd='cd $(locate -r "/[^\.]*$" | fzf --algo=v1 +s )' \
    && lf () { locate -i "$@" | fzf -m --tac +s }
alias u='cd ..'
alias uu='cd ../..'                                        # Up twice or to /
lsg () { ls -Fhal | grep -i $GPARAM "$*" }                 # ls grep
mcd () { mkdir "$1" && cd "$1" }                           # make dir and cd
if (( $+commands[eza] )); then
    alias ls='eza -Fhs=type --icons'
    alias ll='eza -Flhs=type --icons'                      # List long
    alias la='eza -Fahs=type --icons'                      # List all
    alias lla='eza -Falhs=type --icons'                    # List all long
    alias lz='eza -Flhs=size --icons'                      # List by size
    alias lt='eza -Flhs=modified --icons'                  # List by time
    alias lx='eza -Fhs=type --icons'                       # List by type
else
    alias ls="ls ${LSPARAMS} "$@" | less"
    alias ll="\ls -l ${LSPARAMS} "$@" | less"              # List long. TODO
    alias la="\ls -a ${LSPARAMS} "$@" | less"              # List all
    alias lla="\ls -la ${LSPARAMS} "$@" | less"            # List all long
    alias lz="\ls -lrS "$@" | less"                        # List by size
    alias lt="\ls -lrT "$@" | less"                        # List by time
    alias lx="\ls -lBX "$@" | less"                        # sort by ext
    alias l.="\ls ${LSPARAMS} -d .[^.]*"                   # List .dirs
    alias lsd="\ls ${LSPARAMS} *(-/DN)"                    # List dirs & symlinks to dirs
fi
(( $+commands[eza] )) \
    && alias new='eza -Flhrs=modified --icons' \
    && alias old='eza -Flhs=modified --icons' \
    || { alias new=ls\ -lt\ $LSPARAMS\ '| grep -v "^total" | head' \
    && alias old=ls\ -ltr\ $LSPARAMS\ '| grep -v "^total" | head' }
(( $+commands[eza] )) \
    && cdl () { cd "$*" && eza -Flhs=type --icons } \
    || cdl () { cd "$*" && ls -al $LSPARAMS }              # cd and list
alias mc='mc -b'

## Viewing, editing & managing files.
(( $+commands[batcat] )) \
    && alias b='batcat'
(( $+commands[acp] )) \
    && alias cp='acp -gi' \
    || alias cp='cp -i'                    # advcp w/progress bar, confirm overwrite
(( $+commands[amv] )) \
    && alias mv='amv -gi' \
    || alias mv='mv -i'                    # advcp w/progress bar, confirm overwrite
alias dmesg='dmesg -H --color=always'
(( $+commands[fzf] )) \
    && alias dmf='dmesg | fzf -m --tac +s'
#alias vim="stty stop '' -ixoff; vim"                       # Avoid <c-s> terminal hang. <c-q> resumes. Use \vim to pipe output to vim.
#alias vimdiff="stty stop '' -ixoff; vimdiff"               # Avoid <c-s> terminal hang. <c-q> resumes. Use \vim to pipe output to vim.
alias vd='vimdiff'
alias v=vim
alias ed='vim'
alias t='cat .todo | less'
alias vt='vim .todo'
fnd () { find . -iname \*$*\* | less }
(( $+commands[ag] )) \
    && vq () { vim -q <(ag "$*") } \
    && lg () { sudo ag -C $* /var/log/ } \
    || { vq () { vim -q <(grep -i "$*") } \
    && lg () { sudo grep $GPARAM -ir "$@" /var/log/* } }
(( $+commands[rga] )) && \
rgf () {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" \
	&& echo "opening $file" \
	&& xdg-open "$file"
}
alias gcl='git clone'
alias gss='git status -s'
alias gnow='git log -1 --oneline'
alias gbr='git branch'
alias gsw='git switch'
alias gpl='git pull'
alias gcm='git commit -am'
alias gps='git push'
alias gdi='git diff'
alias gco='git checkout'
alias gst='git stash'
alias grh='git reset --hard'
alias gfiles='git ls-tree --name-only -r $(git name-rev --name-only HEAD)'
alias ggraph='git log --graph --all --pretty=format:"%Cred%h%Creset - %Cgreen(%cr)%Creset %s%C(yellow)%d%Creset" --abbrev-commit --date=relative'
alias xo='xdg-open'
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

## Disks & space.
alias free='free -h'
(( $+commands[dfc] )) \
    && alias df=dfc \
    || alias df='df -h'
alias mnt='mount | column -t'
alias lsblk='lsblk -f'
alias big='du -sh * | sort -hr'
alias bh='big | head'

## Processes.
(( $+commands[fzf] )) \
    && alias psf='ps -ef | fzf -m --tac' \
    && alias spf='ss -ptunl|egrep -vi unix | fzf -m --tac'
alias psg='ps -efw | grep -v grep | grep '$GPARAM' $*'     # ps grep. More info than pgrep.
alias pst='ps -ef --sort=pcpu | tail'                      # Most cpu use.
alias psm='ps -ef --sort=vsize | tail'                     # Most mem use.
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

## Package management.
alias ppin='pip install'
alias ppup='pip install -U'
(( $+commands[topgrade] )) \
    && alias tg='topgrade' \
    || echo 'Topgrade not available.\npip install topgrade'

## Networking.
alias lp='ss -np4'                                         # lsof ports
#alias lp='lsof -Pnl +M -i4'                                # lsof ports
alias ssp='ss -ptunl|egrep -vi unix\|-'                    # ss ports
alias isp='whois $(curl -s ifconfig.me) | grep -v "^#\|^%"'
alias ipa='curl -s ifconfig.me'                            # Public ip
#alias ipa='dig +short myip.opendns.com @resolver1.opendns.com'  # Public ip

## Media.
(( $+commands[mpv] )) \
    && alarm () { sleep $1; mpv --loop=inf /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga } \
    && mya () { mpv --ytdl-format=bestaudio ytdl://ytsearch30:"$*" }
alias tts='xsel | text2wave | mpv --speed=1.7 -'
alias grab='ffmpeg -f x11grab -s wxga -i :0.0 -qscale 0 ~/Videos/screengrab-'\`date\ +%H-%M-%S\`'.mpg'
#alias grab='ffmpeg -y -f alsa -ac 2 -i pulse -f x11grab -s `xdpyinfo | grep "dimensions:"|awk "{print $2}"` -i :0.0 -acodec pcm_s16le screengrab-'\`date\ +%H-%M-%S\`'.wav -an -vcodec libx264 -vpre lossless_ultrafast -threads 0 screengrab-'`date +%H-%M-%S`'.mp4'
(( $+commands[yt-dlp] )) \
    && alias ytnp='yt-dlp --no-playlist' \
    && alias yta='yt-dlp -x --add-metadata --embed-thumbnail' \
    && yt () { yt-dlp -c -f 18/22 $* }
(( $+commands[zathura] )) \
    && alias pdfs='lsof | grep "\.pdf" | grep zathura | sed "s/\s\+/ /g" | cut --complement -d" " -f-8'
(( $+commands[deadbeef] )) \
    && alias dbp='deadbeef --nowplaying "%a - %t | %e/%l\"'

## Misc.
alias powertop='sudo powertop'
aw () { local url="https://wiki.archlinux.org/index.php?title=Special%3ASearch&search=$*"; xdg-open "$url" }
mkpw () { head -c 24 /dev/urandom | base64 }
#genpw () { LC_ALL=C tr -dc '!-~' </dev/urandom | fold -w 24 | head -n 10 }
fwh () { file =$1 }                                        # file which
alias wpi='strings -e l'                                   # Windows program info
alias hibp='(echo -n "Password: "; read -s pw; curl -s https://api.pwnedpasswords.com/range/$(echo -n $pw | shasum | cut -b 1-5) | grep $(echo -n $pw | shasum | cut -b 6-40 | tr a-f A-F))'
alias map='telnet mapscii.me'
alias wttr='curl wttr.in/hamilton'
#alias wtf='eval $(thefuck $(fc -ln -1 | tail -1)); fc -R'
alias rserv='ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => 8001, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"'
alias avfix='sudo sysctl -w kernel.shmmax=100000000'

