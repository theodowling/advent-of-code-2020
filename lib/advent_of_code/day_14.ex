defmodule AdventOfCode.Day14 do
  def part1(input) do
    input
    |> parse_to_chunks()
    |> Enum.reduce(%{}, fn set, mem ->
      work_with_set(set, mem)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def parse_to_chunks(input) do
    chunk_fun = fn element, acc ->
      if binary_part(element, 0, 4) == "mask" do
        {:cont, Enum.reverse(acc), [element | []]}
      else
        {:cont, [element | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    input
    |> String.split("\n", trim: true)
    |> Enum.chunk_while([], chunk_fun, after_fun)
  end

  def work_with_set([], mem) do
    mem
  end

  def work_with_set(set, mem) do
    [mask | assigns] = set

    rules =
      mask
      |> String.reverse()
      |> String.codepoints()
      |> Enum.drop(-7)
      |> Enum.with_index()
      |> Enum.filter(&(elem(&1, 0) != "X"))
      |> Enum.map(fn {k, v} -> {v, String.to_integer(k)} end)
      |> Enum.into(%{})

    max_key = rules |> Map.keys() |> Enum.max()

    Enum.reduce(assigns, mem, fn assign, updated_mem ->
      [pos, value] = String.split(assign, " = ")
      position = binary_part(pos, 4, String.length(pos) - 5)
      integer_position = String.to_integer(position)

      v =
        value
        |> String.to_integer()
        |> Integer.digits(2)
        |> Enum.reverse()
        |> update_with_replacements(rules, max_key)
        |> Enum.reverse()
        |> Integer.undigits(2)

      Map.put(updated_mem, integer_position, v)
    end)
  end

  def update_with_replacements(binary, rules, max_key) when length(binary) < max_key + 1 do
    update_with_replacements(binary ++ [0], rules, max_key)
  end

  def update_with_replacements(binary, rules, max_key) when length(binary) >= max_key + 1 do
    Enum.reduce(rules, binary, fn {pos, value}, acc ->
      List.replace_at(acc, pos, value)
    end)
  end

  def part2(input) do
    input
    |> parse_to_chunks()
    |> Enum.reduce(%{}, fn set, mem ->
      work_with_memory_address_decoder_set(set, mem)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def work_with_memory_address_decoder_set([], mem) do
    mem
  end

  def work_with_memory_address_decoder_set(set, mem) do
    [mask | assigns] = set

    rules =
      mask
      |> String.reverse()
      |> String.codepoints()
      |> Enum.drop(-7)
      |> Enum.with_index()
      |> Enum.map(fn {k, v} -> if k == "X", do: {v, "X"}, else: {v, String.to_integer(k)} end)
      |> Enum.into(%{})

    Enum.reduce(assigns, mem, fn assign, updated_mem ->
      [pos, value] = String.split(assign, " = ")
      position = binary_part(pos, 4, String.length(pos) - 5)
      integer_position = String.to_integer(position)

      positions =
        integer_position
        |> Integer.digits(2)
        |> Enum.reverse()
        |> update_with_replacements_and_iterations(rules)

      Enum.reduce(positions, updated_mem, fn p, acc ->
        Map.put(acc, p, String.to_integer(value))
      end)
    end)
  end

  def update_with_replacements_and_iterations(binary, rules) when length(binary) < 36 do
    update_with_replacements_and_iterations(binary ++ [0], rules)
  end

  def update_with_replacements_and_iterations(binary, rules) when length(binary) >= 36 do
    Enum.reduce(rules, binary, fn {pos, value}, acc ->
      if value != 0 do
        List.replace_at(acc, pos, value)
      else
        acc
      end
    end)
    |> Enum.with_index()
    |> Enum.reduce([0], fn {k, i}, acc ->
      case k do
        "X" ->
          for b <- 0..1, s <- acc do
            s + b * Math.pow(2, i)
          end

        1 ->
          for s <- acc do
            s + Math.pow(2, i)
          end

        0 ->
          acc
      end
    end)
  end
end
