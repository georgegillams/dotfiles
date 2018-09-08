// ==UserScript==
// @name        georgegillams.co.uk blog edit link
// @namespace   urn://https://www.georgegillams.co.uk/greasemonkey/george_gillams_blog_edit
// @include     *georgegillams.co.uk*
// @include     *localhost:*
// @include     *0.0.0.0:*
// @include     *127.0.0.1:*
// @exclude     none
// @version     3
// @description:en	Adds an edit button to blogs on my personal website for ease
// @grant    		none
// ==/UserScript==

let lastModifiedBlogId = null;

function addEditButton() {
  if (`${window.location}`.match(/(blog)?(travel)?\/view\/?\?id=/gi)) {
    let blogId = `${window.location}`.split("?id=")[1];
    // console.log(blogId);
    // console.log('its a blog page');
    if (blogId === lastModifiedBlogId) {
      return;
    }
    let blogElement = document.getElementById("greasy_blog_handle");
    if (blogElement) {
      blogElement.innerHTML =
        `<a style="display: block;margin-top: 1.5rem;margin-bottom: -2rem;text-decoration: none;font-weight: bold;font-size: 1.5rem;font-family: Quattrocento Sans,sans-serif;color: hotpink;" href=/admin/blog-editor?id=` +
        blogId +
        `>EDIT THIS BLOG</a> <br/> <br/>` +
        blogElement.innerHTML;
      lastModifiedBlogId = blogId;
    }
  } else {
    // if we have navigated to a non-blog page, reset lastModifiedBlogId
    // console.log('its NOT a blog page');
    lastModifiedBlogId = null;
  }
}

setInterval(addEditButton, 2000);
