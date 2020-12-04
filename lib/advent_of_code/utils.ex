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
            r = rem(n, x)
            d = div(n, x)
            x1 = if r != 0, do: r, else: x
            y1 = if r != 0, do: d + 1, else: d
            MapSet.put(coords, {x1, y1})
          else
            coords
          end

        {coords, n + 1}
      end)

    coords
  end
end
