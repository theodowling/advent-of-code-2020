defmodule AdventOfCode.Day10 do
  def part1(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> interpret_list(1, 1)
  end

  def interpret_list([_ | []], ones, threes) do
    ones * threes
  end

  def interpret_list([h1, h2 | tail], ones, threes) when h2 - h1 == 1 do
    interpret_list([h2 | tail], ones + 1, threes)
  end

  def interpret_list([h1, h2 | tail], ones, threes) when h2 - h1 == 3 do
    interpret_list([h2 | tail], ones, threes + 1)
  end

  def part2(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
    |> get_increments([1])
    |> Enum.chunk_by(&(&1 == 3))
    |> Enum.map(fn x ->
      case x do
        [1] -> 1
        [1, 1] -> 2
        [1, 1, 1] -> 4
        [1, 1, 1, 1] -> 7
        [3 | _] -> 1
      end
    end)
    |> Enum.reduce(1, fn x, acc ->
      acc * x
    end)
  end

  def get_increments([_ | []], acc) do
    Enum.reverse(acc)
  end

  def get_increments([h1, h2 | tail], acc) when h2 - h1 == 1 do
    get_increments([h2 | tail], [1 | acc])
  end

  def get_increments([h1, h2 | tail], acc) when h2 - h1 == 3 do
    get_increments([h2 | tail], [3 | acc])
  end
end
