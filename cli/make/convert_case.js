const camelcase = require('lodash.camelcase');
const upperfirst = require('lodash.upperfirst');
const kebabcase = require('lodash.kebabcase');
const snakecase = require('lodash.snakecase');
const c = require('../../helpers/color').c;

const [,, convention, str] = process.argv;

let nextStr = str;
switch (convention) {
  case 'camel': { nextStr = camelcase(str); break; }
  case 'constant': { nextStr = snakecase(str).toUpperCase(); break; }
  case 'kebab': { nextStr = kebabcase(str); break; }
  case 'pascal': { nextStr = upperfirst(camelcase(str)); break; }
  case 'snake': { nextStr = snakecase(str); break; }
  default: {
    console.error(c.RED, 'No convention found for ' + convention);
    console.error(c.RED, 'Allowed arguments: camel, constant, kebab, pascal, snake');
    console.error(c.END);
  }
}

console.log(nextStr);
