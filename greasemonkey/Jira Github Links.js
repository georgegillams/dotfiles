// ==UserScript==
// @name        Jira Github links
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/jira_github_links
// @include     *github.com*
// @include     *gojira.skyscanner.net*
// @exclude     none
// @version     1
// @description:en	Creates links from GitHub PRs to their respective Jira ticket and vice-versa
// @grant    		none
// ==/UserScript==

function makeGHLink() {
  const allElements = document.getElementsByTagName('H1');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    const elementMatch = element.innerText.match(/\[BPK-[0-9]+\]/g);
    if (
      elementMatch &&
      elementMatch.length > 0 &&
      element.childElementCount < 3
    ) {
      const text = elementMatch[0]
        .split('[')
        .join('')
        .split(']')
        .join('');
      const url = `https://gojira.skyscanner.net/browse/${text}`;
      const newElement = document.createElement('a');
      newElement.innerText = `View ${text} ticket on Jira`;
      newElement.href = url;
      newElement.style.color = '#00b2d6ff';
      newElement.style.fontSize = '1rem';
      element.appendChild(document.createElement('br'));
      element.appendChild(newElement);
    }
  }
}

function makeJiraLink() {
  const allElements = document.getElementsByTagName('LI');
  for (let i = 0; i < allElements.length; i += 1) {
    const element = allElements[i];
    const elementMatch = element.innerText.match(/^BPK-[0-9]+$/g);
    if (
      elementMatch &&
      elementMatch.length > 0 &&
      element.parentElement.childElementCount < 5
    ) {
      const text = element.innerText;
      const url = `https://github.com/pulls?utf8=%E2%9C%93&q=is%3Aopen+is%3Apr+repo%3ASkyscanner%2Fbackpack+repo%3ASkyscanner%2Fbackpack-react-native+repo%3ASkyscanner%2Fbackpack-docs+repo%3ASkyscanner%2Fbackpack-react-scripts+repo%3ASkyscanner%2Fbackpack-node-sass+repo%3ASkyscanner%2Feslint-plugin-backpack+repo%3ASkyscanner%2Feslint-config-skyscanner+repo%3ASkyscanner%2Feslint-config-skyscanner+repo%3ASkyscanner%2Fbackpack-ios+repo%3ASkyscanner%2Fbackpack-android+${text}`;
      const newElement = document.createElement('a');
      newElement.innerText = `View PRs for ${text} on GitHub`;
      newElement.href = url;
      newElement.style.color = '#00b2d6ff';
      newElement.style.fontSize = '1rem';
      element.appendChild(document.createElement('br'));
      element.appendChild(newElement);
    }
  }
}

function makeLinks() {
  makeGHLink();
  makeJiraLink();
}

setInterval(makeLinks, 2000);

