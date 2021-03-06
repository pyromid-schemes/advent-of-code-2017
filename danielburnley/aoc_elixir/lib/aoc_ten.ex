defmodule AocElixir.DayTen do
  def execute_round(inputs, marks \\ AocElixir.DayTen.initial_marks(), position \\ 0, skip \\ 0)
  def execute_round([], marks, position, skip), do: {marks, position, skip}
  def execute_round([input|rest], marks, position, skip) do
    marks = AocElixir.DayTen.twist_knot(marks, position, input)
    new_position = rem(position + input + skip, length(marks))
    execute_round(rest, marks, new_position, skip + 1)
  end

  def initial_marks, do: (for n <- 0..255, do: n)

  def twist_knot(marks, position, amount) when position + amount > length(marks) do
    {middle, last} = Enum.split(marks, position)
    {first, middle} = Enum.split(middle, rem(position + amount, length(marks)))
    {last, first} = last ++ first
    |> Enum.reverse
    |> Enum.split(length(last))
    first ++ middle ++ last
  end
  def twist_knot(marks, position, amount), do: Enum.reverse_slice(marks, position, amount)

  defmodule PartOne do
    def solve(input) do
      String.split(input, ",")
      |> Enum.map(&(String.to_integer &1))
      |> execute
    end

    defp execute(input) do
      {[first, second|_], _, _} = AocElixir.DayTen.execute_round(input)
      first * second
    end
  end

  defmodule PartTwo do
    use Bitwise

    def solve(input) do
      String.to_charlist(input)
      |> Enum.concat([17,31,73,47,23])
      |> execute
    end

    def dense_hash(input) do
      Enum.chunk_every(input, 16)
      |> Enum.map(fn list ->
        Enum.reduce(list, fn x, acc -> x ^^^ acc end)
      end)
    end

    def hash_string(input) do
      Enum.map(input, fn num ->
        Integer.to_string(num, 16)
        |> String.pad_leading(2, "0")
      end)
      |> Enum.join("")
      |> String.downcase
    end

    defp execute(input, remaining_rounds \\ 64, marks \\ AocElixir.DayTen.initial_marks, pos \\ 0, skip \\ 0)
    defp execute(input, 1, marks, pos, skip) do
      {result,_,_} = AocElixir.DayTen.execute_round(input, marks, pos, skip)
      dense_hash(result)
      |> hash_string
    end
    defp execute(input, remaining_rounds, marks, pos, skip) do
      {marks, pos, skip} = AocElixir.DayTen.execute_round(input, marks, pos, skip)
      execute(input, remaining_rounds - 1, marks, pos, skip)
    end
  end
end
