defmodule AdventOfCode.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Day15

  # @tag :skip
  test "part1" do
    input = "0,3,6"
    result = part1(input)

    assert result == 436
    assert part1("1,3,2") == 1
    assert part1("2,1,3") == 10
    assert part1("1,2,3") == 27
    assert part1("2,3,1") == 78
    assert part1("3,2,1") == 438
    assert part1("3,1,2") == 1836
  end

  @tag :skip
  test "part2" do
    assert part2("0,3,6") == 175_594
    assert part2("1,3,2") == 2578
    assert part2("2,1,3") == 3_544_142
    assert part2("1,2,3") == 261_214
    assert part2("2,3,1") == 6_895_259
    assert part2("3,2,1") == 18
    assert part2("3,1,2") == 362
  end
end
