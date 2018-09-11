"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.main = main;

var _fsExtra = require("fs-extra");

var _fsExtra2 = _interopRequireDefault(_fsExtra);

var _util = require("util");

var _util2 = _interopRequireDefault(_util);

var _path = require("path");

var _path2 = _interopRequireDefault(_path);

var _glob = require("glob");

var _glob2 = _interopRequireDefault(_glob);

var _page = require("./template/page");

var _router = require("./template/router");

var _style = require("./template/style");

var _root = require("./template/root");

var _minimist = require("minimist");

var _minimist2 = _interopRequireDefault(_minimist);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

async function getApplicationName() {
  const filesInRoot = await _fsExtra2.default.readdir(`./src`);

  const dirsWithNull = await Promise.all(filesInRoot.map(async file => {
    const stat = await _fsExtra2.default.stat(_path2.default.resolve("./src/", file));
    return stat.isDirectory() ? file : null;
  }));

  const dirs = dirsWithNull.filter(dir => dir !== null);

  if (dirs.length !== 1) {
    throw new Error("Cannot decide the application name. Too many directory or no directory in src directory. ");
  }

  const application = dirs[0];

  return application;
}

async function generateRouter(argv) {

  // create root Type.elm, Update.elm and View.elm
  const application = await getApplicationName();

  if (!_fsExtra2.default.existsSync(_path2.default.resolve("src", application, "Root.elm"))) {
    console.log(`Generating ${application}/Root.elm`);
    await _fsExtra2.default.writeFile(_path2.default.resolve(".", "src", application, "Root.elm"), (0, _root.renderRoot)(application));
  }

  // generate NoutFound
  const notFoundExists = await pageExists("NotFound");
  if (!notFoundExists) {
    await generateNewPage("NotFound");
  }

  // get page names

  const pageFiles = await _util2.default.promisify(_glob2.default)(`./src/${application}/Page/*.elm`);
  const pages = pageFiles.map(p => _path2.default.basename(p, ".elm"));
  if (pages.length === 0) {
    throw new Error("Pege not found.");
  }

  // generate <application>.Alchemy.elm
  console.log(`Generating ./src/${application}/Alchemy.elm for ${pages.join(", ")}...`);
  const source = (0, _router.renderRouter)(application, pages, argv);
  await _fsExtra2.default.writeFile(`./src/${application}/Alchemy.elm`, source);

  // generate alchemy.js
  console.log(`Generating ./src/${application}/alchemy.js...`);
  const indexSource = (0, _style.renderStyle)(application, pages);
  await _fsExtra2.default.writeFile(_path2.default.resolve("./src/", application, "alchemy.js"), indexSource);

  console.log("Done.");
}

function validatePageName(pageName) {
  return (/[A-Z][a-zA-Z0-9_]*/.test(pageName)
  );
}

async function pageExists(pageName) {
  if (!validatePageName(pageName)) {
    throw new Error(`Invalid page name: ${pageName}. An page name must be an valid Elm module name.`);
  }

  const application = await getApplicationName();

  return _fsExtra2.default.existsSync(_path2.default.resolve(`./src/`, application, `Page`, pageName + ".elm"));
}

async function createApplication(application) {
  const exists = _fsExtra2.default.existsSync(_path2.default.resolve(`src`, application));
  if (exists) {
    throw new Error(`Directory ${application} already exists.`);
  } else if (/[A-Z][a-zA-Z0-9_]*/.test(application)) {
    await _fsExtra2.default.ensureDir(_path2.default.resolve("src", application));
  } else {
    throw new Error(`${application} is not a valid package name.`);
  }
}

async function generateNewPage(pageName) {
  if (!validatePageName(pageName)) {
    throw new Error(`Invalid page name: ${pageName}. An page name must be an valid Elm module name.`);
  }

  console.log(`Generating new page: ${pageName}`);

  const application = await getApplicationName();

  console.log(`found application: ${application}`);

  const exists = await pageExists(pageName);
  if (exists) {
    console.error(`[Error] Directory '${pageName}' already exists.`);
    process.exitCode = 1;
  } else {
    const dir = _path2.default.resolve("./src/", application, "Page");
    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, pageName + ".css"), "");
    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, pageName + ".elm"), (0, _page.renderBlankPage)(application, pageName));
  }
}

async function main() {
  var argv = (0, _minimist2.default)(process.argv.slice(2));
  const command = argv._[0];
  if (argv._.length === 0) {
    console.log(`
Usage: 

  elm-alchemy init <application>

    Create new application. 

  elm-alchemy update
    
    (Re)Generate Alchemy.elm, alchemy.js

  elm-alchemy new <name>
      
    Create new page named <name>. <name> must be an valid module name.

    `.trim());

    try {
      const application = await getApplicationName();
      console.log(`\nApplication found: ${application}`);
    } catch (e) {
      console.error(e.toString());
      process.exitCode = 1;
      return;
    }
  } else if (command == "init") {
    const applicationName = argv._[1];
    if (applicationName) {
      await createApplication(applicationName);
      await generateRouter(argv);
    } else {
      console.error("Too few argumant in the command");
    }
  } else if (command === "update") {
    await generateRouter(argv);
  } else if (command === "new") {
    const pageName = argv._[1];
    if (!validatePageName(pageName)) {
      console.error(`Invalid page name: ${pageName}. An page name must be an valid Elm module name.`);
      process.exitCode = 1;
      return;
    }
    await generateNewPage(pageName);
    await generateRouter(argv);
  } else {
    console.error(`[ERROR] Unknown command: ${command}`);
    console.error(JSON.stringify(argv, null, 2));
    process.exitCode = 1;
  }
}

main();