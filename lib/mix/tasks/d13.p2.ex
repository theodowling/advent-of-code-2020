defmodule Mix.Tasks.D13.P2 do
  use Mix.Task

  import AdventOfCode.Day13

  @shortdoc "Day 13 Part 2"
  def run(args) do
    input = """
    1000391
    19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,383,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29,x,457,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,17
    """

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
