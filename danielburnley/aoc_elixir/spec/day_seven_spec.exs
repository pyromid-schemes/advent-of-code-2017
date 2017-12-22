defmodule DaySevenSpec do
  use ESpec
  defp get_top(input) do
    Enum.join(input, "\n")
    |> AocElixir.DaySeven.PartOne.solve
  end

  defp get_weight(input) do
    Enum.join(input, "\n")
    |> AocElixir.DaySeven.PartTwo.solve
  end

  defp acceptance_input do
    [
      "pbga (66)", "xhth (57)", "ebii (61)", "havc (66)", "ktlj (57)",
      "fwft (72) -> ktlj, cntj, xhth", "qoyq (66)", "padx (45) -> pbga, havc, qoyq",
      "tknk (41) -> ugml, padx, fwft", "jptl (61)", "ugml (68) -> gyxo, ebii, jptl",
      "gyxo (61)", "cntj (57)"
    ]
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
  it do: expect(get_top(acceptance_input())).to eq("tknk")

  defp get_input(year, day) do
    {:ok, input} = AdventOfCodeHelper.get_input(year, day)
    String.trim(to_string input)
  end

  it do
    input = get_input(2017, 7) |> String.split("\n", trim: true)
    expect(get_weight(input)).to eq(1993)
  end
  it do: expect(get_weight(acceptance_input())).to eq(60)
end
