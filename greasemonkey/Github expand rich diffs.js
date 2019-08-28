// ==UserScript==
// @name        Github expand rich diffs
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/github_expand_rich_diffs
// @include     *github.com*
// @include     *github.skyscannertools.net*
// @exclude     none
// @version     2
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
  const buttonElement = document.createElement('button');
  buttonElement.innerText = `Expand all rich diffs`;
  buttonElement.style.background =
    'linear-gradient(-180deg, var(--bpk-button-primary-gradient-start-color, #00d775) 0%, var(--bpk-button-primary-gradient-end-color, #00bd68) 100%)';
  buttonElement.style.border = 'none';
  buttonElement.style.fontSize = '1.5rem';
  buttonElement.style.fontWeight = 'bold';
  buttonElement.style.padding = '0.375rem 1.5rem';
  buttonElement.style.borderRadius = '5rem';
  buttonElement.style.color = 'white';
  buttonElement.style.fontSize = '1rem';
  buttonElement.id = 'expand_all_rich_diffs';
  buttonElement.onclick = expandAllRichDiffs;

  const newElement = document.createElement('div');
  newElement.style.width = '100%';
  newElement.style.display = 'flex';
	newElement.style.justifyContent = 'center';

  newElement.appendChild(buttonElement)

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

