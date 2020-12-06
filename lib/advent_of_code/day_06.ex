defmodule AdventOfCode.Day06 do
  def part1(input) do
    input
    |> chunck_and_trim_responses
    |> Stream.map(&Enum.uniq/1)
    |> Stream.map(&Enum.count/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> chunck_responses
    |> Stream.map(&get_intersection/1)
    |> Enum.sum
  end

  def chunck_and_trim_responses(input_path) do
    chunk_fun = fn element, acc ->
      if element == "" do
        {:cont, acc, []}
      else
        {:cont, String.graphemes(element) ++ acc}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    input_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_while([], chunk_fun, after_fun)
  end

  def chunck_responses(input_path) do
    chunk_fun = fn element, acc ->
      if element == "" do
        {:cont, acc, []}
      else
        {:cont, [MapSet.new(String.graphemes(element)) | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    input_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_while([], chunk_fun, after_fun)
  end

  def get_intersection([a | rest]) do
    get_intersection(rest, MapSet.new(a))
  end

  def get_intersection([], acc) do
    MapSet.size(acc)
  end

  def get_intersection([a | rest], acc) do
    get_intersection(rest, MapSet.intersection(a, acc))
  end
end
