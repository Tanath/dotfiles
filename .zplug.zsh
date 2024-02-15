[[ -f ~/.zplug/init.zsh ]] && \
    export ZPLUG_HOME=~/.zplug && \
    source ~/.zplug/init.zsh || \
    echo "Install zplug:\ngit clone https://github.com/zplug/zplug ~/.zplug"

# pl10k prompt
zplug romkatv/powerlevel10k, as:theme, depth:1

# Colour man pages
zplug "ael-code/zsh-colored-man-pages"

# Fish-like autosuggestions for zsh
zplug "zsh-users/zsh-autosuggestions"

# Syntax highlighting in zsh
zplug "zdharma/fast-syntax-highlighting"

# Z plugin: jump to 'frecent' dirs
#zplug "agkozak/zsh-z"
# Switched to zoxide

# Prefix command with doas by pressing esc twice
zplug "anatolykopyl/doas-zsh-plugin"

# Access external clipboards in vi-mode keymaps, and synchronize registers
zplug "zsh-vi-more/evil-registers"

# Zsh easy motion, like Vim's
#zplug "IngoHeimbach/zsh-easy-motion"
#bindkey -M vicmd '#' vi-easy-motion

# Replace zsh's default completion selection menu with fzf
zplug "Aloxaf/fzf-tab"

# Git + fzf
zplug "wfxr/forgit"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
