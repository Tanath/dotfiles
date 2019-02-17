[[ -n ${commands[tsudo]} ]] && alias sudo='tsudo '         # For Termux
[[ -n ${commands[ag]} ]] && lg () { tsudo ag $* /var/log/ } || lg () { tsudo grep $GPARAM -ir $* /var/log/* } # log grep

