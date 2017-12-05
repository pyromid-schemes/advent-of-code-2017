defmodule DayFourSpec do
  use ESpec

  it do: expect(AocElixir.DayFour.PartOne.solve("aa aa")).to eq(0)
  it do: expect(AocElixir.DayFour.PartOne.solve("aa bb")).to eq(1)
  it do: expect(AocElixir.DayFour.PartOne.solve("aa bb\naa bb")).to eq(2)
  it do: expect(AocElixir.DayFour.PartOne.solve("aa bb cc")).to eq(1)
  it do: expect(AocElixir.DayFour.PartOne.solve("aa bb aa")).to eq(0)

  it do: expect(AocElixir.DayFour.PartTwo.solve("ab ba")).to eq(0)
end
