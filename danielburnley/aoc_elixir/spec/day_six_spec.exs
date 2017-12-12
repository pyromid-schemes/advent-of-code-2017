defmodule DaySixSpec do
  use ESpec

  it do: expect(AocElixir.DaySix.PartOne.solve("0\t2\t7\t0")).to eq(5)
  it do: expect(AocElixir.DaySix.PartTwo.solve("0\t2\t7\t0")).to eq(4)

end
