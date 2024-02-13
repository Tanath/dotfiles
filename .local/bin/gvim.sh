#!/bin/sh
PID=$(pidof gvim)
echo $PID
if [ ${PID} -n ]; then
	gvim
fi
gvim --remote-send ':enew<CR>'
gvim --remote-send '"*p'
#gvim --remote-send ':sp<CR>:bn<CR>'
