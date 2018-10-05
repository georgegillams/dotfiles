const {execSync} = require('child_process');
const prompt = require('prompt');

const entities = ["blogs", "comments", "payments", "users", "profiles"];

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

  execSync(`mkdir ~/Dropbox/epicc-conference.herokuapp.com/backups/${backupName}`);

  for (let i = 0; i < entities.length; i += 1) {
    execSync(
      `curl -i --raw https://epicc-conference.herokuapp.com/api/${entities[i]}/load --header "apiKey: ${apiKey}" > ~/Dropbox/epicc-conference.herokuapp.com/backups/${backupName}/${entities[i]}.txt`,
    );
  }
};

prompt.start();
prompt.get(schema, performBackup);
