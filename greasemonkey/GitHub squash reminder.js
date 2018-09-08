// ==UserScript==
// @name        GitHub squash reminder
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/github_squash_reminder
// @include     *github.com*
// @exclude     none
// @version     3
// @description:en	Adds an reminder to squash PRs that have > 1 commit
// @description   	Adds an reminder to squash PRs that have > 1 commit
// @grant    		none
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
      }
    }
    lastModifiedPr = prId;
  }
}

setInterval(addReminder, 2000);
