defmodule AdventOfCode.Day01 do
  import AdventOfCode.Utils

  @spec part1(binary) :: number
  @doc """
  Find the two entries that sum to 2020 and then multiply those two numbers together.
  """
  def part1(args) do
    numbers = parse_input_lines_to_list_of_integers(args)
    [a | rest] = numbers |> Enum.sort()
    {a, b} = find_combination(a, rest, numbers)
    a * b
  end

  @spec part2(binary) :: number
  def part2(args) do
    numbers = parse_input_lines_to_list_of_integers(args)
    [a | rest] = numbers
    {a, b, c} = find_combination_three_way(a, rest, numbers)
    a * b * c
  end

  @spec find_combination(any, any, any) :: :not_found | {any, any}
  def find_combination(a, rest, numbers) do
    case Enum.find(numbers, fn x -> a + x == 2_020 end) do
      nil ->
        if rest == [] do
          :not_found
        else
          [b | rest] = rest
          find_combination(b, rest, numbers)
        end

      b ->
        {a, b}
    end
  end

  @spec find_combination_three_way(any, any, any) :: any
  def find_combination_three_way(a, rest, numbers) do
    case Enum.find_value(numbers, &sum_values(a, &1, numbers)) do
      nil ->
        if rest == [] do
          :not_found
        else
          [b | rest] = rest
          find_combination_three_way(b, rest, numbers)
        end

      a ->
        a
    end
  end

  @spec sum_values(number, number, any) :: nil | {number, number, number}
  def sum_values(a, b, number) do
    if a + b > 2020 do
      nil
    else
      case find_combination(a + b, [], number) do
        :not_found ->
          nil

        {_, c} ->
          {a, b, c}
      end
    end
  end
end
