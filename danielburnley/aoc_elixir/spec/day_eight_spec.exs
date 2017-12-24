defmodule DayEightSpec do
  use ESpec

  def parse_instructions(input), do: AocElixir.DayEight.parse_instructions(input)

  context "parsing" do
    it "increment" do
      expect(parse_instructions(["a inc 1 if a > 1"])).to eq([{{:inc, "a", 1}, {:gt, "a", 1}}])
    end
    it "decrement" do
      expect(parse_instructions(["a dec 1 if a > 1"])).to eq([{{:dec, "a", 1}, {:gt, "a", 1}}])
    end
    it "greater than" do
      expect(parse_instructions(["a inc 1 if a > 1"])).to eq([{{:inc, "a", 1}, {:gt, "a", 1}}])
    end
    it "greater or equal to" do
      expect(parse_instructions(["a inc 1 if a >= 1"])).to eq([{{:inc, "a", 1}, {:gte, "a", 1}}])
    end
    it "less than" do
      expect(parse_instructions(["a inc 1 if a < 1"])).to eq([{{:inc, "a", 1}, {:lt, "a", 1}}])
    end
    it "less or equal to" do
      expect(parse_instructions(["a inc 1 if a <= 1"])).to eq([{{:inc, "a", 1}, {:lte, "a", 1}}])
    end
    it "equal to" do
      expect(parse_instructions(["a inc 1 if a == 1"])).to eq([{{:inc, "a", 1}, {:eq, "a", 1}}])
    end
    it "not equal to" do
      expect(parse_instructions(["a inc 1 if a != 1"])).to eq([{{:inc, "a", 1}, {:neq, "a", 1}}])
    end
    it "negative numbers" do
      expect(parse_instructions(["a inc -10 if a > -10"])).to eq([{{:inc, "a", -10}, {:gt, "a", -10}}])
    end
    it "multiple instructions" do
      input = [
        "a inc 1 if a < 1",
        "a dec 1 if a < 1"
      ]
      expected = [
        {{:inc, "a", 1}, {:lt, "a", 1}},
        {{:dec, "a", 1}, {:lt, "a", 1}}
      ]

      expect(parse_instructions(input)).to eq(expected)
    end
  end

  context "part one" do
    def run(input) do
      Enum.join(input, "\n")
      |> AocElixir.DayEight.PartOne.solve
    end

    it "acceptance" do
      input = [
        "b inc 5 if a > 1",
        "a inc 1 if b < 5",
        "c dec -10 if a >= 1",
        "c inc -20 if c == 10"
      ]
      expect(run(input)).to eq(1)
    end

    it do: expect(run(["a inc 1 if b == 0"])).to eq(1)
    it do: expect(run(["a inc 1 if b != 0"])).to eq(0)
    it do: expect(run(["a inc 1 if b < 0"])).to eq(0)
    it do: expect(run(["a inc 1 if b < 1"])).to eq(1)
    it do: expect(run(["a inc 1 if b <= 0"])).to eq(1)
    it do: expect(run(["a inc 1 if b > 0"])).to eq(0)
    it do: expect(run(["a inc 1 if b > -1"])).to eq(1)
    it do: expect(run(["a inc 1 if b >= 0"])).to eq(1)
    it do: expect(run(["a inc 10 if b == 0"])).to eq(10)
    it do: expect(run(["a dec 10 if b == 0"])).to eq(0)
    it do
      input = [
        "a inc 10 if b == 0",
        "a inc 10 if b == 0"
      ]
      expect(run(input)).to eq(20)
    end
  end
end
