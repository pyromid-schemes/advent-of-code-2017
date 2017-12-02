require('babel-register');  

const helpers = require('../helpers').default
const day = require('./index.js').default

const input = helpers.readFile('day02')

console.log('day 02 a:', day.a(input))
console.log('day 02 b:', day.b(input))