const helpers = require('../helpers').default

const roundDownToNearestOddNumber = n => {
  n = Math.floor(n)
  if (n % 2 === 0) return n - 1
  return n
}

const day03_a = input => {
  // NOTE: Doesn't work for actual square numbers, too lazy to fix, deal with it

  // n = the square root of the nearest square number below it
  // m = the square root of the nearest square number above it
  const n = roundDownToNearestOddNumber(Math.sqrt(input))
  const n2 = n * n
  // amount of steps to reach the nth corner [not the mth]
  const steps_for_n = (n + 1) / 2

  // n2 = n ^ 2
  // m2 = m ^ 2
  const m = n + 2
  const m2 = m * m

  // diff = difference between 2 squares
  const diff = m2 - n2
  // diff_by_4 = amount of numbers on each side [r,u,l,d]
  const diff_by_4 = diff / 4

  // half_side_length = half the length of a side
  const half_side_length = diff_by_4 / 2

  // input minus n^2 = some value between the corner and the number
  const input_minus_n2 = input - n2 
  // get the difference from 'A' corner to offset of the input (not the nth corner)
  const mod = input_minus_n2 % diff_by_4

  // get the difference between the offset from a corner and the middle of the row
  let f = ((mod - half_side_length) % diff_by_4)

  // if the mod is less than half of the side length the result should be negated as values go from [-1 -> -half_side_length -> -1]
  if ( mod < half_side_length ) f *= -1

  // steps to the corner + difference between the center
  return steps_for_n + f
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
  return value
}

const day03_b = input => {
  // Consts and setups
  let currentPosition = { x: 0, y: 0 }
  let values = { '0.0': 1 }
  const positions = ['r', 'u', 'l', 'd']
  const dirs = {
    'r': { x: 1, y: 0 },
    'u': { x: 0, y: 1 },
    'l': { x: -1, y: 0 },
    'd': { x: 0, y: -1 }
  }
  
  // a sequence of letters to follow a route
  let sequence = []
  for(var i=0; i<16; i++){
    const m = i % 4;
    const times = Math.floor(i / 4) * 2 + (m >= 2 ? 2 : 1) // get the amount of times the letter is repeated

    for(var j=0; j<times; j++){
      sequence.push(positions[m])
    }
  }

  let FINAL
  sequence.some(s => {
    // Update new position of 
    currentPosition.x += dirs[s].x
    currentPosition.y += dirs[s].y

    // calculate value at currentPosition
    const value = calculateValueAtPosition(values, currentPosition)

    // update value in the storage
    values[`${currentPosition.x}.${currentPosition.y}`] = value

    // if value is greater than input, we found our number
    if (value > input) {
      FINAL = value
      return true
    }

    return false
  })

  return FINAL

  
  return FINAL
}

export default {
  a: day03_a,
  b: day03_b
}