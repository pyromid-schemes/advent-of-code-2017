const helpers = require('../helpers').default

const swapInList = (list, currentPosition, input) => {
  let swapTo = {}
  for(var i=0; i<input; i++) {
    const key =  (currentPosition + i) % list.length
    const keyTo = (currentPosition + input - i - 1) % list.length
    swapTo[key] = keyTo
  }

  return list.map((item, idx) => typeof swapTo[idx] !== 'undefined' ? list[swapTo[idx]] : item)
}

const runInputsWithRounds = (inputs, length, rounds) => {
  let list = [...Array(length).keys()]
  let currentPosition = 0
  let skip = 0

  while(rounds-- > 0){
    inputs.map(i => {
      list = swapInList(list, currentPosition, i)
      currentPosition += i + skip++

      currentPosition %= list.length
    })
  }

  return list
}

const partA = (input, length = 256) => {
  const inputs = input.split(',').map(i => Number(i))

  const list = runInputsWithRounds(inputs, length, 1)

  return list[0] * list[1]
}

const partB = (input, length = 256) => {
  const inputs = input.split('').map(i => Number(i.charCodeAt())).concat([17, 31, 73, 47, 23])
  
  const list = runInputsWithRounds(inputs, 256, 64)

  let denseHash = []
  let knotHash = ''
  for(var i=0; i<16; i++){
    const block = list.slice(i*16, (i+1)*16)
    let value = block.reduce((acc, n) => acc ^= n, 0)

    const hex = value.toString(16)
    knotHash += (hex.length === 1 ? `0${hex}` : hex)
  }

  return  knotHash
}

export default {
  a: partA,
  b: partB
}