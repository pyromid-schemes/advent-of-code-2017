defmodule DaySevenSpec do
  use ESpec
  defp get_top(input) do
    Enum.join(input, "\n")
    |> AocElixir.DaySeven.PartOne.solve
  end

  it do: expect(get_top(["a (0) -> b", "b (10)"])).to eq("a")
  it do: expect(get_top(["b (10)", "a (0) -> b"])).to eq("a")
  it do
    input = [
      "a (0) -> b, c",
      "b (0) -> d",
      "c (0)",
      "d (0)",
      "e (0) -> a"
    ]
    expect(get_top(input)).to eq("e")
  end
end
