#!/bin/bash
notify-send -t 2500 "xdg-open" "Opening selection."
xdg-open "$*"
