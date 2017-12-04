const helpers = require('../helpers').default

const compute = (input, word_func) => {
  return helpers.splitByNewLine(input).reduce((acc, i) => {
    const words = i.split(' ')
    const wordCount = new Set()

    return acc + (words.some(w => {
      const word = word_func(w)
      const hasWord = wordCount.has(word)
      wordCount.add(word) 
      return hasWord
    }) ? 0 : 1)
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