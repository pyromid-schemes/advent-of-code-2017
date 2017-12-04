const helpers = require('../helpers').default

const day04_a = input => {

  return helpers.splitByNewLine(input).reduce((acc, i) => {
    const words = i.split(' ')
    const wordCount = new Set()

    let valid = true
    words.some(w => {
      if(wordCount.has(w)) {
        valid = false
        return true
      }
      wordCount.add(w)
      return false
    })

    return acc + (valid ? 1 : 0)
  }, 0)
}

const day04_b = input => {
  return 8
}

export default {
  a: day04_a,
  b: day04_b
}