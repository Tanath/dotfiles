# Tanath's Dotfiles (and related)

My dotfiles for Linux, [browser reference](https://github.com/Tanath/dotfiles/tree/master/browsers#readme) & userscripts, other config files & system tweaks, and miscellaneous references.

## Misc
* I use ranger, the terminal file manager. It's configured for devicons, so you need to add that for it to work well without complaining:

    ```
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
    ```

* I also highly recommend the zoxide plugin:

    ```
    git clone https://github.com/jchook/ranger-zoxide ~/.config/ranger/plugins/zoxide
    ```


## vim
My vim config uses [vim-plug](https://github.com/junegunn/vim-plug/) and loads the enabled plugins from [.vim/config/plugins.vim](.vim/config/plugins.vim). Any `.vim` files in `.vim/config/` are loaded. `<Leader>` key is default (`\`). Some useful toggles & mappings:

* `<F4>` toggles wrap.
* `<F7>` toggles spell check.
* `<c-/>`/`<c-7>`/`<c-_>` toggles search highlight.
* `<F10>` is `:terminal`.
* `gb` opens `:Buffers` from [fzf.vim](https://github.com/junegunn/fzf.vim). `<Leader>bb` for built-in version.
* `<leader>km` opens `:Maps` from fzf.vim to search mappings.

I swap caps & esc via udev for better vimming (see [reference/misctweaks.md](reference/misctweaks.md#swap-caps--esc)). This benefits other programs as well, and doesn't mess with muscle memory by keeping consistent. Capslock rarely gets used and esc gets used frequently, it's better that esc is closer and caps is further.

## zsh
This [.zshrc](.zshrc) uses [p10k](https://github.com/romkatv/powerlevel10k) for its prompt. You can replace it with your own if it's not to your liking by uncommenting the sourcing of `.zprompt.zsh` and putting your prompt config there.

It sources the following files if they exist:
* [~/.zprompt.zsh](.zprompt.zsh): Disabled/commented out for now. Formerly Phil's prompt. You can replace it with your own.
* [~/.zalias.zsh](.zalias.zsh): I use this for personalized aliases which aren't distro-specific yet don't belong in `.zshrc`.
* [~/.zpac.zsh](.zpac.zsh): aliases for pacman-based Linux distros.
* [~/.zubuntu.zsh](.zubuntu.zsh): aliases for Debian-based Linux distros. It only has ubuntu in the name for easier tab-completion due to `.zdesk.zsh`.
* `~/.zdesk.zsh`: for desktop-only stuff.
* `~/.zlap.zsh`: for laptop-only stuff.
* `~/.zmobile.zsh`: for mobile-only stuff.

This `.zshrc` gives [zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions). If you don't have a distro package, clone the repo in `~`:
`git clone https://github.com/zsh-users/zsh-autosuggestions`

## bash
This [.bashrc](.bashrc) uses [Starship](https://starship.rs) for its prompt. It defaults to a basic prompt if it doesn't exist.
It sources the following files if they exist:
* [~/.balias.bsh](.balias.bsh): I use this for personalized aliases which aren't distro-specific yet don't belong in `.bashrc`.
* [~/.bpac.bsh](.bpac.bsh): aliases for pacman-based Linux distros.
* [~/.bubuntu.bsh](.bubuntu.bsh): aliases for Debian-based Linux distros. It only has ubuntu in the name for easier tab-completion due to `.bdesk.bsh`.
* `~/.bdesk.bsh`: for desktop-only stuff.
* `~/.blap.bsh`: for laptop-only stuff.
* `~/.bmobile.bsh`: for mobile-only stuff.

