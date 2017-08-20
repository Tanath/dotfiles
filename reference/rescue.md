Based on:
http://www.forensicswiki.org/wiki/Ddrescue#Partition_recovery

# Partition recovery

## Kernel 2.6.3+ & ddrescue 1.4+ 
`ddrescue --direct` will open the input with the O_DIRECT option for uncached reads. 'raw devices' are not needed on newer kernels. For older kernels see below.

First you copy as much data as possible, without retrying or splitting sectors:

`ddrescue --no-split /dev/sda1 imagefile logfile `

Now let it retry previous errors 3 times, using uncached reads:

`ddrescue --direct --max-retries=3 /dev/sda1 imagefile logfile`

If that fails you can try again but retrimmed, so it tries to reread full sectors:

`ddrescue --direct --retrim --max-retries=3 /dev/sda1 imagefile logfile`

You can now use ddrescue (or normal dd) to copy the imagefile to a new partition on a new disk. Use the appropriate filesystem checkers (fsck, CHKDSK) to try to fix errors caused by the bad blocks. Be sure to keep the imagefile around. Just in case the filesystem is severely broken, and datacarving tools like testdisk need to to be used on the original image.

## Before linux kernel 2.6.3 / 2.4.x
In 2.6.3 the 'raw device' has been marked obsolete. On later kernels ddrescue will use O_DIRECT on the input to do uncached reads.

First you copy as much data as possible, without retrying or splitting sectors:

`ddrescue --no-split /dev/sda1 imagefile logfile`

Now change over to raw device access. Let it retry previous errors 3 times, don't read past last block in logfile:
```
modprobe raw
raw /dev/raw/raw1 /dev/sda1
ddrescue --max-retries=3 --complete-only /dev/raw/raw1 imagefile logfile 
```
If that fails you can try again (still using raw) but retrimmed, so it tries to reread full sectors:

`ddrescue --retrim --max-retries=3 --complete-only /dev/raw/raw1 imagefile logfile`

You can now use ddrescue (or normal dd) to copy the imagefile to a new partition on a new disk. Use the appropriate filesystem checkers (fsck, CHKDSK) to try to fix errors caused by the bad blocks. Be sure to keep the imagefile around. Just in case the filesystem is severely broken, and datacarving tools like testdisk need to to be used on the original image.

At the end you may want to unbind the raw device:

`raw /dev/raw/raw1 0 0`

# Examples
These two examples are taken directly from the ddrescue info pages.

Example 1: Rescue an ext2 partition in /dev/sda2 to /dev/sdb2

Please Note: This will overwrite ALL data on the partition you are copying to. If you do not want to do that, rather create an image of the partition to be rescued.
```
ddrescue -r3 /dev/sda2 /dev/sdb2 logfile
e2fsck -v -f /dev/sdb2
mount -t ext2 -o ro /dev/sdb2 /mnt
```
Example 2: Rescue a DVD-ROM in /dev/sr0

`ddrescue -b 2048 /dev/cdrom cdimage logfile`

write disc image to a blank DVD-ROM
This example is derived from the ddrescue manual.

Example 3: Rescue an entire hard disk /dev/sda to another disk /dev/sdb

copy the error free areas first

`ddrescue -n /dev/sda /dev/sdb rescue.log`

attempt to recover any bad sectors

`ddrescue -r 1 /dev/sda /dev/sdb rescue.log`

# Write image to disk
With dd converting 512-byte sectors to 4K:

`dd ibs=512 obs=4K conv=sync if=./path.img of=/dev/sde`

