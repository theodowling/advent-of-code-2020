defmodule AdventOfCode.Day05 do
  def part1(input_path) do
    input_path
    |> File.stream!()
    |> Stream.filter(&binary_part(&1, 0, 2) == "BB")
    |> Enum.to_list()
    |> Enum.sort()
    |> Enum.take(5)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&binary_boarding(&1, 0, 127, 0, 7))
    |> Enum.max()
  end

  def part2(input_path) do
    {_, v} = input_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
    |> Enum.group_by(&binary_part(&1, 0, 7))
    |> Enum.find(fn {_, v} -> Enum.count(v) != 8 end)

    Enum.map(v, fn bin -> binary_boarding(String.graphemes(bin), 0, 127, 0, 7) end)
  end

  @doc """
      iex> binary_boarding(["B","F","F","F","B","B","F","R","R","R"], 0, 127, 0, 7)
      567

      iex> binary_boarding(["F","F","F","B","B","B","F","R","R","R"], 0, 127, 0, 7)
      119
  """

  def binary_boarding([], y1, _y2, x1, _x2) do
    y1 * 8 + x1
  end

  def binary_boarding([c | rest], y1, y2, x1, x2) do
    case c do
      "F" -> binary_boarding(rest, y1, y2 - div(y2 - y1, 2) - 1, x1, x2)
      "B" -> binary_boarding(rest, y1 + div(y2 - y1, 2) + 1, y2, x1, x2)
      "L" -> binary_boarding(rest, y1, y2, x1, x2 - div(x2 - x1, 2) - 1)
      "R" -> binary_boarding(rest, y1, y2, x1 + div(x2 - x1, 2) + 1, x2)
    end
  end
end
