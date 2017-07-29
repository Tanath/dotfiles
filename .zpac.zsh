alias pm='sudo pacmatic'
alias pmr='sudo pacmatic -R' # Pacman remove
alias pmc='sudo pacmatic -Sc' # Clean cache
alias pmrc='sudo pacmatic -Rns' # Pacman remove w/config
alias pms='pacmatic -Ss' # Pacman search
alias pmls='pacmatic -Qs' # Local search
alias pmu='sudo pacmatic -Syu' # Pacman upgrade
alias pml='pacmatic -Ql' # List (files)
alias pmo='pacmatic -Qqtd' # Orphans
alias pa='pacaur'
alias pau='pacaur -Syu' # Pacaur upgrade
alias pas='pacaur -Ss' # Pacaur search
alias par='pacaur -R' # Pacaur remove
alias parc='pacaur -Rns' # Pacaur remove w/config
alias mk='makepkg'
alias mks='makepkg -s'
alias mki='makepkg -is'
alias cws='cower -s' # Cower search
alias cwd='cower -d' # Cower download
alias cwdd='cower -dd' # Cower download w/depends
alias cwu='cower -du' # Cower download upgrades
alias svc='systemctl' # Services
bin () { pacmatic -Ql $* | grep --color=auto bin/ | awk '{print $2}' } # binaries from package
#bin () { pkgfile -l $* | grep --color=auto bin/ }
owns () { pacmatic -Qo $(which $*) } # Ownership of binary

