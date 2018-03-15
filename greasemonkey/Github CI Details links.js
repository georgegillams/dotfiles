// ==UserScript==
// @name        Github CI Details links
// @namespace   urn://userscripts/stash/github/github-ci-details-link/georgegillams
// @include     https://github.com/*/*/pull/*
// @exclude     https://github.com/*/*/pull/new
// @version     1
// @grant       none
// ==/UserScript==

var links = document.getElementsByTagName("a");
for (var i = 0; i < links.length; i++) {
  var a = links[i];
  if (a.className === "status-actions") {
    a.target = "_blank";
  }
}
