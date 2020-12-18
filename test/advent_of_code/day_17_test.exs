defmodule AdventOfCode.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Day17

  # @tag :skip
  test "part1" do
    input = """
    .#.
    ..#
    ###
    """

    result = part1(input)

    assert result == 112
  end

  # @tag :skip
  test "part2" do
    input = """
    .#.
    ..#
    ###
    """

    result = part2(input)

    assert result == 848
  end
end
