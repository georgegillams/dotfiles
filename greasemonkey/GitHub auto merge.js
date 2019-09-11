// ==UserScript==
// @name        GitHub auto merge
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_auto_merge
// @include     *github.com*
// @include     *github.skyscannertools.net*
// @exclude     none
// @version     17
// @description:en	Adds an option to GitHub PRs to auto-merge them. The tab must be kept open for the merge to be performed.
// @grant    		none
// @description	Adds an option to GitHub PRs to auto-merge them. The tab must be kept open for the merge to be performed.
// ==/UserScript==

let testCount = 0;

function requestNotificationPermissions() {
  if (!("Notification" in window) || (Notification.permission === "denied") ) {
    Notification.requestPermission();
  }
}

function createMergedNotification() {
  Notification.requestPermission();
  if (("Notification" in window) && (Notification.permission !== "denied") ) {
    var notification = new Notification("PR merged!", {
      body: `Your PR was merged automatically! ${window.location.href}`
    });
  }
}

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

  const mergeMessageElement = mergeMessageElements[0];
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

function saveAutoMergeUrls(automergeUrls) {
  try {
    window.localStorage.setItem('AUTOMERGE_URLS', JSON.stringify(automergeUrls));
  } catch (e) {
    console.log(e);
    window.alert('There was a problem writing to localStorage. Check that the quota has not been exceeded.')
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
  console.log('CLEANING UP');
  let automergeUrls = getLocalStorageUrls();
  if (automergeUrls.includes(window.location.href)) {
    automergeUrls = automergeUrls.filter(a => a !== window.location.href);
  }
  saveAutoMergeUrls(automergeUrls);
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
    console.log('REMOVING PR');
    automergeUrls = automergeUrls.filter(a => a !== window.location.href);
  } else {
    console.log('ADDING PR');
    automergeUrls.push(window.location.href);
  }
  saveAutoMergeUrls(automergeUrls);
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
      return;
    }
  }

  allElements = document.getElementsByTagName('BUTTON');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    if (
      element.textContent &&
      !element.disabled &&
      (element.innerText === 'Confirm merge' || element.innerText === 'Confirm squash and merge')
    ) {
      console.log('CONFIRMING MERGE');
      createMergedNotification();
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
      (element.innerText === 'Merge pull request' || element.innerText === 'Squash and merge')
    ) {
      console.log('MERGING');
      element.click();
    }
  }
}

function cleanupLocalStorage() {
  const mergedBadgeElements = document.getElementsByClassName('State--purple');
  if (mergedBadgeElements.length < 1) {
    return;
  }

  const mergedBadgeElement = mergedBadgeElements[0];
  if (mergedBadgeElement && mergedBadgeElement.innerText === ' Merged') {
      removeUrlFromLocalStorage();
  }
}

function reload() {
  if (!willAutoMerge()) {
    return;
  }

  console.log('RELOADING');

  window.location.reload();
}

function worker() {
  try {
    mergeIfReady();
    cleanupLocalStorage();
    createButtonIfNecessary();
		requestNotificationPermissions();

    if (testCount > 25) {
      reload();
    }
  } catch (e) {
    console.log(e);
  }
}

setInterval(worker, 1500);

