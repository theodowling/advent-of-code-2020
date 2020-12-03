defmodule AdventOfCode.Day03 do
  import AdventOfCode.Utils

  @spec part1(binary, integer(), integer()) :: integer()
  def part1(args, x, y) do
    trees =
      args
      |> parse_input_to_coordinate_mapset("#", x, y)

    start_position = {1, 1}
    count_trees_while_moving(trees, start_position, 3, 1, x, y, 0)
  end

  @spec part2(binary, integer(), integer()) :: integer()
  def part2(args, x, y) do
    trees =
      args
      |> parse_input_to_coordinate_mapset("#", x, y)

    start_position = {1, 1}
    n1 = count_trees_while_moving(trees, start_position, 1, 1, x, y, 0)
    n2 = count_trees_while_moving(trees, start_position, 3, 1, x, y, 0)
    n3 = count_trees_while_moving(trees, start_position, 5, 1, x, y, 0)
    n4 = count_trees_while_moving(trees, start_position, 7, 1, x, y, 0)
    n5 = count_trees_while_moving(trees, start_position, 1, 2, x, y, 0)

    n1 * n2 * n3 * n4 * n5
  end

  @spec count_trees_while_moving(MapSet.t(any), {integer(), integer()}, integer(), integer(), integer(), integer(), integer()) :: integer()
  def count_trees_while_moving(trees, {x0, y0}, x, y, x_max, y_max, n_trees) do
    n_trees = if MapSet.member?(trees, {x0, y0}), do: n_trees + 1, else: n_trees

    case next_position({x0, y0}, x, y, x_max, y_max) do
      {nil, nil} -> n_trees
      {x1, y1} -> count_trees_while_moving(trees, {x1, y1}, x, y, x_max, y_max, n_trees)
    end
  end

  @spec next_position({integer(), integer()}, integer(), integer(), integer(), integer()) :: {nil | integer(), nil | integer()}
  def next_position({x0, y0}, x, y, x_max, y_max)
      when x0 + x <= x_max and y0 + y <= y_max do
    {x0 + x, y0 + y}
  end

  def next_position({x0, y0}, x, y, x_max, y_max)
      when y0 + y <= y_max do
    {rem(x0 + x, x_max), y0 + y}
  end

  def next_position({_x0, _y0}, _x, _y, _x_max, _y_max) do
    {nil, nil}
  end
end
