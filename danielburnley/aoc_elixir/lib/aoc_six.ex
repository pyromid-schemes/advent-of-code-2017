defmodule AocElixir.DaySix do
  defmodule PartOne do
    def solve(input) do
      String.split(input, "\t", trim: true)
      |> Enum.map(&(String.to_integer(&1)))
      |> Enum.with_index
      |> AocElixir.Helpers.indexed_list_to_map
      |> execute
    end

    defp execute(memory, history \\ [], count \\ 0) do
      case Enum.count(history, &(&1 == memory)) do
        0 ->
          rebalance_memory(memory)
          |> execute([memory|history], count+1)
        _ ->
          count
      end
    end

    defp rebalance_memory(memory) do
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
  end
end
