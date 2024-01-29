// ==UserScript==
// @name        Limited vimkeys
// @match       https://*/*
// @match       http://*/*
// @grant       window.close
// @version     0.2
// @author      Tanath
// @description Add vim keys for some basic functions like scrolling.
// @downloadURL https://github.com/Tanath/dotfiles/raw/master/browsers/limited-vimkeys.user.js
// @updateURL   https://github.com/Tanath/dotfiles/raw/master/browsers/limited-vimkeys.user.js
// ==/UserScript==

document.addEventListener('keydown', function(e) {
  if (e.target.tagName.toLowerCase() === 'input' || e.target.tagName.toLowerCase() === 'textarea') {
    return;
  }
  switch (e.key) {
    case 'd':
      window.scrollBy({left: 0, top: window.innerHeight * 0.4, behavior: "instant"});
      break;
    case 'e':
      window.scrollBy({left: 0, top: -window.innerHeight * 0.4, behavior: "instant"});
      break;
    case 'j':
      window.scrollBy({left: 0, top: window.innerHeight * 0.25, behavior: "instant"});
      break;
    case 'k':
      window.scrollBy({left: 0, top: -window.innerHeight * 0.25, behavior: "instant"});
      break;
    case 'J':
      window.scrollBy({left: 0, top: window.innerHeight * 0.1, behavior: "instant"});
      break;
    case 'K':
      window.scrollBy({left: 0, top: -window.innerHeight * 0.1, behavior: "instant"});
      break;
    case 'g':
      window.scrollTo({left: 0, top: 0, behavior: "instant"});
      break;
    case 'G':
      window.scrollTo({left: 0, top: document.body.scrollHeight, behavior: "instant"});
      break;
    case 'r':
      location.reload();
      break;
    case 'x':
      window.close();
      break;
    case 'y':
      navigator.clipboard.writeText(window.location.href);
      break;
    case 'S':
      history.back();
      break;
    case 'D':
      history.forward();
      break;
    case 'u':
      window.location.href = window.location.href.replace(/\/[^\/]+\/?$/, '');
      break;
    case '[':
      document.querySelector('video').playbackRate-=0.25
      break;
    case ']':
      document.querySelector('video').playbackRate+=0.25
      break;
    case '=':
      document.querySelector('video').playbackRate=1
      break;
    case '{':
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
    case '}':
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

