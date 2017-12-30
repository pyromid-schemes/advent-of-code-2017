defmodule DayEighteenSpec do
  use ESpec

  def expect_part_one(input, expected) do
    expect(AocElixir.DayEighteen.PartOne.solve(input)).to eq(expected)
  end

  def expect_parsed_instructions(input, expected) do
    expect(AocElixir.DayEighteen.parse_instructions(input)).to eq(expected)
  end

  def expect_last_frequency({instruction, registers}, expected) do
    frequency_played = AocElixir.DayEighteen.play_sound(instruction, registers)
    expect(frequency_played).to eq(expected)
  end

  def expect_recovered({instruction, registers, last_frequency}, expected) do
    recovered = AocElixir.DayEighteen.recover_sound(instruction, registers, last_frequency)
    expect(recovered).to eq(expected)
  end

  def expect_registers({instruction, registers}, expected) do
    registers = AocElixir.DayEighteen.execute_instruction(instruction, registers)
    expect(registers).to eq(expected)
  end

  def expect_created_registers(instructions, expected) do
    registers = AocElixir.DayEighteen.setup_registers(instructions)
    expect(registers).to eq(expected)
  end

  def expect_pointer(value, jump, registers, pointer, expected) do
    updated_pointer = AocElixir.DayEighteen.execute_jump(value, jump, registers, pointer)
    expect(updated_pointer).to eq(expected)
  end

  context "play_sound" do
    it "with value", do: expect_last_frequency({10, %{}}, 10)
    it "with register", do: expect_last_frequency({"a", %{"a" => 10}}, 10)
  end

  context "recover_sound" do
    it "with 0 value", do: expect_recovered({0, %{}, 10}, 10)
    it "with register value of 0", do: expect_recovered({"a", %{"a" => 0}, 10}, 10)
    it "with register value non 0", do: expect_recovered({"a", %{"a" => 10}, 10}, nil)
  end

  context "execute_instruction" do
    context "set" do
      it "with value", do: expect_registers({{:set, "a", 10}, %{"a" => 0}}, %{"a" => 10})
      it "with register" do
        registers = %{"a" => 0, "b" => 10}
        expected_registers = %{"a" => 10, "b" => 10}
        expect_registers({{:set, "a", "b"}, registers}, expected_registers)
      end
    end

    context "add" do
      it "with value", do: expect_registers({{:add, "a", 10}, %{"a" => 10}}, %{"a" => 20})
      it "with register" do
        registers = %{"a" => 20, "b" => 10}
        expected_registers = %{"a" => 30, "b" => 10}
        expect_registers({{:add, "a", "b"}, registers}, expected_registers)
      end
    end

    context "mul" do
      it "with value", do: expect_registers({{:mul, "a", 10}, %{"a" => 10}}, %{"a" => 100})
      it "with register" do
        registers = %{"a" => 20, "b" => 10}
        expected_registers = %{"a" => 200, "b" => 10}
        expect_registers({{:mul, "a", "b"}, registers}, expected_registers)
      end
    end

    context "mod" do
      it "with value", do: expect_registers({{:mod, "a", 5}, %{"a" => 7}}, %{"a" => 2})
      it "with register" do
        registers = %{"a" => 7, "b" => 6}
        expected_registers = %{"a" => 1, "b" => 6}
        expect_registers({{:mod, "a", "b"}, registers}, expected_registers)
      end
    end
  end

  context "execute jump" do
    context "with value for check and jump" do
      it "with check < 0", do: expect_pointer(-10, 5, %{}, 5, 5)
      it "with check = 0", do: expect_pointer(0, 5, %{}, 5, 5)
      it "with check > 0", do: expect_pointer(10, 5, %{}, 5, 10)
    end
    context "with register for check and value for jump" do
      it "with check < 0", do: expect_pointer("a", 5, %{"a" => -10}, 5, 5)
      it "with check = 0", do: expect_pointer("a", 5, %{"a" => 0}, 5, 5)
      it "with check > 0", do: expect_pointer("a", 5, %{"a" => 10}, 5, 10)
    end
    context "with value for check and register for jump" do
      it "with check < 0", do: expect_pointer(-10, "a", %{"a" => 5}, 5, 5)
      it "with check = 0", do: expect_pointer(0, "a", %{"a" => 5}, 5, 5)
      it "with check > 0", do: expect_pointer(10, "a", %{"a" => 5}, 5, 10)
    end
    context "with register for check and jump" do
      it "with check < 0", do: expect_pointer("a", "b", %{"a" => -10, "b" => 5}, 5, 5)
      it "with check = 0", do: expect_pointer("a", "b", %{"a" => 0, "b" => 5}, 5, 5)
      it "with check > 0", do: expect_pointer("a", "b", %{"a" => 10, "b" => 5}, 5, 10)
    end
  end

  context "parse_instructions" do
    context "single instruction" do
      context "snd" do
        it "with value", do: expect_parsed_instructions(["snd 10"], [{:snd, 10}])
        it "with negative value", do: expect_parsed_instructions(["snd -10"], [{:snd, -10}])
        it "with register", do: expect_parsed_instructions(["snd a"], [{:snd, "a"}])
      end

      context "rcv" do
        it "with value", do: expect_parsed_instructions(["rcv 10"], [{:rcv, 10}])
        it "with negative value", do: expect_parsed_instructions(["rcv -10"], [{:rcv, -10}])
        it "with register", do: expect_parsed_instructions(["rcv a"], [{:rcv, "a"}])
      end

      context "set" do
        it "with value", do: expect_parsed_instructions(["set a 10"], [{:set, "a", 10}])
        it "with negative value", do: expect_parsed_instructions(["set a -10"], [{:set, "a", -10}])
        it "with register", do: expect_parsed_instructions(["set a b"], [{:set, "a", "b"}])
      end

      context "add" do
        it "with value", do: expect_parsed_instructions(["add a 10"], [{:add, "a", 10}])
        it "with negative value", do: expect_parsed_instructions(["add a -10"], [{:add, "a", -10}])
        it "with register", do: expect_parsed_instructions(["add a b"], [{:add, "a", "b"}])
      end

      context "mul" do
        it "with value", do: expect_parsed_instructions(["mul a 10"], [{:mul, "a", 10}])
        it "with negative value", do: expect_parsed_instructions(["mul a -10"], [{:mul, "a", -10}])
        it "with register", do: expect_parsed_instructions(["mul a b"], [{:mul, "a", "b"}])
      end

      context "mod" do
        it "with value", do: expect_parsed_instructions(["mod a 10"], [{:mod, "a", 10}])
        it "with negative value", do: expect_parsed_instructions(["mod a 10"], [{:mod, "a", 10}])
        it "with register", do: expect_parsed_instructions(["mod a b"], [{:mod, "a", "b"}])
      end

      context "jgz" do
        it "with values", do: expect_parsed_instructions(["jgz 1 10"], [{:jgz, 1, 10}])
        it "with negative values", do: expect_parsed_instructions(["jgz -1 -10"], [{:jgz, -1, -10}])
        it "with registers", do: expect_parsed_instructions(["jgz a b"], [{:jgz, "a", "b"}])
        it "with value & register", do: expect_parsed_instructions(["jgz 1 b"], [{:jgz, 1, "b"}])
        it "with register & value", do: expect_parsed_instructions(["jgz a 1"], [{:jgz, "a", 1}])
      end
    end
  end

  context "setup_registers" do
    context "with single instruction" do
      context "with single value" do
        it "with number", do: expect_created_registers([{:foo, 10}], %{})
        it "with register", do: expect_created_registers([{:foo, "a"}], %{"a" => 0})
      end
      context "with two values" do
        it "with numbers", do: expect_created_registers([{:foo, 10, 20}], %{})
        it "with registers", do: expect_created_registers([{:foo, "a", "b"}], %{"a" => 0, "b" => 0})
        it "with number & register", do: expect_created_registers([{:foo, 10, "a"}], %{"a" => 0})
        it "with register & number", do: expect_created_registers([{:foo, "b", 10}], %{"b" => 0})
      end
    end
    it "with multiple instructions" do
      instructions = [{:foo, "a"}, {:foo, "b", "c"}]
      expected_registers = %{"a" => 0, "b" => 0, "c" => 0}
      expect_created_registers(instructions, expected_registers)
    end
  end
end
