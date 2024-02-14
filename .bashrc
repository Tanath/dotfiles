xhost +local:root > /dev/null 2>&1
# Custom environment variables
command -v vim >/dev/null 2>&1 \
    && export EDITOR=vim \
    && export VISUAL=vim \
    && export SYSTEMD_EDITOR=vim
command -v qt5ct >/dev/null 2>&1 \
    && export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
[[ -d ~/.themes/oomox-materia-dark-mod1 ]] \
    && export GTK_THEME=oomox-materia-dark-mod1 \
    || export GTK_THEME=Adwaita:dark      # For gtk3
export COLUMNS                            # Remember columns for subprocesses.
export SOCKS_VERSION=5
export SDL_AUDIODRIVER=pulse
#[[ -d /usr/share/themes/Numix-DarkBlue/ ]] && export GTK_THEME=Numix-DarkBlue || export GTK_THEME=Adwaita:dark # For gtk3
# This may break some apps, like Dropbox device linking? Get url from ps.
if [[ -n $DISPLAY ]]; then
	export BROWSER=xdg-open
	export GTK_OVERLAY_SCROLLING=0        # Disable overlay scrollbars in gtk3. >_<
else
	command -v w3m >/dev/null 2>&1 \
	    && export BROWSER=w3m \
	    || export BROWSER=elinks
fi

# Add local bin dirs to PATH
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Exit if not interactive shell
[[ $- != *i* ]] && return

if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi
NOTFOUND="/usr/share/doc/pkgfile/command-not-found.bash"
[[ -f $NOTFOUND ]] && source $NOTFOUND

complete -cf sudo

shopt -s cdspell checkwinsize cmdhist dotglob expand_aliases extglob histappend hostcomplete nocaseglob

HISTSIZE=10000
HISTFILESIZE=${HISTSIZE}
HISTCONTROL=ignoreboth
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

