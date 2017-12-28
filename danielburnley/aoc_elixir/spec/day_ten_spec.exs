defmodule DayTenSpec do
  use ESpec

  def expect_marks({input, position, amount}, expected) do
    result = AocElixir.DayTen.twist_knot(input, position, amount)
    expect(result).to eq(expected)
  end

  def expect_part_one(input, expected) do
    expect(AocElixir.DayTen.PartOne.solve(input)).to eq(expected)
  end

  context "part one" do
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

    context "solve" do
      it do: expect_part_one("1", 0)
      it do: expect_part_one("256", 64770)
      it do: expect_part_one("3", 2)
      it do: expect_part_one("3", 2)
      it do: expect_part_one("1,2", 0)
    end
  end
end
