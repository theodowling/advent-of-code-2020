defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  # @tag :skip
  test "part1" do
    input = "priv/sample/day07.txt"
    result = part1(input)

    assert result == 4
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day07.txt"
    result = part2(input)

    assert result == 32
  end
end
