var expect    = require('chai').expect
var day = require('../day05').default

describe('day 5', () => {
  let input, expectedResult
  
  describe('part A', () => {
    const tests = [
      { input: "0\n3\n0\n1\n-3", expectedResult: 5 }
    ]

    tests.map(t => {
      it(`input '${t.input}' should return ${t.expectedResult}`, () => {
        const actualResult = day.a(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})