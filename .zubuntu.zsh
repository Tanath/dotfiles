#dpl (DPkg List package files)
alias dpl='dpkg -L'
#dqs (Dpkg-Query Search) to find what owns a file and stuff.
alias dqs='dpkg-query -S'
#ain (Apt INstall)
alias ain='sudo apt install'
#arm (Apt ReMove)
alias arm='sudo apt remove'
#ash (Apt SHow)
alias ash='apt show'
#aar (Apt AutoRemove)
alias aar='sudo apt autoremove'
#bin (show BINaries from package)
bin () { dpkg -L "$@" | grep bin/ }
#asl (Apt-cache Search, no Libs)
asl () { apt-cache search "$@" | grep -v '^lib' }
