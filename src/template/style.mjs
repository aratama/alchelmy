export function renderStyle(application, pages){
  return `
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT IT      //
/////////////////////////
${
  pages.map(page => {
    return `import './Page/${page.join("/")}/style.css'`
  }).join("\n")
}
`
}