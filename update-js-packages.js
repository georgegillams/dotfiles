#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const args = process.argv.slice(2);
const SUPPORTED_MANAGERS = ['npm', 'yarn', 'pnpm', 'bun'];

let pm = 'npm'; // Default package manager
let matchString = '';

// Smart argument parsing: 
// If the first argument is a package manager, use it. Otherwise, assume it's the search string.
if (SUPPORTED_MANAGERS.includes(args[0])) {
  pm = args[0];
  matchString = args[1] || '';
} else {
  matchString = args[0] || '';
}

// Map the correct install commands for each package manager
const pmCommands = {
  npm: { prod: 'npm install', dev: 'npm install -D' },
  yarn: { prod: 'yarn add', dev: 'yarn add -D' },
  pnpm: { prod: 'pnpm add', dev: 'pnpm add -D' },
  bun: { prod: 'bun add', dev: 'bun add -d' }
};

const cmdProd = pmCommands[pm].prod;
const cmdDev = pmCommands[pm].dev;

const startDir = process.cwd();

// Crucial: Ignore these directories to prevent infinite loops or modifying the wrong files
const IGNORE_DIRS = ['node_modules', '.git', 'dist', 'build', '.next', 'coverage'];

// Recursively find all package.json files
function findPackageJsons(dir, fileList = []) {
  let files;
  try {
    files = fs.readdirSync(dir);
  } catch (err) {
    return fileList; // Skip directories without read permission
  }

  for (const file of files) {
    const fullPath = path.join(dir, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      if (!IGNORE_DIRS.includes(file)) {
        findPackageJsons(fullPath, fileList);
      }
    } else if (file === 'package.json') {
      fileList.push(fullPath);
    }
  }

  return fileList;
}

// Update dependencies for a specific package.json
function processPackageJson(packageJsonPath) {
  const targetDir = path.dirname(packageJsonPath); // 👈 Gets the exact folder of the package.json
  let pkg;

  try {
    pkg = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
  } catch (err) {
    console.error(`\n❌ Error reading or parsing: ${packageJsonPath}`);
    return;
  }

  // Filter keys by match string, then append '@latest'
  const deps = Object.keys(pkg.dependencies || {})
    .filter(k => k.includes(matchString))
    .map(k => `${k}@latest`);
    
  const devDeps = Object.keys(pkg.devDependencies || {})
    .filter(k => k.includes(matchString))
    .map(k => `${k}@latest`);

  if (deps.length === 0 && devDeps.length === 0) {
    return; // Nothing to update in this file
  }

  console.log(`\n======================================================`);
  console.log(`📦 Updating packages in: ${targetDir}`);
  console.log(`🛠️  Using: ${pm}`);
  console.log(`======================================================`);

  if (deps.length > 0) {
    console.log(`\n⏳ Installing dependencies: ${deps.join(' ')}`);
    try {
      // 👈 cwd: targetDir ensures it runs in the exact location of the matched package.json
      execSync(`${cmdProd} ${deps.join(' ')}`, { cwd: targetDir, stdio: 'inherit' });
    } catch (err) {
      console.error(`❌ Failed to update dependencies in ${targetDir}`);
    }
  }

  if (devDeps.length > 0) {
    console.log(`\n⏳ Installing devDependencies: ${devDeps.join(' ')}`);
    try {
      execSync(`${cmdDev} ${devDeps.join(' ')}`, { cwd: targetDir, stdio: 'inherit' });
    } catch (err) {
      console.error(`❌ Failed to update devDependencies in ${targetDir}`);
    }
  }
}

// --- Main Execution ---
console.log(`🔍 Scanning for package.json files starting from: ${startDir}...`);
const packageFiles = findPackageJsons(startDir);

if (packageFiles.length === 0) {
  console.log('No package.json files found.');
  process.exit(0);
}

console.log(`✅ Found ${packageFiles.length} package.json file(s). Searching for dependencies matching: "${matchString}"`);

packageFiles.forEach(processPackageJson);

console.log('\n🎉 All finished!');
