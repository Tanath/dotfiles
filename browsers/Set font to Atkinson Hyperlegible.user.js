// ==UserScript==
// @name         Set font to Atkinson Hyperlegible
// @version      0.4.1
// @description  Set font to Atkinson Hyperlegible.
// @author       Tanath
// @updateURL https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @match        https://*/*
// @match        http://*/*
// @grant        GM_addStyle
// ==/UserScript==

(function() {
    'use strict';
    GM_addStyle(`
        @import url('https://fonts.googleapis.com/css2?display=swap&family=Atkinson+Hyperlegible');
        body, h1, h2, h3, main, div, span, p, li, a {
            font-family: 'Atkinson Hyperlegible', sans-serif !important;
        }
    `);
})();
