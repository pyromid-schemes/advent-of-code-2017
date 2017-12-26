defmodule DayNineSpec do
  use ESpec

  def expect_count(input, expected) do
    expect(AocElixir.DayNine.PartOne.solve(input)).to eq(expected)
  end

  def expect_garbage_count(input, expected) do
    expect(AocElixir.DayNine.PartTwo.solve(input)).to eq(expected)
  end

  context "part one" do
    it "acceptance" do
      expect_count("{}", 1)
      expect_count("{{{}}}", 6)
      expect_count("{{},{}}", 5)
      expect_count("{{{},{},{{}}}}", 16)
      expect_count("{<{},{},{{}}>}", 1)
      expect_count("{<a>,<a>,<a>,<a>}", 1)
      expect_count("{{<a>},{<a>},{<a>},{<a>}}", 9)
      expect_count("{{<!>},{<!>},{<!>},{<a>}}", 3)
      expect_count("{{<!!>},{<!!>},{<!!>},{<!!>}}", 9)
      expect_count("{{<a!>},{<a!>},{<a!>},{<ab>}}", 3)
    end

    it do: expect_count("{}", 1)
    it do: expect_count("{{}}", 3)
    it do: expect_count("{{{}}}", 6)
    it do: expect_count("{{},{}}", 5)
    it do: expect_count("{{<},{>}}", 3)
    it do: expect_count("{{<},{>},{}}", 5)
    it do: expect_count("{{<},{!>},{>}}", 3)
    it do: expect_count("{{<},{!!>}}", 3)
  end

  context "part two" do
    it "acceptance" do
      expect_garbage_count("<>", 0)
      expect_garbage_count("<random characters>", 17)
      expect_garbage_count("<<<<>", 3)
      expect_garbage_count("<{!>}>", 2)
      expect_garbage_count("<!!>", 0)
      expect_garbage_count("<!!!>>", 0)
      expect_garbage_count("<{o\"i!a,<{i<a>", 10)
    end

    it do: expect_garbage_count("{}", 0)
    it do: expect_garbage_count("{<>}", 0)
    it do: expect_garbage_count("{<a>}", 1)
  end
end
