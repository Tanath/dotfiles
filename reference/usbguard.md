# How to use [USBGuard](https://usbguard.github.io/)

After installing you can add your user with `sudo usbguard add-user -u <username>` or a group with `-g <group>`. To generate rules based on currently attached usb devices, do this:
* `sudo -i` for root shell.
* `usbguard generate-policy > /etc/usbguard/rules.conf`
* `ctrl+d` or `exit` to leave root shell.

Start & enable the service at boot with `sudo systemctl enable --now usbguard.service`. You can list devices with `sudo usbguard list-devices` and allow them with `sudo usbguard allow-device <id #>` or block them with `sudo usbguard block-device <id #>`.

---
To edit the configs:
* `sudoedit /etc/usbguard/usbguard-daemon.conf`
* `sudoedit /etc/usbguard/usbguard-rules.conf`
* `sudoedit /etc/usbguard/rules.conf`

You can find documentation for this in `man usbguard-daemon.conf` ([link](https://usbguard.github.io/documentation/configuration.html)), and `man usbguard-rules.conf` (and [link](https://usbguard.github.io/documentation/rule-language.html)). See this link for some [specific examples](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-using-usbguard).
