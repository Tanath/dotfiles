(echo | grep --color=auto '' >/dev/null 2>&1) && GPARAM='--color=auto' || GPARAM=''
NOTFOUND="/usr/share/doc/pkgfile/command-not-found.zsh"
[[ -f $NOTFOUND ]] && source $NOTFOUND

[[ -n ${commands[yay]} ]] && alias y='yay'
[[ -n ${commands[yay]} ]] && alias yu='yay -Syu'           # Yay upgrade
[[ -n ${commands[yay]} ]] && alias yud='yay -Syu --devel'  # Yay upgrade incl. git
[[ -n ${commands[yay]} ]] && alias ys='yay -Ss'            # Yay search
[[ -n ${commands[yay]} ]] && alias yr='yay -R'             # Yay remove
[[ -n ${commands[yay]} ]] && alias yc='yay -Sc'            # Yay clean cache
[[ -n ${commands[yay]} ]] && alias yrc='yay -Rns'          # Yay remove w/config
[[ -n ${commands[pacui]} ]] && alias p='pacui'
[[ -n ${commands[pacmatic]} ]] && alias pm='sudo pacmatic' || alias pm='sudo pacman'
[[ -n ${commands[pacmatic]} ]] && alias pmr='sudo pacmatic -R' || alias pmr='sudo pacman -R'       # Pacman remove
[[ -n ${commands[pacmatic]} ]] && alias pmc='sudo pacmatic -Sc' || alias pmc='sudo pacman -Sc'     # Clean cache
[[ -n ${commands[pacmatic]} ]] && alias pmrc='sudo pacmatic -Rns' || alias pmrc='sudo pacman -Rns' # Remove w/config
[[ -n ${commands[pacmatic]} ]] && alias pmu='sudo pacmatic -Syu' || alias pmu='sudo pacman -Syu'   # Pacman upgrade
alias pms='pacman -Ss'             # Pacman search
alias pmls='pacman -Qs'	           # Local search
alias pml='pacman -Ql'	           # List (files)
alias pmo='pacman -Qtd'	           # Orphans
owns () { pacman -Qo $(which $*) } # Ownership of binary
[[ -n ${commands[pacaur]} ]] && alias pa='pacaur'
[[ -n ${commands[pacaur]} ]] && alias pau='pacaur -Syu'  # Pacaur upgrade
[[ -n ${commands[pacaur]} ]] && alias pas='pacaur -Ss'   # Pacaur search
[[ -n ${commands[pacaur]} ]] && alias par='pacaur -R'    # Pacaur remove
[[ -n ${commands[pacaur]} ]] && alias pac='pacaur -Sc'   # Pacaur clean cache
[[ -n ${commands[pacaur]} ]] && alias parc='pacaur -Rns' # Pacaur remove w/config

[[ -n ${commands[vimdiff]} ]] && export DIFFPROG=vimdiff # pacdiff
[[ -n ${commands[jq]} ]] && aurj () { curl -sSL "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$@" | jq -r '.results[]' }

alias paclog='egrep "pac(new|save)" /var/log/pacman.log'
alias lpac='locate --existing --regex "\.pac(new|save)$"'
alias mk='makepkg'
alias mks='makepkg -s'
alias mki='makepkg -is'
bin () { pacman -Ql $* | grep $GPARAM bin/ | awk '{print $2}' } # Binaries from package
#[[ -n ${commands[pkgfile]} ]] && bin () { pkgfile -l $* | grep $GPARAM bin/ }
