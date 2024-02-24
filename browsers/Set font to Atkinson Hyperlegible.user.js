// ==UserScript==
// @name         Set fonts to Atkinson Hyperlegible Pro & Fira Code Nerd Font
// @version      1.0.1
// @description  Set sans font to Atkinson Hyperlegible Pro & mono to Fira Code Nerd Font.
// @author       Tanath
// @downloadURL  https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @updateURL    https://github.com/Tanath/dotfiles/raw/master/browsers/Set%20font%20to%20Atkinson%20Hyperlegible.user.js
// @match        https://*/*
// @match        http://*/*
// @grant        GM_addStyle
// ==/UserScript==

document.onreadystatechange = function () {
    if (document.readyState === 'complete') {
        'use strict';

        var link1 = document.createElement('link');
        link1.href = 'https://github.com';
        link1.rel = 'preconnect';
        document.head.appendChild(link1);

        var fontFace = `
        @font-face {
            font-family: 'Atkinson Hyperlegible Pro', sans-serif;
            src: url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/v1.5.1/fonts/web/AtkinsonHyperPro-Regular.woff2') format('woff2'),
                 url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/v1.5.1/fonts/web/AtkinsonHyperPro-Bold.woff2') format('woff2'),
                 url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/v1.5.1/fonts/web/AtkinsonHyperPro-Italic.woff2') format('woff2'),
                 url('https://github.com/jacobxperez/atkinson-hyperlegible-pro/raw/v1.5.1/fonts/web/AtkinsonHyperPro-BoldItalic.woff2') format('woff2');
            font-weight: 400 700;
            font-style: normal italic;
        }

        @font-face {
            font-family: 'FiraCode Nerd Font Mono', monospace;
            font-style: normal;
            font-weight: 300;
            src: url('https://github.com/ryanoasis/nerd-fonts/raw/v3.1.1/patched-fonts/FiraCode/Light/FiraCodeNerdFontMono-Light.ttf') format('truetype');
            font-variant-ligatures: none;
        }

        @font-face {
            font-family: 'FiraCode Nerd Font Mono', monospace;
            font-style: normal;
            font-weight: 400;
            src: url('https://github.com/ryanoasis/nerd-fonts/raw/v3.1.1/patched-fonts/FiraCode/Retina/FiraCodeNerdFontMono-Retina.ttf') format('truetype');
            font-variant-ligatures: none;
        }

        @font-face {
            font-family: 'FiraCode Nerd Font Mono', monospace;
            font-style: normal;
            font-weight: 500;
            src: url('https://github.com/ryanoasis/nerd-fonts/raw/v3.1.1/patched-fonts/FiraCode/Medium/FiraCodeNerdFontMono-Medium.ttf') format('truetype');
            font-variant-ligatures: none;
        }

        @font-face {
            font-family: 'FiraCode Nerd Font Mono', monospace;
            font-weight: 600;
            src: url('https://github.com/ryanoasis/nerd-fonts/raw/v3.1.1/patched-fonts/FiraCode/SemiBold/FiraCodeNerdFontMono-SemiBold.ttf') format('truetype');
            font-variant-ligatures: none;
        }

        @font-face {
            font-family: 'FiraCode Nerd Font Mono', monospace;
            font-weight: 700;
            src: url('https://github.com/ryanoasis/nerd-fonts/raw/v3.1.1/patched-fonts/FiraCode/Bold/FiraCodeNerdFontMono-Bold.ttf') format('truetype');
            font-variant-ligatures: none;
        }
        `;

        var styleElement = document.createElement('style');
        styleElement.appendChild(document.createTextNode(fontFace));
        document.head.appendChild(styleElement);

        var style = `
        body, h1, h2, h3, h4, h5, h6, p, a, section, article, aside, nav, header, main, q, li, blockquote {
            font-family: 'Atkinson Hyperlegible Pro', sans-serif !important;
        }
        code, pre, kbd, var, samp {
            font-family: 'FiraCode Nerd Font Mono', monospace !important;
        }
        `;
        var styleElement2 = document.createElement('style');
        styleElement2.appendChild(document.createTextNode(style));
        document.head.appendChild(styleElement2);
    };
};

