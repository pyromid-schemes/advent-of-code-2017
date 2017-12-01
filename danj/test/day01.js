var expect    = require('chai').expect
var day01 = require('../day01').default

describe('day 1', () => {
  describe('part A', () => {
    it('input 1122 should return 3', () => {
      const input = '1122'
      const actualResult = day01.a(input)
      const expectedResult = 3
      expect(actualResult).to.equal(expectedResult)    
    })

    it('input 1111 should return 4', () => {
      const input = '1111'
      const actualResult = day01.a(input)
      const expectedResult = 4
      expect(actualResult).to.equal(expectedResult)    
    })

    it('1234 should return 0', () => {
      const input = '1234'
      const actualResult = day01.a(input)
      const expectedResult = 0
      expect(actualResult).to.equal(expectedResult)    
    })
        
    it('91212129 should return 9', () => {
      const input = '91212129'
      const actualResult = day01.a(input)
      const expectedResult = 9
      expect(actualResult).to.equal(expectedResult)    
    })
  })

  describe('part B', () => {
    it('input 1212 should return 6', () => {
      const input = '1212'
      const actualResult = day01.b(input)
      const expectedResult = 6
      expect(actualResult).to.equal(expectedResult)    
    })

    it('input 1221 should return 0', () => {
      const input = '1221'
      const actualResult = day01.b(input)
      const expectedResult = 0
      expect(actualResult).to.equal(expectedResult)    
    })

    it('input 123425 should return 4', () => {
      const input = '123425'
      const actualResult = day01.b(input)
      const expectedResult = 4
      expect(actualResult).to.equal(expectedResult)    
    })
    
    it('input 123123 should return 12', () => {
      const input = '123123'
      const actualResult = day01.b(input)
      const expectedResult = 12
      expect(actualResult).to.equal(expectedResult)    
    })
    
    it('input 12131415 should return 4', () => {
      const input = '12131415'
      const actualResult = day01.b(input)
      const expectedResult = 4
      expect(actualResult).to.equal(expectedResult)    
    })
  })
})