var expect    = require('chai').expect
var day = require('../day02').default

describe('day 2', () => {
  describe('part A', () => {
    it('input "5 1 9 5" should return 8', () => {
      const input = '5 1 9 5'
      const actualResult = day.a(input)
      const expectedResult = 8
      expect(actualResult).to.equal(expectedResult)    
    })
    it('input "7 5 3" should return 4', () => {
      const input = '7 5 3'
      const actualResult = day.a(input)
      const expectedResult = 4
      expect(actualResult).to.equal(expectedResult)    
    })
    it('input "2 4 6 8" should return 6', () => {
      const input = '2 4 6 8'
      const actualResult = day.a(input)
      const expectedResult = 6
      expect(actualResult).to.equal(expectedResult)    
    })
  })

  describe('part B', () => {
    it('input "5 9 2 8" should return 4', () => {
      const input = '5 9 2 8'
      const actualResult = day.b(input)
      const expectedResult = 4
      expect(actualResult).to.equal(expectedResult)    
    })
    it('input "9 4 7 3" should return 3', () => {
      const input = '9 4 7 3'
      const actualResult = day.b(input)
      const expectedResult = 3
      expect(actualResult).to.equal(expectedResult)    
    })
    it('input "3 8 6 5" should return 2', () => {
      const input = '3 8 6 5'
      const actualResult = day.b(input)
      const expectedResult = 2
      expect(actualResult).to.equal(expectedResult)    
    })
  })
})