defmodule Mix.Tasks.D11.P1 do
  use Mix.Task

  import AdventOfCode.Day11

  @shortdoc "Day 11 Part 1"
  def run(args) do
    input = "priv/input/day11.txt"

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1(96, 90) end}),
      else:
        input
        |> part1(96, 90)
        |> IO.inspect(label: "Part 1 Results")
  end
end
