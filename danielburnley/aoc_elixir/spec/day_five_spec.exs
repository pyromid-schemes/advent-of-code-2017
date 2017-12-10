defmodule DayFiveSpec do
  use ESpec

  def get_jumps(input), do: AocElixir.DayFive.PartOne.solve(input)
  def get_jumps_two(input), do: AocElixir.DayFive.PartTwo.solve(input)

  it do: expect(get_jumps "1").to eq(1)
  it do: expect(get_jumps "0").to eq(2)
  it do: expect(get_jumps "1\n1").to eq(2)
  it do: expect(get_jumps "0\n3\n0\n1\n-3").to eq(5)

  it do: expect(get_jumps_two "1").to eq(1)
  it do: expect(get_jumps_two "0").to eq(2)
  it do: expect(get_jumps_two "1\n1").to eq(2)
  it do: expect(get_jumps_two "0\n3\n0\n1\n-3").to eq(10)

end
