#!/bin/sh
SEND="$@"
PORT=8080
{ echo -ne "HTTP/1.0 200 OK\r\nContent-Length: $(wc -c <$SEND)\r\n\r\n"; cat $SEND; } | nc -l $PORT
