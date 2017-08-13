# Simple file transfer
Receiver runs `
nc -l -p 1234 > file.name
`to listen on port 1234. Then sender runs`
nc -w 3 IPADDR 1234 < file.name
`to send file.

# Multiple file transfer w/tar
Receiver runs`
nc -lvp PORT | tar -xpf -
`Sender runs`
tar -cf - * | nc IPADDR PORT
`

# Notification
To listen for a message and direct to notification:`
nc -lp PORT | while read OUTPUT; do notify-send -t 5000 "PORT:" "$OUTPUT"; done
`
