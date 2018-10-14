const {execSync} = require('child_process');
const prompt = require('prompt');

const entities = ["gts", "blogs", "comments", "payments", 'users'];

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
      hidden: true,
    },
  },
};

const performBackup = async (err, {backupName, apiKey}) => {
  if (err) {
    console.error(err);
    return;
  }

  execSync(`mkdir ~/Dropbox/georgegillams.co.uk/backups/${backupName}`);

  for (let i = 0; i < entities.length; i += 1) {
    execSync(
      `curl -i --raw https://www.georgegillams.co.uk/api/${entities[i]}/load --header "apiKey: ${apiKey}" > ~/Dropbox/georgegillams.co.uk/backups/${backupName}/${entities[i]}.txt`,
    );
  }
};

prompt.start();
prompt.get(schema, performBackup);
