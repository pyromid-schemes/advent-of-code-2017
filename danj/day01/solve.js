require('babel-register');  

const helpers = require('../helpers').default
const day01 = require('./index.js').default

const input = helpers.readFile('day01')

console.log('day 01 a:', day01.a(input))
console.log('day 01 b:', day01.b(input))