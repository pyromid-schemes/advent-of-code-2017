defmodule AocElixir.Helpers do
  def indexed_list_to_map(list, instructions \\ %{})
  def indexed_list_to_map([], instructions), do: instructions
  def indexed_list_to_map([{jump, index}|rest], instructions) do
    indexed_list_to_map(rest, Map.put(instructions, index, jump))
  end
end
