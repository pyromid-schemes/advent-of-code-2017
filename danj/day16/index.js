const helpers = require('../helpers').default

const extractInstructions = command => {
  let instruction = command.substr(0,1)
  let v1, v2

  if (instruction === 's') {
    v1 = command.substr(1)
  } else if (instruction === 'x' || instruction === 'p') {
    v1 = command.substr(1, command.indexOf('/') - 1)
    v2 = command.substr(command.indexOf('/') + 1)

    if(instruction === 'x') { v1 = Number(v1); v2 = Number(v2) }
  }

  return { instruction, v1, v2 }
}

const pa = arr => console.log(arr)

const spin = (arr,value) => arr.substr(arr.length - value) + arr.substr(0, arr.length - value)

const exchange = (arr, v1, v2) => {
  let arr2 = arr.split('')
  const temp = arr2[v1]
  arr2[v1] = arr2[v2]
  arr2[v2] = temp
  return arr2.join('')
}

const partner = (arr, v1, v2) => {
  return exchange(arr, arr.indexOf(v1), arr.indexOf(v2))
}

const partA = input => {
  const commands = input.split(',').map(c => extractInstructions(c))
  let arr = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p'].join('')

  commands.map(command => {
    if(command.instruction === 's') arr = spin(arr, command.v1)
    if(command.instruction === 'x') arr = exchange(arr, command.v1, command.v2)
    if(command.instruction === 'p') arr = partner(arr, command.v1, command.v2)
  })

  return arr // padheomkgjfnblic
}

const partB = input => {
  const commands = input.split(',').map(c => extractInstructions(c))
  let arr = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p'].join('')

  let rounds = 1000000000
  let seen = []
  let i = 0
  while(rounds-- > 0){

    // if(arr === seen[0]){
    //   console.log('seen', seen)
    //   console.log('x', rounds, i, 1000000000 % (1000000000 - rounds), seen[1000000000 % (1000000000 - rounds)])
    //   console.log('s[18]', seen[17], seen[18], seen[19], seen[1000000000 % i])
    //   return 'abc'
    // }
    // seen.push(arr)

    // if(rounds % 1000 === 0) console.log('rounds', rounds)


    // i++
    commands.map(command => {
      if(command.instruction === 's') arr = spin(arr, command.v1)
      if(command.instruction === 'x') arr = exchange(arr, command.v1, command.v2)
      if(command.instruction === 'p') arr = partner(arr, command.v1, command.v2)
    })


    console.log('i[',i,'] [',arr,']')
    i++
  }

  // console.log('arr2partb', arr)

  // return arr
}

export default {
  a: partA,
  b: partB
}
