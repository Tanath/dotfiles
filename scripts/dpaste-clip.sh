#!/bin/sh
xclip -o -sel clip | curl -s -F "content=<-" https://dpaste.com/api/ | xclip -sel clip
notify-send -t 2500 "dpaste.com" "URL copied to clipboard"
