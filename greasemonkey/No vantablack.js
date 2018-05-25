// ==UserScript==
// @name        No vantablack
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/no_vantablack
// @include     *
// @exclude     none
// @version     1
// @description:en	Replaces all black colours with a nicer gray, because black should never be used. Ever
// @grant    		none
// ==/UserScript==

function removeVantaBlack() {
const allElements = document.getElementsByTagName("*");
  for (let i = 0; i < allElements.length; i += 1) {
    let element = allElements[i];
    if (element.style.backgroundColor === "black" || element.style.backgroundColor === "#000" || element.style.backgroundColor === "#0000" || element.style.backgroundColor === "#00000" || element.style.backgroundColor === "#000000") {
      element.style.backgroundColor = "#1e1e1e";
    }
    if (element.style.color === "black" || element.style.color === "#000" || element.style.color === "#0000" || element.style.color === "#00000" || element.style.color === "#000000") {
      element.style.color = "#1e1e1e";
    }
  }
}


removeVantaBlack();
setInterval(removeVantaBlack, 5000);
