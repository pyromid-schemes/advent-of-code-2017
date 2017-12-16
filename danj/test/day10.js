const expect = require('chai').expect
const helpers = require('../helpers').default
const { dayNumber, dayPadded } = helpers.padDay(10)
const day = require(`../day${dayPadded}`).default

describe(`day ${dayNumber}`, () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: '3,4,1,5', expectedResult: 12 }
      // { input: helpers.readFile2(__dirname + `/day${dayPadded}_input.txt`), expectedResult: 1 }
    ]

    tests.map(t => {
      it(`test input should return '${t.expectedResult}'`, () => {
        const actualResult = day.a(t.input, 5)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })

  describe('part B', () => {
    const tests = [
      { input: '1,2,3', expectedResult: '3efbe78a8d82f29979031a4aa0b16a9d' }
    ]

    tests.map(t => {
      it(`test input should return '${t.expectedResult}'`, () => {
        const actualResult = day.b(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})