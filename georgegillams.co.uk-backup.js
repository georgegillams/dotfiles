const {execSync} = require('child_process');

// Save blog posts:
execSync('curl -i --raw https://www.georgegillams.co.uk/api/blog-posts/ --header "blog-collection: all" > ~/Dropbox/georgegillams.co.uk_backups/blog-posts.txt');

// Get list of page identifiers:
var pageIds = execSync('curl -i --raw https://www.georgegillams.co.uk/api/comments/page_ids').toString();
pageIds = pageIds.split('\n').filter(x => x.includes("[\""));
pageIds = JSON.parse(pageIds);
for (let i = 0; i < pageIds.length; i += 1) {
  let pageId = pageIds[i];
execSync(`curl -i --raw https://www.georgegillams.co.uk/api/comments/ --header "page_id: ${pageId}" > ~/Dropbox/georgegillams.co.uk_backups/comments_${pageId}.txt`);
}
