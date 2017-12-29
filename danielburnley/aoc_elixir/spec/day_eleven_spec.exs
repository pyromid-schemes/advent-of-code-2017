defmodule DayElevenSpec do
  use ESpec

  def expect_position(input, expected) do
    expect(AocElixir.DayEleven.get_position(input)).to eq(expected)
  end

  def expect_part_one(input, expected) do
    expect(AocElixir.DayEleven.PartOne.solve(input)).to eq(expected)
  end

  context "record movements" do
    context "single movement" do
      it do: expect_position(["n"],  {0,1,-1})
      it do: expect_position(["ne"], {1,0,-1})
      it do: expect_position(["se"], {1,-1,0})
      it do: expect_position(["s"],  {0,-1,1})
      it do: expect_position(["sw"], {-1,0,1})
      it do: expect_position(["nw"], {-1,1,0})
    end
    context "multiple movements" do
      it do: expect_position(["n","n"], {0,2,-2})
      it do: expect_position(["s","n"], {0,0,0})
      it do: expect_position(["n","ne"], {1,1,-2})
    end

  end

  context "part one" do
    it do: expect_part_one("n", 1)
    it do: expect_part_one("n,n", 2)
    it do: expect_part_one("n,s", 0)
    it do: expect_part_one("ne", 1)
    it do: expect_part_one("sw", 1)
    it do: expect_part_one("ne,sw", 0)
    it do: expect_part_one("nw", 1)
    it do: expect_part_one("se", 1)
    it do: expect_part_one("nw,se", 0)
    it do: expect_part_one("nw,se", 0)
    it do: expect_part_one("ne,ne,s,s", 2)
    it do: expect_part_one("se,sw,se,sw,sw", 3)
  end
end
