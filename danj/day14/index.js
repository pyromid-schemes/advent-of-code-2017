const helpers = require('../helpers').default
const { computeKnotHash } = require('../day10').default

const h2b = hex => [8,4,2,1].reduce((acc, n) => acc + ((parseInt(hex, 16) & n) > 0 ? '1' : '0'), '')

const findPositionsToCheck = position => {
  const increments = [{x: 1, y: 0}, {x: -1, y: 0}, {x: 0, y: 1}, {x: 0, y: -1}]
  const newPositions = []
  increments.forEach(i => {
    const pos = { x: position.x + i.x, y: position.y + i.y }
    if(pos.x >= 0 && pos.x <= 127 && pos.y >= 0 && pos.y <= 127){
      newPositions.push(pos)
    }
  })
  return newPositions
}
const findUsedSquare = grid => {
  for(var y=0; y<128; y++){
    for(var x=0; x<128; x++){
      if(grid[x][y] === '1') return { x, y }
    }
  }
  return { x: -1, y: -1 }
}

const isGridOn = (grid, position) => grid[position.x][position.y] === '1'
const turnOff = (grid, position) => grid[position.x][position.y] = '0'

const regionsInGrid = grid => {
  let regions = 0

  // find x,y of a position in the grid where it is 1
  // add the n/e/s/w positions to a 'checker', replace all these values with 0s, if they were 1's then add their n/e/s/w
  while(true){
    const position = findUsedSquare(grid)
    if(position.x === -1) break
    let positionsToCheck = [position]

    regions++

    let regionSize = 0
    while(positionsToCheck.length > 0) {
      const check = positionsToCheck.splice(0, 1)[0]

      if (isGridOn(grid, check)) {
        turnOff(grid, check)
        positionsToCheck = positionsToCheck.concat(findPositionsToCheck(check))
      }
    }
  }
  
  return regions
}


const partA = input => {
  let arr = []
  
  for(let i=0; i<128; i++){
    const knotHash = computeKnotHash(`${input}-${i}`)
    arr.push(knotHash.split('').map(h => h2b(h)).join(''))
  }

  return arr.join('').split('').reduce((acc, n) => acc + (n === '1' ? 1 : 0), 0)
}

const partB = input => {
  const grid = {}

  for(let y=0; y<128; y++){
    const knotHash = computeKnotHash(`${input}-${y}`)
    knotHash.split('').map((h,x) => {
      const binary = h2b(h).split('')
      binary.map((b, idx) => {
        if(!grid[x*4+idx]) grid[x*4+idx] = {}
        grid[x*4+idx][y] = b 
      })      
    })
  }

  return regionsInGrid(grid)
}

export default {
  a: partA,
  b: partB
}
