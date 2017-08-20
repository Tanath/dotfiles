# Keyboard

## Swap CAPS & ESC
Make a panel shortcut too. Suspend with 2 keyboards will undo.`
setxkbmap -option "caps:swapescape"
`

# Package management/building

## Automatically clean the package cache.
```
sudo mkdir /etc/pacman.d/hooks
sudo vim /etc/pacman.d/hooks/clean_package_cache.hook
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
11. Troubleshot.  
	http://www.syslinux.org/wiki/index.php/MEMDISK#INT_13h_access:_Not_all_images_will_complete_the_boot_process.21
