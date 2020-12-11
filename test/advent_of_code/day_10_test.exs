defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10

  # @tag :skip
  test "part1" do
    input = "priv/sample/day10.txt"
    result = part1(input)

    assert result == 220
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day10.txt"
    result = part2(input)

    assert result == 19208
  end
end
