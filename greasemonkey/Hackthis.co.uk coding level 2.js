// ==UserScript==
// @name        Hackthis.co.uk coding level 2
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/hackthis_coding_2
// @include     https://www.hackthis.co.uk/levels/coding/2
// @exclude     none
// @version     2
// @description Calculates and fills in the solution to coding level 2 on hackthis.co.uk
// @description:en Calculates and fills in the solution to coding level 2 on hackthis.co.uk
// @grant    		none
// ==/UserScript==
let answer = "INCOMPLETE";

function decrypt(n) {
  if (n === " ") {
    return n;
  }
  r = String.fromCharCode(126 + 32 - n);
  console.log(`${n} -> ${r}`);
  return r;
}

function solveLevel() {
  if (answer !== "INCOMPLETE") {
    return;
  }
  let allElements = document.getElementsByTagName("textarea");
  for (let i = 0; i < allElements.length; i += 1) {
    let element = allElements[i];
    if (element.style.height === "140px") {
      element.style.backgroundColor = "#44aeff";
      if (answer === "INCOMPLETE") {
        answer = "";
        const values = element.value.split(",");
        console.log();
        console.log(values);
        for (j = 0; j < values.length; j += 1) {
          answer += decrypt(values[j]);
        }
        console.log(answer);
      } else {
        element.value = answer;
      }
    }
  }
}

solveLevel();
setInterval(solveLevel, 500);
