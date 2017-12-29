defmodule AocElixir.DayEleven do

  def get_position(input, pos \\ {0,0,0})
  def get_position([], pos), do: pos
  def get_position(["n"|rest],  {x,y,z}), do: get_position(rest, {x  ,y+1,z-1})
  def get_position(["ne"|rest], {x,y,z}), do: get_position(rest, {x+1,y  ,z-1})
  def get_position(["se"|rest], {x,y,z}), do: get_position(rest, {x+1,y-1,z  })
  def get_position(["s"|rest],  {x,y,z}), do: get_position(rest, {x  ,y-1,z+1})
  def get_position(["sw"|rest], {x,y,z}), do: get_position(rest, {x-1,y  ,z+1})
  def get_position(["nw"|rest], {x,y,z}), do: get_position(rest, {x-1,y+1,z  })

  def get_distance({x,y,z}), do: [x,y,z] |> Enum.map(&(abs(&1))) |> Enum.max

  defmodule PartOne do
    def solve(input) do
      String.split(input, ",")
      |> AocElixir.DayEleven.get_position
      |> AocElixir.DayEleven.get_distance
    end
  end

  defmodule PartTwo do
    def solve(input) do
      String.split(input, ",")
      |> execute
    end

    def execute(input, position \\ {0,0,0}, largest_distance \\ 0)
    def execute([], _, largest_distance), do: largest_distance
    def execute([move|rest], position, largest_distance) do
      position = AocElixir.DayEleven.get_position([move], position)
      distance = AocElixir.DayEleven.get_distance(position)
      case distance > largest_distance do
        true ->
          execute(rest, position, distance)
        false ->
          execute(rest, position, largest_distance)
      end
    end
  end
end
