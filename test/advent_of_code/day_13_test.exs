defmodule AdventOfCode.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Day13

  # @tag :skip
  test "part1" do
    input = """
    939
    7,13,x,x,59,x,31,19
    """

    result = part1(input)

    assert result == 295
  end

  # @tag :skip
  test "part2" do
    assert part2("\n17,x,13,19\n") == 3417
    assert part2("\n7,13,x,x,59,x,31,19\n") == 1_068_781
    assert part2("\n67,7,59,61\n") == 754_018
    assert part2("\n67,x,7,59,61\n") == 779_210
    assert part2("\n67,7,x,59,61\n") == 1_261_476
    assert part2("\n1789,37,47,1889\n") == 1_202_161_486
  end
end
