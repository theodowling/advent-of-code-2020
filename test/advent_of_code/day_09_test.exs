defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09

  # @tag :skip
  test "part1" do
    input = "priv/sample/day09.txt"
    result = part1(input, 5)

    assert result == 127
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day09.txt"
    result = part2(input, 127)

    assert result == 62
  end
end
