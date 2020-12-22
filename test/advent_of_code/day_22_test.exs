defmodule AdventOfCode.Day22Test do
  use ExUnit.Case

  import AdventOfCode.Day22

  # @tag :skip
  test "part1" do
    input = "priv/sample/day22.txt"
    result = part1(input)

    assert result == 306
  end

  # @tag :skip
  test "part2" do
    input = "priv/sample/day22.txt"
    result = part2(input)

    assert result == 291
  end
end
