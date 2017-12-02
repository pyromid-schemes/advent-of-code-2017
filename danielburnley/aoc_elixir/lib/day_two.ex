defmodule AocElixir.DayTwo do

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&(String.split(&1, "\t", trim: true)))
    |> Enum.map(&(list_to_int(&1)))
  end

  defp list_to_int(input), do: Enum.map(input, &(String.to_integer(&1)))

  defmodule PartOne do

    def solve(input) do
      AocElixir.DayTwo.parse_input(input)
      |> calculate_checksum
    end

    defp calculate_difference({min, max}), do: max - min

    defp calculate_checksum([line]), do: calculate_difference(Enum.min_max(line))
    defp calculate_checksum([line|rest]), do: calculate_difference(Enum.min_max(line)) + calculate_checksum(rest)

  end

end
