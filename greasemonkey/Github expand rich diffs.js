// ==UserScript==
// @name        Github expand rich diffs
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_expand_rich_diffs
// @include     *github.com*
// @include     *github.skyscannertools.net*
// @exclude     none
// @version     1
// @description:en	Creates a button which can expand all rich diffs in a PR.
// @grant    		none
// ==/UserScript==

function expandAllRichDiffs() {
  const toClick = document.querySelectorAll(
    `[aria-label="Display the rich diff"]`,
  );
  for (let i = toClick.length - 1; i >= 0; i -= 1) {
    toClick[i].click();
  }
}

function makeGHButton() {
  const filesElement = document.getElementsByClassName('repository-content')[0];
  if (!filesElement) {
    return;
  }
  const newElement = document.createElement('button');
  newElement.innerText = `Expand all rich diffs`;
  // newElement.href = url;
  newElement.style.background =
    'linear-gradient(-180deg, var(--bpk-button-primary-gradient-start-color, #00d775) 0%, var(--bpk-button-primary-gradient-end-color, #00bd68) 100%)';
  newElement.style.border = 'none';
  newElement.style.fontSize = '1.5rem';
  newElement.style.fontWeight = 'bold';
  newElement.style.padding = '0.375rem 1.5rem';
  newElement.style.borderRadius = '5rem';
  newElement.style.color = 'white';
  newElement.style.fontSize = '1rem';
  newElement.id = 'expand_all_rich_diffs';
  newElement.onclick = expandAllRichDiffs;

  filesElement.appendChild(document.createElement('br'));
  filesElement.appendChild(newElement);
}

function makeLinks() {
  const docLoc = document.location.href;
  if(!docLoc.includes('pull') || !docLoc.includes('files')) {
    return;
  }

  const addedLink = document.getElementById('expand_all_rich_diffs');
  if (addedLink) {
    return;
  }

  makeGHButton();
}

setInterval(makeLinks, 2000);

