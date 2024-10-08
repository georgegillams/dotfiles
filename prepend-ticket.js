/* eslint-disable no-console */

const fs = require("fs");
const { execSync } = require("child_process");

const BRANCH_TICKET_REGEX = /([A-Z]+-[0-9]+)[\-_\/].*/g;

const getCurrentBranchName = () => {
  return execSync(" git symbolic-ref --short HEAD").toString();
};

const getAppendedBranchName = () => {
  const commitMessage = process.argv[2];
  if (!commitMessage) {
    return "";
  }
  const branchName = getCurrentBranchName();
  if (!branchName) {
    return commitMessage;
  }

  const ticketMatch = BRANCH_TICKET_REGEX.exec(branchName);
  const changeType = process.argv[3] || "feat";
  const preColonText = process.argv[4] || "";
  if (ticketMatch) {
    return `${changeType}(${ticketMatch[1]})${preColonText}: ${commitMessage}`;
  } else {
    return `${changeType}${preColonText}: ${commitMessage}`;
  }
};

const newBranchName = getAppendedBranchName();
console.log(newBranchName);
