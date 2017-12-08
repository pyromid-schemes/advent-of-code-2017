const helpers = require('../helpers').default


const runInstructions = input => {
  const rows = helpers.splitByNewLine(input)
  
  // Create instruction set
  const instructions = rows.map(r => {
    const split = r.split(' ')
    
    return {
      register: split[0],
      value: Number(split[2]) * (split[1] === 'inc' ? 1 : -1),
      comparison: {
        register: split[4],
        operator: split[5],
        value: Number(split[6])
      }
    }
  })

  let registers = {}
  //Now process instructions
  instructions.map(i => {
    // set defaults
    if (!registers[i.register]) registers[i.register] = { current: 0, maximum: 0 }
    if (!registers[i.comparison.register]) registers[i.comparison.register] = { current: 0, maximum: 0 }

    // check comparison
    const comparisonRegisterValue = registers[i.comparison.register].current
    const comparisonValue = i.comparison.value
    switch(i.comparison.operator) {
      case '>': 
        if (comparisonRegisterValue > comparisonValue) {
          registers[i.register].current += i.value
        }
        break;
      case '<':
        if (comparisonRegisterValue < comparisonValue) {
          registers[i.register].current += i.value
        }
        break;
      case '>=':
        if (comparisonRegisterValue >= comparisonValue) {
          registers[i.register].current += i.value
        }
        break;
      case '==':
        if (comparisonRegisterValue === comparisonValue) {
          registers[i.register].current += i.value
        }
        break;
      case '<=':
        if (comparisonRegisterValue <= comparisonValue) {
          registers[i.register].current += i.value
        } 
        break;
      case '!=':
        if (comparisonRegisterValue !== comparisonValue) {
          registers[i.register].current += i.value
        }
        break;
    }

    if (registers[i.register].current > registers[i.register].maximum) {
      registers[i.register].maximum = registers[i.register].current
    }
  })

  return registers
}

const sortRegisters = (registers, sortKey) => registers[Object.keys(registers).sort((a,b) => registers[b][sortKey] - registers[a][sortKey])[0]][sortKey]

const partA = input => {
  const registers = runInstructions(input)
  return sortRegisters(registers, 'current')
}

const partB = input => {
  const registers = runInstructions(input)
  return sortRegisters(registers, 'maximum')
}

export default {
  a: partA,
  b: partB
}