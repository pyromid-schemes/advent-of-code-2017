defmodule DayTenSpec do
  use ESpec

  def expect_marks({input, position, amount}, expected) do
    result = AocElixir.DayTen.twist_knot(input, position, amount)
    expect(result).to eq(expected)
  end

  def expect_part_one(input, expected) do
    expect(AocElixir.DayTen.PartOne.solve(input)).to eq(expected)
  end

  def expect_dense_hash(input, expected) do
    expect(AocElixir.DayTen.PartTwo.dense_hash(input)).to eq(expected)
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

  context "solve part one" do
    it do: expect_part_one("1", 0)
    it do: expect_part_one("256", 64770)
    it do: expect_part_one("3", 2)
    it do: expect_part_one("3", 2)
    it do: expect_part_one("1,2", 0)
  end

end
