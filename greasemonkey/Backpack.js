// ==UserScript==
// @name        Backpack
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/backpack_docs
// @include     *backpack.github.io*
// @exclude     none
// @version     1
// @description:en	Adjusts the layout of backpack docs to make it more laptop-friendly
// @grant    		none
// ==/UserScript==

let lastModifiedUrl = null;

function fixNavs() {
  const allElements = document.getElementsByTagName("NAV");
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    const elementClassName = `${element.className}`;
    if (elementClassName.includes("bpkdocs-sidebar-")) {
      element.style.minWidth = "10rem";
      element.style.padding = "3.75rem 2rem";
    }
  }
}

function fixImgs() {
  const allElements = document.getElementsByTagName("IMG");
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    const elementClassName = `${element.className}`;
    if (elementClassName.includes("bpkdocs-sections-list__heading-icon-")) {
      element.style.marginRight = "1rem";
    }
  }
}

function fixAll() {
  const currentUrl = `${window.location}`;
  if (currentUrl === lastModifiedUrl) {
    return;
  }
  fixNavs();
  fixImgs();
  lastModifiedUrl = currentUrl;
}

fixAll();
setInterval(fixAll, 500);

