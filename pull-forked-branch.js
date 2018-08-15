/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* eslint-disable no-console */

const {execSync} = require('child_process');
const prompt = require('prompt');
const fs = require('fs');
const path = require('path');

const schema = {
  properties: {
    repoName: {
      description: 'what repo are you on',
      default: 'backpack',
      pattern: /.*/,
      message: '',
    },
    branch: {
      description: 'Enter the branch you wish to pull',
      pattern: /^[A-Za-z\-]+\:[A-Za-z\-]+$/,
      message: 'Enter the branch, including the github username',
      required: true,
    },
  },
};

const doFork = async (err, {repoName, branch}) => {
  if (err) {
    console.error(err);
    return;
  }

  branchSplit = branch.split(':');
  gitUserName = branchSplit[0];
  gitBranchName = branchSplit[1];

  console.log(gitUserName);
  console.log(gitBranchName);

  console.log(`git checkout -b ${gitUserName}-${gitBranchName}`);
  console.log(
    `git pull https://github.com/${gitUserName}/${repoName}.git ${gitBranchName}`,
  );
  execSync(`git checkout -b ${gitUserName}-${gitBranchName}`);
  execSync(
    `git pull https://github.com/${gitUserName}/${repoName}.git ${gitBranchName}`,
  );
};

prompt.start();
prompt.get(schema, doFork);
