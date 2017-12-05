const helpers = require('../helpers').default

const runInstructions = (instructions, jumpValueIncreaseFunc) => {
  let steps = 0
  let currentInstruction = 0

  while(true) {
    steps++

    const jumpValue = Number(instructions[currentInstruction])
    instructions[currentInstruction] = jumpValue + jumpValueIncreaseFunc(jumpValue)

    currentInstruction += jumpValue

    if (currentInstruction >= instructions.length) break
  }

  return steps
}

const partA = input => runInstructions(helpers.splitByNewLine(input), (jumpValue) => 1 )
const partB = input => runInstructions(helpers.splitByNewLine(input), (jumpValue) => jumpValue >= 3 ? -1 : 1)

export default {
  a: partA,
  b: partB
}