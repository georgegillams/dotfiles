/* eslint-disable no-console */

const fs = require('fs');
const { execSync } = require('child_process');

const BRANCH_TICKET_REGEX = /([A-Z][A-Z][A-Z][A-Z]?-[0-9]+)\-.*/g

const getCurrentBranchName = () => {
   return execSync(' git symbolic-ref --short HEAD').toString();
}

const getAppendedBranchName = () => {
  const commitMessage = process.argv[2];
  if(!commitMessage) {
    return ""; 
  }
  const branchName = getCurrentBranchName();
  if(!branchName) {
    return commitMessage; 
  }

  const match =BRANCH_TICKET_REGEX.exec(branchName);
  if(match){
    return `[${match[1]}] ${commitMessage}`
  }else{
    return `[NO-JIRA] ${commitMessage}`
  }
}

const newBranchName = getAppendedBranchName()
console.log(newBranchName);
