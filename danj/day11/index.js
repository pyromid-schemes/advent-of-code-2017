const helpers = require('../helpers').default

const movePositions = {}
const data = [['n',90],['ne',30],['se',330],['s',270],['sw',210],['nw',150]].map(c => {
  const command = c[0]
  const value = c[1]
  movePositions[command] = { x: Math.cos(value * Math.PI / 180), y: Math.sin(value * Math.PI / 180)}
})

const moveCountFromPosition = position => {
  let moveCount = 0
  const EPSILON = 0.00001

  // EDGE CASE, IF NO Y DIFFERENCE 
  if (position.y < EPSILON && position.y > -EPSILON) {
    return Math.round(Math.abs(position.x / (movePositions['ne'].x * 2))) 
  }

  // Find amount of diagonal left/right moves taken and subtract from the y position to make it all in a line
  let divisionsX = Math.round(position.x / movePositions['ne'].x)
  const newPositionY = position.y - (divisionsX * movePositions['ne'].y)
  moveCount += Math.abs(divisionsX)

  // find amount of hex positions along a north line for the y move count
  let divisionsY = Math.round(newPositionY / movePositions['n'].y)
  moveCount += Math.abs(divisionsY)

  return moveCount
}

const runCommands = commands => {
  let position = { x: 0, y: 0}
  let maxMoveCount = 0
  
  commands.map(c => {
    position.x += movePositions[c].x
    position.y += movePositions[c].y

    const curMoveCount = moveCountFromPosition(position)
    if(curMoveCount > maxMoveCount) maxMoveCount = curMoveCount
  })

  return { position, maxMoveCount }
}

const partA = input => {
  const { position } = runCommands(input.split(','))
  return moveCountFromPosition(position)
}

const partB = input => {
  const { maxMoveCount } = runCommands(input.split(','))
  return maxMoveCount
}

export default {
  a: partA,
  b: partB
}