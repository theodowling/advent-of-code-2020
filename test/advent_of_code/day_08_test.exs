defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08

  # @tag :skip
  test "part1" do
    input = "priv/sample/day08.txt"
    result = part1(input)

    assert result == 5
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day08.txt"
    result = part2(input)

    assert result == 8
  end
end
