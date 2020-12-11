defmodule AdventOfCode.Day09 do
  def part1(input, preamble_size) do
    {preamble, rest} =
      input
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.split(preamble_size)

    find_invalid_sum(preamble, rest)
  end

  def part2(input, number) do
    {min, max} =
      input
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> find_invalid_sequence(number)
      |> Enum.min_max()

    min + max
  end

  def find_invalid_sum(preamble, [sum | rest]) do
    unless valid_sum?(preamble, sum) do
      sum
    else
      find_invalid_sum(tl(preamble) ++ [sum], rest)
    end
  end

  def valid_sum?(list, sum) do
    length(for i <- list, j <- list, i != j, i + j == sum, do: {i, j}) > 0
  end

  def find_invalid_sequence(input, number) do
    {list, result} =
      input
      |> Enum.reduce_while({[], 0}, fn i, {list, acc} ->
        sum = acc + i

        if sum < number do
          {:cont, {[i | list], sum}}
        else
          {:halt, {[i | list], sum}}
        end
      end)

    if result == number do
      list
    else
      find_invalid_sequence(tl(input), number)
    end
  end
end
