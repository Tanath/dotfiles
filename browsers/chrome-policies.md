Chrome policies
===============

Source:
https://www.chromium.org/administrators/linux-quick-start

Policy configuration locations:  
`/etc/chromium` for Chromium  
`/etc/opt/chrome` for Google Chrome

Managed is admin-mandated. Recommended is not required.
```
/etc/opt/chrome/policies/managed/
/etc/opt/chrome/policies/recommended/
```

Create if they don't exist:

`mkdir -p /etc/opt/chrome/policies/{managed,recommended}`

Files are json. Eg.:
```json
{
  "HomepageLocation": "news.google.ca"
}
```

Complete policy list: https://www.chromium.org/administrators/policy-list-3
