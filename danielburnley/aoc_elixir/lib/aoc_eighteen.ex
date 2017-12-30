defmodule AocElixir.DayEighteen do

  defp get_value(value, registers) do
    case Map.has_key?(registers, value) do
      true  -> registers[value]
      false -> value
    end
  end

  defp get_recovery_value(value, registers, last_played) do
    case get_value(value, registers) == 0 do
      true -> last_played
      false -> nil
    end
  end

  def execute_instruction({:set, register, value}, registers), do: Map.put(registers, register, get_value(value, registers))
  def execute_instruction({:add, register, value}, registers) do
    updated_value = get_value(register, registers) + get_value(value, registers)
    Map.put(registers, register, updated_value)
  end
  def execute_instruction({:mul, register, value}, registers) do
    updated_value = get_value(register, registers) * get_value(value, registers)
    Map.put(registers, register, updated_value)
  end
  def execute_instruction({:mod, register, value}, registers) do
    updated_value = rem(get_value(register, registers), get_value(value, registers))
    Map.put(registers, register, updated_value)
  end

  def execute_jump(value, jump, registers, pointer) do
    case get_value(value, registers) > 0 do
      true -> pointer + get_value(jump, registers)
      false -> pointer
    end
  end

  defp extract_single_value(value) do
    case Integer.parse(value) do
      :error -> value
      {value, _} -> value
    end
  end

  defp extract_double_value_instruction(instruction, values) do
    [[a, b]] = Regex.scan(~r/(\S+) (\S+)/, values, capture: :all_but_first)
    {instruction, extract_single_value(a), extract_single_value(b)}
  end

  def parse_instructions([]), do: []
  def parse_instructions(["snd "<> value|rest]), do: [{:snd, extract_single_value(value)}| parse_instructions(rest)]
  def parse_instructions(["rcv "<> value|rest]), do: [{:rcv, extract_single_value(value)}| parse_instructions(rest)]
  def parse_instructions(["set "<> values|rest]), do: [extract_double_value_instruction(:set, values)| parse_instructions(rest)]
  def parse_instructions(["add "<> values|rest]), do: [extract_double_value_instruction(:add, values)| parse_instructions(rest)]
  def parse_instructions(["mul "<> values|rest]), do: [extract_double_value_instruction(:mul, values)| parse_instructions(rest)]
  def parse_instructions(["mod "<> values|rest]), do: [extract_double_value_instruction(:mod, values)| parse_instructions(rest)]
  def parse_instructions(["jgz "<> values|rest]), do: [extract_double_value_instruction(:jgz, values)| parse_instructions(rest)]

  def play_sound(value, registers), do: get_value(value, registers)

  def recover_sound(value, registers, last_played), do: get_recovery_value(value, registers, last_played)

  defp setup_register_for_value(value, registers) do
    case is_number(value) do
      true  -> registers
      false -> Map.put(registers, value, 0)
    end
  end
  def setup_registers(instructions, registers \\ %{})
  def setup_registers([], registers), do: registers
  def setup_registers([{_, value}|rest], registers), do: setup_registers(rest, setup_register_for_value(value, registers))
  def setup_registers([{_, first, second}|rest], registers) do
    registers = setup_register_for_value(first, registers)
    registers = setup_register_for_value(second, registers)
    setup_registers(rest, registers)
  end

  defmodule PartOne do
    def solve(_) do
    end
  end

  defmodule PartTwo do
    def solve(_) do
    end
  end
end
