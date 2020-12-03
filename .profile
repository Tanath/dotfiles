command -v vim >/dev/null 2>&1 \
    && export EDITOR=vim \
    && export VISUAL=vim \
    && export SYSTEMD_EDITOR=vim
command -v fzf >/dev/null 2>&1 \
    && export FZF_DEFAULT_OPTS='--bind "alt-a:select-all,alt-d:deselect-all"'
command -v qt5ct >/dev/null 2>&1 \
    && export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
[[ -d ~/.themes/oomox-materia-dark-mod1 ]] \
    && export GTK_THEME=oomox-materia-dark-mod1 \
    || export GTK_THEME=Adwaita:dark   # For gtk3
