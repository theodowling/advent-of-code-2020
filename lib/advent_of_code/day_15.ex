defmodule AdventOfCode.Day15 do
  def part1(input) do
    begin =
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    numbers_with_positions =
      begin
      |> Enum.with_index(1)
      |> Enum.into(%{})

    next_number(0, Enum.count(begin), numbers_with_positions, 2019)
  end

  def next_number(n, l, _numbers_with_pos, count) when l == count, do: n

  def next_number(n, l, numbers_with_pos, count) do
    case Map.get(numbers_with_pos, n) do
      nil ->
        next_number(0, l + 1, Map.put(numbers_with_pos, n, l + 1), count)

      pos ->
        next_number(l - pos + 1, l + 1, Map.put(numbers_with_pos, n, l + 1), count)
    end
  end

  def part2(input) do
    begin =
      input
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    numbers_with_positions =
      begin
      |> Enum.with_index(1)
      |> Enum.into(%{})

    next_number(0, Enum.count(begin), numbers_with_positions, 29_999_999)
  end
end
