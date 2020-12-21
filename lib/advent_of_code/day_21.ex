defmodule AdventOfCode.Day21 do
  def part1(input) do
    list =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_ingredients_and_allergents/1)

    allergents =
      Enum.reduce(list, %{}, fn {m, l}, acc ->
        Enum.reduce(l, acc, fn i, a ->
          Map.update(a, i, m, &MapSet.intersection(m, &1))
        end)
      end)

    allergent_ingredients =
      allergents
      |> Enum.to_list()
      |> find_ingredients(%{})
      |> Enum.map(&elem(&1, 1))
      |> MapSet.new()

    Enum.reduce(list, 0, fn {map, _}, acc ->
      mapsize =
        map
        |> MapSet.difference(allergent_ingredients)
        |> MapSet.size()

      acc + mapsize
    end)
  end

  def parse_ingredients_and_allergents(line) do
    [_, a, b] = Regex.run(~r/^(?<ing>[^\(]*) \(contains (?<allergent>.*)\)$/, line)

    {MapSet.new(String.split(a, " ")), String.split(b, ", ")}
  end

  def find_ingredients([], acc), do: acc

  def find_ingredients([{c, m} | rest], acc) do
    if MapSet.size(m) == 1 do
      ingredient = hd(MapSet.to_list(m))
      acc = Map.put(acc, c, ingredient)

      rest =
        Enum.map(rest, fn {k, v} ->
          {k, MapSet.delete(v, ingredient)}
        end)

      find_ingredients(rest, acc)
    else
      find_ingredients(rest ++ [{c, m}], acc)
    end
  end

  def part2(input) do
    list =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_ingredients_and_allergents/1)

    allergents =
      Enum.reduce(list, %{}, fn {m, l}, acc ->
        Enum.reduce(l, acc, fn i, a ->
          Map.update(a, i, m, &MapSet.intersection(m, &1))
        end)
      end)

    allergents
    |> Enum.to_list()
    |> find_ingredients(%{})
    |> Enum.to_list()
    # |> Enum.sort_by(fn {k, _v} -> k end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.join(",")
  end
end
