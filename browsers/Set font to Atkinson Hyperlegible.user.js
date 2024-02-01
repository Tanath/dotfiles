// ==UserScript==
// @name         Set font to Atkinson Hyperlegible
// @version      0.9
// @description  Set font to Atkinson Hyperlegible (Pro).
// @author       Tanath
// @downloadURL  https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @updateURL    https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @match        https://*/*
// @match        http://*/*
// @grant        GM_addStyle
// ==/UserScript==

window.onload = function() {
    'use strict';
    var link1 = document.createElement('link');
    link1.href = 'https://github.com';
    link1.rel = 'preconnect';
    document.head.appendChild(link1);

    var link2 = document.createElement('link');
    link2.href = 'https://fonts.googleapis.com';
    link2.rel = 'preconnect';
    document.head.appendChild(link2);

    var link3 = document.createElement('link');
    link3.href = 'https://fonts.googleapis.com/css2?display=swap&family=Atkinson+Hyperlegible&family=Source+Code+Pro&family=Fira+Code&family=Noto+Sans+Symbols';
    link3.rel = 'stylesheet';
    document.head.appendChild(link3);

    var fontFace = `
        @font-face {
            font-family: 'Atkinson Hyperlegible Pro';
            src: url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/main/fonts/web/AtkinsonHyperPro-Regular.woff2') format('woff2'),
                 url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/main/fonts/web/AtkinsonHyperPro-Bold.woff2') format('woff2'),
                 url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/main/fonts/web/AtkinsonHyperPro-Italic.woff2') format('woff2'),
                 url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/main/fonts/web/AtkinsonHyperPro-BoldItalic.woff2') format('woff2');
            font-weight: 400 700;
            font-style: normal italic;
        }
    `;
    var styleElement = document.createElement('style');
    styleElement.appendChild(document.createTextNode(fontFace));
    document.head.appendChild(styleElement);

    var style = `
        * {
            font-family: 'Atkinson Hyperlegible Pro', 'Atkinson Hyperlegible', 'Source Code Pro', 'Fira Code', 'Noto Sans Symbols', sans-serif;
        }
    `;
    var styleElement2 = document.createElement('style');
    styleElement2.appendChild(document.createTextNode(style));
    document.head.appendChild(styleElement2);

    GM_addStyle(style);
};

