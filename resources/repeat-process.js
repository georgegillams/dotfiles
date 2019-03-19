#!/usr/bin/env node

const { exec } = require('child_process');

const [, , ...rest] = process.argv;
const command = rest.join(' ');
const MAX_REPEATS = 3;

function runTests(runCount = 1) {
  if (runCount > MAX_REPEATS) {
    console.log(`Process is still failing after ${MAX_REPEATS} attempts.`);
    console.log(`Giving up.`);
    process.exit(1);
  }

  console.log(`Running process. This is attempt ${runCount} of ${MAX_REPEATS}`);
  console.log(`Executing ${command}`);
  exec(
    command,
    { encoding: 'utf8', maxBuffer: 50 * 1024 * 1024 },
    (error, stdout, stderr) => {
      if (error) {
        runTests(runCount + 1);
        console.error(error.Error);
        console.error(stderr);
      } else {
        console.log(stdout);
        console.log(`Process succeeded on attempt ${runCount}.`);
        process.exit(0);
      }
    },
  );
}

runTests();
