defmodule AdventOfCode.Day02 do
  import AdventOfCode.Utils

  @spec part1(binary) :: non_neg_integer
  def part1(args) do
    args
    |> parse_input_lines_to_list()
    |> Enum.count(&check_password_rule/1)
  end

  @spec part2(binary) :: non_neg_integer
  def part2(args) do
    args
    |> parse_input_lines_to_list()
    |> Enum.count(&check_password_rule(&1, :position))
  end

  @spec check_password_rule(binary, :count | :position) :: boolean
  def check_password_rule(line, type \\ :count) do
    line
    |> parse_rule()
    |> check_password(type)
  end

  @spec parse_rule(binary) :: {integer, integer, binary, [binary]}
  def parse_rule(line) do
    [rule, password] = String.split(line, ": ")
    [rule, c] = String.split(rule, " ")
    [a, b] = String.split(rule, "-")

    {String.to_integer(a), String.to_integer(b), c, String.codepoints(password)}
  end

  @spec check_password({any, any, any, any}, :count | :position) :: boolean
  def check_password({a, b, c, password}, :count) do
    number = count_chars(password, c)
    a <= number && number <= b
  end

  def check_password({a, b, c, password}, :position) do
    n1 = Enum.at(password, a - 1) == c
    n2 = Enum.at(password, b - 1) == c

    (n1 || n2) && n1 != n2
  end

  @spec count_chars([binary], binary) :: non_neg_integer
  def count_chars(password, c) do
    password
    |> Enum.count(fn x -> x == c end)
  end
end
