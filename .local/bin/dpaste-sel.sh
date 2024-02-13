#!/bin/sh
xclip -o | curl -sF "content=<-" https://dpaste.com/api/ | xclip -sel primary && \
    notify-send -t 2500 "dpaste.com" "URL copied to selection" || \
    notify-send -t 2500 "dpaste.com" "Selection dpaste failed"
