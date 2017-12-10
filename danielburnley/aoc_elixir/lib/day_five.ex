require IEx

defmodule AocElixir.DayFive do
  def solve(input, func) do
    parse_input(input)
    |> execute(func)
  end

  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.with_index
    |> instructions_to_map
  end

  defp instructions_to_map(list, instructions \\ %{})
  defp instructions_to_map([], instructions), do: instructions
  defp instructions_to_map([{jump, index}|rest], instructions) do
    instructions_to_map(rest, Map.put(instructions, index, jump))
  end

  defp execute(instructions, func, current \\ 0, count \\ 0)
  defp execute(instructions, _, current, count) when current >= map_size(instructions), do: count
  defp execute(instructions, func, current, count) do
    jump = instructions[current]
    func.(instructions, current, jump)
    |> execute(func, current + jump, count + 1 )
  end

  defmodule PartOne do
    def solve(input) do
      AocElixir.DayFive.solve(input, fn(a, b, c) -> update_map(a,b,c) end)
    end

    defp update_map(instructions, current, jump), do: %{instructions|current => jump + 1}
  end

  defmodule PartTwo do
    def solve(input) do
      AocElixir.DayFive.solve(input, fn(a, b, c) -> update_map(a,b,c) end)
    end

    defp update_map(instructions, current, jump) when jump < 3, do: %{instructions|current => jump + 1}
    defp update_map(instructions, current, jump), do: %{instructions|current => jump - 1}
  end
end
