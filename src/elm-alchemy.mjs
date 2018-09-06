import fs from "fs-extra";
import util from "util";
import path from "path";
import glob from "glob";
import { renderBlankPage } from "./template/page";
import { renderRouter } from "./template/router";
import { renderStyle } from "./template/style";
import { renderRoot } from "./template/root";
import minimist from "minimist";

async function getApplicationName() {
  const filesInRoot = await fs.readdir(`./src`);

  const dirsWithNull = await Promise.all(
    filesInRoot.map(async file => {
      const stat = await fs.stat(path.resolve("./src/", file));
      return stat.isDirectory() ? file : null;
    })
  );

  const dirs = dirsWithNull.filter(dir => dir !== null);

  if (dirs.length !== 1) {
    throw new Error(
      "Cannot decide the application name. Too many directory or no directory in src directory. "
    );
  }

  const application = dirs[0];

  return application;
}

async function generateRouter(argv) {



  // create root Type.elm, Update.elm and View.elm
  const application = await getApplicationName();

  if (!fs.existsSync(path.resolve("src", application, "Root.elm"))) {
    console.log(`Generating ${application}/Root.elm`);    
    await fs.writeFile(
      path.resolve(".", "src", application, "Root.elm"),
      renderRoot(application)
    );
  }

  // generate NoutFound
  const notFoundExists = await pageExists("NotFound");
  if (!notFoundExists) {
    await generateNewPage("NotFound");
  }

  // get page names

  const pageFiles = await util.promisify(glob)(`./src/${application}/Page/*.elm`);
  const pages = pageFiles.map(p => path.basename(p, ".elm"))
  if (pages.length === 0) {
    throw new Error("Pege not found.");
  }

  // generate <application>.Alchemy.elm
  console.log(
    `Generating ./src/${application}/Alchemy.elm for ${pages.join(", ")}...`
  );
  const source = renderRouter(application, pages, argv);
  await fs.writeFile(`./src/${application}/Alchemy.elm`, source);

  // generate alchemy.js
  console.log(`Generating ./src/${application}/alchemy.js...`);
  const indexSource = renderStyle(application, pages);
  await fs.writeFile(
    path.resolve("./src/", application, "alchemy.js"),
    indexSource
  );

  console.log("Done.");
}

function validatePageName(pageName) {
  return /[A-Z][a-zA-Z0-9_]*/.test(pageName);
}

async function pageExists(pageName) {
  if (!validatePageName(pageName)) {
    throw new Error(
      `Invalid page name: ${pageName}. An page name must be an valid Elm module name.`
    );
  }

  const application = await getApplicationName();

  return fs.existsSync(path.resolve(`./src/`, application, `Page`, pageName + ".elm"));
}

async function createApplication(application){
  const exists = fs.existsSync(path.resolve(`src`, application));
  if(exists){
    throw new Error(`Directory ${application} already exists.`);
  }else if (/[A-Z][a-zA-Z0-9_]*/.test(application)) {
    await fs.ensureDir(path.resolve("src", application));    
  } else {
    throw new Error(`${application} is not a valid package name.`);
  }
}

async function generateNewPage(pageName) {
  if (!validatePageName(pageName)) {
    throw new Error(
      `Invalid page name: ${pageName}. An page name must be an valid Elm module name.`
    );
  }

  console.log(`Generating new page: ${pageName}`);

  const application = await getApplicationName();

  const exists = await pageExists(pageName);
  if (exists) {
    console.error(`[Error] Directory '${pageName}' already exists.`);
    process.exitCode = 1;
  } else {
    const dir = path.resolve("./src/", application, "Page", pageName);
    await fs.ensureDir(dir);
    await fs.writeFile(path.resolve(dir, pageName + ".css"), "");
    await fs.writeFile(path.resolve(dir, pageName + ".elm"), renderBlankPage(application, pageName));
  }
}

export async function main() {
  var argv = minimist(process.argv.slice(2));
  const command = argv._[0];
  if (argv._.length === 0) {
    console.log(
      `
Usage: 

  elm-alchemy init <application>

    Create new application. 

  elm-alchemy update
    
    (Re)Generate Alchemy.elm, alchemy.js

  elm-alchemy new <name>
      
    Create new page named <name>. <name> must be an valid module name.

    `.trim()
    );

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
    await createApplication(applicationName);
    await generateRouter(argv);
  } else if (command === "update") {
    await generateRouter(argv);
  } else if (command === "new") {
    const pageName = argv._[1];
    if (!validatePageName(pageName)) {
      console.error(
        `Invalid page name: ${pageName}. An page name must be an valid Elm module name.`
      );
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
