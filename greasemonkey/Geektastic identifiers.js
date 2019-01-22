// ==UserScript==
// @name        Geektastic Identifiers
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/geektastic_identifiers
// @include     *geektastic.com/dashboard
// @exclude     none
// @version     1
// @description:en	Extracts and displays the identifier of a Geektastic test on the dashboard, so that when you talk to your colleagues you can all be on the same page!
// @grant    		none
// ==/UserScript==

function highlight() {
  let allElements = document.getElementsByTagName('DIV');
  for (let i = 0; i < allElements.length; i += 1) {
    let element = allElements[i];
    if (
      element.className.includes('challenge-statistics') &&
      element.id.includes('stats-')
    ) {
      let id = element.id.split('stats-')[1];
      console.log(`Doing the thing`, id);
      element.style.display = 'inline';
      element.innerHTML = `<span>ID: ${id}</span>`;
      element.style.color = '#00b2d6';
      element.style.fontWeight = 'bold';
      element.style.fontSize = '2rem';
    }
  }
}

setInterval(highlight, 2000);

