// ==UserScript==
// @name        Github highlight my name
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_highlight_name
// @include     *github.com*
// @exclude     none
// @version     1
// @description:en	Adds highlight to my own name
// @grant    		none
// ==/UserScript==

function highlight() {
  let allElements = document.getElementsByTagName("A");
  for (let i = 0; i < allElements.length; i += 1) {
    let element = allElements[i];
    if (
      element.className === "muted-link" &&
      element.textContent.includes("georgegillams")
    ) {
      element.style.backgroundColor = "#44aeff";
      element.style.padding = "0 .3rem";
      element.style.color = "white !important";
    }
  }
}

setInterval(highlight, 2000);
