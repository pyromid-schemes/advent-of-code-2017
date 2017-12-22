defmodule AocElixir.DaySeven do
  defmodule PartOne do
    def solve(input) do
      String.split(input, "\n", trim: true)
      |> execute
    end

    defp extract_name(name_with_weight), do: [hd(String.split(name_with_weight, " ", trim: true))]
    defp extract_parents(parents), do: String.split(parents, ",", trim: true) |> Enum.map(&(String.trim(&1)))

    defp update_children_and_parents([name_with_weight], children, parents) do
      {children ++ extract_name(name_with_weight), parents}
    end
    defp update_children_and_parents([name_with_weight, parent_list], children, parents) do
      {children ++ extract_name(name_with_weight), parents ++ extract_parents(parent_list)}
    end

    defp execute(input, children \\ [], parents \\ [])
    defp execute([], children, parents) do
      [bottom] = children -- parents
      bottom
    end
    defp execute([relation|rest], children, parents) do
      {children, parents} = update_children_and_parents(String.split(relation, " -> ", trim: true), children, parents)
      execute(rest, children, parents)
    end
  end
end
