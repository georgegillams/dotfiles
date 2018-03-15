// ==UserScript==
// @name        skyscanner buttons
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/skyscanner_buttons
// @include     https://*skyscanner.net/*
// @exclude     none
// @version     1
// @grant    		none
// ==/UserScript==

const allElements = document.getElementsByTagName("*");
for (let i = 0; i < allElements.length; i += 1) {
  const element = allElements[i];
  if ((element.className + "").includes("bpk-button")) {
    console.log("Found it!");
    element.style.backgroundImage =
      "linear-gradient(140deg, #ff87e0, #a3aaff) !important";
    element.style.padding = ".2rem .8rem !important";
    element.style.borderRadius = ".3rem !important";
    element.style.boxShaddow = ".3rem .3rem 1rem blue";
  }
}
