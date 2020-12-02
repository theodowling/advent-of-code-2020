defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  # @tag :skip
  test "part1" do
    input = """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    5-7 d: vgfddxdzvkndndzm
    """

    result = part1(input)

    assert result == 3
  end

  # @tag :skip
  test "part2" do
    input = """
    1-3 a: abcde
    1-3 b: cdefg
    2-9 c: ccccccccc
    5-7 d: vgfddxdzvkndndzm
    """

    result = part2(input)

    assert result == 1

    input = """
    6-7 z: dqzzzjbzz
    13-16 j: jjjvjmjjkjjjjjjj
    5-6 m: mmbmmlvmbmmgmmf
    2-4 k: pkkl
    16-17 k: kkkkkkkkkkkkkkkqf
    """

    result = part2(input)

    assert result == 2
  end
end
