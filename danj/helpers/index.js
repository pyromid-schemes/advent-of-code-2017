const fs = require('fs')


const readFile = folder => fs.readFileSync(__dirname + '/../' + folder + '/input.txt', 'utf8')
const splitByNewLine = input => input.split("\n")

const sortNumbers = arr => arr.sort((a,b) => a - b)

export default {
  readFile,
  splitByNewLine,
  sortNumbers
}