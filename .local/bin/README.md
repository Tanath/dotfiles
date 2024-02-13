* Make sure `~/.local/bin` is in your `$PATH`. Installing python should do that already.
* [selection-open.sh](selection-open.sh) - To select text and have it open in the associated program set a keyboard shortcut to: `sh -c '~/path/to/selection-open.sh $(xclip -o -r)'`.
* [gvim.sh](gvim.sh) - Set a keyboard shortcut to this script to select text and send it to a new buffer in gvim (put gvim in your path, like `~/.local/bin/`): `sh -c 'xclip -o -selection primary | gvim.sh'`
* [pyserver.sh](pyserver.sh) - If you want to quickly share some files with a temp web server, python has it built in. Configure port in script, and unprivileged user. Needs `sudo` to run as user.
* [webserv-nc.sh](webserv-nc.sh) - Fake web server to send a file over netcat to a browser. Configure port in script.
