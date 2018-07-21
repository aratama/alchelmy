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
eval("__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n__webpack_require__.r(__webpack_exports__);\n/* WEBPACK VAR INJECTION */(function(process) {\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nexports.main = undefined;\n\nvar getApplicationName = function () {\n  var _ref = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee2() {\n    var _this = this;\n\n    var filesInRoot, dirsWithNull, dirs, application;\n    return regeneratorRuntime.wrap(function _callee2$(_context2) {\n      while (1) {\n        switch (_context2.prev = _context2.next) {\n          case 0:\n            _context2.next = 2;\n            return _fsExtra2.default.readdir(\"./src\");\n\n          case 2:\n            filesInRoot = _context2.sent;\n            _context2.next = 5;\n            return Promise.all(filesInRoot.map(function () {\n              var _ref2 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee(file) {\n                var stat;\n                return regeneratorRuntime.wrap(function _callee$(_context) {\n                  while (1) {\n                    switch (_context.prev = _context.next) {\n                      case 0:\n                        _context.next = 2;\n                        return _fsExtra2.default.stat(_path2.default.resolve('./src/', file));\n\n                      case 2:\n                        stat = _context.sent;\n                        return _context.abrupt(\"return\", stat.isDirectory() ? file : null);\n\n                      case 4:\n                      case \"end\":\n                        return _context.stop();\n                    }\n                  }\n                }, _callee, _this);\n              }));\n\n              return function (_x) {\n                return _ref2.apply(this, arguments);\n              };\n            }()));\n\n          case 5:\n            dirsWithNull = _context2.sent;\n            dirs = dirsWithNull.filter(function (dir) {\n              return dir !== null;\n            });\n\n            if (!(dirs.length !== 1)) {\n              _context2.next = 9;\n              break;\n            }\n\n            throw new Error(\"Too many folders in src directory. Cannot decide application name.\");\n\n          case 9:\n            application = dirs[0];\n            return _context2.abrupt(\"return\", application);\n\n          case 11:\n          case \"end\":\n            return _context2.stop();\n        }\n      }\n    }, _callee2, this);\n  }));\n\n  return function getApplicationName() {\n    return _ref.apply(this, arguments);\n  };\n}();\n\nvar generateRouter = function () {\n  var _ref3 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee3() {\n    var application, ds, pages, source, indexSource;\n    return regeneratorRuntime.wrap(function _callee3$(_context3) {\n      while (1) {\n        switch (_context3.prev = _context3.next) {\n          case 0:\n            _context3.next = 2;\n            return getApplicationName();\n\n          case 2:\n            application = _context3.sent;\n\n            console.log(\"Found application: \" + application);\n\n            _context3.next = 6;\n            return _util2.default.promisify(_glob2.default)(\"./src/\" + application + \"/Page/**/\");\n\n          case 6:\n            ds = _context3.sent;\n            pages = ds.map(function (dir) {\n              if (_fsExtra2.default.existsSync(_path2.default.resolve(dir, \"style.css\")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, \"Type.elm\")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, \"Update.elm\")) && _fsExtra2.default.existsSync(_path2.default.resolve(dir, \"View.elm\"))) {\n                return _path2.default.relative(\"./src/\" + application + \"/Page/\", dir).split(_path2.default.sep);\n              } else {\n                return null;\n              }\n            }).filter(function (dir) {\n              return dir !== null;\n            });\n\n            // generate Routing.elm\n\n            console.log(\"Generating ./src/\" + application + \"/Routing.elm for \" + pages.map(function (p) {\n              return p.join(\".\");\n            }).join(\", \") + \"...\");\n            source = (0, _router.renderRouter)(application, pages);\n            _context3.next = 12;\n            return _fsExtra2.default.writeFile(\"./src/\" + application + \"/Routing.elm\", source);\n\n          case 12:\n\n            // generate routing.js\n            console.log(\"Generating ./src/\" + application + \"/routing.js...\");\n            indexSource = (0, _style.renderStyle)(application, pages);\n            _context3.next = 16;\n            return _fsExtra2.default.writeFile(_path2.default.resolve(\"./src/\", application, \"routing.js\"), indexSource);\n\n          case 16:\n\n            console.log(\"Done.\");\n\n          case 17:\n          case \"end\":\n            return _context3.stop();\n        }\n      }\n    }, _callee3, this);\n  }));\n\n  return function generateRouter() {\n    return _ref3.apply(this, arguments);\n  };\n}();\n\nvar generateNewPage = function () {\n  var _ref4 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee4(pageName) {\n    var application, dir;\n    return regeneratorRuntime.wrap(function _callee4$(_context4) {\n      while (1) {\n        switch (_context4.prev = _context4.next) {\n          case 0:\n\n            console.log(\"Generating new page: \" + pageName);\n\n            _context4.next = 3;\n            return getApplicationName();\n\n          case 3:\n            application = _context4.sent;\n\n            if (!_fsExtra2.default.existsSync(_path2.default.resolve(\"./src/\", application, \"Page\", pageName))) {\n              _context4.next = 8;\n              break;\n            }\n\n            console.error(\"[Error] Directory '\" + pageName + \"' already exists.\");\n            _context4.next = 21;\n            break;\n\n          case 8:\n            dir = _path2.default.resolve(\"./src/\", application, \"Page\", pageName);\n            _context4.next = 11;\n            return _fsExtra2.default.ensureDir(dir);\n\n          case 11:\n            _context4.next = 13;\n            return _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"style.css\"), \"\");\n\n          case 13:\n            _context4.next = 15;\n            return _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"Type.elm\"), (0, _type.renderType)(application, pageName));\n\n          case 15:\n            _context4.next = 17;\n            return _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"Update.elm\"), (0, _update.renderUpdate)(application, pageName));\n\n          case 17:\n            _context4.next = 19;\n            return _fsExtra2.default.writeFile(_path2.default.resolve(dir, \"View.elm\"), (0, _view.renderView)(application, pageName));\n\n          case 19:\n            _context4.next = 21;\n            return generateRouter();\n\n          case 21:\n          case \"end\":\n            return _context4.stop();\n        }\n      }\n    }, _callee4, this);\n  }));\n\n  return function generateNewPage(_x2) {\n    return _ref4.apply(this, arguments);\n  };\n}();\n\nvar main = exports.main = function () {\n  var _ref5 = _asyncToGenerator( /*#__PURE__*/regeneratorRuntime.mark(function _callee5() {\n    var command;\n    return regeneratorRuntime.wrap(function _callee5$(_context5) {\n      while (1) {\n        switch (_context5.prev = _context5.next) {\n          case 0:\n            command = process.argv[2];\n\n            if (!(process.argv.length === 2)) {\n              _context5.next = 6;\n              break;\n            }\n\n            _context5.next = 4;\n            return generateRouter();\n\n          case 4:\n            _context5.next = 12;\n            break;\n\n          case 6:\n            if (!(process.argv.length === 4 && command === \"new\")) {\n              _context5.next = 11;\n              break;\n            }\n\n            _context5.next = 9;\n            return generateNewPage(process.argv[3]);\n\n          case 9:\n            _context5.next = 12;\n            break;\n\n          case 11:\n            console.error(\"Unknown command: \" + process.argv.slice(2).join(\" \"));\n\n          case 12:\n          case \"end\":\n            return _context5.stop();\n        }\n      }\n    }, _callee5, this);\n  }));\n\n  return function main() {\n    return _ref5.apply(this, arguments);\n  };\n}();\n\nvar _fsExtra = require(\"fs-extra\");\n\nvar _fsExtra2 = _interopRequireDefault(_fsExtra);\n\nvar _util = require(\"util\");\n\nvar _util2 = _interopRequireDefault(_util);\n\nvar _path = require(\"path\");\n\nvar _path2 = _interopRequireDefault(_path);\n\nvar _glob = require(\"glob\");\n\nvar _glob2 = _interopRequireDefault(_glob);\n\nvar _view = require(\"./template/view\");\n\nvar _update = require(\"./template/update\");\n\nvar _type = require(\"./template/type\");\n\nvar _router = require(\"./template/router\");\n\nvar _style = require(\"./template/style\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nfunction _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg); var value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step(\"next\", value); }, function (err) { step(\"throw\", err); }); } } return step(\"next\"); }); }; }\n\nmain();\n/* WEBPACK VAR INJECTION */}.call(this, require(\"./../node_modules/process/browser.js\")))\n\n//# sourceURL=webpack:///./src/elm-automata.mjs?");

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