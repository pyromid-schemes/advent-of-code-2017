defmodule AocElixir.DaySeventeen do

  def insert_value([0], _, _, _), do: {[0,1], 1}
  def insert_value(buffer, steps, value, pos) do
    insert_location = rem(pos + steps, length(buffer)) + 1
    {List.insert_at(buffer, insert_location, value), insert_location}
  end

  defmodule PartOne do
    def solve(input) do
      execute(String.to_integer(input))
    end

    def execute(steps, buffer \\ [0], value \\ 1, pos \\ 0)
    def execute(steps, buffer, 2017, pos) do
      {buffer, pos} = AocElixir.DaySeventeen.insert_value(buffer, steps, 2017, pos)
      Enum.at(buffer, pos + 1)
    end
    def execute(steps, buffer, value, pos) do
      {buffer, pos} = AocElixir.DaySeventeen.insert_value(buffer, steps, value, pos)
      execute(steps, buffer, value + 1, pos)
    end
  end

  defmodule PartTwo do
    def solve(input) do
      execute(String.to_integer(input))
    end

    def execute(steps, buffer_length \\ 1, value \\ 1, pos \\ 0, ans \\ 0)
    def execute(_, _, 50000001, _, ans), do: ans
    def execute(steps, buffer_length, value, pos, ans) do
      next = rem(pos + steps, buffer_length) + 1
      case next == 1 do
        true ->
          execute(steps, buffer_length + 1, value + 1, next, value)
        false ->
          execute(steps, buffer_length + 1, value + 1, next, ans)
      end
    end
  end
end
