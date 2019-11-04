/**
 * Usage for colored console output:
 * ```
 * var color = require('./color.js').default;
 * var c = require('./color.js).c;
 * color(c.BLUE, 'Script is processing');
 * color(c.YELLOW, 'Be careful of user input!');
 * color(c.GREEN, 'Script completed successfully.');
 * ```
 *
 * Outputs ORIGIN » MESSAGE
 * Where ORIGIN is the relative script name. E.g.:
 * ./install.js » Script is processing
 */

var c = {
  PRE: '\033[0;240;2m',
  BLUE: '\033[0;34m',
  GREEN: '\033[0;32m',
  RED: '\033[0;31m',
  YELLOW: '\033[0;33m',
  END: '\033[0m',
};

var rexStack = /\/(.*)\.js/;

function color(which, message) {
  if (!which) which = '';
  if (!message) message = '';

  var stack;
  try { throw new Error('Get stack'); }
  catch (e) { stack = e.stack; }

  var file = stack
    .split('\n')[2]
    .match(rexStack)[0]
    .replace(process.cwd(), '.');

  console.log(c.PRE + file + ' » ' + which + message + c.END);
}

module.exports = {
  c: c,
  default: color,
};
