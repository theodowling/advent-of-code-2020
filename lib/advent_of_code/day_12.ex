defmodule AdventOfCode.Day12 do
  def part1(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> play_1("E", {0, 0})
  end

  def play_1([], _, {x, y}) do
    abs(x) + abs(y)
  end

  def play_1([move | rest], direction, pos) do
    {dir, pos} = move_position(move, direction, pos)
    play_1(rest, dir, pos)
  end

  def move_position(<<"N", amount::binary>>, dir, {x, y}) do
    {dir, {x, y + String.to_integer(amount)}}
  end

  def move_position(<<"S", amount::binary>>, dir, {x, y}) do
    {dir, {x, y - String.to_integer(amount)}}
  end

  def move_position(<<"E", amount::binary>>, dir, {x, y}) do
    {dir, {x + String.to_integer(amount), y}}
  end

  def move_position(<<"W", amount::binary>>, dir, {x, y}) do
    {dir, {x - String.to_integer(amount), y}}
  end

  def move_position(<<"F", amount::binary>>, dir, {x, y}) do
    case dir do
      "E" -> move_position("E" <> amount, dir, {x, y})
      "N" -> move_position("N" <> amount, dir, {x, y})
      "S" -> move_position("S" <> amount, dir, {x, y})
      "W" -> move_position("W" <> amount, dir, {x, y})
    end
  end

  def move_position("L90", dir, {x, y}) do
    case dir do
      "N" -> {"W", {x, y}}
      "E" -> {"N", {x, y}}
      "S" -> {"E", {x, y}}
      "W" -> {"S", {x, y}}
    end
  end

  def move_position("L180", dir, {x, y}) do
    case dir do
      "N" -> {"S", {x, y}}
      "E" -> {"W", {x, y}}
      "S" -> {"N", {x, y}}
      "W" -> {"E", {x, y}}
    end
  end

  def move_position("R180", dir, {x, y}) do
    case dir do
      "N" -> {"S", {x, y}}
      "E" -> {"W", {x, y}}
      "S" -> {"N", {x, y}}
      "W" -> {"E", {x, y}}
    end
  end

  def move_position("R90", dir, {x, y}) do
    case dir do
      "N" -> {"E", {x, y}}
      "E" -> {"S", {x, y}}
      "S" -> {"W", {x, y}}
      "W" -> {"N", {x, y}}
    end
  end

  def move_position("R270", dir, {x, y}) do
    move_position("L90", dir, {x, y})
  end

  def move_position("L270", dir, {x, y}) do
    move_position("R90", dir, {x, y})
  end

  def part2(input) do
    input
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> play_2({0, 0}, {10, 1})
  end

  def play_2([], {x, y}, _) do
    abs(x) + abs(y)
  end

  def play_2([move | rest], pos, waypoint) do
    {pos, waypoint} = move_relative_position(move, pos, waypoint)
    play_2(rest, pos, waypoint)
  end

  def move_relative_position(<<"N", amount::binary>>, {x, y}, {w1, w2}) do
    {{x, y}, {w1, w2 + String.to_integer(amount)}}
  end

  def move_relative_position(<<"S", amount::binary>>, {x, y}, {w1, w2}) do
    {{x, y}, {w1, w2 - String.to_integer(amount)}}
  end

  def move_relative_position(<<"E", amount::binary>>, {x, y}, {w1, w2}) do
    {{x, y}, {w1 + String.to_integer(amount), w2}}
  end

  def move_relative_position(<<"W", amount::binary>>, {x, y}, {w1, w2}) do
    {{x, y}, {w1 - String.to_integer(amount), w2}}
  end

  def move_relative_position(<<"F", amount::binary>>, {x, y}, {w1, w2}) do
    {{x + w1 * String.to_integer(amount), y + w2 * String.to_integer(amount)}, {w1, w2}}
  end

  def move_relative_position("L90", {x, y}, {w1, w2}) do
    {{x, y}, {-w2, w1}}
  end

  def move_relative_position("L180", {x, y}, {w1, w2}) do
    {{x, y}, {-w1, -w2}}
  end

  def move_relative_position("R180", {x, y}, {w1, w2}) do
    {{x, y}, {-w1, -w2}}
  end

  def move_relative_position("R90", {x, y}, {w1, w2}) do
    {{x, y}, {w2, -w1}}
  end

  def move_relative_position("R270", {x, y}, {w1, w2}) do
    move_relative_position("L90", {x, y}, {w1, w2})
  end

  def move_relative_position("L270", {x, y}, {w1, w2}) do
    move_relative_position("R90", {x, y}, {w1, w2})
  end
end
