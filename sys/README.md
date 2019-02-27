# Some system setup stuff

* [xprofile](xprofile) - Goes to `/etc/xprofile`. Swaps <kbd>caps</kbd> & <kbd>esc</kbd> in X before login, enable numlock.
* Install `mlocate`, run `sudo updatedb`, and set to run hourly: `echo '@hourly root updatedb' | sudo tee -a /etc/crontab`
* [dns.txt](dns.txt) - Some alternative DNS servers to use.
* [ssh.md](ssh.md) - SSH setup & tips.
* `background.png` - A few grub backgrounds I like. To use, put in `/usr/share/grub/background.png`.

# Manjaro/Arch stuff
* To install your graphics drivers on Manjaro, run: `sudo mhwd -a pci free 0300` (or `nonfree`).

# For Sabertooth 990FX mobo
* `shellx64-works.efi` - The Sabertooth 990FX is a quirky mobo and this is the only thing that lets it boot in UEFI mode.
* [IOMMU fix for Sabertooth 990FX](https://ubuntuforums.org/showthread.php?t=2254677):

Add to `GRUB_CMDLINE_LINUX_DEFAULT=`:

    amd_iommu=fullflush iommu=pt

If that doesn't work, add:

    ivrs_ioapic[9]=00:14.0 ivrs_ioapic[10]=00:00.2

