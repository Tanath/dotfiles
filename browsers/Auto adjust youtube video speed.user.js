// ==UserScript==
// @name        Auto adjust youtube video speed
// @description Set youtube video speed to 1.5x (you can set your own speed) automatically.
// @match       https://*.youtube.com/*
// @icon        https://www.google.com/s2/favicons?sz=64&domain=youtube.com
// @require     http://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js
// @require     https://update.greasyfork.org/scripts/383527/701631/Wait_for_key_elements.js
// @grant       GM_addStyle
// @version     0.0.4
// @downloadURL https://github.com/Tanath/dotfiles/raw/master/browsers/Auto%20adjust%20youtube%20video%20speed.user.js
// @updateURL   https://github.com/Tanath/dotfiles/raw/master/browsers/Auto%20adjust%20youtube%20video%20speed.user.js
// ==/UserScript==

waitForKeyElements ("video", function() {
  'use strict';
  // set your desired play speed here
  var rate = 1.5;
  document.querySelector('video').onplay=function() {
    document.querySelector('video').playbackRate = rate;
  }
  document.querySelector('video').playbackRate = rate;
});
