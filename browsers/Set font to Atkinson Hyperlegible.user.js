// ==UserScript==
// @name         Set font to Atkinson Hyperlegible
// @version      0.5
// @description  Set font to Atkinson Hyperlegible.
// @author       Tanath
// @downloadURL  https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @updateURL    https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @match        https://*/*
// @match        http://*/*
// @grant        GM_addStyle
// ==/UserScript==

(function() {
    'use strict';
    // Preload the font for improved performance
    var link = document.createElement('link');
    link.href = 'https://fonts.googleapis.com/css2?display=swap&family=Atkinson+Hyperlegible';
    link.rel = 'preload';
    link.as = 'font';
    document.head.appendChild(link);

    var style = `
        body, h1, h2, h3, main, div, span, p, td, li, a {
            font-family: 'Atkinson Hyperlegible', sans-serif !important;
        }
    `;
})();
