defmodule AocElixir.DayEight do
  def parse_instructions([]), do: []
  def parse_instructions([instruction|rest]) do
    [increment, condition] = String.split(instruction, " if ")
    [{parse_increment(increment), parse_condition(condition)}|parse_instructions(rest)]
  end

  defp parse_increment([register, "dec", amount]), do: {:dec, register, String.to_integer(amount)}
  defp parse_increment([register, "inc", amount]), do: {:inc, register, String.to_integer(amount)}
  defp parse_increment(increment) do
    Regex.run(~r/(\w+) (inc|dec) (-?\d+)/, increment, capture: :all_but_first)
    |> parse_increment
  end

  defp parse_condition([register, ">", amount]),  do: {:gt, register, String.to_integer(amount)}
  defp parse_condition([register, ">=", amount]), do: {:gte, register, String.to_integer(amount)}
  defp parse_condition([register, "<", amount]),  do: {:lt, register, String.to_integer(amount)}
  defp parse_condition([register, "<=", amount]), do: {:lte, register, String.to_integer(amount)}
  defp parse_condition([register, "==", amount]), do: {:eq, register, String.to_integer(amount)}
  defp parse_condition([register, "!=", amount]), do: {:neq, register, String.to_integer(amount)}
  defp parse_condition(condition) do
    Regex.run(~r/(\w+) (\S+) (-?\d+)/, condition, capture: :all_but_first)
    |> parse_condition
  end

  defmodule PartOne do
    def solve(input) do
      String.split(input, "\n")
      |> AocElixir.DayEight.parse_instructions
      |> execute
    end

    defp condition_met?({:eq, register, amount}, registers),  do: registers[register] == amount
    defp condition_met?({:neq, register, amount}, registers), do: registers[register] != amount
    defp condition_met?({:lt, register, amount}, registers),  do: registers[register] <  amount
    defp condition_met?({:lte, register, amount}, registers), do: registers[register] <= amount
    defp condition_met?({:gt, register, amount}, registers),  do: registers[register] >  amount
    defp condition_met?({:gte, register, amount}, registers), do: registers[register] >= amount

    defp increment_register({:inc, register, amount}, registers) do
      %{registers|register => registers[register] + amount}
    end
    defp increment_register({:dec, register, amount}, registers) do
      %{registers|register => registers[register] - amount}
    end

    defp init_registers(instructions, registers \\ %{})
    defp init_registers([], registers), do: registers
    defp init_registers([{{_, first, _},{_, second, _}}|rest], registers) do
      registers = Map.put(registers, first, 0)
      |> Map.put(second, 0)
      init_registers(rest, registers)
    end

    defp execute(instructions), do: execute(instructions, init_registers(instructions))
    defp execute([], registers), do: Map.values(registers) |> Enum.max
    defp execute([{increment, condition}|rest], registers) do
      case condition_met?(condition, registers) do
        true ->
          registers = increment_register(increment, registers)
          execute(rest, registers)
        false ->
          execute(rest, registers)
      end
    end
  end
end
