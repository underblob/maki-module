#!/usr/bin/env node

const execSync = require('child_process').execSync;
const [,, command, ...args] = process.argv;
const cwd = process.cwd().replace(/\\/g, '/'); // Replace backlashes from Windows

process.chdir(__dirname);

switch(command) {
  case 'install': {
    execSync(`bash ./cli/install.sh ${cwd} ${args.join(' ')}`, { stdio: 'inherit' });
    break;
  }
  case 'make': {
    execSync(`bash ./cli/make.sh ${cwd} ${args.join(' ')}`, { stdio: 'inherit' });
    break;
  }
  default: {
    execSync('bash ./cli/help.sh', { stdio: 'inherit' });
  }
}
