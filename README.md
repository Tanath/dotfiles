# Tanath's Dotfiles (and related)

My `.zshrc`, `.vimrc` and other config files & system alterations. Some references for misc things too.

`.zprompt.zsh` is a tweaked version of [Phil's zsh prompt](http://aperiodic.net/phil/prompt/) by [Bender](https://gist.github.com/bender-the-greatest/802e33cc20d0685c33715c3b8d035af5) (thanks!). This file is assumed to exist. If you'd rather use your own prompt with this `.zshrc` you can replace `.zprompt.zsh`.  
`.zpac.zsh` has aliases for pacman-based Linux distros. Goes with `.zshrc`  
`.zubuntu.zsh` for Debian-based Linux distros. Goes with `.zshrc`. It only has ubuntu in the name for easier tab-completion.

This `.zshrc` benefits from [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). If you don't have a distro package, clone the repo in `~`:  
`git clone https://github.com/zsh-users/zsh-autosuggestions`

The `.vimrc` uses `~/.vim/` and will create it if it doesn't exist.
