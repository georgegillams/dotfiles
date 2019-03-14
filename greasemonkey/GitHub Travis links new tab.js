// ==UserScript==
// @name        GitHub Travis links new tab
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/github_travis_new_tab
// @include     *github.com*
// @include     *github.skyscannertools.net*
// @exclude     none
// @version     4
// @description:en	Adds rel=no_opener and taget=blank to github travis links on Github
// @grant    		none
// ==/UserScript==

function addTarget() {
  const allElements = document.getElementsByTagName("*");
  for (let i = 0; i < allElements.length; i += 1) {
    let element = allElements[i];
    if (element.href && (element.href.includes("travis") || element.href.includes("jenkins"))) {
      element.target = "_blank";
      element.rel = "noopener noreferrer";
    }
  }
}

setInterval(addTarget, 2000);

