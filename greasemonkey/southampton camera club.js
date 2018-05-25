// ==UserScript==
// @name        southampton camera club
// @namespace   urn://https://www.georgegillams.co.uk/api/greasemonkey/southampton_camera_club
// @include     http://*.southamptoncameraclub.co.uk/*
// @exclude     none
// @version     2
// @grant    		none
// ==/UserScript==

const allElements = document.getElementsByTagName("*");
for (let i = 0; i < allElements.length; i += 1) {
  const element = allElements[i];
  if (element.id === "wpcp-error-message") {
    element.style.display = "none";
  }
  if (element.unSelectable === "on") {
    element.unSelectable = "off";
  }
  if (element.unselectable === "on") {
    element.unselectable = "off";
  }
}

var unsel = document.querySelectorAll("*[unselectable]");
for (i = unsel.length; i--; ) {
  unsel[i].removeAttribute("unselectable");
}

var elmLink = document.querySelectorAll("[unselectable]");

elmLink.forEach(function(entry) {
  entry.removeAttribute("unselectable");
});
