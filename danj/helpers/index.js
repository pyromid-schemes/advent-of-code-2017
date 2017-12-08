const fs = require('fs')


const readFile2 = filename => fs.readFileSync(filename, 'utf8')
const readFile = folder => fs.readFileSync(__dirname + '/../' + folder + '/input.txt', 'utf8')
const splitByNewLine = input => input.split("\n")

const sortNumbers = arr => arr.sort((a,b) => a - b)

const padDay = dayNumber => {
  const dayPadded =  `${dayNumber < 10 ? '0' : ''}${dayNumber}`
  return { dayNumber, dayPadded }
}

export default {
  readFile,
  readFile2,
  splitByNewLine,
  sortNumbers,
  padDay
}