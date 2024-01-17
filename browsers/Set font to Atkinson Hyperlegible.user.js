// ==UserScript==
// @name         Set font to Atkinson Hyperlegible
// @version      0.8
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
    link2.href = 'https://fonts.googleapis.com/css2?display=swap&family=Atkinson+Hyperlegible&family=Fira+Code&family=Source+Code+Pro&family=Noto+Sans+Symbols';
    link2.rel = 'stylesheet';
    document.head.appendChild(link2);

/*
    var style = `
        body, h1, h2, h3, main, article, .article, article-body, section, div, span, p, td, li, a {
            font-family: 'Atkinson Hyperlegible', 'Fira Code', 'Noto Sans Symbols', sans-serif;
        }
    `;
*/

    var style = `
        * {
            font-family: 'Atkinson Hyperlegible', 'Fira Code', 'Source Code Pro', 'Noto Sans Symbols', sans-serif;
        }
    `;
    var styleElement = document.createElement('style');
    styleElement.appendChild(document.createTextNode(style));
    document.head.appendChild(styleElement);

    GM_addStyle(style);
})();
