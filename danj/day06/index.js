const helpers = require('../helpers').default

const updateBanks = banks => {
  // Get index of bank stack with highest vlaue
  let indexOfHighestValuedBlock = findIndexOfHighestBlock(banks)
  let value = banks[indexOfHighestValuedBlock]

  // Reset this stack to 0
  banks[indexOfHighestValuedBlock++] = 0

  // Update all other stacks with the value from this stack
  while(value-- > 0) {
    indexOfHighestValuedBlock %= banks.length
    banks[indexOfHighestValuedBlock]++
    indexOfHighestValuedBlock++
  }

  // Return new bank stack
  return banks
}

const findIndexOfHighestBlock = banks => {
  let highestValue = -1
  let highestValueIndex = 0

  banks.map((b,idx) => {
    if (b > highestValue) {
      highestValue = b
      highestValueIndex = idx
    }
  })

  return highestValueIndex
}

const runBankSimulation = input => {
  let banks = input.split(' ').map(i => Number(i))
  
  let existingPatterns = {}
  existingPatterns[banks.join('.')] = 0

  let diff = 0
  let steps = 0
  while(true){
    steps++

    banks = updateBanks(banks)

    // Create pattern from bank set
    const pattern = banks.join('.')
    // Check if pattern exists already - if it does, return some values
    if(existingPatterns[pattern]){
      diff = steps - existingPatterns[pattern]
      break;
    }
    // Add the pattern with the amount of steps to reach here
    existingPatterns[pattern] = steps
  }

  return { diff, steps }
}

const partA = input => {
  const { diff, steps } = runBankSimulation(input)
  return steps
}

const partB = input => {
  const { diff, steps } = runBankSimulation(input)
  return diff
}

export default {
  a: partA,
  b: partB
}