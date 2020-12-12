defmodule AdventOfCode.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Day12

  # @tag :skip
  test "part1" do
    input = "priv/sample/day12.txt"
    result = part1(input)

    assert result == 25
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day12.txt"
    result = part2(input)

    assert result == 286
  end
end
