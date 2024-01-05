Web browser configs
===================

Use Firefox. I can no longer recommend Chrome and most browsers based on it (like [Brave](https://www.spacebar.news/p/stop-using-brave-browser)) due to manifest v3 or other reasons, like those in the Brave link.
* Recommended [extensions for desktop](https://addons.mozilla.org/en-US/firefox/collections/4759639/tanath/), and [for mobile](https://addons.mozilla.org/en-CA/android/collections/4759639/Tanath-mobile-collection).
    *  To add the mobile collection, use [Firefox beta](https://play.google.com/store/apps/details?id=org.mozilla.firefox_beta&hl=en), go to settings, about. Tap the logo 5 times to enable debug settings. Go back and tap custom add-on collection. Enter the ID and collection name from the URL:
    <img src="https://lh7-us.googleusercontent.com/MCX496ctbJavayFSNxBOLsDwSg9imKT9eMVwdMgTDdjk8l7KCsfhmrLJ_UoRQDbqt5_a0lbz0zuy1qsuREPh0BxfPo0eCyLUKNGm4lSvR_eo8RIqnq6HhHFWsToswMGc-vDuNdh9b2Xe46brSDCpdn4=s320">
    They will show in add-ons as recommended.

      4759639
      Tanath-mobile-collection
* List of privacy & security settings:
    https://github.com/arkenfox/user.js/wiki

  Lots of good info there, but take with a grain of salt.
* [Tridactylrc](https://github.com/Tanath/dotfiles/blob/master/browsers/tridactylrc) - Settings for [Tridactyl](https://github.com/tridactyl/tridactyl) Firefox extension which adds vim-like browser controls.
    * On Linux, save the file to `~/.config/tridactyl/tridactylrc` and run `:source` in Firefox.
    * On Windows, put it in `~\.tridactyl\_tridactyrc` (with no extension).
    * On either, you can copy the link to the raw file on GitHub and use `:source --url ...`
* Install Violentmonkey or Tampermonkey for userscripts, and when you click on 'raw' (or 'view' in the menu on mobile) for the userscripts here, it will offer to install them.
* [SurfingKeysRC](https://gist.github.com/Tanath/3802c263d90cbc78ec1ab2231f85505a) - Settings for [SurfingKeys](https://github.com/brookhong/Surfingkeys) Chrome extension.
