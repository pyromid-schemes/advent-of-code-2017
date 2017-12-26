defmodule AocElixir.DayNine do
  defmodule PartOne do
    def solve(input) do
      String.graphemes(input)
      |> execute
    end

    defp execute(input, value \\ 1, garbage \\ false)
    defp execute([], _, _), do: 0
    defp execute(["{"|rest], value, false), do: value + execute(rest, value + 1)
    defp execute(["}"|rest], value, false), do: execute(rest, value - 1)
    defp execute(["<"|rest], value, false), do: execute(rest, value, true)
    defp execute([">"|rest], value, true), do: execute(rest, value, false)
    defp execute(["!", _|rest], value, true), do: execute(rest, value, true)
    defp execute([_|rest], value, garbage), do: execute(rest, value, garbage)
  end

  defmodule PartTwo do
    def solve(input) do
      String.graphemes(input)
      |> execute
    end

    defp execute(input, garbage \\ false)
    defp execute([], _), do: 0
    defp execute(["<"|rest], false), do: execute(rest, true)
    defp execute([">"|rest], true), do: execute(rest, false)
    defp execute(["!", _|rest], true), do: execute(rest, true)
    defp execute([_|rest], true), do: 1 + execute(rest, true)
    defp execute([_|rest], false), do: execute(rest, false)
  end
end
