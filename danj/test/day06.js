var expect    = require('chai').expect
var day = require('../day06').default

describe('day 6', () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: "0 2 7 0", expectedResult: 5 }
    ]

    tests.map(t => {
      it(`input '${t.input}' should return ${t.expectedResult}`, () => {
        const actualResult = day.a(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})