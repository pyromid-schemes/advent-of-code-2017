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

  defmodule PartTwo do
    def solve(input) do
      bottom = AocElixir.DaySeven.PartOne.solve(input)
      String.split(input, "\n", trim: true)
      |> execute(bottom)
    end

    defp extract_name(name_with_weight), do: hd(String.split(name_with_weight, " ", trim: true))
    defp extract_parents(parents), do: String.split(parents, ",", trim: true) |> Enum.map(&(String.trim(&1)))
    defp extract_name_and_weight(input) do
      Regex.run(~r/^(\w+)\s\((\d+)\)/, input, capture: :all_but_first)
    end

    defp get_weights(input, weights \\ %{})
    defp get_weights([], weights), do: weights
    defp get_weights([input|rest], weights) do
      [name, weight] = extract_name_and_weight(input)
      get_weights(rest, Map.put(weights, name, String.to_integer(weight)))
    end

    defp extract_relation([input]), do: {extract_name(input), []}
    defp extract_relation([name, parents]), do: {extract_name(name), extract_parents(parents)}

    defp get_relations(input, relations \\ %{})
    defp get_relations([], relations), do: relations
    defp get_relations([input|rest], relations) do
      {name, parents} = extract_relation(String.split(input, " -> "))
      get_relations(rest, Map.put(relations, name, parents))
    end

    defp calculate_weight(disc, weights, relations) do
      parent_weights = relations[disc]
      |> Enum.map(&(calculate_parents([&1], weights, relations)))
      |> List.flatten
      |> Enum.sum
      weights[disc] + parent_weights
    end

    defp calculate_parents([], _, _), do: []
    defp calculate_parents([disc|rest], weights, relations) do
      [calculate_weight(disc, weights, relations)] ++ calculate_parents(rest, weights, relations)
    end

    defp get_incorrect_column(parent_weights) do
      get_incorrect_column(parent_weights, parent_weights)
    end
    defp get_incorrect_column([weight|rest], parent_weights) do
      case Enum.count(parent_weights, &(&1 == weight)) do
        1 ->
          weight
        _ ->
          get_incorrect_column(rest, parent_weights)
      end
    end

    defp calculate_change(column_name, target_weight, weights, relations) do
      parents = calculate_parents(relations[column_name], weights, relations) |> Enum.sum
      target_weight - parents - weights[column_name]
    end

    defp is_top?(column_name, relations) do
      Enum.map(relations[column_name], fn(col) ->
        relations[col]
      end) |> List.flatten |> Enum.empty?
    end

    defp execute(input, bottom) do
      weights = get_weights(input)
      relations = get_relations(input)
      execute(bottom, weights, relations)
    end

    defp execute(bottom, weights, relations) do
      columns = relations[bottom]
      parent_weights = calculate_parents(columns, weights, relations)
      {column_name, weight} = get_incorrect_column(Enum.zip(columns, parent_weights))
      case is_top?(column_name, relations) do
        true ->
          [target_weight] = Enum.uniq(parent_weights) -- [weight]
          weights[column_name] + calculate_change(column_name, target_weight, weights, relations)
        false ->
          execute(column_name, weights, relations)
      end
    end

  end
end
