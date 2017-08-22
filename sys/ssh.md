* https://stribika.github.io/2015/01/04/secure-secure-shell.html
* http://collectiveidea.com/blog/archives/2014/02/18/a-simple-pair-programming-setup-with-ssh-and-tmux/
* Never use DSA or ECDSA. If you connect to your server from a machine with a poor random number generator and eg. the same k happens to be used twice, an observer of the traffic can figure out your private key.

# Server
Use `chacha20-poly1305@openssh.com` and `curve25519-sha256@libssh.org`  
Install openssh, sshguard.  
For keygen on server:  
```
ssh-keygen -b 4096 -f .ssh/id_rsa4096 -C "$(whoami)@$(hostname)-$(date -I)" -a 512
ssh-keygen -t ed25519 -b 2048 -C "$(whoami)@$(hostname)-$(date -I)"
```

The .pub is for server. Also append to `~/.ssh/authorized_keys` on server  
If key pair genned by client, .pub key should be single-line version.  
Add to `sshd_config`:
```
KexAlgorithms curve25519-sha256@libssh.org
```

Add user if they don't already exist:
```
sudo useradd -d /path/to/home username  
```

Add user to ssh group:
```
sudo gpasswd -a username ssh  
```

Permissions should be:
```
drwx------ 2 username users 4.0K Apr 17 00:23 .ssh
-rw------- 1 username users  738 Apr 17 00:23 user-key.pub
-rw------- 1 username users  738 Apr 17 00:18 authorized_keys
```
Set up Google Authenticator for 2fa:  
https://wiki.archlinux.org/index.php/Google_Authenticator

## curveprotect
Add to `/etc/ssh/ssh_config`:
```
ProxyCommand /opt/curveprotect/bin/nettunnel -u -c %h %p  
```

# Client

For keygen on client:  
```
ssh-keygen -b 4096 -f .ssh/id_rsa4096 -C "USER@$RHOST-$(date -I)" -a 512
ssh-keygen -t ed25519 -b 2048 -C "USER@RHOST-$(date -I)"
```
User ed25519 for security, rsa for compatibility. Putty doesn't support ed25519.  
They copy to server:  
`ssh-copy-id -i ~/.ssh/id_ed25519.pub USER@RHOST`

```
ssh-add .ssh/id_ed25519  
```

Install keychain.  
Add to `~/.zshrc`:
```
/usr/bin/keychain ~/.ssh/id_ed25519
source ~/.ssh-agent > /dev/null
ssh-copy-id IPADDR -p PORT
```

Add to `ssh_config`:
```
Host *  
	KexAlgorithms curve25519-sha256@libssh.org  
```

## Multiplexing
```
mkdir -p ~/.ssh/cm_socket
```

Add to `~/.ssh/config`:
```
Host *  
ControlMaster auto  
ControlPath ~/.ssh/cm_socket/%r@%h:%p  
ServerAliveInterval 60  
```

## Sshfs
Install sshfs. Mount sshfs:
```
sshfs USER@IPADDR:/ ~/remotefs/ -C -p PORT  
```

Unmount sshfs:
```
fusermount -u ~/remotefs/  
```

## Edit remote files with local vim:
```
vim scp://USER@IPADDR//path/to/file
```

## Audio
paprefs > network server > enable local devices  
Use pax11publish to discover your PulseAudio port (usually 4713),
```
ssh -R 24713:localhost:4713  
export PULSE_SERVER="tcp:localhost:24713"  
```

Or: copy ~/.pulse-cookie, and run pasystray  

## Send only specified key to server
In your `~/.ssh/config`, something like:
```
# Ignore SSH keys unless specified in Host subsection
IdentitiesOnly yes
# Send your public key to github only
Host github.com
	IdentityFile ~/.ssh/id_rsa
```

## Tunnel
On client:  
SOCKS:
```
ssh -NC -p PORT -D 4443 USER@HOST  
```

Forwarding:
```
ssh -NC -p PORT USER@HOST -L LPORT:RHOST:RPORT
```

Set proxy to port 4443.

## Copying
```
rsync -zhuvaPi -e "ssh -vp PORT" SOURCE USER@HOST:DEST
scp -P PORT SOURCE USER@HOST:DEST
```

## VNC
```
ssh USER@HOST -p PORT -L 5900:localhost:5900 "x11vnc -display :0 -noxdamage"  
```

Or:
```
ssh -L 5900:localhost:5900 USER@HOST  
x11vnc -safer -localhost -nopw -once -display :0  
```

Or:
```
ssh -t -L 5900:localhost:5900 USER@HOST 'sudo x11vnc -display :0 -auth /home/USER/.Xauthority'  
```

# Windows
Install cygwin and babun/apt-cyg

