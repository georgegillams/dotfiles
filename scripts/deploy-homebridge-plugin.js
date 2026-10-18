#!/usr/bin/env node
/**
 * Deploy a local Homebridge plugin (or nested package) to a Pi.
 *
 * Usage:
 *   node deploy-homebridge-plugin.js --source DIR --plugin-dir REMOTE_DIR [options]
 *
 * Options:
 *   --host USER@HOST   SSH target (default: pi@192.168.1.96, or HB_HOST)
 *   --source DIR       Local package root (required)
 *   --plugin-dir PATH  Remote install path (required)
 *   --build CMD        Shell command to run in --source before syncing
 *   --name NAME        Label used in status messages
 *   --identifier NAME  Set package.json "name" (and hardcoded PLUGIN_NAME /
 *                      pluginName refs) before sync. Persists locally.
 *                      Must be a valid Homebridge id: homebridge-* or
 *                      @scope/homebridge-* (e.g. @george.gillams/homebridge-ecovacs).
 *   --display-name-suffix TEXT
 *                      Ensure package.json displayName ends with TEXT (e.g.
 *                      "(george.gillams modified)"). Persists locally.
 *   --platform-alias ALIAS
 *                      Set config.schema.json pluginAlias and hardcoded
 *                      PLATFORM_NAME / platformName refs so the fork can be
 *                      configured independently of the upstream plugin
 *                      (e.g. GeorgeGillamsPetkitPlatform). Persists locally.
 *   --no-restart       Skip `hb-service restart` (useful when chaining deploys)
 *   --no-hb-install    Skip `hb-service add file:<plugin-dir>` (for nested
 *                      packages that are not Homebridge plugins)
 *
 * Syncs the whole source tree with rsync (excludes node_modules, .git, .env),
 * runs `npm install --omit=dev`, registers the package with Homebridge via
 * `hb-service add file:./…` (relative to /var/lib/homebridge), chowns, and
 * restarts Homebridge.
 *
 * Deploy plugins to /var/lib/homebridge/local-plugins/<name> — not into
 * node_modules. npm refuses file: installs from under node_modules; hb-service
 * add will symlink node_modules/<name> → local-plugins/<name>.
 *
 * Password: HB_PASSWORD, or 1Password item "Raspberry pi login".
 */
const { spawnSync } = require("child_process");
const fs = require("fs");
const os = require("os");
const path = require("path");
const { parseArgs } = require("util");

const DEFAULT_HOST = process.env.HB_HOST || "pi@192.168.1.96";
const HB_ROOT = "/var/lib/homebridge";
const RSYNC_EXCLUDES = ["node_modules", ".git", ".env"];
const OP_ITEM = "Raspberry pi login";
const OP_VAULT = "Personal";

function usage(exitCode = 0) {
  const text = fs
    .readFileSync(__filename, "utf8")
    .split("\n")
    .slice(1)
    .filter((line) => line.startsWith(" *") && !line.startsWith(" */"))
    .map((line) => line.replace(/^ \* ?/, ""))
    .join("\n")
    .trim();
  console.log(text);
  process.exit(exitCode);
}

function fail(message) {
  console.error(`error: ${message}`);
  process.exit(1);
}

function run(command, args, options = {}) {
  const result = spawnSync(command, args, {
    encoding: "utf8",
    stdio: options.stdio || "inherit",
    env: options.env || process.env,
    cwd: options.cwd,
    shell: options.shell || false,
  });
  if (result.error) {
    fail(`${command} failed to start: ${result.error.message}`);
  }
  if (result.status !== 0) {
    fail(`${command} ${args.join(" ")} exited with status ${result.status}`);
  }
  return result;
}

function runCapture(command, args, options = {}) {
  const result = spawnSync(command, args, {
    encoding: "utf8",
    stdio: ["ignore", "pipe", "pipe"],
    env: options.env || process.env,
    cwd: options.cwd,
  });
  if (result.error) {
    fail(`${command} failed to start: ${result.error.message}`);
  }
  if (result.status !== 0) {
    const stderr = (result.stderr || "").trim();
    fail(
      `${command} ${args.join(" ")} exited with status ${result.status}` +
        (stderr ? `\n${stderr}` : "")
    );
  }
  return (result.stdout || "").replace(/\s+$/, "");
}

function which(command) {
  const result = spawnSync("which", [command], { encoding: "utf8" });
  return result.status === 0;
}

function expandHome(p) {
  if (!p) return p;
  if (p === "~") return os.homedir();
  if (p.startsWith("~/")) return path.join(os.homedir(), p.slice(2));
  return p;
}

function parseCli(argv) {
  let values;
  try {
    ({ values } = parseArgs({
      args: argv,
      options: {
        host: { type: "string" },
        source: { type: "string" },
        "plugin-dir": { type: "string" },
        build: { type: "string" },
        name: { type: "string" },
        identifier: { type: "string" },
        "display-name-suffix": { type: "string" },
        "platform-alias": { type: "string" },
        "no-restart": { type: "boolean", default: false },
        "no-hb-install": { type: "boolean", default: false },
        help: { type: "boolean", short: "h" },
      },
      strict: true,
    }));
  } catch (error) {
    console.error(`error: ${error.message}`);
    usage(1);
  }

  if (values.help) usage(0);
  if (!values.source || !values["plugin-dir"]) {
    fail("--source and --plugin-dir are required");
  }

  const source = path.resolve(expandHome(values.source));
  if (!fs.existsSync(source) || !fs.statSync(source).isDirectory()) {
    fail(`source is not a directory: ${source}`);
  }

  return {
    host: values.host || DEFAULT_HOST,
    source,
    pluginDir: values["plugin-dir"],
    build: values.build || "",
    name: values.name || path.basename(source),
    identifier: values.identifier || "",
    displayNameSuffix: values["display-name-suffix"] || "",
    platformAlias: values["platform-alias"] || "",
    noRestart: Boolean(values["no-restart"]),
    noHbInstall: Boolean(values["no-hb-install"]),
  };
}

function getPassword() {
  if (process.env.HB_PASSWORD) {
    return process.env.HB_PASSWORD.replace(/\s+$/, "");
  }
  if (!which("op")) {
    fail("1Password CLI (op) is required");
  }
  return runCapture("op", [
    "item",
    "get",
    OP_ITEM,
    "--vault",
    OP_VAULT,
    "--field",
    "password",
    "--reveal",
    "--cache",
  ]);
}

function sshOpts() {
  // Force password auth: a global IdentityAgent (e.g. 1Password) makes plain
  // ssh/sshpass fail with "Permission denied (publickey,password)" even when
  // the password is correct.
  return [
    "-o",
    "StrictHostKeyChecking=accept-new",
    "-o",
    "PreferredAuthentications=password",
    "-o",
    "PubkeyAuthentication=no",
    "-o",
    "IdentityAgent=none",
    "-o",
    "NumberOfPasswordPrompts=1",
  ];
}

function sshEnv(password) {
  return { ...process.env, SSHPASS: password };
}

function ssh(host, remoteCommand, password) {
  run("sshpass", ["-e", "ssh", ...sshOpts(), host, remoteCommand], {
    env: sshEnv(password),
  });
}

function rsyncTo(localDir, host, remoteDir, password) {
  const excludes = RSYNC_EXCLUDES.flatMap((item) => ["--exclude", item]);
  const sshCommand = ["sshpass", "-e", "ssh", ...sshOpts()].join(" ");
  console.log(`→ Syncing ${localDir}/ → ${host}:${remoteDir}/`);
  run(
    "rsync",
    [
      "-avz",
      "--delete",
      ...excludes,
      "-e",
      sshCommand,
      "--rsync-path=sudo rsync",
      `${localDir}/`,
      `${host}:${remoteDir}/`,
    ],
    { env: sshEnv(password) }
  );
}

function shellSingleQuote(value) {
  return `'${String(value).replace(/'/g, `'\\''`)}'`;
}

// Homebridge only loads packages matching this (see homebridge-config-ui-x).
const HB_PLUGIN_NAME_RE = /^(@[\w-]+(?:\.[\w-]+)*\/)?homebridge-[\w-]+$/;

function assertHomebridgePluginName(name) {
  if (!HB_PLUGIN_NAME_RE.test(name)) {
    fail(
      `invalid Homebridge plugin identifier "${name}" — must match ` +
        `homebridge-* or @scope/homebridge-* (e.g. @george.gillams/homebridge-petkit-platform)`
    );
  }
}

function withDisplayNameSuffix(displayName, suffix) {
  const trimmedSuffix = String(suffix).trim();
  const base = String(displayName || "")
    .replace(/\s*\(george\.gillams[^)]*\)\s*$/i, "")
    .trim();
  return base ? `${base} ${trimmedSuffix}` : trimmedSuffix;
}

const IDENTITY_SOURCE_FILES = [
  "index.js",
  "src/settings.ts",
  "src/settings.js",
  "src/homebridge-ui/server.js",
];

function rewriteStringConstants(sourceDir, replacements) {
  const entries = Object.entries(replacements).filter(([, value]) => value);
  if (!entries.length) return;

  for (const rel of IDENTITY_SOURCE_FILES) {
    const filePath = path.join(sourceDir, rel);
    if (!fs.existsSync(filePath)) continue;
    const original = fs.readFileSync(filePath, "utf8");
    let next = original;
    const touched = [];
    for (const [constName, value] of entries) {
      const pattern = new RegExp(
        `(\\b(?:export\\s+const|const|let|var)\\s+${constName}\\s*=\\s*['"])([^'"]+)(['"])`,
        "g"
      );
      const updated = next.replace(pattern, `$1${value}$3`);
      if (updated !== next) {
        touched.push(`${constName}→${value}`);
        next = updated;
      }
    }
    if (next !== original) {
      console.log(`→ ${rel}: ${touched.join(", ")}`);
      fs.writeFileSync(filePath, next);
    }
  }
}

function applyPlatformAlias(sourceDir, platformAlias) {
  const schemaPath = path.join(sourceDir, "config.schema.json");
  if (!fs.existsSync(schemaPath)) {
    fail(`--platform-alias requires config.schema.json in ${sourceDir}`);
  }

  const original = fs.readFileSync(schemaPath, "utf8");
  const schema = JSON.parse(original);
  const previousAlias = schema.pluginAlias;
  let changed = false;

  if (schema.pluginAlias !== platformAlias) {
    console.log(
      `→ config.schema.json pluginAlias: ${previousAlias || "(none)"} → ${platformAlias}`
    );
    schema.pluginAlias = platformAlias;
    changed = true;
  }

  // Keep schema default name aligned when it mirrored the old pluginAlias.
  const nameProp = schema.schema?.properties?.name;
  if (
    nameProp &&
    nameProp.default === previousAlias &&
    previousAlias !== platformAlias
  ) {
    console.log(
      `→ config.schema.json name.default: ${nameProp.default} → ${platformAlias}`
    );
    nameProp.default = platformAlias;
    changed = true;
  }

  if (changed) {
    const trailingNewline = original.endsWith("\n") ? "\n" : "";
    fs.writeFileSync(
      schemaPath,
      `${JSON.stringify(schema, null, 2)}${trailingNewline}`
    );
  }

  rewriteStringConstants(sourceDir, {
    PLATFORM_NAME: platformAlias,
    platformName: platformAlias,
  });
}

// Rewrite package identity so the synced copy can coexist with (or be
// distinguished from) another install. Changes are left in the local source.
function applyPackageJsonOverrides(
  sourceDir,
  { identifier, displayNameSuffix, platformAlias }
) {
  if (!identifier && !displayNameSuffix && !platformAlias) {
    return;
  }

  const pkgPath = path.join(sourceDir, "package.json");
  if (!fs.existsSync(pkgPath)) {
    fail(`no package.json in ${sourceDir}`);
  }

  if (identifier) {
    assertHomebridgePluginName(identifier);
  }

  const original = fs.readFileSync(pkgPath, "utf8");
  const pkg = JSON.parse(original);
  let changed = false;

  if (identifier && pkg.name !== identifier) {
    console.log(`→ package.json name: ${pkg.name} → ${identifier}`);
    pkg.name = identifier;
    changed = true;
  }

  if (displayNameSuffix) {
    const next = withDisplayNameSuffix(
      pkg.displayName || pkg.name || "",
      displayNameSuffix
    );
    if (pkg.displayName !== next) {
      console.log(
        `→ package.json displayName: ${pkg.displayName || "(none)"} → ${next}`
      );
      pkg.displayName = next;
      changed = true;
    }
  }

  if (platformAlias && pkg.alias && pkg.alias !== platformAlias) {
    console.log(`→ package.json alias: ${pkg.alias} → ${platformAlias}`);
    pkg.alias = platformAlias;
    changed = true;
  }

  if (changed) {
    const trailingNewline = original.endsWith("\n") ? "\n" : "";
    fs.writeFileSync(
      pkgPath,
      `${JSON.stringify(pkg, null, 2)}${trailingNewline}`
    );
  }

  if (identifier) {
    rewriteStringConstants(sourceDir, {
      PLUGIN_NAME: identifier,
      pluginName: identifier,
    });
  }

  if (platformAlias) {
    applyPlatformAlias(sourceDir, platformAlias);
  }
}

// npm ignores/strips file: paths that point into node_modules. Prefer a path
// under /var/lib/homebridge/local-plugins and a relative file:./ spec.
function hbFileInstallSpec(pluginDir) {
  const normalized = pluginDir.replace(/\/+$/, "");
  if (!normalized.startsWith(`${HB_ROOT}/`)) {
    fail(
      `hb-install requires --plugin-dir under ${HB_ROOT} (got ${pluginDir})`
    );
  }
  const relative = normalized.slice(HB_ROOT.length + 1);
  if (relative === "node_modules" || relative.startsWith("node_modules/")) {
    fail(
      `hb-install cannot use a path under ${HB_ROOT}/node_modules; ` +
        `deploy to ${HB_ROOT}/local-plugins/<name> instead`
    );
  }
  return `file:./${relative}`;
}

function main() {
  const {
    host,
    source,
    pluginDir,
    build,
    name,
    identifier,
    displayNameSuffix,
    platformAlias,
    noRestart,
    noHbInstall,
  } = parseCli(process.argv.slice(2));

  if (!which("sshpass")) {
    fail("sshpass is required (brew install esolitos/ipa/sshpass)");
  }
  if (!which("rsync")) {
    fail("rsync is required");
  }

  const password = getPassword();
  if (!password) {
    fail(`could not read password from 1Password item "${OP_ITEM}"`);
  }

  applyPackageJsonOverrides(source, {
    identifier,
    displayNameSuffix,
    platformAlias,
  });

  if (build) {
    console.log(`→ Building in ${source}`);
    run(build, [], { cwd: source, shell: true });
  }

  console.log(`→ Ensuring remote dir exists on ${host}`);
  // npm may leave a file: symlink here (e.g. eufy-robovac-js -> ../../../…).
  // mkdir -p then fails with "File exists"; replace symlinks with a real dir.
  ssh(
    host,
    [
      `if [ -L ${shellSingleQuote(pluginDir)} ]; then sudo rm ${shellSingleQuote(
        pluginDir
      )}; fi`,
      `sudo mkdir -p ${shellSingleQuote(pluginDir)}`,
    ].join(" && "),
    password
  );

  rsyncTo(source, host, pluginDir, password);

  const remoteSteps = [
    `echo '→ npm install'`,
    `sudo npm install --omit=dev --prefix ${shellSingleQuote(pluginDir)}`,
    `sudo chown -R homebridge:homebridge ${shellSingleQuote(pluginDir)}`,
  ];

  if (!noHbInstall) {
    const fileSpec = hbFileInstallSpec(pluginDir);
    // Registers the package in /var/lib/homebridge/package.json as file:./…
    // and symlinks node_modules/<name> → the deployed directory.
    remoteSteps.push(
      `echo '→ hb-service add ${fileSpec}'`,
      `sudo hb-service add ${shellSingleQuote(fileSpec)}`
    );
  }

  if (!noRestart) {
    remoteSteps.push("sudo hb-service restart");
  }

  const labels = ["Remote install"];
  if (!noHbInstall) labels.push("hb-install");
  if (!noRestart) labels.push("restart");
  else labels.push("skip restart");
  console.log(`→ ${labels.join(" + ")}`);
  ssh(host, remoteSteps.join(" && "), password);

  console.log(`✓ Deployed ${name}`);
}

main();
