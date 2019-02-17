# Tanath's Dotfiles (and related)

My dotfiles, and other config files & system tweaks, and miscellaneous references.

## zsh
This `.zshrc` sources `.zprompt.zsh` for its prompt. You can replace it with your own if it's not to your liking. This uses a tweaked version of [Phil's zsh prompt](http://aperiodic.net/phil/prompt/) by [Bender](https://gist.github.com/bender-the-greatest/802e33cc20d0685c33715c3b8d035af5) which has a bugfix for when Atom's `apm` is installed (thanks!). 
It sources the following files if they exist:
* `~/.zpac.zsh`: aliases for pacman-based Linux distros.
* `~/.zubuntu.zsh`: aliases for Debian-based Linux distros. It only has ubuntu in the name for easier tab-completion due to `.zdesk.zsh`.
* `~/.zalias.zsh`: I use this for personalized aliases which aren't distro-specific yet don't belong in `.zshrc`.
* `~/.zdesk.zsh`: for desktop-only stuff.
* `~/.zlap.zsh`: for laptop-only stuff.

This `.zshrc` gives [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). If you don't have a distro package, clone the repo in `~`:  
`git clone https://github.com/zsh-users/zsh-autosuggestions`  

## vim
The `.vimrc` uses `~/.vim/` and `~/.vim/pack/plugins/` is used for native plugins. They will be created it if they don't exist.
I swap caps & esc in X for better vimming (see `reference/misctweaks.md`). This benefits other programs as well, and doesn't mess with muscle meory. Capslock rarely gets used and esc gets used frequently, it's better that esc is closer and caps is further.  

