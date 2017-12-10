defmodule DayFiveSpec do
  use ESpec

  def get_jumps(input), do: AocElixir.DayFive.PartOne.solve(input)

  it do: expect(get_jumps "1").to eq(1)
  it do: expect(get_jumps "0").to eq(2)
  it do: expect(get_jumps "1\n1").to eq(2)
  it do: expect(get_jumps "0\n3\n0\n1\n-3").to eq(5)

end
