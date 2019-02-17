(( $+commands[vim] )) && export EDITOR=vim
(( $+commands[vim] )) && export VISUAL=vim
#export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'gvim'; else echo 'vim'; fi)"
# This may break some apps, like Dropbox device linking? Get url from ps.
if (( $+DISPLAY )); then export BROWSER=xdg-open; else export BROWSER=w3m; fi
