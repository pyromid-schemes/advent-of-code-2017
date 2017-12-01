const fs = require('fs')

const readFile = folder => fs.readFileSync(__dirname + '/../' + folder + '/input.txt', 'utf8')

export default {
  readFile
}