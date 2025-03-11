const { execSync } = require("child_process");

const data = JSON.parse(execSync("aws iam list-access-keys").toString());
const keys = data.AccessKeyMetadata;
for (const key of keys) {
  if (key.Status === "Active") {
    console.log(`Leaving active key ${key.AccessKeyId}`);
  } else {
    console.log(`deleting key ${key.AccessKeyId}`);
    execSync(`aws iam delete-access-key --access-key-id ${key.AccessKeyId}`);
  }
}
