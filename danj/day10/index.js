const helpers = require('../helpers').default

// const printList = (input, current) => {
//   const input2 = input.map((i, idx) => current === idx ? `[${i}]` : i).join(',')
//   console.log(`input2: ${input2}`)
// }

const swapInList = (list, currentPosition, input) => {
  let swapTo = {}
  for(var i=0; i<input; i++) {
    const key =  (currentPosition + i) % list.length
    const keyTo = (currentPosition + input - i - 1) % list.length
    swapTo[key] = keyTo
  }

  return list.map((item, idx) => typeof swapTo[idx] !== 'undefined' ? list[swapTo[idx]] : item)
}

const partA = (input, length = 256) => {
  const inputs = input.split(',').map(i => Number(i))

  // Setup defaults
  let list = [...Array(length).keys()]
  let currentPosition = 0
  let skip = 0

  inputs.map(i => {
    list = swapInList(list, currentPosition, i)
    currentPosition += i + skip++

    currentPosition %= list.length
  })

  return list[0] * list[1]
}

const partB = (input, length = 256) => {
  const inputs = input.split(',').map(i => Number(i.charCodeAt())).concat([17, 31, 73, 47, 23])

  // Setup defaults
  let list = [...Array(length).keys()]
  let currentPosition = 0
  let skip = 0

  // Convert to ascii characters
  console.log(`inputs: ${inputs}`)


  inputs.map(i => {
    list = swapInList(list, currentPosition, i)
    currentPosition += i + skip++

    currentPosition %= list.length
  })

  return list[0] * list[1]
}

export default {
  a: partA,
  b: partB
}