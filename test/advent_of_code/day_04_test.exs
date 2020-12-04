defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04

  # @tag :skip
  test "part1" do
    input = "priv/sample/day04.txt"
    result = part1(input)

    assert result == 2
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day04_2.txt"
    result = part2(input)

    assert result == 4
  end
end
