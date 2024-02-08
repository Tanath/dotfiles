// ==UserScript==
// @name        Disable input autofocus
// @match       https://*/*
// @grant       none
// @version     0.1
// @author      Tanath
// @description Prevent pages from automatically focusing input.
// ==/UserScript==

var inputList = document.getElementsByTagName("input");
for(var i = 0; i < inputList.length; i++){
    inputList[i].blur();
}
