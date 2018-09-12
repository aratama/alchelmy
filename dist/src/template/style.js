"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.renderStyle = renderStyle;

var _fs = require("fs");

var _fs2 = _interopRequireDefault(_fs);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function renderStyle(application, pages) {
  return `
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT THIS    //
/////////////////////////
${pages.filter(page => _fs2.default.existsSync(`./src/${application}/Page/${page}.css`)).map(page => {
    return `import './Page/${page}.css'`;
  }).join("\n")}
`;
}