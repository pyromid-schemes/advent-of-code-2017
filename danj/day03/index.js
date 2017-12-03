const helpers = require('../helpers').default

const roundDownToNearestOddNumber = n => {
  n = Math.floor(n)
  if (n % 2 === 0) return n - 1
  return n
}

const day03_a = input => {
  // find the squares between the number 
  // 9 < 12 < 25
  // side length = 4
  // left = 3
  // left - side length = 1
  // console.log('sqrt', Math.sqrt(input))

  // 10 -> 1 [ 1 - 2 = - 1 ] 1 < 2 so flip [ = 1 ]
  // 11 -> 0 [ 2 - 2 = 0 ]
  // 12 -> 1 [ 3 - 2 = 1 ] 
  // 13 -> 2 [ 4 - 2 = 2 ]
  // 14 -> 1
  // 15 -> 0

  const n = roundDownToNearestOddNumber(Math.sqrt(input))
  const n_2 = n * n
  console.log('n', n, 'n^2', n_2)

  const next_n = n + 2
  const next_n_2 = next_n * next_n

  const diff = next_n_2 - n_2
  const diff_divided_by_4 = diff / 4
  // console.log('diff', diff)
  console.log('diff / 4 [SIDE_LENGTH]', diff_divided_by_4)

  const half_side_length = diff_divided_by_4 / 2
  console.log('half_side_length', half_side_length)

  const input_minus_n_2 = input - n_2
  console.log('input minus n^2', input_minus_n_2)
  const mod = input_minus_n_2 % diff_divided_by_4
  console.log('mod', mod)
  // console.log()

  let f = ((input_minus_n_2 - half_side_length) % diff_divided_by_4)

  if ( mod < half_side_length ) f *= -1

  
  console.log('F=',f)

  const steps_for_n = (n + 1) / 2
  console.log('STEPS FOR N', n, steps_for_n)

  return (steps_for_n) + f
}

const calculateValueAtPosition = (values, currentPosition) => {
  const checks = [{x: -1, y: 1}, {x: 0, y: 1}, {x: 1, y: 1}, {x: 1, y: 0}, {x: 1, y: -1}, {x: 0, y: -1}, {x: -1, y: -1},{x: -1, y: 0}]

  let value = 0
  checks.map(c => {
    const newPos = { x: currentPosition.x + c.x, y: currentPosition.y + c.y }

    const key = `${newPos.x}.${newPos.y}`
    if (values[key]) {
      value += values[key]
    }
  })
  console.log('value', value)
  return value
}

const findNumberGreaterThanInSequence = (number, sequence) => {
  let values = { '0.0': 1 }
  let currentPosition = { x: 0, y: 0 }
  const dirs = {
    'r': { x: 1, y: 0 },
    'u': { x: 0, y: 1 },
    'l': { x: -1, y: 0 },
    'd': { x: 0, y: -1 }
  }

  let FINAL
  sequence.some(s => {
    currentPosition.x += dirs[s].x
    currentPosition.y += dirs[s].y

    const value = calculateValueAtPosition(values, currentPosition)

    values[`${currentPosition.x}.${currentPosition.y}`] = value

    if (!FINAL && value > number) {
      FINAL = value
      return true
    }

    console.log(`currentPosition [${JSON.stringify(currentPosition)}]`)
    return false
  })

  return FINAL
}

const day03_b = input => {
  let currentPosition = { x: 0, y: 0 }
  let positions = ['r', 'u', 'l', 'd']
  
  let sequence = []
  for(var i=0; i<16; i++){
    const m = i % 4;
    const times = Math.floor(i / 4) * 2 + (m >= 2 ? 2 : 1) // get the amount of times the letter is repeated

    console.log(`[${positions[m]}] times [${times}]`)

    for(var j=0; j<times; j++){
      sequence.push(positions[m])
    }
  }

  const numberGreaterThanInSequence = findNumberGreaterThanInSequence(input, sequence)
  
  return numberGreaterThanInSequence
}

export default {
  a: day03_a,
  b: day03_b
}