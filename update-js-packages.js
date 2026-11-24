#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const matchString = process.argv[2] || '';
const startDir = process.cwd();

// Crucial: Ignore these directories to prevent infinite loops or modifying the wrong files
const IGNORE_DIRS = ['node_modules', '.git', 'dist', 'build', '.next', 'coverage'];

// Cache to prevent looking up the same package multiple times
const versionCache = {};

// Helper: Fetch the latest version of a package synchronously.
// Runs in the package.json's directory so its .npmrc (e.g. private registries) is honoured.
function getLatestVersion(pkgName, cwd) {
  const cacheKey = `${cwd}::${pkgName}`;
  if (versionCache[cacheKey]) return versionCache[cacheKey];
  
  try {
    // Suppress stderr to keep terminal clean if a package isn't found
    const latest = execSync(`npm show "${pkgName}" version 2>/dev/null`, { stdio: 'pipe', cwd })
      .toString()
      .trim()
      .split('\n')
      .pop()
      .trim();
      
    if (latest) {
      versionCache[cacheKey] = latest;
      return latest;
    }
  } catch (err) {
    return null; // Package might not exist or network error
  }
}

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

// Helper: Updates a specific map inside package.json (dependencies, resolutions, etc.)
function updateDependencyMap(obj, fieldName, logs, cwd) {
  if (!obj || typeof obj !== 'object') return false;
  
  let modified = false;
  const keys = Object.keys(obj).filter(k => k.includes(matchString));

  for (const key of keys) {
    const oldVersion = obj[key];
    if (typeof oldVersion !== 'string') continue;
    
    // Skip local/git/workspace resolutions 
    if (oldVersion.match(/^(workspace:|file:|git\+?|http:|https:)/)) continue;

    // Smart regex: extracts exact package name from nested paths like "**/pkg" or "@scope/pkg"
    const pkgName = key.match(/(@[^\/]+\/[^\/]+|[^\/]+)$/)?.[0] || key;

    process.stdout.write(`   🔍 Checking ${pkgName}... \r`);
    const latest = getLatestVersion(pkgName, cwd);
    
    if (!latest) {
      logs.push(`   ⚠️  Could not resolve latest version of ${pkgName} [${fieldName}]`);
      continue;
    }

    // Preserve the prefix (^, ~, or empty if exact)
    const prefixMatch = oldVersion.match(/^[\^~]?/);
    const prefix = prefixMatch ? prefixMatch[0] : '';
    const newVersion = `${prefix}${latest}`;

    if (oldVersion !== newVersion) {
      logs.push(`   ✅ Bumped ${key} (${oldVersion} -> ${newVersion}) [${fieldName}]`);
      obj[key] = newVersion;
      modified = true;
    }
  }
  
  return modified;
}

// Process an individual package.json
function processPackageJson(packageJsonPath) {
  const targetDir = path.dirname(packageJsonPath);
  let pkg;
  let indent = 2; // Default indentation fallback

  try {
    const content = fs.readFileSync(packageJsonPath, 'utf8');
    // Auto-detect the project's formatting (tabs or spaces) to preserve it
    const indentMatch = content.match(/^[ \t]+/m);
    indent = indentMatch ? indentMatch[0] : 2;
    pkg = JSON.parse(content);
  } catch (err) {
    console.error(`\n❌ Error reading or parsing: ${packageJsonPath}`);
    return;
  }

  const logs = [];
  
  // Update all standard dependency blocks and resolution blocks
  const depsModified = updateDependencyMap(pkg.dependencies, 'dependencies', logs, targetDir);
  const devDepsModified = updateDependencyMap(pkg.devDependencies, 'devDependencies', logs, targetDir);
  const resModified = updateDependencyMap(pkg.resolutions, 'resolutions', logs, targetDir);
  const overModified = updateDependencyMap(pkg.overrides, 'overrides', logs, targetDir);
  
  let pnpmOverModified = false;
  if (pkg.pnpm && pkg.pnpm.overrides) {
    pnpmOverModified = updateDependencyMap(pkg.pnpm.overrides, 'pnpm.overrides', logs, targetDir);
  }

  const fileNeedsSave = depsModified || devDepsModified || resModified || overModified || pnpmOverModified;

  if (fileNeedsSave || logs.length > 0) {
    console.log(`\n======================================================`);
    console.log(`${fileNeedsSave ? '💾 Updating' : '📄 Checked'}: ${packageJsonPath}`);
    console.log(`======================================================`);
    
    // Clear the loading line
    process.stdout.write('                                       \r');
    
    logs.forEach(log => console.log(log));
  }

  if (fileNeedsSave) {
    // Save file preserving exact indentation
    fs.writeFileSync(packageJsonPath, JSON.stringify(pkg, null, indent) + '\n', 'utf8');
  }
}

// --- Main Execution ---
console.log(`🔍 Scanning for package.json files starting from: ${startDir}...`);
const packageFiles = findPackageJsons(startDir);

if (packageFiles.length === 0) {
  console.log('No package.json files found.');
  process.exit(0);
}

console.log(`✅ Found ${packageFiles.length} package.json file(s). Looking up latest versions matching: "${matchString}"\n`);

packageFiles.forEach(processPackageJson);

// Clear any trailing status line
process.stdout.write('                                       \r');
console.log('\n🎉 All finished! Run your package manager install command to apply updates.');