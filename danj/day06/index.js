const helpers = require('../helpers').default

/*
s -> 0 2 7 0
1 -> 2 4 1 2
2 -> 3 1 2 3
3 -> 0 2 3 4
4 -> 1 3 4 1
5 -> 2 4 1 2 [same as 1] -- 5 is the number of times before it finds a loop
*/
const findIndexOfHighestBlock = banks => {
  let highestValue = -1
  let highestValueIndex = 0

  banks.map((b,idx) => {
    // console.log(`b[${idx}] [${b}]`)
    if (b > highestValue) {
      highestValue = b
      highestValueIndex = idx
    }
  })

  return highestValueIndex
}

const partA = input => {
  let banks = input.split(' ').map(i => Number(i))
  console.log('banks', banks)

  let existingPatterns = new Set()
  existingPatterns.add(banks.join('.'))

  let steps = 0
  while(true){
    steps++

    let indexOfHighestValuedBlock = findIndexOfHighestBlock(banks)
    let value = banks[indexOfHighestValuedBlock]
    // console.log('index', indexOfHighestValuedBlock)
    // console.log('value', value)

    banks[indexOfHighestValuedBlock++] = 0

    while(value-- > 0) {
      indexOfHighestValuedBlock %= banks.length

      banks[indexOfHighestValuedBlock]++

      // console.log('iohvb', indexOfHighestValuedBlock)

      indexOfHighestValuedBlock++
    }

    const pattern = banks.join('.')

    if(existingPatterns.has(pattern)){
      break;
    }
    existingPatterns.add(pattern)

    // console.log('banksnew', banks)

    // find index of highest valued block -- 2 [7]

    if (steps === 100000) break;
  }

  return steps
}
const partB = input => 2

export default {
  a: partA,
  b: partB
}