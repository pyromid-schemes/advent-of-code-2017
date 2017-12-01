defmodule AocElixir.DayOne do
  defmodule PartOne do
    def solve(input) do
      String.split(input, "", trim: true)
      |> Enum.map(&(String.to_integer(&1)))
      |> execute
    end

    defp execute([]), do: 0
    defp execute([_]), do: 0
    defp execute([a, b]), do: calculate_ends(a, b)
    defp execute(input) do
      calculate(input) + calculate_ends(List.first(input), List.last(input))
    end

    defp calculate_ends(num, num), do: num
    defp calculate_ends(_, _), do: 0

    defp calculate([]), do: 0
    defp calculate([_]), do: 0
    defp calculate([num,num|rest]), do: num + calculate([num|rest])
    defp calculate([_|rest]), do: calculate(rest)
  end

  defmodule PartTwo do
    def solve(input) do
      String.split(input, "", trim: true)
      |> Enum.map(&(String.to_integer(&1)))
      |> split_list
      |> execute
    end

    defp split_list([]), do: [[],[]]
    defp split_list(input) do
      Enum.chunk_every(input, (round(length(input)/2)))
    end

    defp execute([[], []]), do: 0
    defp execute([first, second]) do
      calculate(first, second) * 2
    end

    defp calculate([], []), do: 0
    defp calculate([num|first], [num|second]), do: num + calculate(first, second)
    defp calculate([_|first], [_|second]), do: calculate(first, second)
  end
end
