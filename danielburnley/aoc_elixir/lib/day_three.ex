defmodule AocElixir.DayThree do
  defmodule PartOne do
    def solve(input) do
      String.to_integer(input)
      |> calculate_distance
    end

    def calculate_distance(start) do
      closest_corner_sqrt = get_closest_corner_square(start)
      difference_in_squares = get_difference_in_squares(start, closest_corner_sqrt)
      side_length = closest_corner_sqrt - 1
      position_along_side = get_position_along_side(difference_in_squares, closest_corner_sqrt-1)
      abs(position_along_side - (side_length/2)) + (side_length/2)
      |> round
    end

    defp get_closest_corner_square(cell) do
      :math.sqrt(cell)
      |> Float.floor
      |> round
      |> get_closest_odd_square
    end

    defp get_closest_odd_square(sqrt) when rem(sqrt, 2) == 0, do: sqrt + 1
    defp get_closest_odd_square(sqrt) when rem(sqrt, 2) == 1, do: sqrt + 2

    defp get_difference_in_squares(start, closest_corner_sqrt) do
      :math.pow(closest_corner_sqrt, 2) - start
      |> round
    end

    defp get_position_along_side(difference, side_length) when difference > side_length do
      get_position_along_side(difference - side_length, side_length)
    end
    defp get_position_along_side(difference, _), do: difference

  end
end
