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

  defmodule PartTwo do

    def solve(input) do
      AocElixir.DayTwo.parse_input(input)
      |> calculate_checksum
    end


    defp calculate_divisors(_, []), do: :none
    defp calculate_divisors(num, [divisor|_rest]) when rem(num, divisor) == 0, do: num/divisor
    defp calculate_divisors(divisor, [num|_rest]) when rem(num, divisor) == 0, do: num/divisor
    defp calculate_divisors(num, [_|rest]), do: calculate_divisors(num, rest)

    defp get_checksum_for_line([first|rest]) do
      case calculate_divisors(first, rest) do
        :none -> get_checksum_for_line(rest)
        result -> result
      end
    end

    defp calculate_checksum([line]), do: get_checksum_for_line(line)
    defp calculate_checksum([line|rest]), do: get_checksum_for_line(line) + calculate_checksum(rest)

  end

end
