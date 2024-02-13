#!/bin/sh
# Set port & low-privilege user
PORT=8080
RUNAS=http

# Set share path:
if [[ "$@" != "" ]]; then
    WHERE="$@"
else
    WHERE="$(pwd)"
fi
echo "Using path: " $WHERE

if [ -d $WHERE ]; then
	cd $WHERE
	#sudo -u $RUNAS python2 -m SimpleHTTPServer $PORT
	sudo -u $RUNAS python -m http.server $PORT
else
	echo "Failed. Path not accessible?"
	notify-send -u low "$0: Failed."
fi

