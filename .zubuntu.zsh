alias dpl='dpkg -L'
alias dqs='dpkg-query -S'
alias ain='sudo apt install'
alias arm='sudo apt remove'
alias ash='apt show'
alias aar='sudo apt autoremove'
bin () { dpkg -L "$@" | grep bin/ }
asl () { apt-cache search "$@" | grep -v '^lib' }

