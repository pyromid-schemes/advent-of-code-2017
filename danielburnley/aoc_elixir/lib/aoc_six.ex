defmodule AocElixir.DaySix do
  def prepare_input(input) do
    String.split(input, "\t", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.with_index
    |> AocElixir.Helpers.indexed_list_to_map
  end

  def rebalance_memory(memory) do
    {index, value} = max_memory_value(memory)
    rebalance_memory(%{memory| index => 0}, value, index + 1)
  end
  defp rebalance_memory(memory, 0, _), do: memory
  defp rebalance_memory(memory, value, index) when index >= map_size(memory) do
    rebalance_memory(%{memory| 0 => memory[0] + 1}, value - 1, 1)
  end
  defp rebalance_memory(memory, value, index) do
    rebalance_memory(%{memory| index => memory[index] + 1}, value - 1, index + 1)
  end

  defp max_memory_value(memory), do: Map.to_list(memory) |> max_memory_value({-1, -1})
  defp max_memory_value([], max_values), do: max_values
  defp max_memory_value([{index, value}|rest], {_, max_value}) when max_value < value, do: max_memory_value(rest, {index, value})
  defp max_memory_value([_|rest], max_values), do: max_memory_value(rest, max_values)

  defmodule PartOne do
    def solve(input) do
      AocElixir.DaySix.prepare_input(input)
      |> execute
    end

    defp execute(memory, history \\ [], count \\ 0) do
      case Enum.count(history, &(&1 == memory)) do
        0 ->
          AocElixir.DaySix.rebalance_memory(memory)
          |> execute([memory|history], count+1)
        _ ->
          count
      end
    end
  end

  defmodule PartTwo do
    def solve(input) do
      AocElixir.DaySix.prepare_input(input)
      |> get_repeated_pattern(3156)
      |> execute
    end

    defp execute(input), do: execute(AocElixir.DaySix.rebalance_memory(input), input, 1)
    defp execute(memory, memory, count), do: count
    defp execute(input, pattern_to_match, count), do: execute(AocElixir.DaySix.rebalance_memory(input), pattern_to_match, count + 1)

    defp get_repeated_pattern(input, 0), do: input
    defp get_repeated_pattern(input, count), do: get_repeated_pattern(AocElixir.DaySix.rebalance_memory(input), count - 1)
  end
end
