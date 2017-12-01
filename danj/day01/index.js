const sumWithRule = (input, f) => {
  let index = 0

  return input.split('').reduce((acc, value) => {
    return acc + (value === input[f(index++)] ? Number(value) : 0)
  }, 0)
}

const day01_a = input => sumWithRule(input, i => (i+1) % input.length)
const day01_b = input => sumWithRule(input, i => (i + input.length/2) % input.length)

export default {
  a: day01_a,
  b: day01_b
}