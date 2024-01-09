// ==UserScript==
// @name         Set font to Atkinson Hyperlegible
// @version      0.6.2
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
    var link1 = document.createElement('link');
    link1.href = 'https://fonts.googleapis.com';
    link1.rel = 'preconnect';
    document.head.appendChild(link1);

    var link2 = document.createElement('link');
    link2.href = 'https://fonts.googleapis.com/css2?display=swap&family=Atkinson+Hyperlegible&family=Fira+Code&family=Noto+Sans+Symbols';
    link2.rel = 'stylesheet';
    document.head.appendChild(link2);

    var style = `
        body, h1, h2, h3, main, article, .article, article-body, section, div, span, p, td, li, a {
            font-family: 'Atkinson Hyperlegible', 'Fira Code', 'Noto Sans Symbols', sans-serif !important;
        }
    `;
    GM_addStyle(style);
})();
