const expect = require('chai').expect
const helpers = require('../helpers').default
const { dayNumber, dayPadded } = helpers.padDay(8)
const day = require(`../day${dayPadded}`).default

describe(`day ${dayNumber}`, () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: helpers.readFile2(__dirname + `/day${dayPadded}_input.txt`), expectedResult: 1 }
    ]

    tests.map(t => {
      it(`test input should return '${t.expectedResult}'`, () => {
        const actualResult = day.a(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })

  describe('part B', () => {
    const tests = [
      { input: helpers.readFile2(__dirname + `/day${dayPadded}_input.txt`), expectedResult: 10 }
    ]

    tests.map(t => {
      it(`test input should return '${t.expectedResult}'`, () => {
        const actualResult = day.b(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})