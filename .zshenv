# Custom environment variables
export SOCKS_VERSION=5
#export SDL_AUDIODRIVER=pulse
#[[ -d /usr/share/themes/Numix-DarkBlue/ ]] \
#   && export GTK_THEME=Numix-DarkBlue \
#   || export GTK_THEME=Adwaita:dark # For gtk3
[[ -d ~/.themes/oomox-materia-dark-mod3 ]] \
    && export GTK_THEME=oomox-materia-dark-mod3 \
    || export GTK_THEME=Adwaita:dark   # For gtk3
export GTK_OVERLAY_SCROLLING=0         # Disable overlay scrollbars in gtk3. >_<
command -v qt5ct >/dev/null 2>&1 \
    && export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

(( $+commands[vim] )) \
    && export EDITOR=vim \
    && export VISUAL=vim \
    && export SYSTEMD_EDITOR=vim
(( $+commands[less] )) \
    && export PAGER=less \
    && export LESS='-RFXe'
export COLUMNS  # Remember columns for subprocesses.
# This may break some apps, like Dropbox device linking? Get url from ps.
if (( $+DISPLAY )); then
	export BROWSER=xdg-open
else
	(( $+commands[w3m] )) \
	    && export BROWSER=w3m \
	    || export BROWSER=elinks
fi

# Add local bin dirs to PATH
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Exit if not interactive shell
[[ -o interactive ]] || return

(( $+commands[vivid] )) \
    && export LS_COLORS="$(vivid generate molokai)"
(( $+commands[exa] )) && export EXA_COLORS="da=32"
(( $+commands[fzf] )) \
    && export FZF_DEFAULT_OPTS='--bind "alt-a:select-all,alt-d:deselect-all"' \
    && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'" \
    && export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
if (( $+commands[fzf] )) && (( $+commands[rg] )); then
    export FZF_DEFAULT_COMMAND='rg --hidden -l .';
elif (( $+commands[fzf] )) && (( $+commands[ag] )); then
    export FZF_DEFAULT_COMMAND='ag --hidden -l';
fi
(( $+commands[sk] )) \
    && export SKIM_DEFAULT_OPTS='--bind "alt-a:select-all,alt-d:deselect-all"'

