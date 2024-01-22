# Exit if not interactive shell
[[ $- != *i* ]] && return

[[ -n ${commands[tsudo]} ]] && alias sudo='tsudo '         # For Termux
[[ -n ${commands[ag]} ]] && lg () { tsudo ag $* /var/log/ } || lg () { tsudo grep $GPARAM -ir $* /var/log/* } # log grep

## ssh
#/data/data/com.termux/files/usr/bin/keychain --nolock ~/.ssh/ssh_host_ed25519_key
#ssh-add ~/.ssh/ssh_host_ed25519_key
#source ~/.ssh-agent > /dev/null
