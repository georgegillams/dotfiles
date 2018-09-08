// ==UserScript==
// @name        GitHub expand all hidden comments
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/github_expand_comments
// @include     *github.com*
// @exclude     none
// @version     1
// @description:en      Adds a button to expand all hidden comments
// @grant               none
// ==/UserScript==

let lastModifiedPr = null;

function expandAllComments() {
  const allElements = document.getElementsByTagName('BUTTON');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    if (element.textContent && element.textContent.includes('Show outdated')) {
      element.click();
    }
  }
}

function addButton() {
  let prId = `${window.location}`.split("pull/")[1];
  if (lastModifiedPr === prId) {
    return;
  }
  const allElements = document.getElementsByTagName('DIV');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    if (
    element.className ===
    'discussion-timeline pull-discussion-timeline js-pull-discussion-timeline js-quote-selection-container js-review-state-classes  '
    ) {
      element.innerHTML = `<button id="expand-all-button" class="btn btn-sm btn-outline" style="display: inline-block;margin-bottom: 1rem;margin-top: 1rem;font-family: Quattrocento Sans,sans-serif;width: 100%">Expand all hidden comments</button></br></br>${element.innerHTML}`;
      lastModifiedPr = prId;
    }
  }
  const addedElement = document.getElementById('expand-all-button');
  if (addedElement) {
    addedElement.addEventListener('click', expandAllComments, false);
    buttonEventAdded = true;
  }
}

setInterval(addButton, 2000);

