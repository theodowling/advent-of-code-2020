defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  # @tag :skip
  test "part1" do
    input = "priv/sample/day06.txt"
    result = part1(input)

    assert result == 11
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day06.txt"
    result = part2(input)

    assert result == 6
  end
end
