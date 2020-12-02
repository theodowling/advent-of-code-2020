defmodule AdventOfCode.Day02 do
  import AdventOfCode.Utils

  def part1(args) do
    args
    |> parse_input_lines_to_list()
    |> Enum.count(&check_password_rule/1)
  end

  def part2(args) do
    args
    |> parse_input_lines_to_list()
    |> Enum.count(&check_password_rule(&1, :position))
  end

  def check_password_rule(line, type \\ :count) do
    line
    |> parse_rule()
    |> check_password(type)
  end

  def parse_rule(line) do
    case Regex.run(~r/^(?<a>\d{1,})-(?<b>\d{1,})\s(?<c>.):\s(?<password>\S{1,})$/, line) do
      [_, a, b, c, password] ->
        {String.to_integer(a), String.to_integer(b), c, String.split(password, "", trim: true)}

      _ ->
        raise("invalid regex #{line}")
    end
  end

  def check_password({a, b, c, password}, :count) do
    number = count_chars(password, c)
    a <= number and number <= b
  end

  def check_password({a, b, c, password}, :position) do
    n1 = Enum.at(password, a - 1) == c
    n2 = Enum.at(password, b - 1) == c

    if n1 || n2 do
      not (n1 and n2)
    else
      false
    end
  end

  def count_chars(password, c) do
    password
    |> Enum.count(fn x -> x == c end)
  end
end
