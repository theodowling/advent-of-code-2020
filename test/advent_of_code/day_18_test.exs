defmodule AdventOfCode.Day18Test do
  use ExUnit.Case

  import AdventOfCode.Day18

  # @tag :skip
  test "part1" do
    assert line_result("2 * 3 + (4 * 5)") == 26
    assert line_result("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
    assert line_result("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12240
    assert line_result("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632
  end

  # @tag :skip
  test "part2" do
    assert advanced_line_result("1 + (2 * 3) + (4 * (5 + 6))") == 51
    assert advanced_line_result("2 * 3 + (4 * 5)") == 46
    assert advanced_line_result("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445
    assert advanced_line_result("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 669_060
    assert advanced_line_result("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340
  end
end
