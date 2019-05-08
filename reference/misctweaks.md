This is mostly for me, for reference if I need it. Some of it may be useful to others.

# Enable VTs

Edit `/etc/systemd/logind.conf` to have `NAutoVTs=6`.
Should take effect immediately.

# Keyboard

Enable Magic sysrq keys:

* To use these, they must first be activated with either `sysctl kernel.sysrq=1` or `echo "1" > /proc/sys/kernel/sysrq`. If you wish to have it enabled during boot, edit `/etc/sysctl.d/99-sysctl.conf` and insert the text `kernel.sysrq = 1`. If you want to make sure it will be enabled even before the partitions are mounted and in the initrd, then add `sysrq_always_enabled=1` to your kernel parameters.

Volume buttons:

* Set `XF86AudioRaiseVolume` to `amixer set Master playback 5%+ unmute`
* Set `XF86AudioLowerVolume` to `amixer set Master playback 5%-`
* Set `XF86AudioMute` to `amixer set Master toggle`

## Swap CAPS & ESC

There's handy AUR packages for this:

* `interception-caps2esc`
* `caps2esc`

I use udev to swap keys in the kernel, to make it permanent and consistent. For my keyboard I have the following in `/usr/lib/udev/hwdb.d/60-keyboard.hwdb`:

```
# Microsoft Natural Ergonomic Keyboard 4000
evdev:input:b0003v045Ep00DB*
 KEYBOARD_KEY_c022d=up                                  # zoomin
 KEYBOARD_KEY_c022e=down                                # zoomout
 KEYBOARD_KEY_70039=esc                                 # caps > esc
 KEYBOARD_KEY_70029=capslock                            # esc > caps
```

For more info on remapping keys on Linux, see:

* https://wiki.archlinux.org/index.php/Keyboard_input
* https://wiki.archlinux.org/index.php/Map_scancodes_to_keycodes

I used to use this, which only applies to X. Resume from suspend reverts for me.

`setxkbmap -option "caps:swapescape"`

# Package management/building

## Automatically clean the package cache.
```
sudo mkdir /etc/pacman.d/hooks
sudoedit /etc/pacman.d/hooks/clean_package_cache.hook
```
Contents:
```
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
```

## Manjaro driver installation
Find classid, then use it to install:
```
mhwd --pci -l -d | grep 'INFO\|CLASS'
sudo mhwd -a pci nonfree <classid>
```

# QT & GTK
https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications
https://wiki.manjaro.org/index.php?title=Set_all_Qt_app%27s_to_use_GTK%2B_font_%26_theme_settings

Install `qt5-styleplugins` and `qt5ct`. Restart, run `qt5ct` from terminal and select gtk2.
For gtk2 apps install `gtk-theme-switch2` and select theme.

# Default web browser for xdg-open

`xdg-settings set default-web-browser google-chrome-beta.desktop`

# Blocking net in Wine
1. `wine regedit`
2. Go to: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`
3. You should see a ProxyEnable key that is set to 0. Set it to 1.
4. Create the following DWORD values (right-click and select new):
	"MigrateProxy" set to
	"ProxyHttp.1.1" set to 0
5. Create the following Strings:
	"ProxyOverride" set to "<local>"
	"ProxyServer" set to "http://prohibited:80"
	"UserAgent" set to "Mozilla/4.0 (compatible; MSIE 8.0; Win32)"

# Bootable USB w/various ISOs

1. Install syslinux:
	`sudo pacman -S syslinux`
	or
	`sudo apt-get install syslinux`
2. Repartition and format USB as FAT.
3. Mark as bootable.
	Use gparted.
	Set label.
4. Copy syslinux master boot record to drive:
	`sudo dd if=/usr/lib/syslinux/mbr.bin of=/dev/sdg`
5. Install syslinux on the drive partition:
	`sudo syslinux /dev/sdg1`
6. Mount the drive.
	Use file manager or,
	`sudo mount /dev/sdg1 /media/temp`
7. Copy the memdisk bootloader to drive:
	`sudo cp /usr/lib/syslinux/memdisk /media/temp`
8. Copy the .iso to drive.
9. Create file named `syslinux.cfg` on drive with the following, using correct iso name:
```
DEFAULT labelname
LABEL labelname
  LINUX memdisk
  INITRD filename.iso
  APPEND iso
```
10. Done! Boot with it.
11. [Troubleshoot](http://www.syslinux.org/wiki/index.php/MEMDISK#INT_13h_access:_Not_all_images_will_complete_the_boot_process.21)

# Firefox theme integration
```
==> vertex-maia-themes:
  -> For seamless integration of Firefox and Palemoon browsers
  -> please copy the 'chrome' folder of the desired theme to your browser profile
  -> or create a symlink.
==> For example:
  -> 'ln -s /usr/share/themes/Palemoon/Vertex-Maia-Dark/chrome/ ~/.moonchild\ productions/pale\ moon/<xyz123>.default/chrome'
```

# Mount virtualbox shared folder in linux
```
sudo mount -t vboxsf vbox ~/vbox
```

# XFCE clock format
Tooltip: %c
Format:
%a %T%n%h %e/%y
