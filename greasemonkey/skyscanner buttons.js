// ==UserScript==
// @name        Skyscanner buttons
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/skyscanner_buttons
// @include     *
// @exclude     none
// @version     3
// @description:en	Makes the button on Skyscanner nicer by reducing padding and border-radius
// @grant    		none
// ==/UserScript==

function fixButtons() {
  const allElements = document.getElementsByTagName("BUTTON");
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    const elementClassName = `${element.className}`;
    if (
      elementClassName.includes("bpk-button") ||
      elementClassName.includes("backpack-button")
    ) {
      console.log("found it!");
      console.log(element);
      element.style.borderRadius = ".3rem";
      element.style.boxShaddow = ".3rem .3rem 1rem blue";
      element.style.padding = ".2rem .8rem";

      if (
        elementClassName.includes("secondary") ||
        elementClassName.includes("featured") ||
        elementClassName.includes("destructive") ||
        element.disabled
      ) {
        continue;
      }
      // element.style.backgroundImage = 'none';
      // element.style.backgroundColor = '#a3aaff';
      element.style.color = "white";
      // element.style.backgroundImage = 'linear-gradient(140deg, #ff87e0, #a3aaff)';
    }
  }
}

fixButtons();
setInterval(fixButtons, 5000);
