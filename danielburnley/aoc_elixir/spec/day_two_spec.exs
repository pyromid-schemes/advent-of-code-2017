defmodule DayTwoSpec do
  use ESpec
  defp min_max_checksum(input), do: AocElixir.DayTwo.PartOne.solve(input)

  it do: expect(min_max_checksum("1\t9")).to eq(8)
  it do: expect(min_max_checksum("1\t9\n1\t9")).to eq(16)
  it do: expect(min_max_checksum("1\t2\n3\t4")).to eq(2)

end
