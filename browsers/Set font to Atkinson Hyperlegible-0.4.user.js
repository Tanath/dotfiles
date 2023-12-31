// ==UserScript==
// @name         Set font to Atkinson Hyperlegible
// @version      0.4
// @description  Set font to Atkinson Hyperlegible.
// @author       Tanath
// @match        https://*/*
// @match        http://*/*
// @grant        GM_addStyle
// ==/UserScript==

(function() {
    'use strict';
    GM_addStyle(`
        @import url('https://fonts.googleapis.com/css2?display=swap&family=Atkinson+Hyperlegible');
        body, h1, h2, main, div, span, p, li, a {
            font-family: 'Atkinson Hyperlegible', sans-serif !important;
        }
    `);
})();