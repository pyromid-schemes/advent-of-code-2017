defmodule AocElixir.DayEleven do

  def get_position(input, pos \\ {0,0,0})
  def get_position([], pos), do: pos
  def get_position(["n"|rest],  {x,y,z}), do: get_position(rest, {x  ,y+1,z-1})
  def get_position(["ne"|rest], {x,y,z}), do: get_position(rest, {x+1,y  ,z-1})
  def get_position(["se"|rest], {x,y,z}), do: get_position(rest, {x+1,y-1,z  })
  def get_position(["s"|rest],  {x,y,z}), do: get_position(rest, {x  ,y-1,z+1})
  def get_position(["sw"|rest], {x,y,z}), do: get_position(rest, {x-1,y  ,z+1})
  def get_position(["nw"|rest], {x,y,z}), do: get_position(rest, {x-1,y+1,z  })

  defmodule PartOne do
    def solve(input) do
      String.split(input, ",")
      |> AocElixir.DayEleven.get_position
      |> execute
    end

    defp execute({x,y,z}) do
      [x,y,z] |> Enum.map(&(abs(&1))) |> Enum.max
    end
  end

  defmodule PartTwo do
    def solve(_) do
    end
  end
end
