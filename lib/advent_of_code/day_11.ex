defmodule AdventOfCode.Day11 do
  def part1(input, x_max, y_max) do
    input
    |> File.read!()
    |> parse_input_to_coordinate_mapset(x_max, y_max)
    |> part_1_iterate_until_repeating(MapSet.new(), x_max, y_max)
    |> MapSet.size()
  end

  def part2(input, x_max, y_max) do
    input
    |> File.read!()
    |> parse_input_to_coordinate_mapset(x_max, y_max)
    |> part_2_iterate_until_repeating(MapSet.new(), x_max, y_max)
  end

  def part_1_iterate_until_repeating(empty_seats, occupied_seats, x_max, y_max) do
    begin = empty_seats

    all_coordinates = for a <- 1..x_max, b <- 1..y_max, do: {a, b}

    {new_empty, new_occupied} =
      all_coordinates
      |> Enum.reduce({empty_seats, occupied_seats}, fn {x, y}, {new_empty, new_occupied} ->
        nearest_neighbours({x, y}, x_max, y_max, 1)
        |> count_taken_seats(occupied_seats)
        |> update_seat_value_part_1({x, y}, new_empty, new_occupied)
      end)

    if begin == new_empty do
      new_occupied
    else
      part_1_iterate_until_repeating(new_empty, new_occupied, x_max, y_max)
    end
  end

  def neighbours({x, y}, x_max, y_max) do
    x1 = max(x - 1, 1)
    x2 = min(x + 1, x_max)
    y1 = max(y - 1, 1)
    y2 = min(y + 1, y_max)
    for xn <- x1..x2, yn <- y1..y2, {xn, yn} != {x, y}, do: {xn, yn}
  end

  def nearest_neighbours({x, y}, x_max, y_max, _n) do
    x1 = max(x - 1, 1)
    x2 = min(x + 1, x_max)
    y1 = max(y - 1, 1)
    y2 = min(y + 1, y_max)
    for xn <- x1..x2, yn <- y1..y2, {xn, yn} != {x, y}, do: {xn, yn}
  end

  def next_coordinate(:top, {x, y}, _x_max, y_max, n)
      when y + n <= y_max do
    {x, y + n}
  end

  def next_coordinate(:top_left, {x, y}, _x_max, y_max, n)
      when x - n >= 1
      when y + n <= y_max do
    {x - n, y + n}
  end

  def next_coordinate(:top_right, {x, y}, x_max, y_max, n)
      when x + n <= x_max
      when y + n <= y_max do
    {x - n, y + n}
  end

  def next_coordinate(:left, {x, y}, _x_max, _y_max, n)
      when x - n >= 1 do
    {x - n, y}
  end

  def next_coordinate(:right, {x, y}, x_max, _y_max, n)
      when x + n <= x_max do
    {x - n, y}
  end

  def next_coordinate(:bottom_left, {x, y}, _x_max, _y_max, n)
      when x - n >= 1
      when y - n >= 1 do
    {x - n, y - n}
  end

  def next_coordinate(:bottom, {x, y}, _x_max, _y_max, n)
      when y - n >= 1 do
    {x, y - n}
  end

  def next_coordinate(:bottom_right, {x, y}, x_max, _y_max, n)
      when y - n >= 1
      when x + n <= x_max do
    {x + n, y - n}
  end

  def next_coordinate(_, _, _, _, _) do
    :halt
  end

  def part_2_iterate_until_repeating(empty_seats, occupied_seats, x_max, y_max) do
    begin = empty_seats

    all_seats = MapSet.union(empty_seats, occupied_seats) |> MapSet.to_list()

    {new_empty, new_occupied} =
      all_seats
      |> Enum.reduce({empty_seats, occupied_seats}, fn {_x, _y}, {new_empty, new_occupied} ->
        {new_empty, new_occupied}
      end)

    if begin == new_empty do
      new_occupied
    else
      part_2_iterate_until_repeating(new_empty, new_occupied, x_max, y_max)
    end
  end

  def count_taken_seats(neighbours, occupied_seats) do
    neighbours
    |> Enum.count(&MapSet.member?(occupied_seats, &1))
  end

  def update_seat_value_part_1(count, {x, y}, empty, occupied) when count == 0 do
    if MapSet.member?(empty, {x, y}) do
      {MapSet.delete(empty, {x, y}), MapSet.put(occupied, {x, y})}
    else
      {empty, occupied}
    end
  end

  def update_seat_value_part_1(count, {x, y}, empty, occupied) when count > 3 do
    if MapSet.member?(occupied, {x, y}) do
      {MapSet.put(empty, {x, y}), MapSet.delete(occupied, {x, y})}
    else
      {empty, occupied}
    end
  end

  def update_seat_value_part_1(_count, _, empty, occupied) do
    {empty, occupied}
  end

  def update_seat_value_part_2(count, {x, y}, empty, occupied) when count == 0 do
    if MapSet.member?(empty, {x, y}) do
      {MapSet.delete(empty, {x, y}), MapSet.put(occupied, {x, y})}
    else
      {empty, occupied}
    end
  end

  def update_seat_value_part_2(count, {x, y}, empty, occupied) when count > 4 do
    if MapSet.member?(occupied, {x, y}) do
      {MapSet.put(empty, {x, y}), MapSet.delete(occupied, {x, y})}
    else
      {empty, occupied}
    end
  end

  def update_seat_value_part_2(_count, _, empty, occupied) do
    {empty, occupied}
  end

  def parse_input_to_coordinate_mapset(input, x, y) do
    check = x * y + 1

    {coords, ^check} =
      input
      |> String.split("", trim: true)
      |> Enum.filter(&(&1 != "\n"))
      |> Enum.reduce({MapSet.new(), 1}, fn item, {coords, n} ->
        coords =
          if item == "L" do
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
