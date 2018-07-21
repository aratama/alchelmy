"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.renderStyle = renderStyle;
function renderStyle(application, pages) {
  return `
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT IT      //
/////////////////////////
${pages.map(page => {
    return `import './Page/${page.join("/")}/style.css'`;
  }).join("\n")}
`;
}