Web browser configs
===================

Use Firefox. I can no longer recommend Chrome and most browsers based on it (like [Brave](https://www.spacebar.news/p/stop-using-brave-browser)) due to manifest v3 or other reasons, like those in the Brave link.
* Windows [direct download for Firefox](https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US) from powershell, for setting up a new Windows install without running Edge:
    * `iwr -uri https://tiny.cc/firefoxdl -outfile firefox-installer.exe`
    * `iwr -uri 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US' -outfile firefox-installer.exe`
* Recommended [extensions for desktop](https://addons.mozilla.org/en-US/firefox/collections/4759639/tanath/), and [for mobile](https://addons.mozilla.org/en-CA/android/collections/4759639/Tanath-mobile-collection).
    *  To add the mobile collection, use [Firefox beta](https://play.google.com/store/apps/details?id=org.mozilla.firefox_beta&hl=en), go to settings, about. Tap the logo 5 times to enable debug settings. Go back and tap custom add-on collection. Enter the ID and collection name from the URL:
    <img src="https://lh7-us.googleusercontent.com/MCX496ctbJavayFSNxBOLsDwSg9imKT9eMVwdMgTDdjk8l7KCsfhmrLJ_UoRQDbqt5_a0lbz0zuy1qsuREPh0BxfPo0eCyLUKNGm4lSvR_eo8RIqnq6HhHFWsToswMGc-vDuNdh9b2Xe46brSDCpdn4=s320">

    They will show in add-ons as recommended.

      4759639
      Tanath-mobile-collection
* Dark themes:

    * There's a few options in my extension collection.
    * https://addons.mozilla.org/en-US/firefox/addon/matte-black-blue/ (fallback available in Addons)
* Install Violentmonkey or Tampermonkey for userscripts, and when you click on 'raw' (or 'view' in the menu on mobile) for the userscripts here (above), it will offer to install them.
* If you use the [userscript to set the font to Atkinson Hyperlegible](https://github.com/Tanath/dotfiles/blob/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js), then you might want to put this bookmarklet on your toolbar on desktop, and in `Bookmarks` on mobile:

    ```js
    javascript:(function() {  'use strict';  var style = `  * {  font-family: 'Atkinson Hyperlegible', 'Fira Code', 'Noto Sans Symbols', sans-serif !important;  }  `;  var styleElement = document.createElement('style'); styleElement.appendChild(document.createTextNode(style)); document.head.appendChild(styleElement); })();
    ```
    
    The userscript sets the font where it can without breaking some text icons, making tofu. The bookmarklet uses `!important` to override if you don't care and want to change it anyway. It depends on the userscript to make the font available though.
* List of privacy & security settings:
    https://github.com/arkenfox/user.js/wiki

  Lots of good info there, but take with a grain of salt.
* The Context search origin extension adds custom search engines to the context menu (right click). Just add a bookmarks folder called `Searches` (needs the capital) with crafted bookmarks for your search engines. Usually you can go to a search page and right click on the search box, and choose "add keyword for this search" to add the right kind of bookmark. Put those bookmarks in that folder for them to appear in the context menu.
    * These bookmarks all have `%s` in them somewhere, which is a search variable that gets replaced with your search. Firefox lets you add keywords to these bookmarks so you can use them from the address bar, like `wp Firefox` could search Wikipedia for Firefox if you set 'wp' as its keyword. My tridactylrc has ideas for keywords and URLs in the search engines section.
* [Tridactylrc](https://github.com/Tanath/dotfiles/blob/master/browsers/tridactylrc) - Settings for [Tridactyl](https://github.com/tridactyl/tridactyl) Firefox extension which adds vim-like browser controls.
    * On Linux, save the file to `~/.config/tridactyl/tridactylrc` and run `:source` in Firefox.
    * On Windows, put it in `~\.tridactyl\_tridactyrc` (with no extension).
    * On either, you can copy the link to the raw file on GitHub and use `:source --url https://github.com/Tanath/dotfiles/raw/master/browsers/tridactylrc`

Chrome
======

* [SurfingKeysRC](https://gist.github.com/Tanath/3802c263d90cbc78ec1ab2231f85505a) - Settings for [SurfingKeys](https://github.com/brookhong/Surfingkeys) Chrome extension.
