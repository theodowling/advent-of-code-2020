defmodule AdventOfCode.Utils do
  @spec parse_input_lines_to_list_of_integers(binary) :: [integer()]
  def parse_input_lines_to_list_of_integers(input) do
    input |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
  end

  @spec parse_input_lines_to_list(binary) :: [binary]
  def parse_input_lines_to_list(input) do
    input |> String.split("\n", trim: true)
  end

  def parse_input_to_coordinate_mapset(input, val, x, y) do
    check = x * y + 1

    {coords, ^check} =
      input
      |> String.split("", trim: true)
      |> Enum.filter(&(&1 != "\n"))
      |> Enum.reduce({MapSet.new(), 1}, fn item, {coords, n} ->
        coords =
          if item == val || val == :all do
            x1 = if rem(n, x) != 0, do: rem(n, x), else: x
            y1 = if rem(n, x) != 0, do: div(n, x) + 1, else: div(n, x)
            MapSet.put(coords, {x1, y1})
          else
            coords
          end

        {coords, n + 1}
      end)

    coords
  end
end
