To save space, you can compress data produced by dd with gzip, e.g.: `
dd if=/dev/sdb | gzip -c > drive.img
` 
You can restore your disk with: `
gunzip -c drive.img.gz | dd of=/dev/sdb
` 

For imaging/reimaging, PXE booting, etc., try FOG.`
mkdir fog && cd fog
git clone https://github.com/FOGProject/fogproject.git
git pull
cd bin
sudo ./installfog
`

