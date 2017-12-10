require IEx

defmodule AocElixir.DayFive do
  defmodule PartOne do
    def solve(input) do
      String.split(input, "\n", trim: true)
      |> Enum.map(&(String.to_integer(&1)))
      |> Enum.with_index
      |> instructions_to_map
      |> execute
    end

    defp instructions_to_map(list, instructions \\ %{})
    defp instructions_to_map([], instructions), do: instructions
    defp instructions_to_map([{jump, index}|rest], instructions) do
      instructions_to_map(rest, Map.put(instructions, index, jump))
    end

    defp execute(instructions, current \\ 0, count \\ 0)
    defp execute(instructions, current, count) when current >= map_size(instructions), do: count
    defp execute(instructions, current, count) do
      jump = instructions[current]
      execute(%{instructions|current => jump + 1}, current + jump, count + 1)
    end
  end
end
