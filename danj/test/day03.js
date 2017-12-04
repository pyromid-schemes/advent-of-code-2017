var expect    = require('chai').expect
var day = require('../day03').default

describe('day 3', () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: '12', expectedResult: 3 },
      { input: '23', expectedResult: 2 },
      { input: '20', expectedResult: 3 },
      { input: '27', expectedResult: 4 },
      { input: '28', expectedResult: 3 },
      { input: '1024', expectedResult: 31 },
      { input: '11', expectedResult: 2 }
    ]

    tests.map(t => {
      it(`input '${t.input}' should return ${t.expectedResult}`, () => {
        const actualResult = day.a(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})