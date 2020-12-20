defmodule AdventOfCode.Day18 do
  def part1(input) do
    input
    |> File.stream!()
    |> Enum.map(fn line -> line_result(line) end)
    |> Enum.sum()
  end

  def line_result(line) do
    {result, []} =
      line
      |> String.replace("*", "-")
      |> Code.string_to_quoted!()
      |> replace_operators(%{:- => :*})
      |> Code.eval_quoted()

    result
  end

  defp replace_operators(op, _replace) when is_number(op), do: op

  defp replace_operators({operator, metadata, [a, b]}, operators) do
    {operators[operator] || operator, metadata,
     [replace_operators(a, operators), replace_operators(b, operators)]}
  end

  def part2(input) do
    input
    |> File.stream!()
    |> Enum.map(fn line -> advanced_line_result(line) end)
    |> Enum.sum()
  end

  def advanced_line_result(line) do
    {result, []} =
      line
      |> String.replace("*", "-")
      |> String.replace("+", "/")
      |> Code.string_to_quoted!()
      |> replace_operators(%{:- => :*, :/ => :+})
      |> Code.eval_quoted()

    result
  end
end
