# References, notes
* https://infosec.mozilla.org/guidelines/openssh
* https://www.ssh-audit.com/hardening_guides.html
* https://wiki.archlinux.org/title/Openssh
* https://man.openbsd.org/sshd_config
* [Signing git commits with ssh keys](https://docs.gitlab.com/ee/user/project/repository/signed_commits/ssh.html)
* [Signing arbitrary data with ssh keys](https://www.agwa.name/blog/post/ssh_signatures)
* [SSH with certificates](https://github.com/nsheridan/cashier)
* Never use DSA or ECDSA. If you connect to your server from a machine with a poor random number generator and eg. the same k happens to be used twice, an observer of the traffic can figure out your private key.
* Whenever you make changes to sshd_config you need to restart sshd for them to take effect.

# Server
For details, see `man sshd_config`.  
Use ed25519 for security, rsa for compatibility. Putty doesn't support ed25519 last I checked, and is still a common client.  
Use `chacha20-poly1305@openssh.com` and `curve25519-sha256@libssh.org` if you can.  
Install: openssh, sshguard.   
Regenerate keys on server:  

```sh
rm /etc/ssh/ssh_host_*
ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_rsa_key -C "$(whoami)@$(hostname)-$(date -I)" -a 512
ssh-keygen -t ed25519 -b 2048 -f /etc/ssh/ssh_host_ed25519_key -C "$(whoami)@$(hostname)-$(date -I)"
```

Remove small DH moduli:

```sh
awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.safe
mv /etc/ssh/moduli.safe /etc/ssh/moduli
```

To generate the keys for the ssh user, go to a shell prompt as the user you want to log in to the server as. You can use `sudo -u USER -i` to switch to another user. Generate the key and send the files to the client.
Also append to `~/.ssh/authorized_keys` on server. You may also need/want to have the authorized_keys file in `/etc/ssh/USER/authorized_keys` and put `AuthorizedKeysFile  /etc/%u/authorized_keys` in `/etc/ssh/sshd_config` with user ownership & readable permissions:

```sh
sudo chown USER /etc/ssh/USER/authorized_keys
sudo chmod go+r /etc/ssh/USER/authorized_keys
```

If you genned the key pair on client, .pub key should be single-line version.  
If the key pair is genned on server and someone stubbornly insists on using putty instead of something better like mobaxterm, you can convert the key to putty's format:  

    * Open PuTTYgen, select Type of key to generate as: SSH-2 RSA
	* Click "Load" on the right side about 3/4 down
	* Set the file type to *.*
	* Browse to, and open your .pem file
	* PuTTY will auto-detect everything it needs, and you just need to click "Save private key" and you can save your ppk key for use with PuTTY.

Enable the keys on server, and avoid weak algorithms. Add/uncomment in `/etc/ssh/sshd_config` or `/etc/ssh/sshd_config.d/algorithm_hardening.conf`:

```
HostKey /etc/ssh/ssh_host_ed25519_key
HostKey /etc/ssh/ssh_host_rsa_key

# Restrict key exchange, cipher, and MAC algorithms, as per sshaudit.com
# hardening guide.
KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,gss-curve25519-sha256-,diffie-hellman-group16-sha512,gss-group16-sha512-,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256

Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr,aes192-ctr

MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256

HostKeyAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512,rsa-sha2-256

CASignatureAlgorithms sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512,rsa-sha2-256

GSSAPIKexAlgorithms gss-curve25519-sha256-,gss-group16-sha512-

HostbasedAcceptedAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-256

PubkeyAcceptedAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-256
```

While editing the server config, also do:

```
# Require public key auth, no passwords.
AuthenticationMethods publickey
PubkeyAuthentication yes
PasswordAuthentication no

# If you only have IPv4 connectivity:
#AddressFamily inet

# Disable root login.
PermitRootLogin no

# Log fingerprint for auditing.
LogLevel VERBOSE
```

Add user if they don't already exist:

```sh
sudo useradd -d /path/to/home USERNAME  
```

Add user to ssh group:

```sh
sudo usermod -a -G ssh USERNAME
  OR
sudo gpasswd -a USERNAME ssh  
```

Permissions should be:

```
drwx------ 2 username users 4.0K Apr 17 00:23 .ssh
-rw------- 1 username users  738 Apr 17 00:23 user-key.pub
-rw------- 1 username users  738 Apr 17 00:18 authorized_keys
```

Also add a line in sshd_config to only allow certain users you specify:  
`AllowUsers foo bar`

You can [set up Google Authenticator](https://wiki.archlinux.org/index.php/Google_Authenticator) for 2FA.

# Client
For details, see `man ssh_config`.  
On client edit `~/.ssh/config`:

```
AddKeysToAgent  yes
PubkeyAuthentication yes
# If you only have IPv4 connectivity:
#AddressFamily inet

# Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know which hosts your keys have access to.
HashKnownHosts yes

# Host keys the client accepts - order here is honored by OpenSSH
HostKeyAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512,rsa-sha2-256

KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,gss-curve25519-sha256-,diffie-hellman-group16-sha512,gss-group16-sha512-,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256

MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr,aes192-ctr

PubkeyAcceptedAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-rsa-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com

HostbasedAcceptedAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-256
GSSAPIKexAlgorithms gss-curve25519-sha256-,gss-group16-sha512-
```

To generate keys on the client...  

* Where misc is your name for the key,
* and -C is a comment,
* and RHOST is the remote host the key is for...

```sh
ssh-keygen -t ed25519 -b 2048 -f ~/.ssh/id_ed25519_misc -C "USER@RHOST-$(date -I)"
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa4096_misc -C "USER@$RHOST-$(date -I)" -a 512
```

Then copy to server:
`ssh-copy-id -i ~/.ssh/id_ed25519_misc.pub USER@RHOST`

```sh
ssh-add ~/.ssh/id_ed25519_misc
```

Install keychain agent.  
Add to your shell config, eg. `~/.zshrc` or `~/.zshenv`, after interactive shell check:

```sh
/usr/bin/keychain --quiet ~/.ssh/id_ed25519_misc
ssh-copy-id IPADDR -p PORT
```

After logging in to the server, confirming it works, you may want to add it to your `~/.ssh/config`, like:

```
Host SERVERALIAS
    HostName 192.168.0.22
    User tanath
    IdentityFile ~/.ssh/id_ed25519_misc
```

Along with any other server settings.  
So your user config might look like:

```
AddKeysToAgent  yes
PubkeyAuthentication yes

# If you only have IPv4 connectivity:
#AddressFamily inet

# Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know which hosts your keys have access to.
HashKnownHosts yes

# Host keys the client accepts - order here is honored by OpenSSH
HostKeyAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512,rsa-sha2-256

KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org,gss-curve25519-sha256-,diffie-hellman-group16-sha512,gss-group16-sha512-,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha256

MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr,aes192-ctr

PubkeyAcceptedAlgorithms ssh-ed25519,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-rsa-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com

HostbasedAcceptedAlgorithms sk-ssh-ed25519-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,sk-ssh-ed25519@openssh.com,ssh-ed25519,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-512,rsa-sha2-256-cert-v01@openssh.com,rsa-sha2-256
GSSAPIKexAlgorithms gss-curve25519-sha256-,gss-group16-sha512-

Host 2048
    HostName ascii.town
    User play
```

## Multiplexing
```sh
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

```sh
sshfs USER@IPADDR:/ ~/remotefs/ -C -p PORT  
```

Unmount sshfs:

```sh
fusermount -u ~/remotefs/  
```

## Edit remote files with local vim:
```sh
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

```sh
ssh -NC -p PORT -D 4443 USER@HOST  
```

Forwarding:

```sh
ssh -NC -p PORT USER@HOST -L LPORT:RHOST:RPORT
```

Set proxy to port 4443.

## Copying
```sh
rsync -zhuvaPi -e "ssh -vp PORT" SOURCE USER@HOST:DEST
scp -P PORT SOURCE USER@HOST:DEST
```

## VNC
```sh
ssh USER@HOST -p PORT -L 5900:localhost:5900 "x11vnc -display :0 -noxdamage"  
```

Or:
```
ssh -L 5900:localhost:5900 USER@HOST  
x11vnc -safer -localhost -nopw -once -display :0  
```

Or:
```sh
ssh -t -L 5900:localhost:5900 USER@HOST 'sudo x11vnc -display :0 -auth /home/USER/.Xauthority'  
```

# Windows
Install cygwin and babun/apt-cyg

