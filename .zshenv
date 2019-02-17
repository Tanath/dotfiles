[[ -n $+commands[vim] ]] && export EDITOR=vim
[[ -n $+commands[vim] ]] && export VISUAL=vim
#export VISUAL="$(if [[ -n $DISPLAY ]]; then echo 'gvim'; else echo 'vim'; fi)"
# This may break some apps, like Dropbox device linking? Get url from ps.
if [[ -n $DISPLAY ]]; then export BROWSER=xdg-open; else export BROWSER=w3m; fi
