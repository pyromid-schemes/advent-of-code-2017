const helpers = require('../helpers').default

let powersOf2 = [] 
for(var i=0; i<32; i++) powersOf2 = [Math.pow(2, i)].concat(powersOf2)

const convertToBinary = hex => powersOf2.reduce((acc, n) => acc + ((hex & n) > 0 ? '1' : '0'), '')

class Generator {
  constructor(seed, factor, multipleOf = 1) {
    this.value = seed
    this.factor = factor
    this.multipleOf = multipleOf
  }

  next(){
    this.value = (this.value * this.factor) % 2147483647
    return this.value
  }

  nextMultipleOf(){
    while(true) {
      const value = this.next()

      if(value % this.multipleOf === 0) return value
    }
  }
}

const partA = input => {
  const generatorA = new Generator(289, 16807)
  const generatorB = new Generator(629, 48271)

  let iterations = 40000000
  
  let count = 0
  while(iterations-- > 0){
    const valA = convertToBinary(generatorA.next()).substring(16)
    const valB = convertToBinary(generatorB.next()).substring(16)

    if(valA === valB) count++
  }

  return count
}

const partB = input => {
  const generatorA = new Generator(289, 16807, 4)
  const generatorB = new Generator(629, 48271, 8)

  let iterations = 5000000
  
  let count = 0
  while(iterations-- > 0){
    const valA = convertToBinary(generatorA.nextMultipleOf()).substring(16)
    const valB = convertToBinary(generatorB.nextMultipleOf()).substring(16)

    if(valA === valB) count++
  }

  return count
}

export default {
  a: partA,
  b: partB
}
