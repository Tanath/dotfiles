// ==UserScript==
// @name        Disable input autofocus
// @match       https://*/*
// @grant       GM_addStyle
// @version     0.2
// @author      Tanath
// @description Prevent pages from automatically focusing input.
// ==/UserScript==

GM_addStyle("input { focus: blur !important; }");
var inputList = document.getElementsByTagName("input");
for(var i = 0; i < inputList.length; i++){
    inputList[i].blur();
}
