// ==UserScript==
// @name        Limited vimkeys
// @match       https://*/*
// @match       http://*/*
// @grant       window.close
// @version     1.0.2
// @author      Tanath
// @description Add vim keys for some basic functions like scrolling.
// @downloadURL https://github.com/Tanath/dotfiles/raw/master/browsers/limited-vimkeys.user.js
// @updateURL   https://github.com/Tanath/dotfiles/raw/master/browsers/limited-vimkeys.user.js
// ==/UserScript==
// Changelog:
// 1.0.1 -> 1.0.2: fix bug with input typing & consolidate 2 event listeners.

const scrollDown = 'j';
const scrollUp = 'k';
const scrollDownHalf = 'd';
const scrollUpHalf = 'e';
const downSmall = 'J';
const upSmall = 'K';
const jumpTop = 'g';
const jumpBottom = 'G';
const reload = 'r';
const close = 'x';
const copyURL = 'y';
const goBack = 'S';
const goForward = 'D';
const upURL = 'u';
const focusInput = 'i';
const slower = '[';
const faster = ']';
const normalSpeed = '=';
const prevSection = '{';
const nextSection = '}';
const repeatAction = '.';
let lastAction = null;

const actions = {
    [scrollDown]: () => window.scrollBy({left: 0, top: window.innerHeight * 0.25, behavior: "instant"}),
    [scrollUp]: () => window.scrollBy({left: 0, top: -window.innerHeight * 0.25, behavior: "instant"}),
    [scrollDownHalf]: () => window.scrollBy({left: 0, top: window.innerHeight * 0.4, behavior: "instant"}),
    [scrollUpHalf]: () => window.scrollBy({left: 0, top: -window.innerHeight * 0.4, behavior: "instant"}),
    [downSmall]: () => window.scrollBy({left: 0, top: window.innerHeight * 0.1, behavior: "instant"}),
    [upSmall]: () => window.scrollBy({left: 0, top: -window.innerHeight * 0.1, behavior: "instant"}),
    [jumpTop]: () => window.scrollTo({left: 0, top: 0, behavior: "instant"}),
    [jumpBottom]: () => window.scrollTo({left: 0, top: document.body.scrollHeight, behavior: "instant"}),
    [reload]: () => location.reload(),
    [close]: () => window.close(),
    [copyURL]: () => navigator.clipboard.writeText(window.location.href),
    [goBack]: () => history.back(),
    [goForward]: () => history.forward(),
    [upURL]: () => window.location.href = window.location.href.replace(/\/[^\/]+\/?$/, ''),
    [focusInput]: () => {
        let input = document.querySelector('input, textarea');
        if (input) {
            document.addEventListener('keydown', (event) => {
                if (event.key === 'i' && document.activeElement !== input) {
                    event.preventDefault();
                    setTimeout(() => {
                        input.focus();
                    });
                }
            });
        }
    },
    [slower]: () => document.querySelector('video').playbackRate -= 0.25,
    [faster]: () => document.querySelector('video').playbackRate += 0.25,
    [normalSpeed]: () => document.querySelector('video').playbackRate = 1,
    [prevSection]: (e) => {
        (function(e) {
            var prevTargetElements = document.querySelectorAll('h1, h2, h3, h4, h5, h6, hr, section, article, aside, nav, header, main');
            var currentY = window.scrollY;
            for (var i = prevTargetElements.length - 1; i >= 0; i--) {
                var pElementY = prevTargetElements[i].getBoundingClientRect().top + window.scrollY;
                if (pElementY < currentY) {
                    window.scrollTo({ top: pElementY, behavior: 'smooth' });
                    break;
                }
            }
        })(e);
    },
    [nextSection]: (e) => {
        (function(e) {
            var nextTargetElements = document.querySelectorAll('h1, h2, h3, h4, h5, h6, hr, section, article, aside, nav, header, main');
            var currentY = window.scrollY;
            for (var i = 0; i < nextTargetElements.length; i++) {
                var nElementY = nextTargetElements[i].getBoundingClientRect().top + window.scrollY;
                if (nElementY > (currentY+1)) {
                    window.scrollTo({ top: nElementY, behavior: 'smooth', block: 'start' });
                    break;
                }
            }
        })(e);
    }
};

document.addEventListener('keydown', function(e) {
    if (e.target.tagName.toLowerCase() === 'input' || e.target.tagName.toLowerCase() === 'textarea') {
        return;
    }
    let key = e.key;
    if (key === repeatAction && lastAction && actions[lastAction]) {
        e.preventDefault();
        actions[lastAction]();
    } else if (actions[key]) {
        actions[key]();
        lastAction = key;
    }
});

