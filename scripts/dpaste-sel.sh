#!/bin/sh
xclip -o | curl -s -F "content=<-" https://dpaste.com/api/ | xclip -sel primary
notify-send -t 2500 "dpaste.com" "URL copied to selection"
