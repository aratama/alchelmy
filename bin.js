const { spawn } = require('child_process');
const p = spawn('node', ['--experimental-modules', 'src/elm-alchemy.mjs']);
p.stdout.on('data', (data) => {
  console.log(data.toString());
});
p.stderr.on('data', (data) => {
  console.error(data.toString());
});
p.on('close', (code) => {
  process.exit(code);
});