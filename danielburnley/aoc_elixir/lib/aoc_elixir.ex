defmodule AocElixir do
  def run do
    input = get_input(2017, 1)
    IO.puts "Day 1.1 - #{AocElixir.DayOne.solve(input)}"
  end

  defp get_input(year, day) do
    {:ok, input} = AdventOfCodeHelper.get_input(year, day)
    String.trim(to_string input)
  end
end
