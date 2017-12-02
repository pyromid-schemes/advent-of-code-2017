const helpers = require('../helpers').default

const day02_a = input => {
  // Split the file into lines
  return helpers.splitByNewLine(input).reduce((acc, i) => {
    // Convert the line into an array and sort
    const sorted = helpers.sortNumbers(i.split(' ').map(i2 => Number(i2)))
    // return acc + max - min
    return acc + sorted[sorted.length - 1] - sorted[0]
  }, 0)
}
const day02_b = input =>  {
  return helpers.splitByNewLine(input).reduce((acc, i) => {
    // get a list of all values
    const values = i.split(' ').map(i2 => Number(i2))

    // double loop for doing divison of every number by every number
    return acc + values.reduce((acc1, v1) => {
      return acc1 + values.reduce((acc2, v2) => {
        // Store val so not computed multiple times
        const division = v1 / v2
        // Add the division if its even
        return acc2 +  (v1 === v2 ? 0 : (division === Math.floor(division) ? division : 0))
      }, 0)
    }, 0)
  }, 0)
}

export default {
  a: day02_a,
  b: day02_b
}