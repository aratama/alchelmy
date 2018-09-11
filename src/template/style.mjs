import fs from "fs";

export function renderStyle(application, pages){
  return `
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT IT      //
/////////////////////////
${
  pages.filter(page => fs.existsSync(`./src/${application}/Page/${page}.css`)).map(page => {
    return `import './Page/${page}.css'`
  }).join("\n")
}
`
}