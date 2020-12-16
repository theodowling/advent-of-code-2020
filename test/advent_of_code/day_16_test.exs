defmodule AdventOfCode.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Day16

  # @tag :skip
  test "part1" do
    input = "priv/sample/day16.txt"
    result = part1(input)

    assert result == 71
  end

  @tag :skip
  test "part2" do
    input = "priv/sample/day16.txt"
    result = part2(input)

    assert result
  end
end
