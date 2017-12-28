defmodule AocElixir.DayTen do
  def twist_knot(marks, _, amount) when amount < 2, do: marks
  def twist_knot(marks, 0, amount) do
    {first, second} = Enum.split(marks, amount)
    Enum.reverse(first) ++ second
  end
  def twist_knot(marks, position, amount) when position + amount > length(marks) do
    {middle, last} = Enum.split(marks, position)
    {first, middle} = Enum.split(middle, rem(position + amount, length(marks)))
    {last, first} = last ++ first
    |> Enum.reverse
    |> Enum.split(length(last))
    first ++ middle ++ last
  end
  def twist_knot(marks, position, amount) do
    {first, second} = Enum.split(marks, position)
    {to_reverse, rest} = Enum.split(second, amount)
    first ++ Enum.reverse(to_reverse) ++ rest
  end

  defmodule PartOne do
    def solve(input) do
      String.split(input, ",")
      |> Enum.map(&(String.to_integer &1))
      |> execute
    end

    def initial_marks, do: (for n <- 0..255, do: n)

    defp execute(inputs, marks \\ initial_marks(), position \\ 0, skip \\ 0)
    defp execute([], marks, _, _) do
      [first, second|_] = marks
      first * second
    end
    defp execute([input|rest], marks, position, skip) do
      marks = AocElixir.DayTen.twist_knot(marks, position, input)
      new_position = rem(position + input + skip, 256)
      execute(rest, marks, new_position, skip + 1)
    end
  end

  defmodule PartTwo do
    def solve(_) do
    end
  end
end
