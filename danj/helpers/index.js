const fs = require('fs')


const readFile2 = filename => fs.readFileSync(filename, 'utf8')
const readFile = folder => fs.readFileSync(__dirname + '/../' + folder + '/input.txt', 'utf8')
const splitByNewLine = input => input.split("\n")

const sortNumbers = arr => arr.sort((a,b) => a - b)

export default {
  readFile,
  readFile2,
  splitByNewLine,
  sortNumbers
}