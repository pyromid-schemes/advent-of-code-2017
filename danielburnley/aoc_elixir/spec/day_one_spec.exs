defmodule DayOneSpec do
  use ESpec

  it do: expect(AocElixir.DayOne.solve("")).to eq(0)
  it do: expect(AocElixir.DayOne.solve("1")).to eq(0)
  it do: expect(AocElixir.DayOne.solve("11")).to eq(1)
  it do: expect(AocElixir.DayOne.solve("22")).to eq(2)
  it do: expect(AocElixir.DayOne.solve("1122")).to eq(3)
  it do: expect(AocElixir.DayOne.solve("1111")).to eq(4)
  it do: expect(AocElixir.DayOne.solve("1234")).to eq(0)
  it do: expect(AocElixir.DayOne.solve("1231")).to eq(1)

end
