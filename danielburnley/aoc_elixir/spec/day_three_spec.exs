defmodule DayThreeSpec do
  use ESpec

  def get_distance(input), do: AocElixir.DayThree.PartOne.solve(input)

  it do: expect(get_distance("361527")).to eq(326)
end
