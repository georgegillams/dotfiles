// ==UserScript==
// @name        GitHub auto merge
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_auto_merge
// @include     *github.com*
// @include     *github.skyscannertools.net*
// @exclude     none
// @version     6
// @description:en	Automatically merges a GitHub PR on the URL provided.
// @grant    		none
// ==/UserScript==

let testCount = 0;

function createNotification() {
  const notificationElement = document.createElement('div');
  notificationElement.innerText = `THIS PR WILL BE AUTOMATICALLY MERGED.`;
  notificationElement.style.backgroundColor = '#d92b6b';
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

function getNotification() {
  const addedNotification = document.getElementById('auto_merge_notification');
  return addedNotification;
}

function createNotificationIfNecessary() {
  if (willAutoMerge() && !getNotification()) {
    createNotification();
  }
}

function createButton() {
  const mergeButton = document.createElement('button');
  mergeButton.innerText = `AUTO MERGE PR`;
  mergeButton.style.color = 'white';
  mergeButton.style.fontSize = '1rem';
  mergeButton.style.fontWeight = 'bold';
  mergeButton.style.padding = '0.375rem 1.5rem';
  mergeButton.id = 'auto_merge_button';
  mergeButton.style.border = 'none';
  mergeButton.style.backgroundColor = '#fa488a';
  mergeButton.style.backgroundImage =
    'linear-gradient(-180deg, #fa488a 0%, #d92b6b 100%)';
  mergeButton.style.borderRadius = '10rem';
  mergeButton.style.marginTop = '1rem';
  mergeButton.onclick = toggleAutoMerge;

  const mergeMessageElements = document.getElementsByClassName('merge-message');
  if (mergeMessageElements.length < 1) {
    return;
  }

  const mergeMessageElement = document.getElementsByClassName(
    'merge-message',
  )[0];
  if (mergeMessageElement) {
    mergeMessageElement.appendChild(mergeButton);
  }
}

function getAutoMergeButton() {
  const addedButton = document.getElementById('auto_merge_button');
  return addedButton;
}

function createButtonIfNecessary() {
  if (!getAutoMergeButton()) {
    createButton();
    updateUI();
  }
}

function removeNotificationIfNecessary() {
  const addedNotification = getNotification();

  if (addedNotification && !willAutoMerge()) {
    addedNotification.remove();
  }
}

function getLocalStorageUrls() {
  const automergeUrlsString = window.localStorage.getItem('AUTOMERGE_URLS');
  const automergeUrls = automergeUrlsString
    ? JSON.parse(automergeUrlsString)
    : [];
  return automergeUrls;
}

function removeUrlFromLocalStorage() {
  let automergeUrls = getLocalStorageUrls();
  if (automergeUrls.includes(window.location.href)) {
    automergeUrls = automergeUrls.filter(a => !window.location.href);
  }
  window.localStorage.setItem('AUTOMERGE_URLS', JSON.stringify(automergeUrls));
}

function willAutoMerge() {
  const automergeUrls = getLocalStorageUrls();
  if (automergeUrls.includes(window.location.href)) {
    return true;
  }
  return false;
}

function toggleAutoMerge() {
  let automergeUrls = getLocalStorageUrls();
  if (automergeUrls.includes(window.location.href)) {
    automergeUrls = automergeUrls.filter(a => !window.location.href);
  } else {
    automergeUrls.push(window.location.href);
  }
  window.localStorage.setItem('AUTOMERGE_URLS', JSON.stringify(automergeUrls));
  updateUI();
}

function updateUI() {
  const addedButton = getAutoMergeButton();

  if (addedButton) {
    if (willAutoMerge()) {
      addedButton.innerText = 'CANCEL MERGE';
    } else {
      addedButton.innerText = 'AUTO MERGE PR';
    }
  }
  removeNotificationIfNecessary();
  createNotificationIfNecessary();
}

function mergeIfReady() {
  if (!willAutoMerge()) {
    return;
  }

  console.log('TESTING MERGEABILITY');
  testCount += 1;

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
      removeUrlFromLocalStorage();
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
  if (!willAutoMerge()) {
    return;
  }

  console.log('RELOADING');

  window.reload();
}

function worker() {
  mergeIfReady();
  createButtonIfNecessary();

  if (testCount > 25) {
    reload();
  }
}

setInterval(worker, 1500);

