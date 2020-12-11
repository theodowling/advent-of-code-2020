defmodule AdventOfCode.Day07 do
  def part1(input) do
    input
    |> parse_input_to_graph()
    |> find_bags("shiny gold")
    |> MapSet.size()
  end

  defp find_bags(graph, colour) do
    in_neighbours =
      graph
      |> Graph.in_neighbors(colour)
      |> MapSet.new()

    in_neighbours
    |> Enum.map(&find_bags(graph, &1))
    |> Enum.reduce(%MapSet{}, &MapSet.union/2)
    |> MapSet.union(in_neighbours)
  end

  def part2(input) do
    graph =
      input
      |> parse_input_to_graph()

    count(graph, "shiny gold", 1)
  end

  defp count(graph, colour, factor) do
    Graph.out_edges(graph, colour)
    |> Enum.reduce(0, fn %{label: c, v2: v2}, sum ->
      sum + c * factor + count(graph, v2, c * factor)
    end)
  end

  def get_recipe(line) do
    [colour, what] = String.split(line, " bags contain ")
    contents = what |> String.split(", ") |> Enum.map(&parse_bags/1)
    {colour, contents}
  end

  def parse_bags("no other bags.") do
    []
  end

  def parse_bags(bag) do
    [count | rest] =
      bag
      |> String.split(" ")

    {String.to_integer(count), rest |> Enum.drop(-1) |> Enum.join(" ")}
  end

  def parse_input_to_graph(input) do
    bags =
      input
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.map(&get_recipe/1)
      |> Enum.into(%{})

    Enum.reduce(bags, Graph.new(), fn {k, v}, graph ->
      g = Graph.add_vertex(graph, k)

      Enum.reduce(v, g, fn values, acc ->
        case values do
          [] ->
            acc

          {count, colour} ->
            acc
            |> Graph.add_vertex(colour)
            |> Graph.add_edge(k, colour, label: count)
        end
      end)
    end)
  end
end
