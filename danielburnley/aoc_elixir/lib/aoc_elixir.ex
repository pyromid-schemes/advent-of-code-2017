defmodule AocElixir do
  def run do
    # input = get_input(2017, 1)
    # IO.puts "Day 1.1 - #{AocElixir.DayOne.PartOne.solve(input)}"
    # IO.puts "Day 1.2 - #{AocElixir.DayOne.PartTwo.solve(input)}"
    # input = get_input(2017, 2)
    # IO.puts "Day 2.1 - #{AocElixir.DayTwo.PartOne.solve(input)}"
    # IO.puts "Day 2.2 - #{AocElixir.DayTwo.PartTwo.solve(input)}"
    # input = get_input(2017, 4)
    # IO.puts "Day 4.1 - #{AocElixir.DayFour.PartOne.solve(input)}"
    # IO.puts "Day 4.2 - #{AocElixir.DayFour.PartTwo.solve(input)}"
    # input = get_input(2017, 5)
    # IO.puts "Day 5.1 - #{AocElixir.DayFive.PartOne.solve(input)}"
    # IO.puts "Day 5.2 - #{AocElixir.DayFive.PartTwo.solve(input)}"
    input = get_input(2017, 6)
    IO.puts "Day 6.1 - #{AocElixir.DaySix.PartOne.solve(input)}"
  end

  defp get_input(year, day) do
    {:ok, input} = AdventOfCodeHelper.get_input(year, day)
    String.trim(to_string input)
  end
end
