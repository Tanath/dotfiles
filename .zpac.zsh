(echo | grep --color=auto '' >/dev/null 2>&1) && GPARAM='--color=auto' || GPARAM=''
NOTFOUND="/usr/share/doc/pkgfile/command-not-found.zsh"
[[ -f $NOTFOUND ]] && source $NOTFOUND

[[ -n ${commands[yay]} ]] && alias y='yay'
# Yay install with fzf
[[ -n ${commands[yay]} ]] && alias yi='yay -Slq | fzf -q "$1" -m --preview "yay -Si {1}"| xargs -ro yay -S'
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
alias pms='pacman -Ss'                                     # Pacman search
alias pmls='pacman -Qs'	                                   # Local search
alias pml='pacman -Ql'	                                   # List (files)
alias pmo='pacman -Qtd'	                                   # Orphans
alias owns='pacman -Qo'                                    # Ownership of file
[[ -n ${commands[expac]} ]] && alias bigp='expac -HM "%m %n" | sort -n' # List packages by size
[[ -n ${commands[paru]} ]] && alias p='paru'
# Paru install with fzf
[[ -n ${commands[paru]} ]] && alias pi='paru -Slq | fzf -q "$1" -m --preview "paru -Si {1}"| xargs -ro paru -S'
[[ -n ${commands[paru]} ]] && alias pu='paru -Syu'    # Paru upgrade
[[ -n ${commands[paru]} ]] && alias pas='paru -Ss'    # Paru search
[[ -n ${commands[paru]} ]] && alias pr='paru -R'      # Paru remove
[[ -n ${commands[paru]} ]] && alias pc='paru -Sc'     # Paru clean cache
[[ -n ${commands[paru]} ]] && alias prc='paru -Rns'   # Paru remove w/config

[[ -n ${commands[vimdiff]} ]] && export DIFFPROG=vimdiff # pacdiff
[[ -n ${commands[jq]} ]] && aurj () { curl -sSL "https://aur.archlinux.org/rpc/?v=5&type=search&arg=$@" | jq -r '.results[]' }

alias paclog='egrep "pac(new|save)" /var/log/pacman.log'
alias lpac='locate --existing --regex "\.pac(new|save)$"'
alias mk='makepkg'
alias mks='makepkg -s'
alias mki='makepkg -is'
bin () { pacman -Ql $* | grep $GPARAM bin/ | awk '{print $2}' } # Binaries from package
#[[ -n ${commands[pkgfile]} ]] && bin () { pkgfile -l $* | grep $GPARAM bin/ }
