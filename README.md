# Tanath's Dotfiles (and related)

My dotfiles, and other config files & system tweaks. Some miscellaneous references too.

`.zprompt.zsh` is a tweaked version of [Phil's zsh prompt](http://aperiodic.net/phil/prompt/) by [Bender](https://gist.github.com/bender-the-greatest/802e33cc20d0685c33715c3b8d035af5) which has a bugfix for when Atom's `apm` is installed (thanks!). This file is assumed to exist. If you'd rather use your own prompt with this `.zshrc` you can replace `.zprompt.zsh`.  
`.zpac.zsh` has aliases for pacman-based Linux distros. Goes with `.zshrc`  
`.zubuntu.zsh` for Debian-based Linux distros. Goes with `.zshrc`. It only has ubuntu in the name for easier tab-completion.

This `.zshrc` gives [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). If you don't have a distro package, clone the repo in `~`:  
`git clone https://github.com/zsh-users/zsh-autosuggestions`  
If you want to add your own custom aliases & functions the following files are automatically sourced if they exist:  
* `~/.zalias.zsh`
* `~/.zdesk.zsh` for desktop-only stuff.
* `~/.zlap.zsh` for laptop-only stuff.

The `.vimrc` uses `~/.vim/` and `~/.vim/pack/plugins/` is used for native plugins. They will be created it if they don't exist.
Some people change `<leader>` to left ctrl. I leave it default. Left ctrl is the easiest one to hit - you can roll your hand and hit it with the edge. The right hand is sometimes on the mouse.  
Vim's defaults are generally well thought out and there are usually reasons for things to be the way they are. Much of people's issues with vim comes from remapping things before they know what they're doing.  
I swap caps & esc in X for better vimming (see reference/misctweaks.md), and since capslock rarely gets used and esc gets used frequently, it's better that esc is closer and caps is further.

I don't recommend the `.bashrc` yet. I don't use bash, but have been working on improving it anyway as a fallback. It's currently buggy/broken.
