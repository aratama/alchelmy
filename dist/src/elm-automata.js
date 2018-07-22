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

var _view = require("./template/view");

var _update = require("./template/update");

var _type = require("./template/type");

var _router = require("./template/router");

var _style = require("./template/style");

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
    throw new Error("Too many folders in src directory. Cannot decide application name.");
  }

  const application = dirs[0];

  return application;
}

async function generateRouter() {
  const application = await getApplicationName();
  console.log(`Found application: ${application}`);

  const ds = await _util2.default.promisify(_glob2.default)(`./src/${application}/Page/**/`);

  const pages = ds.map(dir => {
    if (_fsExtra2.default.existsSync(_path2.default.resolve(dir, "style.css")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, "Type.elm")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, "Update.elm")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, "View.elm"))) {
      return _path2.default.relative(`./src/${application}/Page/`, dir).split(_path2.default.sep);
    } else {
      return null;
    }
  }).filter(dir => dir !== null);

  // generate Routing.elm
  console.log(`Generating ./src/${application}/Routing.elm for ${pages.map(p => p.join(".")).join(", ")}...`);
  const source = (0, _router.renderRouter)(application, pages);
  await _fsExtra2.default.writeFile(`./src/${application}/Routing.elm`, source);

  // generate routing.js
  console.log(`Generating ./src/${application}/routing.js...`);
  const indexSource = (0, _style.renderStyle)(application, pages);
  await _fsExtra2.default.writeFile(_path2.default.resolve("./src/", application, "routing.js"), indexSource);

  console.log("Done.");
}

async function generateNewPage(pageName) {
  console.log(`Generating new page: ${pageName}`);

  const application = await getApplicationName();

  if (_fsExtra2.default.existsSync(_path2.default.resolve(`./src/`, application, `Page`, pageName))) {
    console.error(`[Error] Directory '${pageName}' already exists.`);
  } else {
    const dir = _path2.default.resolve("./src/", application, "Page", pageName);
    await _fsExtra2.default.ensureDir(dir);
    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, "style.css"), "");
    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, "Type.elm"), (0, _type.renderType)(application, pageName));
    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, "Update.elm"), (0, _update.renderUpdate)(application, pageName));
    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, "View.elm"), (0, _view.renderView)(application, pageName));

    await generateRouter();
  }
}

async function main() {
  var argv = (0, _minimist2.default)(process.argv.slice(2));
  console.dir(argv);
  console.dir("foo");

  const command = process.argv[2];
  if (process.argv.length === 2) {
    console.log("usage: elm-automata update");
  } else if (command === "update") {
    await generateRouter();
  } else if (process.argv.length === 4 && command === "new") {
    await generateNewPage(process.argv[3]);
  } else {
    console.error(`Unknown command: ${process.argv.slice(2).join(" ")}`);
  }
}

main();