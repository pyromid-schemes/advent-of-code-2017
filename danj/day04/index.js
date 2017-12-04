const helpers = require('../helpers').default

const compute = (input, word_func) => {
  return helpers.splitByNewLine(input).reduce((acc, i) => {
    const words = i.split(' ')
    const wordCount = new Set()

    let valid = true
    words.some(w => {
      const word = word_func(w)

      if(wordCount.has(word)) {
        valid = false
        return true
      }
      wordCount.add(word)
      return false
    })

    return acc + (valid ? 1 : 0)
  }, 0)
}

const day04_a = input => {
  return compute(input, w => w)
}

const day04_b = input => {
  return compute(input, w => w.split('').sort().join(''))
}

export default {
  a: day04_a,
  b: day04_b
}