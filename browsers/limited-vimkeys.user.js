// ==UserScript==
// @name        Limited vimkeys
// @match       https://*/*
// @match       http://*/*
// @grant       window.close
// @version     0.2.1
// @author      Tanath
// @description Add vim keys for some basic functions like scrolling.
// @downloadURL https://github.com/Tanath/dotfiles/raw/master/browsers/limited-vimkeys.user.js
// @updateURL   https://github.com/Tanath/dotfiles/raw/master/browsers/limited-vimkeys.user.js
// ==/UserScript==

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
const slower = '[';
const faster = ']';
const normalSpeed = '=';
const prevSection = '{';
const nextSection = '}';

document.addEventListener('keydown', function(e) {
  if (e.target.tagName.toLowerCase() === 'input' || e.target.tagName.toLowerCase() === 'textarea') {
    return;
  }
  switch (e.key) {
    case scrollDown:
      window.scrollBy({left: 0, top: window.innerHeight * 0.25, behavior: "instant"});
      break;
    case scrollUp:
      window.scrollBy({left: 0, top: -window.innerHeight * 0.25, behavior: "instant"});
      break;
    case scrollDownHalf:
      window.scrollBy({left: 0, top: window.innerHeight * 0.4, behavior: "instant"});
      break;
    case scrollUpHalf:
      window.scrollBy({left: 0, top: -window.innerHeight * 0.4, behavior: "instant"});
      break;
    case downSmall:
      window.scrollBy({left: 0, top: window.innerHeight * 0.1, behavior: "instant"});
      break;
    case upSmall:
      window.scrollBy({left: 0, top: -window.innerHeight * 0.1, behavior: "instant"});
      break;
    case jumpTop:
      window.scrollTo({left: 0, top: 0, behavior: "instant"});
      break;
    case jumpBottom:
      window.scrollTo({left: 0, top: document.body.scrollHeight, behavior: "instant"});
      break;
    case reload:
      location.reload();
      break;
    case close:
      window.close();
      break;
    case copyURL:
      navigator.clipboard.writeText(window.location.href);
      break;
    case goBack:
      history.back();
      break;
    case goForward:
      history.forward();
      break;
    case upURL:
      window.location.href = window.location.href.replace(/\/[^\/]+\/?$/, '');
      break;
    case slower:
      document.querySelector('video').playbackRate-=0.25
      break;
    case faster:
      document.querySelector('video').playbackRate+=0.25
      break;
    case normalSpeed:
      document.querySelector('video').playbackRate=1
      break;
    case prevSection:
      (function() {
        var prevTargetElements = document.querySelectorAll('h1, h2, h3, h4, h5, h6, hr, section, article, aside, nav, header, main');
        var currentY = window.scrollY;
        for (var i = prevTargetElements.length - 1; i >= 0; i--) {
          var pElementY = prevTargetElements[i].getBoundingClientRect().top + window.scrollY;
          if (pElementY < currentY) {
            window.scrollTo({ top: pElementY, behavior: 'smooth' });
            break;
          }
        }
      })();
      break;
    case nextSection:
      (function() {
        var nextTargetElements = document.querySelectorAll('h1, h2, h3, h4, h5, h6, hr, section, article, aside, nav, header, main');
        var currentY = window.scrollY;
        for (var i = 0; i < nextTargetElements.length; i++) {
          var nElementY = nextTargetElements[i].getBoundingClientRect().top + window.scrollY;
          if (nElementY > (currentY+1)) {
            window.scrollTo({ top: nElementY, behavior: 'smooth', block: 'start' });
            break;
          }
        }
      })();
      break;
  }
});

