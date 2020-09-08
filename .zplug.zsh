[[ -f ~/.zplug/init.zsh ]] && export ZPLUG_HOME=~/.zplug && source ~/.zplug/init.zsh
# git clone https://github.com/zplug/zplug $ZPLUG_HOME

# Fish-like autosuggestions for zsh
zplug "zsh-users/zsh-autosuggestions"

# Syntax highlighting in zsh
zplug "zdharma/fast-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
