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

  describe('part B', () => {
    const tests = [
      { input: 'abcde fghij', expectedResult: 1 },
      { input: 'abcde xyz ecdab', expectedResult: 0 },
      { input: 'a ab abc abd abf abj', expectedResult: 1 },
      { input: 'iiii oiii ooii oooi oooo', expectedResult: 1 },
      { input: 'oiii ioii iioi iiio', expectedResult: 0 }

    ]

    tests.map(t => {
      it(`input '${t.input}' should return ${t.expectedResult}`, () => {
        const actualResult = day.b(t.input)
        expect(actualResult).to.equal(t.expectedResult)    
      })
    })
  })
})