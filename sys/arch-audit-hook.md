/usr/share/libalpm/hooks/arch-audit.hook

[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = *

[Action]
Depends = curl
Depends = openssl
Depends = arch-audit
When = PostTransaction
Exec = /usr/bin/arch-audit
Description = Checking packages for known vulnerabilities…
