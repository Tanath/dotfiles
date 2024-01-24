# Some system setup stuff

* For most people I'd recommend [Linux Mint Cinnamon edge edition](https://www.linuxmint.com/edition.php?id=314). There's some config files here you can import for certain Cinnamon applets. And here's a [package list](lmcpackages-most.txt) for some recommended packages to install. Also install [topgrade](https://github.com/topgrade-rs/topgrade) with:
    * ```pip install topgrade```
* You can install a package list with, for example:

    ```sh
       sudo apt install $(cat packages.txt)
    ```

* [xprofile](xprofile) - Goes to `/etc/xprofile`. Swaps <kbd>caps</kbd> & <kbd>esc</kbd> in X before login, enables numlock (requires numlockx).
* For instant file searching, install `plocate`, run `sudo updatedb` to index files, and set to run hourly. On Debian, Linux Mint, and others which support Debian's modifications to cron, just move the daily to hourly:

    ```sh
    sudo mv /etc/cron.daily/plocate /etc/cron.hourly/
    ```
    * On distros which don't use Debian's modifications, you can do:
 
    ```sh
    echo '@hourly root updatedb' | sudo tee -a /etc/crontab
    ```

* [ssh.md](ssh.md) - SSH setup & tips.

# Misc

* Regardless of desktop environment I prefer `xfce4-terminal`, and make a custom keyboard shortcut binding <kbd>F12</kbd> to ```xfce4-terminal --fullscreen --drop-down``` for quick and easy toggleable access to the terminal from anywhere. 

# Manjaro/Arch stuff
* To install your graphics drivers on Manjaro, run: ```sudo mhwd -a pci free 0300``` (or ```sudo mhwd -a pci nonfree 0300``` for proprietary).

# For Sabertooth 990FX mobo
* `shellx64-works.efi` - The Sabertooth 990FX is a quirky mobo and this is the only thing that lets it boot in UEFI mode.
* [IOMMU fix for Sabertooth 990FX](https://ubuntuforums.org/showthread.php?t=2254677):

Add to `GRUB_CMDLINE_LINUX_DEFAULT=`:

    amd_iommu=fullflush iommu=pt

If that doesn't work, add:

    ivrs_ioapic[9]=00:14.0 ivrs_ioapic[10]=00:00.2

