defmodule AdventOfCode.Day17 do
  def part1(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.codepoints/1)

    n = Enum.count(grid)
    index = div(n, 2)
    grid_map = grid_map(grid, -index) |> MapSet.new()
    grid_range = Range.new(-index, index)

    iterate(grid_map, grid_range, 6)
    |> MapSet.size()
  end

  def grid_map(grid, index, dimensions \\ 3) do
    new_grid =
      grid
      |> Enum.map(fn row -> Enum.with_index(row, index) end)
      |> Enum.map(fn row -> Enum.filter(row, &(elem(&1, 0) == "#")) end)
      |> Enum.with_index(index)

    case dimensions do
      3 -> for {y_entries, y} <- new_grid, {_, x} <- y_entries, do: {x, y, 0}
      4 -> for {y_entries, y} <- new_grid, {_, x} <- y_entries, do: {x, y, 0, 0}
    end
  end

  def iterate(grid_map, _range, 0), do: grid_map

  def iterate(grid_map, a..b, n) do
    new_range = Range.new(a - 1, b + 1)

    new_grid =
      for x <- new_range, y <- new_range, z <- new_range do
        if MapSet.member?(grid_map, {x, y, z}) do
          if count_neighbours(grid_map, {x, y, z}) in [2, 3] do
            {x, y, z}
          else
            nil
          end
        else
          if count_neighbours(grid_map, {x, y, z}) == 3 do
            {x, y, z}
          else
            nil
          end
        end
      end
      |> Enum.filter(&(&1 != nil))
      |> MapSet.new()

    iterate(new_grid, new_range, n - 1)
  end

  def count_neighbours(grid_map, {x, y, z}) do
    [
      {x + 1, y, z},
      {x + 1, y - 1, z},
      {x + 1, y + 1, z},
      {x + 1, y, z - 1},
      {x + 1, y, z + 1},
      {x + 1, y - 1, z + 1},
      {x + 1, y + 1, z + 1},
      {x + 1, y - 1, z - 1},
      {x + 1, y + 1, z - 1},
      {x, y - 1, z},
      {x, y + 1, z},
      {x, y, z - 1},
      {x, y, z + 1},
      {x, y - 1, z + 1},
      {x, y + 1, z + 1},
      {x, y - 1, z - 1},
      {x, y + 1, z - 1},
      {x - 1, y, z},
      {x - 1, y - 1, z},
      {x - 1, y + 1, z},
      {x - 1, y, z - 1},
      {x - 1, y, z + 1},
      {x - 1, y - 1, z + 1},
      {x - 1, y + 1, z + 1},
      {x - 1, y - 1, z - 1},
      {x - 1, y + 1, z - 1}
    ] |> Enum.count(&MapSet.member?(grid_map, &1))
  end

  def count_neighbours(grid_map, {x, y, z, w}) do
    [
      {x + 1, y, z, w - 1},
      {x + 1, y - 1, z, w - 1},
      {x + 1, y + 1, z, w - 1},
      {x + 1, y, z - 1, w - 1},
      {x + 1, y, z + 1, w - 1},
      {x + 1, y - 1, z + 1, w - 1},
      {x + 1, y + 1, z + 1, w - 1},
      {x + 1, y - 1, z - 1, w - 1},
      {x + 1, y + 1, z - 1, w - 1},
      {x, y - 1, z, w - 1},
      {x, y + 1, z, w - 1},
      {x, y, z - 1, w - 1},
      {x, y, z + 1, w - 1},
      {x, y - 1, z + 1, w - 1},
      {x, y + 1, z + 1, w - 1},
      {x, y - 1, z - 1, w - 1},
      {x, y + 1, z - 1, w - 1},
      {x - 1, y, z, w - 1},
      {x - 1, y - 1, z, w - 1},
      {x - 1, y + 1, z, w - 1},
      {x - 1, y, z - 1, w - 1},
      {x - 1, y, z + 1, w - 1},
      {x - 1, y - 1, z + 1, w - 1},
      {x - 1, y + 1, z + 1, w - 1},
      {x - 1, y - 1, z - 1, w - 1},
      {x - 1, y + 1, z - 1, w - 1},
      {x + 1, y, z, w},
      {x + 1, y - 1, z, w},
      {x + 1, y + 1, z, w},
      {x + 1, y, z - 1, w},
      {x + 1, y, z + 1, w},
      {x + 1, y - 1, z + 1, w},
      {x + 1, y + 1, z + 1, w},
      {x + 1, y - 1, z - 1, w},
      {x + 1, y + 1, z - 1, w},
      {x, y - 1, z, w},
      {x, y + 1, z, w},
      {x, y, z - 1, w},
      {x, y, z + 1, w},
      {x, y - 1, z + 1, w},
      {x, y + 1, z + 1, w},
      {x, y - 1, z - 1, w},
      {x, y + 1, z - 1, w},
      {x - 1, y, z, w},
      {x - 1, y - 1, z, w},
      {x - 1, y + 1, z, w},
      {x - 1, y, z - 1, w},
      {x - 1, y, z + 1, w},
      {x - 1, y - 1, z + 1, w},
      {x - 1, y + 1, z + 1, w},
      {x - 1, y - 1, z - 1, w},
      {x - 1, y + 1, z - 1, w},
      {x + 1, y, z, w + 1},
      {x + 1, y - 1, z, w + 1},
      {x + 1, y + 1, z, w + 1},
      {x + 1, y, z - 1, w + 1},
      {x + 1, y, z + 1, w + 1},
      {x + 1, y - 1, z + 1, w + 1},
      {x + 1, y + 1, z + 1, w + 1},
      {x + 1, y - 1, z - 1, w + 1},
      {x + 1, y + 1, z - 1, w + 1},
      {x, y - 1, z, w + 1},
      {x, y + 1, z, w + 1},
      {x, y, z - 1, w + 1},
      {x, y, z + 1, w + 1},
      {x, y - 1, z + 1, w + 1},
      {x, y + 1, z + 1, w + 1},
      {x, y - 1, z - 1, w + 1},
      {x, y + 1, z - 1, w + 1},
      {x - 1, y, z, w + 1},
      {x - 1, y - 1, z, w + 1},
      {x - 1, y + 1, z, w + 1},
      {x - 1, y, z - 1, w + 1},
      {x - 1, y, z + 1, w + 1},
      {x - 1, y - 1, z + 1, w + 1},
      {x - 1, y + 1, z + 1, w + 1},
      {x - 1, y - 1, z - 1, w + 1},
      {x - 1, y + 1, z - 1, w + 1},
      {x, y, z, w + 1},
      {x, y, z, w - 1}
    ] |> Enum.count(&MapSet.member?(grid_map, &1))
  end

  def part2(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.codepoints/1)

    n = Enum.count(grid)
    index = div(n, 2)
    grid_map = grid_map(grid, -index, 4) |> MapSet.new()
    grid_range = Range.new(-index, index)

    iterate2(grid_map, grid_range, 6)
    |> MapSet.size()
  end

  def iterate2(grid_map, _range, 0), do: grid_map

  def iterate2(grid_map, a..b, n) do
    new_range = Range.new(a - 1, b + 1)

    new_grid =
      for x <- new_range, y <- new_range, z <- new_range, w <- new_range do
        if MapSet.member?(grid_map, {x, y, z, w}) do
          if count_neighbours(grid_map, {x, y, z, w}) in [2, 3] do
            {x, y, z, w}
          else
            nil
          end
        else
          if count_neighbours(grid_map, {x, y, z, w}) == 3 do
            {x, y, z, w}
          else
            nil
          end
        end
      end
      |> Enum.filter(&(&1 != nil))
      |> MapSet.new()

    iterate2(new_grid, new_range, n - 1)
  end


end
