/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/elm-automata.mjs":
/*!******************************!*\
  !*** ./src/elm-automata.mjs ***!
  \******************************/
/*! no exports provided */
/***/ (function(__webpack_module__, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n/* WEBPACK VAR INJECTION */(function(process) {\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nexports.main = main;\n\nvar _fsExtra = require(\"fs-extra\");\n\nvar _fsExtra2 = _interopRequireDefault(_fsExtra);\n\nvar _util = require(\"util\");\n\nvar _util2 = _interopRequireDefault(_util);\n\nvar _path = require(\"path\");\n\nvar _path2 = _interopRequireDefault(_path);\n\nvar _glob = require(\"glob\");\n\nvar _glob2 = _interopRequireDefault(_glob);\n\nvar _view = require(\"./template/view\");\n\nvar _update = require(\"./template/update\");\n\nvar _type = require(\"./template/type\");\n\nvar _router = require(\"./template/router\");\n\nvar _style = require(\"./template/style\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nasync function getApplicationName() {\n  const filesInRoot = await _fsExtra2.default.readdir(`./src`);\n\n  const dirsWithNull = await Promise.all(filesInRoot.map(async file => {\n    const stat = await _fsExtra2.default.stat(_path2.default.resolve('./src/', file));\n    return stat.isDirectory() ? file : null;\n  }));\n\n  const dirs = dirsWithNull.filter(dir => dir !== null);\n\n  if (dirs.length !== 1) {\n    throw new Error(\"Too many folders in src directory. Cannot decide application name.\");\n  }\n\n  const application = dirs[0];\n\n  return application;\n}\n\nasync function generateRouter() {\n\n  const application = await getApplicationName();\n  console.log(`Found application: ${application}`);\n\n  const ds = await _util2.default.promisify(_glob2.default)(`./src/${application}/Page/**/`);\n\n  const pages = ds.map(dir => {\n    if (_fsExtra2.default.existsSync(_path2.default.resolve(dir, \"style.css\")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, \"Type.elm\")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, \"Update.elm\")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, \"View.elm\"))) {\n      return _path2.default.relative(`./src/${application}/Page/`, dir).split(_path2.default.sep);\n    } else {\n      return null;\n    }\n  }).filter(dir => dir !== null);\n\n  // generate Routing.elm\n  console.log(`Generating ./src/${application}/Routing.elm for ${pages.map(p => p.join(\".\")).join(\", \")}...`);\n  const source = (0, _router.renderRouter)(application, pages);\n  await _fsExtra2.default.writeFile(`./src/${application}/Routing.elm`, source);\n\n  // generate routing.js\n  console.log(`Generating ./src/${application}/routing.js...`);\n  const indexSource = (0, _style.renderStyle)(application, pages);\n  await _fsExtra2.default.writeFile(_path2.default.resolve(\"./src/\", application, \"routing.js\"), indexSource);\n\n  console.log(\"Done.\");\n}\n\nasync function generateNewPage(pageName) {\n\n  console.log(`Generating new page: ${pageName}`);\n\n  const application = await getApplicationName();\n\n  if (_fsExtra2.default.existsSync(_path2.default.resolve(`./src/`, application, `Page`, pageName))) {\n    console.error(`[Error] Directory '${pageName}' already exists.`);\n  } else {\n    const dir = _path2.default.resolve(\"./src/\", application, \"Page\", pageName);\n    await _fsExtra2.default.ensureDir(dir);\n    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"style.css\"), \"\");\n    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"Type.elm\"), (0, _type.renderType)(application, pageName));\n    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"Update.elm\"), (0, _update.renderUpdate)(application, pageName));\n    await _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"View.elm\"), (0, _view.renderView)(application, pageName));\n\n    await generateRouter();\n  }\n}\n\nasync function main() {\n  const command = process.argv[2];\n  if (process.argv.length === 2) {\n    await generateRouter();\n  } else if (process.argv.length === 4 && command === \"new\") {\n    await generateNewPage(process.argv[3]);\n  } else {\n    console.error(`Unknown command: ${process.argv.slice(2).join(\" \")}`);\n  }\n}\n\nmain();\n/* WEBPACK VAR INJECTION */}.call(this, require(\"./../node_modules/process/browser.js\")))\n\n//# sourceURL=webpack:///./src/elm-automata.mjs?");

/***/ }),

/***/ 0:
/*!************************************!*\
  !*** multi ./src/elm-automata.mjs ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("module.exports = __webpack_require__(/*! ./src/elm-automata.mjs */\"./src/elm-automata.mjs\");\n\n\n//# sourceURL=webpack:///multi_./src/elm-automata.mjs?");

/***/ })

/******/ });