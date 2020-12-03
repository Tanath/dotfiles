# Custom environment variables
export SOCKS_VERSION=5
export SDL_AUDIODRIVER=pulse
#[[ -d /usr/share/themes/Numix-DarkBlue/ ]] && export GTK_THEME=Numix-DarkBlue || export GTK_THEME=Adwaita:dark # For gtk3
[[ -d ~/.themes/oomox-materia-dark-mod1 ]] \
    && export GTK_THEME=oomox-materia-dark-mod1 \
    || export GTK_THEME=Adwaita:dark   # For gtk3
export GTK_OVERLAY_SCROLLING=0         # Disable overlay scrollbars in gtk3. >_<
