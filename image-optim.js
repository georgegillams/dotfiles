const {execSync} = require('child_process');
const prompt = require('prompt');
const fs = require('fs');
const path = require('path');

// Note that for `git status -s` to identify an image file, it must be tracked. New files will not be included until they are added.
const optimiseImages = async () => {
  const changedFiles = execSync('git status -s | cut -c4-').toString().split('\n').filter(s => s !== '');
  const filesToOptimise = [];
  changedFiles.forEach(f => {
    if(f.includes("SnapshotTest") || f.includes('backstop_data')){
    console.log(`Skipping snapshot test file 🌇 --> ${f} `);
    }else if(f.match(/(\.|\/)(gif|jpe?g|png)"?$/i)) {
      console.log(`optimising image file 🌄 --> ${f}`)
      filesToOptimise.push(f);
    }
  })
  if(filesToOptimise.length > 0){
  execSync(`imageoptim ${filesToOptimise.join(' ')}`)
  }
  console.log(``);
};

optimiseImages();
