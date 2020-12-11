defmodule AdventOfCode.Day11 do
  import AdventOfCode.Utils

  def part1(input, x_max, y_max) do
    input
    |> File.stream!()
    |> parse_stream_to_coordinate_map(x_max, y_max)
    |> part_1_iterate_until_repeating(x_max, y_max)
    |> Enum.count(fn {_, v} ->
      v == :O
    end)
  end

  def part2(input, x_max, y_max) do
    input
    |> File.stream!()
    |> parse_stream_to_coordinate_map(x_max, y_max)
  end

  def part_1_iterate_until_repeating(m, x_max, y_max) do
    begin = m

    m =
      Enum.map(m, fn {{x, y}, v} ->
        neighbours({x, y}, x_max, y_max)
        |> count_taken_seats(m)
        |> update_seat_value_part_1({x, y}, v)
      end)
      |> Enum.into(%{})

    if m == begin do
      m
    else
      part_1_iterate_until_repeating(m, x_max, y_max)
    end
  end

  def neighbours({x, y}, x_max, y_max) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
    |> Enum.filter(fn {x1, y1} -> not (x1 < 1 or x1 > x_max or y1 < 1 or y1 > y_max) end)
  end

  def part_2_iterate_until_repeating(m, x_max, y_max) do
    begin = m

    m =
      Enum.map(m, fn {{x, y}, v} ->
        neighbours({x, y}, x_max, y_max)
        |> count_taken_seats(m)
        |> update_seat_value_part_1({x, y}, v)
      end)
      |> Enum.into(%{})

    if m == begin do
      m
    else
      part_1_iterate_until_repeating(m, x_max, y_max)
    end
  end

  def count_taken_seats(neighbours, seats) do
    neighbours
    |> Enum.count(fn n -> seats[n] == :O end)
  end

  def update_seat_value_part_1(count, {x, y}, :L) when count == 0 do
    {{x, y}, :O}
  end

  def update_seat_value_part_1(count, {x, y}, :O) when count > 3 do
    {{x, y}, :L}
  end

  def update_seat_value_part_1(_count, {x, y}, :.) do
    {{x, y}, :.}
  end

  def update_seat_value_part_1(_count, {x, y}, v) do
    {{x, y}, v}
  end
end
