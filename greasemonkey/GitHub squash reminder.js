// ==UserScript==
// @name        GitHub squash reminder
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/github_squash_reminder
// @include     *github.com*
// @include     *github.skyscannertools.net*
// @exclude     none
// @version     6
// @description:en	Adds an reminder to squash PRs that have > 1 commit
// @grant    		none
// @description   	Adds an reminder to squash PRs that have > 1 commit
// ==/UserScript==

let lastModifiedPr = null;

function addReminder() {
  let prId = `${window.location}`.split("pull/")[1];
  if (lastModifiedPr === prId) {
    return;
  } else {
    let commitCount = parseInt(
      document.getElementById("commits_tab_counter").textContent
    );
    console.log(commitCount);
    if (commitCount !== 1) {
      let allElements = document.getElementsByTagName("DIV");
      for (let i = 0; i < allElements.length; i += 1) {
        let element = allElements[i];
        if (element.className === "merge-message") {
          element.innerHTML =
            `<div style="display: block;margin-bottom: -2rem;text-decoration: none;font-weight: bold;font-size: 1.5rem;font-family: Quattrocento Sans,sans-serif;color: #e02626;">REMEMBER TO SQUASH!</div> <br/> <br/>` +
            element.innerHTML;
        }
      }
      allElements = document.getElementsByTagName("BUTTON");
      for (let i = 0; i < allElements.length; i += 1) {
        let element = allElements[i];
        if (
          element.textContent &&
          element.textContent.includes("Merge pull request")
        ) {
          element.disabled = true;
          element.textContent = "MERGE ONLY ONCE SQUASHED!";
          element.style.backgroundImage =
            "linear-gradient(-180deg, #e02626 0%, #9F2D27 90%)";
          element.style.color = "white";
        }
        if (
          element.textContent &&
          element.textContent.includes("Squash and merge")
        ) {
          element.textContent = "SMERGE!";
        }
        if (
          element.textContent &&
          element.textContent.includes("Confirm squash and merge")
        ) {
          element.textContent = "Confirm SMERGE!";
        }
      }
    }
    lastModifiedPr = prId;
  }
}

function worker() {
  try {
    addReminder();
  } catch (e) {
    console.log(e);
  }
}

setInterval(worker, 2000);


