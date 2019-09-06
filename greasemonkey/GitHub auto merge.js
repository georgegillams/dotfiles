// ==UserScript==
// @name        GitHub auto merge
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_auto_merge
// @include     YOUR_PR_URL_HERE
// @exclude     none
// @version     2
// @description:en	Automatically merges a GitHub PR on the URL provided.
// @grant    		none
// ==/UserScript==

function mergeIfReady() {
  console.log('TESTING MERGEABILITY');

  let allElements = document.getElementsByTagName('BUTTON');

  allElements = document.getElementsByTagName('BUTTON');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    if (
      element.textContent &&
      !element.disabled &&
      element.innerText === 'Confirm merge'
    ) {
      console.log('CONFIRMING MERGE');
      element.click();
      return;
    }
  }

  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    if (
      element.textContent &&
      !element.disabled &&
      !element.className.includes('btn-danger') &&
      element.innerText === 'Merge pull request'
    ) {
      console.log('MERGING');
      element.click();
    }
  }
}

function reload() {
  console.log('RELOADING');

  window.reload();
}

setInterval(mergeIfReady, 1500);
setInterval(reload, 36000);

