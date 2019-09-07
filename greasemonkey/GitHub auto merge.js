// ==UserScript==
// @name        GitHub auto merge
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_auto_merge
// @include     YOUR_PR_URL_HERE
// @exclude     none
// @version     3
// @description:en	Automatically merges a GitHub PR on the URL provided.
// @grant    		none
// ==/UserScript==

function createNotification () {
  const notificationElement = document.createElement('div');
  notificationElement.innerText = `THIS PR WILL BE AUTOMATICALLY MERGED.`;
  notificationElement.style.backgroundColor = 'red';
  notificationElement.style.fontSize = '1.5rem';
  notificationElement.style.fontWeight = 'bold';
  notificationElement.style.padding = '0.375rem 1.5rem';
  notificationElement.style.display = 'flex';
  notificationElement.style.justifyContent = 'center';
  notificationElement.style.position = 'fixed';
  notificationElement.style.top = 0;
  notificationElement.style.left = 0;
  notificationElement.style.width = '100vw';
  notificationElement.style.color = 'white';
  notificationElement.style.zIndex = 500;
  notificationElement.id = 'auto_merge_notification';

  const bodyElement = document.getElementsByTagName('BODY')[0];
  bodyElement.appendChild(notificationElement);
}

function showNotification() {
  const addedNotification = document.getElementById('auto_merge_notification');
  if (addedNotification) {
    return;
  }

  createNotification();
}

function mergeIfReady() {
  showNotification();
  console.log('TESTING MERGEABILITY');

  let allElements = document.getElementsByTagName('BUTTON');

  allElements = document.getElementsByTagName('BUTTON');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    if (
      element.textContent &&
      !element.disabled &&
      element.innerText === 'Delete branch'
    ) {
      console.log('DELETING BRANCH');
      element.click();
      return;
    }
  }

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

