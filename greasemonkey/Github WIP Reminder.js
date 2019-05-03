// ==UserScript==
// @name        GitHub WIP reminder
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/github_WIP_reminder
// @include     *github.com*
// @exclude     none
// @version     2
// @description:en	Adds an reminder to not review WIP PR's
// @description	Adds an reminder to not review WIP PR's
// @grant    		none
// ==/UserScript==

let lastModifiedPr = null;

function addReminder() {
  let prId = `${window.location}`.split('pull/')[1];
  if (lastModifiedPr === prId) {
    return;
  } else {
    let allElements = document.getElementsByTagName('SPAN');
    for (let i = 0; i < allElements.length; i += 1) {
      let element = allElements[i];
      if (element.innerText.includes('WIP')) {
          console.log(`element`, element)
        console.log(`element.parentElement.parentElement`, element.parentElement.parentElement);
        if (element.parentElement.parentElement.className.includes("labels css-truncate")) {
          console.log(`wip`);
          let newElement = document.createElement('div');
          newElement.innerText = `HEY THIS IS WIP!`;
          newElement.style.backgroundColor = 'rgb(214, 11, 0)';
          newElement.style.color = 'white';
          newElement.style.fontSize = '2rem';
          newElement.style.position = 'fixed';
          newElement.style.left = 0;
          newElement.style.top = 0;
          newElement.style.zIndex = 40000;
          newElement.style.width = '100vw';
          newElement.style.height = '5rem';
          newElement.style.padding = '1rem';
          newElement.style.display = 'flex';
          newElement.style.alignItems = 'center';
          newElement.style.justifyContent = 'center';
          element.appendChild(newElement);
        }
      }
    }
  }
  lastModifiedPr = prId;
}

setInterval(addReminder, 2000);

