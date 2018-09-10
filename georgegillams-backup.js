const {execSync} = require('child_process');
const prompt = require('prompt');

// Create backup
let defaultBackupName = Date.now().toString();
const schema = {
  properties: {
    backupName: {
      description: 'What shall we call this backup?',
      default: defaultBackupName,
      pattern: /.*/,
      message: '',
    },
    apiKey: {
      description: 'Enter the admin API key to use for this backup',
      pattern: /.*/,
      message: 'Enter the admin API key to use for this backup',
      required: true,
    },
  },
};

const performBackup = async (err, {backupName, apiKey}) => {
  if (err) {
    console.error(err);
    return;
  }

  execSync(`mkdir ~/Dropbox/georgegillams.co.uk/backups/${backupName}`);

  // Save blog posts:
  execSync(
    `curl -i --raw https://www.georgegillams.co.uk/api/blogs/load --header "apiKey: ${apiKey}" > ~/Dropbox/georgegillams.co.uk/backups/${backupName}/blogs.txt`,
  );

  // Save comments
  execSync(
    `curl -i --raw https://www.georgegillams.co.uk/api/comments/load --header "apiKey: ${apiKey}" > ~/Dropbox/georgegillams.co.uk/backups/${backupName}/comments.txt`,
  );

  // Save payments
  execSync(
    `curl -i --raw https://www.georgegillams.co.uk/api/payments/load --header "apiKey: ${apiKey}" > ~/Dropbox/georgegillams.co.uk/backups/${backupName}/payments.txt`,
  );

  // Save users
  execSync(
    `curl -i --raw https://www.georgegillams.co.uk/api/users/load --header "apiKey: ${apiKey}" > ~/Dropbox/georgegillams.co.uk/backups/${backupName}/users.txt`,
  );
};

prompt.start();
prompt.get(schema, performBackup);
