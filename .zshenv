(( $+commands[exa] )) && export EXA_COLORS="da=32"
(( $+commands[vim] )) \
    && export EDITOR=vim \
    && export VISUAL=vim \
    && export SYSTEMD_EDITOR=vim
(( $+commands[less] )) && export PAGER=less
export COLUMNS  # Remember columns for subprocesses.
# This may break some apps, like Dropbox device linking? Get url from ps.
if (( $+DISPLAY )); then
	export BROWSER=xdg-open
else
	(( $+commands[w3m] )) \
	    && export BROWSER=w3m \
	    || export BROWSER=elinks
fi
(( $+commands[fzf] )) \
    && export FZF_DEFAULT_OPTS='--bind "alt-a:select-all,alt-d:deselect-all"'
