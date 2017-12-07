var expect    = require('chai').expect
var day = require('../day07').default
const helpers = require('../helpers').default

describe('day 7', () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: helpers.readFile2(__dirname + '/day07_input.txt'), expectedResult: 'tknk' }
    ]

    tests.map(t => {
      it(`test input should return '${t.expectedResult}'`, () => {
        const actualResult = day.a(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})