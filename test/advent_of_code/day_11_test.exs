defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11

  # @tag :skip
  test "part1" do
    input = "priv/sample/day11.txt"
    result = part1(input, 10, 10)

    assert result == 37
  end

  @tag :skip
  test "part2" do
    input = "priv/sample/day11.txt"
    result = part2(input, 10, 10)

    assert result == 26
  end
end
