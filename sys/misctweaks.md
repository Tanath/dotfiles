Keyboard
========

# Swap caps & esc. Make a panel shortcut too. Suspend with 2 keyboards will undo.
`setxkbmap -option "caps:swapescape"`

Package management/building
===========================

# Automatically clean the package cache.
`
sudo mkdir /etc/pacman.d/hooks
sudo vim /etc/pacman.d/hooks/clean_package_cache.hook
`
Contents:
`
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *
[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -ruk2
`

