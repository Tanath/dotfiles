# Tanath's Dotfiles (and related)

My dotfiles, and other config files & system tweaks, and miscellaneous references.

## zsh
This `.zshrc` sources `.zprompt.zsh` for its prompt. You can replace it with your own if it's not to your liking. This uses [Phil's zsh prompt](http://aperiodic.net/phil/prompt/). 
![zsh prompt](http://aperiodic.net/phil/prompt/normal.png)
It sources the following files if they exist:
* `~/.zprompt.zsh`: Phil's prompt. You can replace it with your own.
* `~/.zalias.zsh`: I use this for personalized aliases which aren't distro-specific yet don't belong in `.zshrc`.
* `~/.zpac.zsh`: aliases for pacman-based Linux distros.
* `~/.zubuntu.zsh`: aliases for Debian-based Linux distros. It only has ubuntu in the name for easier tab-completion due to `.zdesk.zsh`.
* `~/.zdesk.zsh`: for desktop-only stuff.
* `~/.zlap.zsh`: for laptop-only stuff.
* `~/.zmobile.zsh`: for mobile-only stuff.

This `.zshrc` gives [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). If you don't have a distro package, clone the repo in `~`:  
`git clone https://github.com/zsh-users/zsh-autosuggestions`  

## vim
The `.vimrc` uses `~/.vim/` and `~/.vim/pack/plugins/` is used for native plugins. They will be created it if they don't exist.
I swap caps & esc in X for better vimming (see `reference/misctweaks.md`). This benefits other programs as well, and doesn't mess with muscle meory. Capslock rarely gets used and esc gets used frequently, it's better that esc is closer and caps is further.  

## bash
This `.bashrc` sources [~/zer0prompt/zer0prompt.sh](https://github.com/zer0ed/zer0prompt) for its prompt, which is similar to Phil's zsh prompt above. It defaults to a basic prompt if it doesn't exist.
It sources the following files if they exist:
* `~/.balias.bsh`: I use this for personalized aliases which aren't distro-specific yet don't belong in `.bashrc`.
* `~/.bpac.bsh`: aliases for pacman-based Linux distros.
* `~/.bubuntu.bsh`: aliases for Debian-based Linux distros. It only has ubuntu in the name for easier tab-completion due to `.bdesk.bsh`.
* `~/.bdesk.bsh`: for desktop-only stuff.
* `~/.blap.bsh`: for laptop-only stuff.
* `~/.bmobile.bsh`: for mobile-only stuff.

