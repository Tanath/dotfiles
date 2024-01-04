// ==UserScript==
// @name         Spacebar scroll marker
// @namespace    None
// @version      0.3
// @description  Fading marker line when you hit space to scroll.
// @match        https://*/*
// @exclude      https://docs.google.com/*
// @exclude      https://*.reddit.com/*
// @grant        none
// @downloadURL  https://github.com/Tanath/dotfiles/raw/master/browsers/Spacebar%20scroll%20marker.user.js
// @updateURL    https://github.com/Tanath/dotfiles/raw/master/browsers/Spacebar%20scroll%20marker.user.js
// ==/UserScript==
(function() {
    'use strict';
    let elem = document.createElement('div');
    elem.style.width = "100%";
    elem.style.borderTop = "1px solid red";
    elem.style.position = "absolute";
    elem.style.top = "0px";
    elem.style.opacity = "0";
    elem.style.transition = "opacity 1500ms";
    document.body.appendChild(elem);
    window.addEventListener('keydown', e => {
        if (e.code === "Space") {
            elem.style.transition = "";
            elem.style.top = (window.innerHeight + window.scrollY) + "px";
            elem.style.opacity = "1";
            setTimeout(function() {
                elem.style.transition = "opacity 1800ms";
                elem.style.opacity = "0";
            }, 200);
        }
    });
})();
