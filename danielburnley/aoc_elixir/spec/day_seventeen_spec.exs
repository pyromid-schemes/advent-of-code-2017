defmodule DaySeventeenSpec do
  use ESpec

  def expect_part_one(input, expected) do
    expect(AocElixir.DaySeventeen.PartOne.solve(input)).to eq(expected)
  end

  def expect_inserted_value({buffer, steps, value, pos}, expected) do
    result = AocElixir.DaySeventeen.insert_value(buffer, steps, value, pos)
    expect(result).to eq(expected)
  end

  context "insert_value" do
    context "acceptance" do
      it do: expect_inserted_value({[0], 3, 1, 0}, {[0,1], 1})
      it do: expect_inserted_value({[0,1], 3, 2, 1}, {[0,2,1], 1})
      it do: expect_inserted_value({[0,2,1], 3, 3, 1}, {[0,2,3,1], 2})
      it do: expect_inserted_value({[0,2,3,1], 3, 4, 2}, {[0,2,4,3,1], 2})
      it do: expect_inserted_value({[0,2,4,3,1], 3, 5, 2}, {[0,5,2,4,3,1], 1})
    end

    context "with no looping required" do
      context "with step size one" do
        it "position 0, two items in buffer" do
          expect_inserted_value({[0,1], 1, 2, 0}, {[0,1,2], 2})
        end

        it "position 0, three items in buffer" do
          expect_inserted_value({[0,1,2], 1, 3, 0}, {[0,1,3,2], 2})
        end

        it "position 1, three items in buffer" do
          expect_inserted_value({[0,1,2], 1, 3, 1}, {[0,1,2,3], 3})
        end
      end

      context "with step size of more than one" do
        it "at position 0 with three items in buffer" do
          expect_inserted_value({[0,1,2], 2, 3, 0}, {[0,1,2,3], 3})
        end

        it "at position 1 with five items in buffer" do
          expect_inserted_value({[0,1,2,3,4], 2, 5, 1}, {[0,1,2,3,5,4], 4})
        end
      end
    end

    context "with looping required" do
      it "intial state with step size two" do
        expect_inserted_value({[0], 2, 1, 0}, {[0,1], 1})
      end

      it "two items in buffer, step size two, position 0" do
        expect_inserted_value({[0,1], 2, 2, 0}, {[0,2,1], 1})
      end

      it "two items in buffer, step size two, position 1" do
        expect_inserted_value({[0,1], 2, 2, 1}, {[0,1,2], 2})
      end

      it "two items in buffer, step size 4, position 1" do
        expect_inserted_value({[0,1], 4, 2, 1}, {[0,1,2], 2})
      end

      it "two items in buffer, step size 4, position 1" do
        expect_inserted_value({[0,1], 5, 2, 1}, {[0,2,1], 1})
      end
    end
  end

  context "solve part one" do
    context "acceptance" do
      it do: expect_part_one("3", 638)
    end
  end
end
