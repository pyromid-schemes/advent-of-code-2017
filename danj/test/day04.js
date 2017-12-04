var expect    = require('chai').expect
var day = require('../day04').default

describe('day 4', () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: 'aa bb cc dd ee', expectedResult: 1 },
      { input: 'aa bb cc dd aa', expectedResult: 0 },
      { input: 'aa bb cc dd aaa', expectedResult: 1 }

    ]

    tests.map(t => {
      it(`input '${t.input}' should return ${t.expectedResult}`, () => {
        const actualResult = day.a(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})