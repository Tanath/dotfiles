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

I used to use this, which only applies to X and not in VTs. Resume from suspend also reverts it for me.

`setxkbmap -option "caps:swapescape"`

Now I use udev to swap keys in the kernel, to make it permanent and consistent. For my keyboard I put the following in `/usr/lib/udev/hwdb.d/70-keyboard.hwdb`:

```
# Microsoft Natural Ergonomic Keyboard 4000
evdev:input:b0003v045Ep00DB*
 KEYBOARD_KEY_c022d=up                                  # zoomin
 KEYBOARD_KEY_c022e=down                                # zoomout
 KEYBOARD_KEY_70039=esc                                 # caps > esc
 KEYBOARD_KEY_70029=capslock                            # esc > caps
```

Then run:

* `sudo systemd-hwdb update`
* `sudo udevadm trigger`

For more info on remapping keys on Linux, see:

* https://wiki.archlinux.org/index.php/Keyboard_input
* https://wiki.archlinux.org/index.php/Map_scancodes_to_keycodes

# Package management/building

## Automatically clean the package cache.
```
sudoedit /usr/share/libalpm/hooks/pacman_cache.hook
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
Exec = /usr/bin/paccache -rk2
```

## Check for firmware updates.
```
sudoedit /etc/pacman.d/hooks/fwupd.hook
```
Contents:
```
[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = *

[Action]
Depends = fwupd
When = PostTransaction
Exec = /usr/bin/fwupdmgr get-updates
Description = Checking for firmware updates...
```

## Manjaro driver installation
Find classid, then use it to install:
```
mhwd --pci -l -d | grep 'INFO\|CLASS'
sudo mhwd -a pci nonfree <classid>
```

# QT & GTK
* https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications
* https://wiki.manjaro.org/index.php?title=Set_all_Qt_app%27s_to_use_GTK%2B_font_%26_theme_settings

Install `qt5-styleplugins` and `qt5ct`. Restart, run `qt5ct` from terminal and select gtk2.
For gtk2 apps install `gtk-theme-switch2` and select theme.

# Fonts
Fonts should be readable with characters that are easy to distinguish from each other even with poor vision. Most fonts fail at this. Atkinson Hyperlegible does a great job and is my gold standard for comparison, hence my userscript to change web pages to it. For mono, the best nerd font I've found which doesn't fail at this is Monoid. Check these characters in your font:
* q9gB80OoailI1LCGQ{}
* `q9gB80OoailI1LCGQ{}`

Emoji font config:
* `sudo pacman -S noto-fonts-emoji`
* `mkdir -p ~/.config/fontconfig/conf.d`
* `$EDITOR ~/.config/fontconfig/conf.d/30-color-fonts.conf`
```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <alias binding="same">
        <family>emoji</family>
        <prefer>
            <family>Noto Color Emoji</family> <!-- Google -->
            <family>Apple Color Emoji</family> <!-- Apple -->
            <family>Segoe UI Emoji</family> <!-- Microsoft -->
            <family>Twitter Color Emoji</family> <!-- Twitter -->
            <family>EmojiOne Mozilla</family> <!-- Mozilla -->
            <family>Emoji Two</family>
            <family>JoyPixels</family>
            <family>Emoji One</family>
            <!-- Non-color -->
            <family>Noto Emoji</family> <!-- Google -->
            <family>Android Emoji</family> <!-- Google -->
        </prefer>
    </alias>
</fontconfig>
```

# Default web browser for xdg-open

`xdg-settings set default-web-browser firefox.desktop`

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

This section is outdated. Use [Ventoy](https://github.com/ventoy/Ventoy#--ventoy) now.

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

# Mount virtualbox shared folder in linux
```
sudo mount -t vboxsf vbox-shared /mnt/vbox-shared
```

# Clock applet format
Date format: 
* `%a. %b. %e%n%H:%M %p`

Tooltip:
* `%Y-%m-%d%n%I:%M %p`

[Syntax reference](https://foragoodstrftime.com/).
