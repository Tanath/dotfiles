#dpl (DPkg List package files)
alias dpl='dpkg -L'
#dqs (Dpkg-Query Search) to find what package owns a file
alias dqs='dpkg-query -S'
#ain (Apt INstall)
alias ain='sudo apt install'
#arm (Apt ReMove)
alias arm='sudo apt remove'
#apu (Apt PUrge)
alias apu='sudo apt purge'
#aud (Apt UpDate)
alias aud='sudo apt update'
#aug (Apt UpGrade)
alias aug='sudo apt upgrade'
#adu (Apt Dist-Upgrade)
alias adu='sudo apt dist-upgrade'
#afu (Apt Full-Upgrade)
alias afu='sudo apt full-upgrade'
#ase (Apt SEarch)
alias ase='apt search'
#ali (Apt LIst)
alias ali='apt list'
#ash (Apt SHow)
alias ash='apt show'
#acl (Apt ChangeLog)
alias acl='apt changelog'
#aar (Apt AutoRemove)
alias aar='sudo apt autoremove'
#atin (AptiTude INstall)
alias atin='sudo aptitude install'
#atrm (AptiTude ReMove)
alias atrm='sudo aptitude remove'
#atp (AptiTude Purge)
alias atp='sudo aptitude purge'
#atu (AptiTude Update)
alias atu='sudo aptitude update'
#atsu (AptiTude Safe-Upgrade)
alias atsu='sudo aptitude safe-upgrade'
#atfu (AptiTude Full-Upgrade)
alias atfu='sudo aptitude full-upgrade'
#atse (AptiTude SEarch)
alias atse='aptitude search'
#atsh (AptiTude SHow)
alias atsh='aptitude show'
#atcl (AptiTude ChangeLog)
alias atcl='aptitude changelog'
#atma (AptiTude MarkAuto)
alias atma='sudo aptitude markauto'
#bin (show BINaries from package)
bin () { dpkg -L "$@" | grep bin/ }
#asl (Apt-cache Search, no Libs)
asl () { apt-cache search "$@" | grep -v '^lib' }

