defmodule DayTenSpec do
  use ESpec

  def expect_marks({input, position, amount}, expected) do
    result = AocElixir.DayTen.twist_knot(input, position, amount)
    expect(result).to eq(expected)
  end

  def expect_part_one(input, expected) do
    expect(AocElixir.DayTen.PartOne.solve(input)).to eq(expected)
  end

  def expect_part_two(input, expected) do
    expect(AocElixir.DayTen.PartTwo.solve(input)).to eq(expected)
  end

  def expect_dense_hash(input, expected) do
    expect(AocElixir.DayTen.PartTwo.dense_hash(input)).to eq(expected)
  end

  def expect_hash_string(input, expected) do
    expect(AocElixir.DayTen.PartTwo.hash_string(input)).to eq(expected)
  end

  def expect_round({input, marks}, expected) do
    expect(AocElixir.DayTen.execute_round(input, marks)).to eq(expected)
  end

  context "twist knot" do
    context "acceptance" do
      it do: expect_marks({[0,1,2,3,4], 0, 3}, [2,1,0,3,4])
      it do: expect_marks({[2,1,0,3,4], 3, 4}, [4,3,0,1,2])
    end

    context "from position 0" do
      it "twist nothing" do
        expect_marks({[1,2,3], 0, 0}, [1,2,3])
      end

      it "twist one" do
        expect_marks({[1,2,3], 0, 1}, [1,2,3])
      end

      it "twist two" do
        expect_marks({[1,2,3], 0, 2}, [2,1,3])
      end

      it "twist whole list" do
        expect_marks({[1,2,3], 0, 3}, [3,2,1])
      end
    end

    context "from non-zero position" do
      context "not looping" do
        it "twist nothing" do
          expect_marks({[1,2,3,4,5], 1, 0}, [1,2,3,4,5])
        end

        it "twist one" do
          expect_marks({[1,2,3,4,5], 1, 1}, [1,2,3,4,5])
        end

        it "twist two" do
          expect_marks({[1,2,3,4,5], 1, 2}, [1,3,2,4,5])
        end

        it "twist up to end" do
          expect_marks({[1,2,3,4,5], 1, 4}, [1,5,4,3,2])
        end
      end
      context "looping" do
        it "twist last and first elements" do
          expect_marks({[1,2,3,4], 3, 2}, [4,2,3,1])
        end
      end
    end
  end

  context "execute_round" do
    it do: expect_round({[1], [1,2,3,4,5]}, {[1,2,3,4,5], 1, 1})
    it do: expect_round({[2], [1,2,3,4,5]}, {[2,1,3,4,5], 2, 1})
    it do: expect_round({[1,2], [1,2,3,4,5]}, {[1,3,2,4,5], 4, 2})
    it do: expect_round({[1,2,3], [1,2,3,4,5]}, {[1,5,2,4,3], 4, 3})
  end

  context "calculate dense hash" do
    it "with only two items", do: expect_dense_hash([10, 20], [30])
    it "with sixteen items" do
      input = [65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22]
      expect_dense_hash(input, [64])
    end
    it "with thirty two items" do
      input = [
        65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22,
        65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22
      ]
      expect_dense_hash(input, [64,64])
    end
  end

  context "dense_hash to string" do
    it "with one characters", do: expect_hash_string([64], "40")
    it "with two characters", do: expect_hash_string([64,7], "4007")
    it "with four characters", do: expect_hash_string([64,7,255, 0], "4007ff00")
  end

  context "solve part one" do
    it do: expect_part_one("1", 0)
    it do: expect_part_one("256", 64770)
    it do: expect_part_one("3", 2)
    it do: expect_part_one("3", 2)
    it do: expect_part_one("1,2", 0)
  end

  context "solve part two" do
    it do: expect_part_two("", "a2582a3a0e66e6e86e3812dcb672a272")
    it do: expect_part_two("AoC 2017", "33efeb34ea91902bb2f59c9920caa6cd")
    it do: expect_part_two("1,2,3", "3efbe78a8d82f29979031a4aa0b16a9d")
    it do: expect_part_two("1,2,4", "63960835bcdc130f0b66d7ff4f6a5a8e")
  end
end
