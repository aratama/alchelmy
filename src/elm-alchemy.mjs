import fs from "fs-extra";
import util from "util";
import path from "path";
import glob from "glob";
import { renderView } from "./template/page/view";
import { renderUpdate } from "./template/page/update";
import { renderType } from "./template/page/type";
import { renderRouter } from "./template/router";
import { renderStyle } from "./template/style";
import { renderRootType } from "./template/root/type";
import { renderRootUpdate } from "./template/root/update";
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



  // create root Type.elm
  const application = await getApplicationName();

  if (!fs.existsSync(path.resolve("src", application, "Type.elm"))) {
    console.log(`Generating ${application}/Type.elm`);
    await fs.writeFile(
      `./src/${application}/Type.elm`,
      renderRootType(application)
    );

    console.log(`Generating ${application}/Update.elm`);
    await fs.writeFile(
      `./src/${application}/Update.elm`,
      renderRootUpdate(application)
    );
  }

  // generate NoutFound
  const notFoundExists = await pageExists("NotFound");
  if (!notFoundExists) {
    await generateNewPage("NotFound");
  }

  // get page names

  const ds = await util.promisify(glob)(`./src/${application}/Page/**/`);

  const pages = ds
    .map(dir => {
      if (
        fs.existsSync(path.resolve(dir, "style.css")) &&
        fs.existsSync(path.resolve(dir, "Type.elm")) &&
        fs.existsSync(path.resolve(dir, "Update.elm")) &&
        fs.existsSync(path.resolve(dir, "View.elm"))
      ) {
        return path.relative(`./src/${application}/Page/`, dir).split(path.sep);
      } else {
        return null;
      }
    })
    .filter(dir => dir !== null);

  if (pages.length === 0) {
    throw new Error("Pege not found.");
  }

  // generate <application>.Alchemy.elm
  console.log(
    `Generating ./src/${application}/Alchemy.elm for ${pages
      .map(p => p.join("."))
      .join(", ")}...`
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

  return fs.existsSync(path.resolve(`./src/`, application, `Page`, pageName));
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
    await fs.writeFile(path.resolve(dir, "style.css"), "");
    await fs.writeFile(
      path.resolve(dir, "Type.elm"),
      renderType(application, pageName)
    );
    await fs.writeFile(
      path.resolve(dir, "Update.elm"),
      renderUpdate(application, pageName)
    );
    await fs.writeFile(
      path.resolve(dir, "View.elm"),
      renderView(application, pageName)
    );
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

Options:

  --parse <hash|path>
    
     Specify an url parse function. The default is "hash".

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