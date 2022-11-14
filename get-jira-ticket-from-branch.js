/* eslint-disable no-console */

const { execSync } = require("child_process");

const BRANCH_TICKET_REGEX = /([A-Z]+-[0-9]+)[\-\/].*/g;

const getCurrentBranchName = () => {
  return execSync(" git symbolic-ref --short HEAD").toString();
};

const getTicket = () => {
  const branchName = getCurrentBranchName();
  if (!branchName) {
    throw new Error("No branch name found. Are you in a git repo?");
  }

  const match = BRANCH_TICKET_REGEX.exec(branchName);
  if (!match) {
    throw new Error("No ticket found in branch name");
  }
  return match[1];
};

const ticket = getTicket();
console.log(ticket);
