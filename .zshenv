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

# Exit if not interactive shell
[[ $- != *i* ]] && return

(( $+commands[vivid] )) \
    && export LS_COLORS="$(vivid generate molokai)"
(( $+commands[exa] )) && export EXA_COLORS="da=32"
(( $+commands[fzf] )) \
    && export FZF_DEFAULT_OPTS='--bind "alt-a:select-all,alt-d:deselect-all"' \
    && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'" \
    && export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
(( $+commands[fzf] )) && (( $+commands[rg] )) \
    && export FZF_DEFAULT_COMMAND='rg --hidden -l' \
    || (( $+commands[fzf] )) && (( $+commands[ag] )) \
    && export FZF_DEFAULT_COMMAND='ag --hidden -l'
(( $+commands[sk] )) \
    && export SKIM_DEFAULT_OPTS='--bind "alt-a:select-all,alt-d:deselect-all"'

