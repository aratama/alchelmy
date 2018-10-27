#! /usr/bin/env node

const Main = require("./output/Main/");
Main.main()

/*
const path = require("path");
const { spawn } = require('child_process');
const p = spawn('node', ['--experimental-modules', path.resolve(__dirname, 'src/elm-alchemy.mjs')].concat(process.argv.slice(2)));
p.stdout.on('data', (data) => {
  console.log(data.toString());
});
p.stderr.on('data', (data) => {
  console.error(data.toString());
});
p.on('close', (code) => {
  process.exit(code);
});
*/