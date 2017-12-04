require('babel-register')

const helpers = require('./helpers').default

// Get the day
const whichDay = process.argv[2]
const whichDayPadded = whichDay.length === 1 ? `0${whichDay}` : whichDay

const day = require(`./day${whichDayPadded}`).default
const input = helpers.readFile('day'+whichDayPadded)

console.log(`day ${whichDay} a:`, day.a(input))
console.log(`day ${whichDay} b:`, day.b(input))