const { execSync } = require("child_process");

const currentBranch = execSync("git rev-parse --abbrev-ref HEAD")
  .toString()
  .split("\n")
  .join("");

const ghQueryCommand = `gh run list --jq ".[] | select (.status != \\"completed\\") | select (.headBranch == \\"${currentBranch}\\")" --json status,headBranch,databaseId`;
const jobsString = execSync(ghQueryCommand).toString();
const jobs = JSON.parse(`[${jobsString}]`);

for (const job of jobs) {
  console.log(`cancelling job ${job.databaseId}`);
  execSync(`gh run cancel ${job.databaseId}`);
}
