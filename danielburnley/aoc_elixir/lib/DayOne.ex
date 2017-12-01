defmodule AocElixir.DayOne do
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
