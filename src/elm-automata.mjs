import fs from "fs-extra";
import util from "util";
import path from "path";
import glob from "glob";
import { renderView } from "./template/view";
import { renderUpdate } from "./template/update";
import { renderType } from "./template/type";
import { renderRouter } from "./template/router";
import { renderStyle } from "./template/style";
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
      "Too many folders in src directory. Cannot decide application name."
    );
  }

  const application = dirs[0];

  return application;
}

async function generateRouter() {
  const application = await getApplicationName();
  console.log(`Found application: ${application}`);

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

  // generate Routing.elm
  console.log(
    `Generating ./src/${application}/Routing.elm for ${pages
      .map(p => p.join("."))
      .join(", ")}...`
  );
  const source = renderRouter(application, pages);
  await fs.writeFile(`./src/${application}/Routing.elm`, source);

  // generate routing.js
  console.log(`Generating ./src/${application}/routing.js...`);
  const indexSource = renderStyle(application, pages);
  await fs.writeFile(
    path.resolve("./src/", application, "routing.js"),
    indexSource
  );

  console.log("Done.");
}

async function generateNewPage(pageName) {
  if (!/[A-Z][a-zA-Z0-9_]*/.test(pageName)) {
    throw new Error(
      `Invalid page name: ${pageName}. An page name must be an valid Elm module name.`
    );
  }

  console.log(`Generating new page: ${pageName}`);

  const application = await getApplicationName();

  if (fs.existsSync(path.resolve(`./src/`, application, `Page`, pageName))) {
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

    await generateRouter();
  }
}

export async function main() {
  var argv = minimist(process.argv.slice(2));
  const command = argv._[0];
  if (argv._.length === 0) {
    console.log(
      `
usage: 

elm-automata update
    generate Routing.elm

elm-automata new <name>
    create new page named <name>

`.trim()
    );

    try {
      const application = await getApplicationName();
      console.log(`\nApplication found: ${application}`);
    } catch (e) {
      // ignore
    }
  } else if (command === "update") {
    await generateRouter();
  } else if (process.argv.length === 4 && command === "new") {
    await generateNewPage(process.argv[3]);
  } else {
    console.error(`[ERROR] Unknown command: ${command}`);
    process.exitCode = 1;
  }
}

main();
