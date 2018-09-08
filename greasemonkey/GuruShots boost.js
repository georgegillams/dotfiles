// ==UserScript==
// @name        GuruShots boost
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/gurushots_boost
// @include     *gurushots.com/*
// @exclude     none
// @version     6
// @description:en	Makes the boost buttons on GuruShots.com stand out more when a free boost is available.
// @grant    		none
// ==/UserScript==

function checkForFreeBoosts() {
  let availableBoostCount = 0;

  const allDivElements = document.getElementsByTagName("DIV");
  for (let i = 0; i < allDivElements.length; i += 1) {
    const element = allDivElements[i];
    if (element.className.includes("boost")) {
      if (
        element.className.includes("boost--boosting") ||
        element.className.includes("boost-state-locked") ||
        element.className.includes("boost-state-used")
      ) {
        continue;
      }
      availableBoostCount += 1;
      element.style.backgroundColor = "hotpink";
      element.style.color = "white";
      element.style.borderColor = "black";
      element.style.opacity = "1";
    }
  }

  if (availableBoostCount < 1) {
    return;
  }

  for (let i = 0; i < allDivElements.length; i += 1) {
    const element = allDivElements[i];
    if (element.className === "w-max") {
      element.style.backgroundColor = "hotpink";
    }
  }
}

setInterval(checkForFreeBoosts, 5000);
