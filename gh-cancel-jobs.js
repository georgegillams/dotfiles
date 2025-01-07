const { execSync } = require("child_process");

const currentBranch = execSync("git rev-parse --abbrev-ref HEAD")
  .toString()
  .split("\n")
  .join("");

const ghQueryCommand = `gh run list --jq ".[] | select (.status != \\"completed\\") | select (.headBranch == \\"${currentBranch}\\")" --json status,headBranch,databaseId`;
console.log(`Running command: ${ghQueryCommand}`);
const jobsStrings = execSync(ghQueryCommand).toString().split('\n');
console.log(`\nJobs:\n${jobsStrings.join('\n')}\n`);
const jobs = JSON.parse(`[${jobsStrings.join(',')}]`);

for (const job of jobs) {
  console.log(`cancelling job ${job.databaseId}`);
  execSync(`gh run cancel ${job.databaseId}`);
}
