require IEx

defmodule AocElixir.DayFour do

  def execute([]), do: 0
  def execute([list|rest]) do
    case contains_duplicates?(list) do
      true ->
        execute(rest)
      false ->
        1 + execute(rest)
    end
  end

  defp contains_duplicates?(list) do
    Enum.uniq(list)
    |> contains_duplicates?(list)
  end
  defp contains_duplicates?(list, list), do: false
  defp contains_duplicates?(_, _), do: true

  defmodule PartOne do
    def solve(input) do
      String.split(input, "\n", trim: true)
      |> Enum.map(&(String.split(&1, " ", trim: true)))
      |> AocElixir.DayFour.execute
    end
  end

  defmodule PartTwo do
    def solve(input) do
      String.split(input, "\n", trim: true)
      |> Enum.map(&(split_string_and_alphabetise(&1)))
      |> AocElixir.DayFour.execute
    end

    defp split_string_and_alphabetise(input) do
      String.split(input, " ", trim: true)
      |> Enum.map(&(alphabetise(&1)))
    end

    defp alphabetise(word) do
      String.split(word, "", trim: true)
      |> Enum.sort
      |> Enum.join
    end
  end
end
